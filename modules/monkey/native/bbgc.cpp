
//v1001

#include <utility>

#include "bbgc.h"

// For testing only...
// #define BBGC_DISABLED 1

namespace bbDB{

	void stop();
	
	void stopped();
	
	void error( bbString err );
}

namespace bbGC{

	int memused;
	
	int malloced;

	bool debug;
	
	size_t trigger=4*1024*1024;

	int suspended=1;
	
	int markedBit;
	int unmarkedBit;

	bbGCNode *markQueue;
	bbGCNode *markedList;
	bbGCNode *unmarkedList;
	
	bbGCRoot *roots;
	
	bbGCFiber *fibers;
	bbGCFiber *currentFiber;
	
	bbGCTmp *freeTmps;
	
	bbGCTmp *retained;

	bbGCNode markLists[2];
	bbGCNode freeList;
	
	size_t markedBytes;
	size_t unmarkedBytes;
	
	size_t allocedBytes;
	
	void *pools[32];
	
	unsigned char *poolBuf;
	size_t poolBufSize;
	
	bool inited;
	
	void init(){

		if( inited ) return;
		inited=true;

		markedBit=1;
		markedList=&markLists[0];
		markedList->succ=markedList->pred=markedList;
		
		unmarkedBit=2;
		unmarkedList=&markLists[1];
		unmarkedList->succ=unmarkedList->pred=unmarkedList;
		
		freeList.succ=freeList.pred=&freeList;
		
		fibers=new bbGCFiber;
		
		currentFiber=fibers;
		
		suspended=0;
	}
	
	void setDebug( bool debug ){
	
		bbGC::debug=debug;
	}
	
	void setTrigger( size_t size ){
	
		trigger=size;
	}
	
	void suspend(){
	
		++suspended;
	}
	
	void resume(){
	
		--suspended;
	}
	
	void destroy( bbGCNode *p ){
	
		if( p->flags & 1 ){
			
			//Run finalizer
			//printf( "finalizing: %s %p\n",p->typeName(),p );fflush( stdout );
			
			++suspended;
			
			p->state=unmarkedBit;
			
			p->gcFinalize();
			
			if( p->state==markedBit ) bbRuntimeError( "Object resurrected in finalizer" );
				
			--suspended;
		}
		
		//printf( "destroying: %s %p\n",p->typeName(),p );fflush( stdout );
		
#if BBGC_DEBUG
//		printf( "destroying: %s %p\n",p->typeName(),p );
		p->state=3;
		p->flags=0;
#else
		
		p->~bbGCNode();
			
		bbGC::free( p );
#endif
	}
	
	void reclaim( size_t size=0x7fffffff ){
	
		size_t freed=0;
	
		while( freeList.succ!=&freeList ){
		
			bbGCNode *p=freeList.succ;
			
			freed+=mallocSize( p );
			
			remove( p );
			
			destroy( p );
			
			if( freed>=size ) break;
		}
	}
	
	void mark( bbGCNode *p ){

		if( !p || p->state==markedBit ) return;
		
		remove( p );
		insert( p,markedList );
		
		markedBytes+=mallocSize( p );

		p->state=markedBit;
		
		p->gcMark();
	}
	
	void markRoots(){
	
		for( bbGCRoot *root=roots;root;root=root->succ ){
		
			root->gcMark();
		}
	}
	
	void markRetained(){
	
		for( bbGCTmp *tmp=retained;tmp;tmp=tmp->succ ){
		
			tmp->node->gcMark();
		}
	}
	
	void markFibers(){
	
		bbGCFiber *fiber=fibers;
		
		for(;;){
		
			bbGCMark( fiber->entry );

			for( bbGCFrame *frame=fiber->frames;frame;frame=frame->succ ){
			
				frame->gcMark();
			}
			
			for( bbGCNode *node=fiber->ctoring;node;node=node->succ ){
			
				node->gcMark();
			}
			
			for( bbGCTmp *tmp=fiber->tmps;tmp;tmp=tmp->succ ){
			
				if( tmp->node ) tmp->node->gcMark();
			}
			
			fiber=fiber->succ;
			
			if( fiber==fibers ) break; 
		}
	}
	
	void markQueued( size_t tomark=0x7fffffff ){
	
		while( markQueue && markedBytes<tomark ){

			bbGCNode *p=markQueue;
			markQueue=p->succ;
			
			insert( p,markedList );
			
			markedBytes+=mallocSize( p );
			
			p->gcMark();
		}
	}

	void sweep(){
	
		markRetained();
		
		markFibers();
	
		markQueued();
		
		if( unmarkedList->succ!=unmarkedList ){
			
			//append unmarked to end of free queue
			unmarkedList->succ->pred=freeList.pred;
			unmarkedList->pred->succ=&freeList;
			freeList.pred->succ=unmarkedList->succ;
			freeList.pred=unmarkedList->pred;
			
			//clear unmarked
			unmarkedList->succ=unmarkedList->pred=unmarkedList;
		}

		//swap mark/unmarked lists		
		std::swap( markedList,unmarkedList );
		std::swap( markedBit,unmarkedBit );
		unmarkedBytes=markedBytes;
		markedBytes=0;

		//start new sweep phase
		allocedBytes=0;

		markRoots();
	}
	
	void retain( bbGCNode *node ){
		if( !node ) return;
		
		bbGCTmp *tmp=freeTmps;
		if( !tmp ) tmp=new bbGCTmp;
		tmp->node=node;
		tmp->succ=retained;
		retained=tmp;
	}
	
	void release( bbGCNode *node ){
		if( !node ) return;
		
		bbGCTmp **p=&retained;
		while( bbGCTmp *tmp=*p ){
			if( tmp->node==node ){
				*p=tmp->succ;
				tmp->succ=freeTmps;
				freeTmps=tmp;
				return;
			}
			p=&tmp->succ;
		}
		printf( "Warning! bbGC::release() - node not found!\n" );
	}
	
	void *malloc( size_t size ){
	
		size=(size+sizeof(size_t)+7)&~7;
		
		memused+=size;
		
		if( size<256 && pools[size>>3] ){
			void *p=pools[size>>3];
			pools[size>>3]=*(void**)p;
			allocedBytes+=size;
			size_t *q=(size_t*)p;
			*q++=size;
			return q;
		}
		
		if( !suspended ){

			if( allocedBytes+size>=trigger ){
				
				sweep();
				
			}else{
			
				markQueued( double( allocedBytes+size ) / double( trigger ) * double( unmarkedBytes + trigger ) );
			}
			
			reclaim( size );
		}
		
		void *p;
		
		if( size<256 ){
			if( size>poolBufSize ){
				if( poolBufSize ){
					*(void**)poolBuf=pools[poolBufSize>>3];
					pools[poolBufSize>>3]=poolBuf;
				}
				poolBufSize=65536;
				poolBuf=(unsigned char*)::malloc( poolBufSize );
				malloced+=poolBufSize;
			}
			p=poolBuf;
			poolBuf+=size;
			poolBufSize-=size;
		}else{
			p=::malloc( size );
			malloced+=size;
		}
		
		allocedBytes+=size;
		size_t *q=(size_t*)p;
		*q++=size;

		return q;
	}
	
	size_t mallocSize( void *p ){
	
		if( p ) return *((size_t*)p-1);
		
		return 0;
	}
	
	void free( void *p ){
	
		if( !p ) return;
		
		size_t *q=(size_t*)p-1;
		
		size_t size=*q;
		
		if( debug ){
//			printf( "bbGC::free %p size=%i\n",q,size );fflush( stdout );
		}
		
		memused-=size;
		
		if( size<256 ){
			*(void**)q=pools[size>>3];
			pools[size>>3]=q;
		}else{
			malloced-=size;
			::free( q );
		}
	}

	bbGCNode *alloc( size_t size ){

		bbGCNode *p=(bbGCNode*)bbGC::malloc( size );
		
		*((void**)p)=(void*)0xcafebabe;
		
		p->state=0;
		p->flags=0;
		
		return p;
	}
	
	void collect(){
	
		if( !inited ) return;
		
		static size_t maxused;
	
		sweep();
		
		reclaim();
		
		if( memused>maxused ) maxused=memused;
		
//		printf( "Collect complete: memused=%i max memused=%i\n",memused,maxused );fflush( stdout );
	}
}

