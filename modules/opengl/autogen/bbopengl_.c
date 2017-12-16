
#define GLAPI

#include "bbopengl.h"

#include <stdio.h>

#if __EMSCRIPTEN__

void GLAPIENTRY glClearDepthf( GLclampf depth );

void GLAPIENTRY bbglClearDepth( GLclampd depth ){

	glClearDepthf( (GLclampf)depth );
}

#else

#define SDL_GL_CONTEXT_PROFILE_MASK		21
#define SDL_GL_CONTEXT_PROFILE_ES		0x0004 

void *SDL_GL_GetProcAddress( const char *proc );
int SDL_GL_ExtensionSupported( const char *ext );
int SDL_GL_GetAttribute( int attr,int *value );

void (GLAPIENTRY*bbglClearDepthf)( GLclampf depth );

void GLAPIENTRY bbglClearDepthd( GLclampd depth ){

	bbglClearDepthf( (GLclampf)depth );
}

#endif

void bbglInit(){

#if __EMSCRIPTEN__

	BBGL_ES=1;

	BBGL_draw_buffers=SDL_GL_ExtensionSupported( "GL_WEBGL_draw_buffers" );
		
#else

${INITS}

	int profile=0;
	SDL_GL_GetAttribute( SDL_GL_CONTEXT_PROFILE_MASK,&profile );
	BBGL_ES=( profile==SDL_GL_CONTEXT_PROFILE_ES );

	if( BBGL_ES ){
		
		bbglClearDepthf=SDL_GL_GetProcAddress( "glClearDepthf" );
		bbglClearDepth=bbglClearDepthd;
		
		if( BBGL_draw_buffers=SDL_GL_ExtensionSupported( "GL_EXT_draw_buffers" ) ){			//For MRTSs
			
			bbglDrawBuffers=SDL_GL_GetProcAddress( "glDrawBuffersEXT" );
			
		}else if( BBGL_draw_buffers=SDL_GL_ExtensionSupported( "GL_NV_draw_buffers" ) ){	//For MRTs on nvidia shield!
		
			bbglDrawBuffers=SDL_GL_GetProcAddress( "glDrawBuffersNV" );
		}
		
	}else if( bbglDrawBuffers ){
	
		BBGL_draw_buffers=1;
	}

#endif
	
	BBGL_depth_texture=SDL_GL_ExtensionSupported( "GL_EXT_depth_texture" ) || 
		SDL_GL_ExtensionSupported( "GL_ANGLE_depth_texture" ) ||
		SDL_GL_ExtensionSupported( "GL_WEBGL_depth_texture" ) ||
		SDL_GL_ExtensionSupported( "GL_OES_depth_texture" );
	
	BBGL_seamless_cube_map=SDL_GL_ExtensionSupported( "GL_ARB_seamless_cube_map" );
		
	BBGL_texture_filter_anisotropic=SDL_GL_ExtensionSupported( "GL_ARB_texture_filter_anisotropic" ) ||
		SDL_GL_ExtensionSupported( "GL_EXT_texture_filter_anisotropic" );
		
	BBGL_standard_derivatives=!BBGL_ES  || SDL_GL_ExtensionSupported( "GL_OES_standard_derivatives" );
}
