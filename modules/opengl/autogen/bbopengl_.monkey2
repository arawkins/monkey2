
'Note: This module actually has a depdndancy on SDL2, but we don't talk about that as it would create a circular dependancy.

Namespace opengl

#If __TARGET__="windows"

#If __ARCH__="x86"

	#Import "../angle/bin/libEGL.dll"
	#Import "../angle/bin/libGLESv2.dll"
	#Import "../angle/bin/d3dcompiler_47.dll"
	
#Elseif __ARCH__="x64"

	#Import "../angle/bin/x64/libEGL.dll"
	#Import "../angle/bin/x64/libGLESv2.dll"
	#Import "../angle/bin/x64/d3dcompiler_47.dll"
	
#endif

'	#include <GL/gl.h>	

	#Import "bbopengl.c"
	#Import "bbopengl.h"

#Else If __TARGET__="macos"
	
	#Import "<OpenGL.framework>"
	
'	#include <OpenGL/gl.h>

	#Import "bbopengl.c"
	#Import "bbopengl.h"
		
#Else If __TARGET__="linux"
 	
	#Import "<libGL.a>"
	
'	#define GL_GLEXT_PROTOTYPES
'	#include <GL/gl.h>

	#Import "bbopengl.c"
	#Import "bbopengl.h"
		
#Else If __TARGET__="raspbian"
	
	#Import "<libGLESv1_CM.a>"
	#Import "<libGLESv2.a>"
	#Import "<libEGL.a>"
	
'	#Import "<GLES2/gl2.h>"
		
	#Import "bbopengl.c"
	#Import "bbopengl.h"
	
#Else If __TARGET__="emscripten"
	
'	#Import "<GLES2/gl2.h>"

	#Import "bbopengl.c"
	#Import "bbopengl.h"
	
#Else If __TARGET__="android"

	#Import "<libGLESv1_CM.a>"
	#Import "<libGLESv2.a>"
	
'	#Import "<GLES2/gl2.h>"
	
	#Import "bbopengl.c"
	#Import "bbopengl.h"
	
#Else If __TARGET__="ios"

	#Import "<OpenGLES.framework>"
	
'	#import "<OpenGLES/ES2/gl.h>"
	
	#Import "bbopengl.c"
	#Import "bbopengl.h"
	
#Endif

Extern

Alias GLvoid:Void
Alias GLenum:UInt
Alias GLboolean:Bool
Alias GLbitfield:UInt
Alias GLbyte:Byte
Alias GLshort:Short
Alias GLint:Int
Alias GLsizei:Int
Alias GLubyte:UByte
Alias GLushort:UShort
Alias GLuint:UInt
Alias GLfloat:Float
Alias GLclampf:Float
Alias GLdouble:Double
Alias GLclampd:Double
Alias GLfixed:Int
Alias GLclampx:Int
Alias GLintptr:Long
Alias GLsizeiptr:Long

Struct GLchar="GLchar"
End

Struct GLcchar="const GLchar"
End

Function bbglInit()

Global BBGL_ES:Bool

Global BBGL_draw_buffers:Bool
Global BBGL_depth_texture:Bool
Global BBGL_seamless_cube_map:Bool
Global BBGL_texture_filter_anisotropic:Bool
Global BBGL_standard_derivatives:Bool

${DEFS}

${DECLS}

