
Namespace mojo.graphics.glutil

Private

Global tmpi:Int

Public

#rem monkeydoc @hidden
#end
Global glGraphicsSeq:Int=1

#rem monkeydoc @hidden
#end
Function glCheck()
	Local err:=glGetError()
	If err=GL_NO_ERROR Return
	Assert( False,"GL ERROR! err="+err )
End

#rem monkeydoc @hidden
#end
Function glFormat:GLenum( format:PixelFormat )
	Select format
	Case PixelFormat.A8 Return GL_ALPHA
	Case PixelFormat.I8 Return GL_LUMINANCE
	Case PixelFormat.IA16 Return GL_LUMINANCE_ALPHA
	Case PixelFormat.RGB24 Return GL_RGB
	Case PixelFormat.RGBA32 Return GL_RGBA
	End
	Assert( False,"Invalidate PixelFormat" )
	Return GL_RGBA
End

#rem monkeydoc @hidden
#end
Function glPushTexture2d:Void( tex:Int )
	glGetIntegerv( GL_TEXTURE_BINDING_2D,Varptr tmpi )
	glBindTexture( GL_TEXTURE_2D,tex )
End

#rem monkeydoc @hidden
#end
Function glPopTexture2d:Void()
	glBindTexture( GL_TEXTURE_2D,tmpi )
End

#rem monkeydoc @hidden
#end
Function glPushArrayBuffer( buf:Int )
	glGetIntegerv( GL_ARRAY_BUFFER_BINDING,Varptr tmpi )
	glBindBuffer( GL_ARRAY_BUFFER,buf )
End

#rem monkeydoc @hidden
#end
Function glPopArrayBuffer()
	glBindBuffer( GL_ARRAY_BUFFER,tmpi )
End

#rem monkeydoc @hidden
#end
Function glPushElementArrayBuffer( buf:Int )
	glGetIntegerv( GL_ELEMENT_ARRAY_BUFFER_BINDING,Varptr tmpi )
	glBindBuffer( GL_ELEMENT_ARRAY_BUFFER,buf )
End

#rem monkeydoc @hidden
#end
Function glPopElementArrayBuffer()
	glBindBuffer( GL_ELEMENT_ARRAY_BUFFER,tmpi )
End

#rem monkeydoc @hidden
#end
Function glPushFramebuffer:Void( framebuf:Int )
	glGetIntegerv( GL_FRAMEBUFFER_BINDING,Varptr tmpi )
	glBindFramebuffer( GL_FRAMEBUFFER,framebuf )
End

#rem monkeydoc @hidden
#end
Function glPopFramebuffer:Void()
	glBindFramebuffer( GL_FRAMEBUFFER,tmpi )
End

#rem monkeydoc @hidden
#end
Function glCompile:Int( type:Int,source:String )

	source="
	#if GL_ES
	#if GL_FRAGMENT_PRECISION_HIGH
	precision highp float;
	#else
	precision mediump float;
	#endif
	#endif
	"+source
	
	Local shader:=glCreateShader( type )
	glShaderSourceEx( shader,source )
	glCompileShader( shader )
	glGetShaderiv( shader,GL_COMPILE_STATUS,Varptr tmpi )
	If Not tmpi
		Local lines:=source.Split( "~n" )
		For Local i:=0 Until lines.Length
			Print (i+1)+":~t"+lines[i]
		Next
		RuntimeError( "Failed to compile fragment shader:"+glGetShaderInfoLogEx( shader ) )
	Endif
	Return shader
End

#rem monkeydoc @hidden
#end
Function glLink:Void( program:Int )
	glLinkProgram( program )
	glGetProgramiv( program,GL_LINK_STATUS,Varptr tmpi )
	If Not tmpi RuntimeError( "Failed to link program:"+glGetProgramInfoLogEx( program ) )
End
