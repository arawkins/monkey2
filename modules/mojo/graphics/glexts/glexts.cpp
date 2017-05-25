
#include "glexts.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern "C" void* SDL_GL_GetProcAddress( const char *proc );
extern "C" int SDL_GL_ExtensionSupported( const char *extension );

namespace bbGLexts{

	bool GL_draw_buffers=true;
	bool GL_texture_float;
	bool GL_texture_half_float;
	bool GL_depth_texture;

	void(*glDrawBuffers)( int n,const GLenum *bufs );
	
	void init(){
	
	#if __EMSCRIPTEN__
	
		if( GL_draw_buffers=SDL_GL_ExtensionSupported( "GL_WEBGL_draw_buffers" ) ){

			// Don't actually call this, will crash emscripten...extension is 'just there'!
			//
			// glDrawBuffers=(void(*)(int,const GLenum*)) SDL_GL_GetProcAddress( "glDrawBuffersWEBGL" );
			
			glDrawBuffers=::glDrawBuffers;
		}
		
	#else
	
		if( GL_draw_buffers=SDL_GL_ExtensionSupported( "GL_EXT_draw_buffers" ) ){
			
			glDrawBuffers=(void(*)(int,const GLenum*)) SDL_GL_GetProcAddress( "glDrawBuffersEXT" );
		}
		
	#endif

		GL_texture_float=SDL_GL_ExtensionSupported( "GL_OES_texture_float" );
		
		GL_texture_half_float=SDL_GL_ExtensionSupported( "GL_OES_texture_half_float" );
		
		GL_depth_texture=SDL_GL_ExtensionSupported( "GL_OES_depth_texture" );
	
		printf( "GL_draw_buffers=%i\n",int( GL_draw_buffers ) );
		printf( "GL_texture_float=%i\n",int( GL_texture_float ) );
		printf( "GL_texture_half_float=%i\n",int( GL_texture_half_float ) );
		printf( "GL_depth_texture=%i\n",int( GL_depth_texture ) );
		
		fflush( stdout );
	}
	
}