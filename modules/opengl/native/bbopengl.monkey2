
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

Const GL_VERSION_1_1:Int
Const GL_ZERO:Int
Const GL_FALSE:Int
Const GL_LOGIC_OP:Int
Const GL_NONE:Int
Const GL_TEXTURE_COMPONENTS:Int
Const GL_NO_ERROR:Int
Const GL_POINTS:Int
Const GL_CURRENT_BIT:Int
Const GL_TRUE:Int
Const GL_ONE:Int
Const GL_CLIENT_PIXEL_STORE_BIT:Int
Const GL_LINES:Int
Const GL_LINE_LOOP:Int
Const GL_POINT_BIT:Int
Const GL_CLIENT_VERTEX_ARRAY_BIT:Int
Const GL_LINE_STRIP:Int
Const GL_LINE_BIT:Int
Const GL_TRIANGLES:Int
Const GL_TRIANGLE_STRIP:Int
Const GL_TRIANGLE_FAN:Int
Const GL_QUADS:Int
Const GL_QUAD_STRIP:Int
Const GL_POLYGON_BIT:Int
Const GL_POLYGON:Int
Const GL_POLYGON_STIPPLE_BIT:Int
Const GL_PIXEL_MODE_BIT:Int
Const GL_LIGHTING_BIT:Int
Const GL_FOG_BIT:Int
Const GL_DEPTH_BUFFER_BIT:Int
Const GL_ACCUM:Int
Const GL_LOAD:Int
Const GL_RETURN:Int
Const GL_MULT:Int
Const GL_ADD:Int
Const GL_NEVER:Int
Const GL_ACCUM_BUFFER_BIT:Int
Const GL_LESS:Int
Const GL_EQUAL:Int
Const GL_LEQUAL:Int
Const GL_GREATER:Int
Const GL_NOTEQUAL:Int
Const GL_GEQUAL:Int
Const GL_ALWAYS:Int
Const GL_SRC_COLOR:Int
Const GL_ONE_MINUS_SRC_COLOR:Int
Const GL_SRC_ALPHA:Int
Const GL_ONE_MINUS_SRC_ALPHA:Int
Const GL_DST_ALPHA:Int
Const GL_ONE_MINUS_DST_ALPHA:Int
Const GL_DST_COLOR:Int
Const GL_ONE_MINUS_DST_COLOR:Int
Const GL_SRC_ALPHA_SATURATE:Int
Const GL_STENCIL_BUFFER_BIT:Int
Const GL_FRONT_LEFT:Int
Const GL_FRONT_RIGHT:Int
Const GL_BACK_LEFT:Int
Const GL_BACK_RIGHT:Int
Const GL_FRONT:Int
Const GL_BACK:Int
Const GL_LEFT:Int
Const GL_RIGHT:Int
Const GL_FRONT_AND_BACK:Int
Const GL_AUX0:Int
Const GL_AUX1:Int
Const GL_AUX2:Int
Const GL_AUX3:Int
Const GL_INVALID_ENUM:Int
Const GL_INVALID_VALUE:Int
Const GL_INVALID_OPERATION:Int
Const GL_STACK_OVERFLOW:Int
Const GL_STACK_UNDERFLOW:Int
Const GL_OUT_OF_MEMORY:Int
Const GL_2D:Int
Const GL_3D:Int
Const GL_3D_COLOR:Int
Const GL_3D_COLOR_TEXTURE:Int
Const GL_4D_COLOR_TEXTURE:Int
Const GL_PASS_THROUGH_TOKEN:Int
Const GL_POINT_TOKEN:Int
Const GL_LINE_TOKEN:Int
Const GL_POLYGON_TOKEN:Int
Const GL_BITMAP_TOKEN:Int
Const GL_DRAW_PIXEL_TOKEN:Int
Const GL_COPY_PIXEL_TOKEN:Int
Const GL_LINE_RESET_TOKEN:Int
Const GL_EXP:Int
Const GL_VIEWPORT_BIT:Int
Const GL_EXP2:Int
Const GL_CW:Int
Const GL_CCW:Int
Const GL_COEFF:Int
Const GL_ORDER:Int
Const GL_DOMAIN:Int
Const GL_CURRENT_COLOR:Int
Const GL_CURRENT_INDEX:Int
Const GL_CURRENT_NORMAL:Int
Const GL_CURRENT_TEXTURE_COORDS:Int
Const GL_CURRENT_RASTER_COLOR:Int
Const GL_CURRENT_RASTER_INDEX:Int
Const GL_CURRENT_RASTER_TEXTURE_COORDS:Int
Const GL_CURRENT_RASTER_POSITION:Int
Const GL_CURRENT_RASTER_POSITION_VALID:Int
Const GL_CURRENT_RASTER_DISTANCE:Int
Const GL_POINT_SMOOTH:Int
Const GL_POINT_SIZE:Int
Const GL_POINT_SIZE_RANGE:Int
Const GL_POINT_SIZE_GRANULARITY:Int
Const GL_LINE_SMOOTH:Int
Const GL_LINE_WIDTH:Int
Const GL_LINE_WIDTH_RANGE:Int
Const GL_LINE_WIDTH_GRANULARITY:Int
Const GL_LINE_STIPPLE:Int
Const GL_LINE_STIPPLE_PATTERN:Int
Const GL_LINE_STIPPLE_REPEAT:Int
Const GL_LIST_MODE:Int
Const GL_MAX_LIST_NESTING:Int
Const GL_LIST_BASE:Int
Const GL_LIST_INDEX:Int
Const GL_POLYGON_MODE:Int
Const GL_POLYGON_SMOOTH:Int
Const GL_POLYGON_STIPPLE:Int
Const GL_EDGE_FLAG:Int
Const GL_CULL_FACE:Int
Const GL_CULL_FACE_MODE:Int
Const GL_FRONT_FACE:Int
Const GL_LIGHTING:Int
Const GL_LIGHT_MODEL_LOCAL_VIEWER:Int
Const GL_LIGHT_MODEL_TWO_SIDE:Int
Const GL_LIGHT_MODEL_AMBIENT:Int
Const GL_SHADE_MODEL:Int
Const GL_COLOR_MATERIAL_FACE:Int
Const GL_COLOR_MATERIAL_PARAMETER:Int
Const GL_COLOR_MATERIAL:Int
Const GL_FOG:Int
Const GL_FOG_INDEX:Int
Const GL_FOG_DENSITY:Int
Const GL_FOG_START:Int
Const GL_FOG_END:Int
Const GL_FOG_MODE:Int
Const GL_FOG_COLOR:Int
Const GL_DEPTH_RANGE:Int
Const GL_DEPTH_TEST:Int
Const GL_DEPTH_WRITEMASK:Int
Const GL_DEPTH_CLEAR_VALUE:Int
Const GL_DEPTH_FUNC:Int
Const GL_ACCUM_CLEAR_VALUE:Int
Const GL_STENCIL_TEST:Int
Const GL_STENCIL_CLEAR_VALUE:Int
Const GL_STENCIL_FUNC:Int
Const GL_STENCIL_VALUE_MASK:Int
Const GL_STENCIL_FAIL:Int
Const GL_STENCIL_PASS_DEPTH_FAIL:Int
Const GL_STENCIL_PASS_DEPTH_PASS:Int
Const GL_STENCIL_REF:Int
Const GL_STENCIL_WRITEMASK:Int
Const GL_MATRIX_MODE:Int
Const GL_NORMALIZE:Int
Const GL_VIEWPORT:Int
Const GL_MODELVIEW_STACK_DEPTH:Int
Const GL_PROJECTION_STACK_DEPTH:Int
Const GL_TEXTURE_STACK_DEPTH:Int
Const GL_MODELVIEW_MATRIX:Int
Const GL_PROJECTION_MATRIX:Int
Const GL_TEXTURE_MATRIX:Int
Const GL_ATTRIB_STACK_DEPTH:Int
Const GL_CLIENT_ATTRIB_STACK_DEPTH:Int
Const GL_ALPHA_TEST:Int
Const GL_ALPHA_TEST_FUNC:Int
Const GL_ALPHA_TEST_REF:Int
Const GL_DITHER:Int
Const GL_BLEND_DST:Int
Const GL_BLEND_SRC:Int
Const GL_BLEND:Int
Const GL_LOGIC_OP_MODE:Int
Const GL_INDEX_LOGIC_OP:Int
Const GL_COLOR_LOGIC_OP:Int
Const GL_AUX_BUFFERS:Int
Const GL_DRAW_BUFFER:Int
Const GL_READ_BUFFER:Int
Const GL_SCISSOR_BOX:Int
Const GL_SCISSOR_TEST:Int
Const GL_INDEX_CLEAR_VALUE:Int
Const GL_INDEX_WRITEMASK:Int
Const GL_COLOR_CLEAR_VALUE:Int
Const GL_COLOR_WRITEMASK:Int
Const GL_INDEX_MODE:Int
Const GL_RGBA_MODE:Int
Const GL_DOUBLEBUFFER:Int
Const GL_STEREO:Int
Const GL_RENDER_MODE:Int
Const GL_PERSPECTIVE_CORRECTION_HINT:Int
Const GL_POINT_SMOOTH_HINT:Int
Const GL_LINE_SMOOTH_HINT:Int
Const GL_POLYGON_SMOOTH_HINT:Int
Const GL_FOG_HINT:Int
Const GL_TEXTURE_GEN_S:Int
Const GL_TEXTURE_GEN_T:Int
Const GL_TEXTURE_GEN_R:Int
Const GL_TEXTURE_GEN_Q:Int
Const GL_PIXEL_MAP_I_TO_I:Int
Const GL_PIXEL_MAP_S_TO_S:Int
Const GL_PIXEL_MAP_I_TO_R:Int
Const GL_PIXEL_MAP_I_TO_G:Int
Const GL_PIXEL_MAP_I_TO_B:Int
Const GL_PIXEL_MAP_I_TO_A:Int
Const GL_PIXEL_MAP_R_TO_R:Int
Const GL_PIXEL_MAP_G_TO_G:Int
Const GL_PIXEL_MAP_B_TO_B:Int
Const GL_PIXEL_MAP_A_TO_A:Int
Const GL_PIXEL_MAP_I_TO_I_SIZE:Int
Const GL_PIXEL_MAP_S_TO_S_SIZE:Int
Const GL_PIXEL_MAP_I_TO_R_SIZE:Int
Const GL_PIXEL_MAP_I_TO_G_SIZE:Int
Const GL_PIXEL_MAP_I_TO_B_SIZE:Int
Const GL_PIXEL_MAP_I_TO_A_SIZE:Int
Const GL_PIXEL_MAP_R_TO_R_SIZE:Int
Const GL_PIXEL_MAP_G_TO_G_SIZE:Int
Const GL_PIXEL_MAP_B_TO_B_SIZE:Int
Const GL_PIXEL_MAP_A_TO_A_SIZE:Int
Const GL_UNPACK_SWAP_BYTES:Int
Const GL_UNPACK_LSB_FIRST:Int
Const GL_UNPACK_ROW_LENGTH:Int
Const GL_UNPACK_SKIP_ROWS:Int
Const GL_UNPACK_SKIP_PIXELS:Int
Const GL_UNPACK_ALIGNMENT:Int
Const GL_PACK_SWAP_BYTES:Int
Const GL_PACK_LSB_FIRST:Int
Const GL_PACK_ROW_LENGTH:Int
Const GL_PACK_SKIP_ROWS:Int
Const GL_PACK_SKIP_PIXELS:Int
Const GL_PACK_ALIGNMENT:Int
Const GL_MAP_COLOR:Int
Const GL_MAP_STENCIL:Int
Const GL_INDEX_SHIFT:Int
Const GL_INDEX_OFFSET:Int
Const GL_RED_SCALE:Int
Const GL_RED_BIAS:Int
Const GL_ZOOM_X:Int
Const GL_ZOOM_Y:Int
Const GL_GREEN_SCALE:Int
Const GL_GREEN_BIAS:Int
Const GL_BLUE_SCALE:Int
Const GL_BLUE_BIAS:Int
Const GL_ALPHA_SCALE:Int
Const GL_ALPHA_BIAS:Int
Const GL_DEPTH_SCALE:Int
Const GL_DEPTH_BIAS:Int
Const GL_MAX_EVAL_ORDER:Int
Const GL_MAX_LIGHTS:Int
Const GL_MAX_CLIP_PLANES:Int
Const GL_MAX_TEXTURE_SIZE:Int
Const GL_MAX_PIXEL_MAP_TABLE:Int
Const GL_MAX_ATTRIB_STACK_DEPTH:Int
Const GL_MAX_MODELVIEW_STACK_DEPTH:Int
Const GL_MAX_NAME_STACK_DEPTH:Int
Const GL_MAX_PROJECTION_STACK_DEPTH:Int
Const GL_MAX_TEXTURE_STACK_DEPTH:Int
Const GL_MAX_VIEWPORT_DIMS:Int
Const GL_MAX_CLIENT_ATTRIB_STACK_DEPTH:Int
Const GL_SUBPIXEL_BITS:Int
Const GL_INDEX_BITS:Int
Const GL_RED_BITS:Int
Const GL_GREEN_BITS:Int
Const GL_BLUE_BITS:Int
Const GL_ALPHA_BITS:Int
Const GL_DEPTH_BITS:Int
Const GL_STENCIL_BITS:Int
Const GL_ACCUM_RED_BITS:Int
Const GL_ACCUM_GREEN_BITS:Int
Const GL_ACCUM_BLUE_BITS:Int
Const GL_ACCUM_ALPHA_BITS:Int
Const GL_NAME_STACK_DEPTH:Int
Const GL_AUTO_NORMAL:Int
Const GL_MAP1_COLOR_4:Int
Const GL_MAP1_INDEX:Int
Const GL_MAP1_NORMAL:Int
Const GL_MAP1_TEXTURE_COORD_1:Int
Const GL_MAP1_TEXTURE_COORD_2:Int
Const GL_MAP1_TEXTURE_COORD_3:Int
Const GL_MAP1_TEXTURE_COORD_4:Int
Const GL_MAP1_VERTEX_3:Int
Const GL_MAP1_VERTEX_4:Int
Const GL_MAP2_COLOR_4:Int
Const GL_MAP2_INDEX:Int
Const GL_MAP2_NORMAL:Int
Const GL_MAP2_TEXTURE_COORD_1:Int
Const GL_MAP2_TEXTURE_COORD_2:Int
Const GL_MAP2_TEXTURE_COORD_3:Int
Const GL_MAP2_TEXTURE_COORD_4:Int
Const GL_MAP2_VERTEX_3:Int
Const GL_MAP2_VERTEX_4:Int
Const GL_MAP1_GRID_DOMAIN:Int
Const GL_MAP1_GRID_SEGMENTS:Int
Const GL_MAP2_GRID_DOMAIN:Int
Const GL_MAP2_GRID_SEGMENTS:Int
Const GL_TEXTURE_1D:Int
Const GL_TEXTURE_2D:Int
Const GL_FEEDBACK_BUFFER_POINTER:Int
Const GL_FEEDBACK_BUFFER_SIZE:Int
Const GL_FEEDBACK_BUFFER_TYPE:Int
Const GL_SELECTION_BUFFER_POINTER:Int
Const GL_SELECTION_BUFFER_SIZE:Int
Const GL_TEXTURE_WIDTH:Int
Const GL_TRANSFORM_BIT:Int
Const GL_TEXTURE_HEIGHT:Int
Const GL_TEXTURE_INTERNAL_FORMAT:Int
Const GL_TEXTURE_BORDER_COLOR:Int
Const GL_TEXTURE_BORDER:Int
Const GL_DONT_CARE:Int
Const GL_FASTEST:Int
Const GL_NICEST:Int
Const GL_AMBIENT:Int
Const GL_DIFFUSE:Int
Const GL_SPECULAR:Int
Const GL_POSITION:Int
Const GL_SPOT_DIRECTION:Int
Const GL_SPOT_EXPONENT:Int
Const GL_SPOT_CUTOFF:Int
Const GL_CONSTANT_ATTENUATION:Int
Const GL_LINEAR_ATTENUATION:Int
Const GL_QUADRATIC_ATTENUATION:Int
Const GL_COMPILE:Int
Const GL_COMPILE_AND_EXECUTE:Int
Const GL_BYTE:Int
Const GL_UNSIGNED_BYTE:Int
Const GL_SHORT:Int
Const GL_UNSIGNED_SHORT:Int
Const GL_INT:Int
Const GL_UNSIGNED_INT:Int
Const GL_FLOAT:Int
Const GL_2_BYTES:Int
Const GL_3_BYTES:Int
Const GL_4_BYTES:Int
Const GL_DOUBLE:Int
Const GL_CLEAR:Int
Const GL_AND:Int
Const GL_AND_REVERSE:Int
Const GL_COPY:Int
Const GL_AND_INVERTED:Int
Const GL_NOOP:Int
Const GL_XOR:Int
Const GL_OR:Int
Const GL_NOR:Int
Const GL_EQUIV:Int
Const GL_INVERT:Int
Const GL_OR_REVERSE:Int
Const GL_COPY_INVERTED:Int
Const GL_OR_INVERTED:Int
Const GL_NAND:Int
Const GL_SET:Int
Const GL_EMISSION:Int
Const GL_SHININESS:Int
Const GL_AMBIENT_AND_DIFFUSE:Int
Const GL_COLOR_INDEXES:Int
Const GL_MODELVIEW:Int
Const GL_PROJECTION:Int
Const GL_TEXTURE:Int
Const GL_COLOR:Int
Const GL_DEPTH:Int
Const GL_STENCIL:Int
Const GL_COLOR_INDEX:Int
Const GL_STENCIL_INDEX:Int
Const GL_DEPTH_COMPONENT:Int
Const GL_RED:Int
Const GL_GREEN:Int
Const GL_BLUE:Int
Const GL_ALPHA:Int
Const GL_RGB:Int
Const GL_RGBA:Int
Const GL_LUMINANCE:Int
Const GL_LUMINANCE_ALPHA:Int
Const GL_BITMAP:Int
Const GL_POINT:Int
Const GL_LINE:Int
Const GL_FILL:Int
Const GL_RENDER:Int
Const GL_FEEDBACK:Int
Const GL_SELECT:Int
Const GL_FLAT:Int
Const GL_SMOOTH:Int
Const GL_KEEP:Int
Const GL_REPLACE:Int
Const GL_INCR:Int
Const GL_DECR:Int
Const GL_VENDOR:Int
Const GL_RENDERER:Int
Const GL_VERSION:Int
Const GL_EXTENSIONS:Int
Const GL_S:Int
Const GL_ENABLE_BIT:Int
Const GL_T:Int
Const GL_R:Int
Const GL_Q:Int
Const GL_MODULATE:Int
Const GL_DECAL:Int
Const GL_TEXTURE_ENV_MODE:Int
Const GL_TEXTURE_ENV_COLOR:Int
Const GL_TEXTURE_ENV:Int
Const GL_EYE_LINEAR:Int
Const GL_OBJECT_LINEAR:Int
Const GL_SPHERE_MAP:Int
Const GL_TEXTURE_GEN_MODE:Int
Const GL_OBJECT_PLANE:Int
Const GL_EYE_PLANE:Int
Const GL_NEAREST:Int
Const GL_LINEAR:Int
Const GL_NEAREST_MIPMAP_NEAREST:Int
Const GL_LINEAR_MIPMAP_NEAREST:Int
Const GL_NEAREST_MIPMAP_LINEAR:Int
Const GL_LINEAR_MIPMAP_LINEAR:Int
Const GL_TEXTURE_MAG_FILTER:Int
Const GL_TEXTURE_MIN_FILTER:Int
Const GL_TEXTURE_WRAP_S:Int
Const GL_TEXTURE_WRAP_T:Int
Const GL_CLAMP:Int
Const GL_REPEAT:Int
Const GL_POLYGON_OFFSET_UNITS:Int
Const GL_POLYGON_OFFSET_POINT:Int
Const GL_POLYGON_OFFSET_LINE:Int
Const GL_R3_G3_B2:Int
Const GL_V2F:Int
Const GL_V3F:Int
Const GL_C4UB_V2F:Int
Const GL_C4UB_V3F:Int
Const GL_C3F_V3F:Int
Const GL_N3F_V3F:Int
Const GL_C4F_N3F_V3F:Int
Const GL_T2F_V3F:Int
Const GL_T4F_V4F:Int
Const GL_T2F_C4UB_V3F:Int
Const GL_T2F_C3F_V3F:Int
Const GL_T2F_N3F_V3F:Int
Const GL_T2F_C4F_N3F_V3F:Int
Const GL_T4F_C4F_N3F_V4F:Int
Const GL_CLIP_PLANE0:Int
Const GL_CLIP_PLANE1:Int
Const GL_CLIP_PLANE2:Int
Const GL_CLIP_PLANE3:Int
Const GL_CLIP_PLANE4:Int
Const GL_CLIP_PLANE5:Int
Const GL_LIGHT0:Int
Const GL_COLOR_BUFFER_BIT:Int
Const GL_LIGHT1:Int
Const GL_LIGHT2:Int
Const GL_LIGHT3:Int
Const GL_LIGHT4:Int
Const GL_LIGHT5:Int
Const GL_LIGHT6:Int
Const GL_LIGHT7:Int
Const GL_HINT_BIT:Int
Const GL_POLYGON_OFFSET_FILL:Int
Const GL_POLYGON_OFFSET_FACTOR:Int
Const GL_ALPHA4:Int
Const GL_ALPHA8:Int
Const GL_ALPHA12:Int
Const GL_ALPHA16:Int
Const GL_LUMINANCE4:Int
Const GL_LUMINANCE8:Int
Const GL_LUMINANCE12:Int
Const GL_LUMINANCE16:Int
Const GL_LUMINANCE4_ALPHA4:Int
Const GL_LUMINANCE6_ALPHA2:Int
Const GL_LUMINANCE8_ALPHA8:Int
Const GL_LUMINANCE12_ALPHA4:Int
Const GL_LUMINANCE12_ALPHA12:Int
Const GL_LUMINANCE16_ALPHA16:Int
Const GL_INTENSITY:Int
Const GL_INTENSITY4:Int
Const GL_INTENSITY8:Int
Const GL_INTENSITY12:Int
Const GL_INTENSITY16:Int
Const GL_RGB4:Int
Const GL_RGB5:Int
Const GL_RGB8:Int
Const GL_RGB10:Int
Const GL_RGB12:Int
Const GL_RGB16:Int
Const GL_RGBA2:Int
Const GL_RGBA4:Int
Const GL_RGB5_A1:Int
Const GL_RGBA8:Int
Const GL_RGB10_A2:Int
Const GL_RGBA12:Int
Const GL_RGBA16:Int
Const GL_TEXTURE_RED_SIZE:Int
Const GL_TEXTURE_GREEN_SIZE:Int
Const GL_TEXTURE_BLUE_SIZE:Int
Const GL_TEXTURE_ALPHA_SIZE:Int
Const GL_TEXTURE_LUMINANCE_SIZE:Int
Const GL_TEXTURE_INTENSITY_SIZE:Int
Const GL_PROXY_TEXTURE_1D:Int
Const GL_PROXY_TEXTURE_2D:Int
Const GL_TEXTURE_PRIORITY:Int
Const GL_TEXTURE_RESIDENT:Int
Const GL_TEXTURE_BINDING_1D:Int
Const GL_TEXTURE_BINDING_2D:Int
Const GL_VERTEX_ARRAY:Int
Const GL_NORMAL_ARRAY:Int
Const GL_COLOR_ARRAY:Int
Const GL_INDEX_ARRAY:Int
Const GL_TEXTURE_COORD_ARRAY:Int
Const GL_EDGE_FLAG_ARRAY:Int
Const GL_VERTEX_ARRAY_SIZE:Int
Const GL_VERTEX_ARRAY_TYPE:Int
Const GL_VERTEX_ARRAY_STRIDE:Int
Const GL_NORMAL_ARRAY_TYPE:Int
Const GL_NORMAL_ARRAY_STRIDE:Int
Const GL_COLOR_ARRAY_SIZE:Int
Const GL_COLOR_ARRAY_TYPE:Int
Const GL_COLOR_ARRAY_STRIDE:Int
Const GL_INDEX_ARRAY_TYPE:Int
Const GL_INDEX_ARRAY_STRIDE:Int
Const GL_TEXTURE_COORD_ARRAY_SIZE:Int
Const GL_TEXTURE_COORD_ARRAY_TYPE:Int
Const GL_TEXTURE_COORD_ARRAY_STRIDE:Int
Const GL_EDGE_FLAG_ARRAY_STRIDE:Int
Const GL_VERTEX_ARRAY_POINTER:Int
Const GL_NORMAL_ARRAY_POINTER:Int
Const GL_COLOR_ARRAY_POINTER:Int
Const GL_INDEX_ARRAY_POINTER:Int
Const GL_TEXTURE_COORD_ARRAY_POINTER:Int
Const GL_EDGE_FLAG_ARRAY_POINTER:Int
Const GL_COLOR_INDEX1_EXT:Int
Const GL_COLOR_INDEX2_EXT:Int
Const GL_COLOR_INDEX4_EXT:Int
Const GL_COLOR_INDEX8_EXT:Int
Const GL_COLOR_INDEX12_EXT:Int
Const GL_COLOR_INDEX16_EXT:Int
Const GL_EVAL_BIT:Int
Const GL_LIST_BIT:Int
Const GL_TEXTURE_BIT:Int
Const GL_SCISSOR_BIT:Int
Const GL_ALL_ATTRIB_BITS:Int
Const GL_CLIENT_ALL_ATTRIB_BITS:Int
Const GL_VERSION_1_2:Int
Const GL_SMOOTH_POINT_SIZE_RANGE:Int
Const GL_SMOOTH_POINT_SIZE_GRANULARITY:Int
Const GL_SMOOTH_LINE_WIDTH_RANGE:Int
Const GL_SMOOTH_LINE_WIDTH_GRANULARITY:Int
Const GL_UNSIGNED_BYTE_3_3_2:Int
Const GL_UNSIGNED_SHORT_4_4_4_4:Int
Const GL_UNSIGNED_SHORT_5_5_5_1:Int
Const GL_UNSIGNED_INT_8_8_8_8:Int
Const GL_UNSIGNED_INT_10_10_10_2:Int
Const GL_RESCALE_NORMAL:Int
Const GL_TEXTURE_BINDING_3D:Int
Const GL_PACK_SKIP_IMAGES:Int
Const GL_PACK_IMAGE_HEIGHT:Int
Const GL_UNPACK_SKIP_IMAGES:Int
Const GL_UNPACK_IMAGE_HEIGHT:Int
Const GL_TEXTURE_3D:Int
Const GL_PROXY_TEXTURE_3D:Int
Const GL_TEXTURE_DEPTH:Int
Const GL_TEXTURE_WRAP_R:Int
Const GL_MAX_3D_TEXTURE_SIZE:Int
Const GL_BGR:Int
Const GL_BGRA:Int
Const GL_MAX_ELEMENTS_VERTICES:Int
Const GL_MAX_ELEMENTS_INDICES:Int
Const GL_CLAMP_TO_EDGE:Int
Const GL_TEXTURE_MIN_LOD:Int
Const GL_TEXTURE_MAX_LOD:Int
Const GL_TEXTURE_BASE_LEVEL:Int
Const GL_TEXTURE_MAX_LEVEL:Int
Const GL_LIGHT_MODEL_COLOR_CONTROL:Int
Const GL_SINGLE_COLOR:Int
Const GL_SEPARATE_SPECULAR_COLOR:Int
Const GL_UNSIGNED_BYTE_2_3_3_REV:Int
Const GL_UNSIGNED_SHORT_5_6_5:Int
Const GL_UNSIGNED_SHORT_5_6_5_REV:Int
Const GL_UNSIGNED_SHORT_4_4_4_4_REV:Int
Const GL_UNSIGNED_SHORT_1_5_5_5_REV:Int
Const GL_UNSIGNED_INT_8_8_8_8_REV:Int
Const GL_ALIASED_POINT_SIZE_RANGE:Int
Const GL_ALIASED_LINE_WIDTH_RANGE:Int
Const GL_VERSION_1_2_1:Int
Const GL_VERSION_1_3:Int
Const GL_MULTISAMPLE:Int
Const GL_SAMPLE_ALPHA_TO_COVERAGE:Int
Const GL_SAMPLE_ALPHA_TO_ONE:Int
Const GL_SAMPLE_COVERAGE:Int
Const GL_SAMPLE_BUFFERS:Int
Const GL_SAMPLES:Int
Const GL_SAMPLE_COVERAGE_VALUE:Int
Const GL_SAMPLE_COVERAGE_INVERT:Int
Const GL_CLAMP_TO_BORDER:Int
Const GL_TEXTURE0:Int
Const GL_TEXTURE1:Int
Const GL_TEXTURE2:Int
Const GL_TEXTURE3:Int
Const GL_TEXTURE4:Int
Const GL_TEXTURE5:Int
Const GL_TEXTURE6:Int
Const GL_TEXTURE7:Int
Const GL_TEXTURE8:Int
Const GL_TEXTURE9:Int
Const GL_TEXTURE10:Int
Const GL_TEXTURE11:Int
Const GL_TEXTURE12:Int
Const GL_TEXTURE13:Int
Const GL_TEXTURE14:Int
Const GL_TEXTURE15:Int
Const GL_TEXTURE16:Int
Const GL_TEXTURE17:Int
Const GL_TEXTURE18:Int
Const GL_TEXTURE19:Int
Const GL_TEXTURE20:Int
Const GL_TEXTURE21:Int
Const GL_TEXTURE22:Int
Const GL_TEXTURE23:Int
Const GL_TEXTURE24:Int
Const GL_TEXTURE25:Int
Const GL_TEXTURE26:Int
Const GL_TEXTURE27:Int
Const GL_TEXTURE28:Int
Const GL_TEXTURE29:Int
Const GL_TEXTURE30:Int
Const GL_TEXTURE31:Int
Const GL_ACTIVE_TEXTURE:Int
Const GL_CLIENT_ACTIVE_TEXTURE:Int
Const GL_MAX_TEXTURE_UNITS:Int
Const GL_TRANSPOSE_MODELVIEW_MATRIX:Int
Const GL_TRANSPOSE_PROJECTION_MATRIX:Int
Const GL_TRANSPOSE_TEXTURE_MATRIX:Int
Const GL_TRANSPOSE_COLOR_MATRIX:Int
Const GL_SUBTRACT:Int
Const GL_COMPRESSED_ALPHA:Int
Const GL_COMPRESSED_LUMINANCE:Int
Const GL_COMPRESSED_LUMINANCE_ALPHA:Int
Const GL_COMPRESSED_INTENSITY:Int
Const GL_COMPRESSED_RGB:Int
Const GL_COMPRESSED_RGBA:Int
Const GL_TEXTURE_COMPRESSION_HINT:Int
Const GL_NORMAL_MAP:Int
Const GL_REFLECTION_MAP:Int
Const GL_TEXTURE_CUBE_MAP:Int
Const GL_TEXTURE_BINDING_CUBE_MAP:Int
Const GL_TEXTURE_CUBE_MAP_POSITIVE_X:Int
Const GL_TEXTURE_CUBE_MAP_NEGATIVE_X:Int
Const GL_TEXTURE_CUBE_MAP_POSITIVE_Y:Int
Const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y:Int
Const GL_TEXTURE_CUBE_MAP_POSITIVE_Z:Int
Const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z:Int
Const GL_PROXY_TEXTURE_CUBE_MAP:Int
Const GL_MAX_CUBE_MAP_TEXTURE_SIZE:Int
Const GL_COMBINE:Int
Const GL_COMBINE_RGB:Int
Const GL_COMBINE_ALPHA:Int
Const GL_RGB_SCALE:Int
Const GL_ADD_SIGNED:Int
Const GL_INTERPOLATE:Int
Const GL_CONSTANT:Int
Const GL_PRIMARY_COLOR:Int
Const GL_PREVIOUS:Int
Const GL_SOURCE0_RGB:Int
Const GL_SOURCE1_RGB:Int
Const GL_SOURCE2_RGB:Int
Const GL_SOURCE0_ALPHA:Int
Const GL_SOURCE1_ALPHA:Int
Const GL_SOURCE2_ALPHA:Int
Const GL_OPERAND0_RGB:Int
Const GL_OPERAND1_RGB:Int
Const GL_OPERAND2_RGB:Int
Const GL_OPERAND0_ALPHA:Int
Const GL_OPERAND1_ALPHA:Int
Const GL_OPERAND2_ALPHA:Int
Const GL_TEXTURE_COMPRESSED_IMAGE_SIZE:Int
Const GL_TEXTURE_COMPRESSED:Int
Const GL_NUM_COMPRESSED_TEXTURE_FORMATS:Int
Const GL_COMPRESSED_TEXTURE_FORMATS:Int
Const GL_DOT3_RGB:Int
Const GL_DOT3_RGBA:Int
Const GL_MULTISAMPLE_BIT:Int
Const GL_VERSION_1_4:Int
Const GL_BLEND_DST_RGB:Int
Const GL_BLEND_SRC_RGB:Int
Const GL_BLEND_DST_ALPHA:Int
Const GL_BLEND_SRC_ALPHA:Int
Const GL_POINT_SIZE_MIN:Int
Const GL_POINT_SIZE_MAX:Int
Const GL_POINT_FADE_THRESHOLD_SIZE:Int
Const GL_POINT_DISTANCE_ATTENUATION:Int
Const GL_GENERATE_MIPMAP:Int
Const GL_GENERATE_MIPMAP_HINT:Int
Const GL_DEPTH_COMPONENT16:Int
Const GL_DEPTH_COMPONENT24:Int
Const GL_DEPTH_COMPONENT32:Int
Const GL_MIRRORED_REPEAT:Int
Const GL_FOG_COORDINATE_SOURCE:Int
Const GL_FOG_COORDINATE:Int
Const GL_FRAGMENT_DEPTH:Int
Const GL_CURRENT_FOG_COORDINATE:Int
Const GL_FOG_COORDINATE_ARRAY_TYPE:Int
Const GL_FOG_COORDINATE_ARRAY_STRIDE:Int
Const GL_FOG_COORDINATE_ARRAY_POINTER:Int
Const GL_FOG_COORDINATE_ARRAY:Int
Const GL_COLOR_SUM:Int
Const GL_CURRENT_SECONDARY_COLOR:Int
Const GL_SECONDARY_COLOR_ARRAY_SIZE:Int
Const GL_SECONDARY_COLOR_ARRAY_TYPE:Int
Const GL_SECONDARY_COLOR_ARRAY_STRIDE:Int
Const GL_SECONDARY_COLOR_ARRAY_POINTER:Int
Const GL_SECONDARY_COLOR_ARRAY:Int
Const GL_MAX_TEXTURE_LOD_BIAS:Int
Const GL_TEXTURE_FILTER_CONTROL:Int
Const GL_TEXTURE_LOD_BIAS:Int
Const GL_INCR_WRAP:Int
Const GL_DECR_WRAP:Int
Const GL_TEXTURE_DEPTH_SIZE:Int
Const GL_DEPTH_TEXTURE_MODE:Int
Const GL_TEXTURE_COMPARE_MODE:Int
Const GL_TEXTURE_COMPARE_FUNC:Int
Const GL_COMPARE_R_TO_TEXTURE:Int
Const GL_VERSION_1_5:Int
Const GL_CURRENT_FOG_COORD:Int
Const GL_FOG_COORD:Int
Const GL_FOG_COORD_ARRAY:Int
Const GL_FOG_COORD_ARRAY_BUFFER_BINDING:Int
Const GL_FOG_COORD_ARRAY_POINTER:Int
Const GL_FOG_COORD_ARRAY_STRIDE:Int
Const GL_FOG_COORD_ARRAY_TYPE:Int
Const GL_FOG_COORD_SRC:Int
Const GL_SRC0_ALPHA:Int
Const GL_SRC0_RGB:Int
Const GL_SRC1_ALPHA:Int
Const GL_SRC1_RGB:Int
Const GL_SRC2_ALPHA:Int
Const GL_SRC2_RGB:Int
Const GL_BUFFER_SIZE:Int
Const GL_BUFFER_USAGE:Int
Const GL_QUERY_COUNTER_BITS:Int
Const GL_CURRENT_QUERY:Int
Const GL_QUERY_RESULT:Int
Const GL_QUERY_RESULT_AVAILABLE:Int
Const GL_ARRAY_BUFFER:Int
Const GL_ELEMENT_ARRAY_BUFFER:Int
Const GL_ARRAY_BUFFER_BINDING:Int
Const GL_ELEMENT_ARRAY_BUFFER_BINDING:Int
Const GL_VERTEX_ARRAY_BUFFER_BINDING:Int
Const GL_NORMAL_ARRAY_BUFFER_BINDING:Int
Const GL_COLOR_ARRAY_BUFFER_BINDING:Int
Const GL_INDEX_ARRAY_BUFFER_BINDING:Int
Const GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING:Int
Const GL_EDGE_FLAG_ARRAY_BUFFER_BINDING:Int
Const GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING:Int
Const GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING:Int
Const GL_WEIGHT_ARRAY_BUFFER_BINDING:Int
Const GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING:Int
Const GL_READ_ONLY:Int
Const GL_WRITE_ONLY:Int
Const GL_READ_WRITE:Int
Const GL_BUFFER_ACCESS:Int
Const GL_BUFFER_MAPPED:Int
Const GL_BUFFER_MAP_POINTER:Int
Const GL_STREAM_DRAW:Int
Const GL_STREAM_READ:Int
Const GL_STREAM_COPY:Int
Const GL_STATIC_DRAW:Int
Const GL_STATIC_READ:Int
Const GL_STATIC_COPY:Int
Const GL_DYNAMIC_DRAW:Int
Const GL_DYNAMIC_READ:Int
Const GL_DYNAMIC_COPY:Int
Const GL_SAMPLES_PASSED:Int
Const GL_VERSION_2_0:Int
Const GL_BLEND_EQUATION_RGB:Int
Const GL_VERTEX_ATTRIB_ARRAY_ENABLED:Int
Const GL_VERTEX_ATTRIB_ARRAY_SIZE:Int
Const GL_VERTEX_ATTRIB_ARRAY_STRIDE:Int
Const GL_VERTEX_ATTRIB_ARRAY_TYPE:Int
Const GL_CURRENT_VERTEX_ATTRIB:Int
Const GL_VERTEX_PROGRAM_POINT_SIZE:Int
Const GL_VERTEX_PROGRAM_TWO_SIDE:Int
Const GL_VERTEX_ATTRIB_ARRAY_POINTER:Int
Const GL_STENCIL_BACK_FUNC:Int
Const GL_STENCIL_BACK_FAIL:Int
Const GL_STENCIL_BACK_PASS_DEPTH_FAIL:Int
Const GL_STENCIL_BACK_PASS_DEPTH_PASS:Int
Const GL_MAX_DRAW_BUFFERS:Int
Const GL_DRAW_BUFFER0:Int
Const GL_DRAW_BUFFER1:Int
Const GL_DRAW_BUFFER2:Int
Const GL_DRAW_BUFFER3:Int
Const GL_DRAW_BUFFER4:Int
Const GL_DRAW_BUFFER5:Int
Const GL_DRAW_BUFFER6:Int
Const GL_DRAW_BUFFER7:Int
Const GL_DRAW_BUFFER8:Int
Const GL_DRAW_BUFFER9:Int
Const GL_DRAW_BUFFER10:Int
Const GL_DRAW_BUFFER11:Int
Const GL_DRAW_BUFFER12:Int
Const GL_DRAW_BUFFER13:Int
Const GL_DRAW_BUFFER14:Int
Const GL_DRAW_BUFFER15:Int
Const GL_BLEND_EQUATION_ALPHA:Int
Const GL_POINT_SPRITE:Int
Const GL_COORD_REPLACE:Int
Const GL_MAX_VERTEX_ATTRIBS:Int
Const GL_VERTEX_ATTRIB_ARRAY_NORMALIZED:Int
Const GL_MAX_TEXTURE_COORDS:Int
Const GL_MAX_TEXTURE_IMAGE_UNITS:Int
Const GL_FRAGMENT_SHADER:Int
Const GL_VERTEX_SHADER:Int
Const GL_MAX_FRAGMENT_UNIFORM_COMPONENTS:Int
Const GL_MAX_VERTEX_UNIFORM_COMPONENTS:Int
Const GL_MAX_VARYING_FLOATS:Int
Const GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS:Int
Const GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS:Int
Const GL_SHADER_TYPE:Int
Const GL_FLOAT_VEC2:Int
Const GL_FLOAT_VEC3:Int
Const GL_FLOAT_VEC4:Int
Const GL_INT_VEC2:Int
Const GL_INT_VEC3:Int
Const GL_INT_VEC4:Int
Const GL_BOOL:Int
Const GL_BOOL_VEC2:Int
Const GL_BOOL_VEC3:Int
Const GL_BOOL_VEC4:Int
Const GL_FLOAT_MAT2:Int
Const GL_FLOAT_MAT3:Int
Const GL_FLOAT_MAT4:Int
Const GL_SAMPLER_1D:Int
Const GL_SAMPLER_2D:Int
Const GL_SAMPLER_3D:Int
Const GL_SAMPLER_CUBE:Int
Const GL_SAMPLER_1D_SHADOW:Int
Const GL_SAMPLER_2D_SHADOW:Int
Const GL_DELETE_STATUS:Int
Const GL_COMPILE_STATUS:Int
Const GL_LINK_STATUS:Int
Const GL_VALIDATE_STATUS:Int
Const GL_INFO_LOG_LENGTH:Int
Const GL_ATTACHED_SHADERS:Int
Const GL_ACTIVE_UNIFORMS:Int
Const GL_ACTIVE_UNIFORM_MAX_LENGTH:Int
Const GL_SHADER_SOURCE_LENGTH:Int
Const GL_ACTIVE_ATTRIBUTES:Int
Const GL_ACTIVE_ATTRIBUTE_MAX_LENGTH:Int
Const GL_FRAGMENT_SHADER_DERIVATIVE_HINT:Int
Const GL_SHADING_LANGUAGE_VERSION:Int
Const GL_CURRENT_PROGRAM:Int
Const GL_POINT_SPRITE_COORD_ORIGIN:Int
Const GL_LOWER_LEFT:Int
Const GL_UPPER_LEFT:Int
Const GL_STENCIL_BACK_REF:Int
Const GL_STENCIL_BACK_VALUE_MASK:Int
Const GL_STENCIL_BACK_WRITEMASK:Int
Const GL_VERSION_2_1:Int
Const GL_CURRENT_RASTER_SECONDARY_COLOR:Int
Const GL_PIXEL_PACK_BUFFER:Int
Const GL_PIXEL_UNPACK_BUFFER:Int
Const GL_PIXEL_PACK_BUFFER_BINDING:Int
Const GL_PIXEL_UNPACK_BUFFER_BINDING:Int
Const GL_FLOAT_MAT2x3:Int
Const GL_FLOAT_MAT2x4:Int
Const GL_FLOAT_MAT3x2:Int
Const GL_FLOAT_MAT3x4:Int
Const GL_FLOAT_MAT4x2:Int
Const GL_FLOAT_MAT4x3:Int
Const GL_SRGB:Int
Const GL_SRGB8:Int
Const GL_SRGB_ALPHA:Int
Const GL_SRGB8_ALPHA8:Int
Const GL_SLUMINANCE_ALPHA:Int
Const GL_SLUMINANCE8_ALPHA8:Int
Const GL_SLUMINANCE:Int
Const GL_SLUMINANCE8:Int
Const GL_COMPRESSED_SRGB:Int
Const GL_COMPRESSED_SRGB_ALPHA:Int
Const GL_COMPRESSED_SLUMINANCE:Int
Const GL_COMPRESSED_SLUMINANCE_ALPHA:Int
Const GL_ARB_seamless_cube_map:Int
Const GL_TEXTURE_CUBE_MAP_SEAMLESS:Int
Const GL_ARB_texture_filter_anisotropic:Int
Const GL_TEXTURE_MAX_ANISOTROPY:Int
Const GL_MAX_TEXTURE_MAX_ANISOTROPY:Int
Const GL_ARB_framebuffer_object:Int
Const GL_INVALID_FRAMEBUFFER_OPERATION:Int
Const GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING:Int
Const GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE:Int
Const GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE:Int
Const GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE:Int
Const GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE:Int
Const GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE:Int
Const GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE:Int
Const GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE:Int
Const GL_FRAMEBUFFER_DEFAULT:Int
Const GL_FRAMEBUFFER_UNDEFINED:Int
Const GL_DEPTH_STENCIL_ATTACHMENT:Int
Const GL_INDEX:Int
Const GL_MAX_RENDERBUFFER_SIZE:Int
Const GL_DEPTH_STENCIL:Int
Const GL_UNSIGNED_INT_24_8:Int
Const GL_DEPTH24_STENCIL8:Int
Const GL_TEXTURE_STENCIL_SIZE:Int
Const GL_UNSIGNED_NORMALIZED:Int
Const GL_DRAW_FRAMEBUFFER_BINDING:Int
Const GL_FRAMEBUFFER_BINDING:Int
Const GL_RENDERBUFFER_BINDING:Int
Const GL_READ_FRAMEBUFFER:Int
Const GL_DRAW_FRAMEBUFFER:Int
Const GL_READ_FRAMEBUFFER_BINDING:Int
Const GL_RENDERBUFFER_SAMPLES:Int
Const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE:Int
Const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME:Int
Const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL:Int
Const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE:Int
Const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER:Int
Const GL_FRAMEBUFFER_COMPLETE:Int
Const GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT:Int
Const GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:Int
Const GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER:Int
Const GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER:Int
Const GL_FRAMEBUFFER_UNSUPPORTED:Int
Const GL_MAX_COLOR_ATTACHMENTS:Int
Const GL_COLOR_ATTACHMENT0:Int
Const GL_COLOR_ATTACHMENT1:Int
Const GL_COLOR_ATTACHMENT2:Int
Const GL_COLOR_ATTACHMENT3:Int
Const GL_COLOR_ATTACHMENT4:Int
Const GL_COLOR_ATTACHMENT5:Int
Const GL_COLOR_ATTACHMENT6:Int
Const GL_COLOR_ATTACHMENT7:Int
Const GL_COLOR_ATTACHMENT8:Int
Const GL_COLOR_ATTACHMENT9:Int
Const GL_COLOR_ATTACHMENT10:Int
Const GL_COLOR_ATTACHMENT11:Int
Const GL_COLOR_ATTACHMENT12:Int
Const GL_COLOR_ATTACHMENT13:Int
Const GL_COLOR_ATTACHMENT14:Int
Const GL_COLOR_ATTACHMENT15:Int
Const GL_DEPTH_ATTACHMENT:Int
Const GL_STENCIL_ATTACHMENT:Int
Const GL_FRAMEBUFFER:Int
Const GL_RENDERBUFFER:Int
Const GL_RENDERBUFFER_WIDTH:Int
Const GL_RENDERBUFFER_HEIGHT:Int
Const GL_RENDERBUFFER_INTERNAL_FORMAT:Int
Const GL_STENCIL_INDEX1:Int
Const GL_STENCIL_INDEX4:Int
Const GL_STENCIL_INDEX8:Int
Const GL_STENCIL_INDEX16:Int
Const GL_RENDERBUFFER_RED_SIZE:Int
Const GL_RENDERBUFFER_GREEN_SIZE:Int
Const GL_RENDERBUFFER_BLUE_SIZE:Int
Const GL_RENDERBUFFER_ALPHA_SIZE:Int
Const GL_RENDERBUFFER_DEPTH_SIZE:Int
Const GL_RENDERBUFFER_STENCIL_SIZE:Int
Const GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE:Int
Const GL_MAX_SAMPLES:Int

Function glAccum:Void(op:GLenum,value:GLfloat)
Function glAlphaFunc:Void(func:GLenum,ref:GLclampf)
Function glAreTexturesResident:GLboolean(n:GLsizei,textures:GLuint Ptr,residences:GLboolean Ptr)
Function glArrayElement:Void(i:GLint)
Function glBegin:Void(mode:GLenum)
Function glBindTexture:Void(target:GLenum,texture:GLuint)
Function glBitmap:Void(width:GLsizei,height:GLsizei,xorig:GLfloat,yorig:GLfloat,xmove:GLfloat,ymove:GLfloat,bitmap:CString)
Function glBlendFunc:Void(sfactor:GLenum,dfactor:GLenum)
Function glCallList:Void(list:GLuint)
Function glCallLists:Void(n:GLsizei,type:GLenum,lists:Void Ptr)
Function glClear:Void(mask:GLbitfield)
Function glClearAccum:Void(red:GLfloat,green:GLfloat,blue:GLfloat,alpha:GLfloat)
Function glClearColor:Void(red:GLclampf,green:GLclampf,blue:GLclampf,alpha:GLclampf)
Function glClearDepth:Void(depth:GLclampd)
Function glClearIndex:Void(c:GLfloat)
Function glClearStencil:Void(s:GLint)
Function glClipPlane:Void(plane:GLenum,equation:GLdouble Ptr)
Function glColor3b:Void(red:GLbyte,green:GLbyte,blue:GLbyte)
Function glColor3bv:Void(v:GLbyte Ptr)
Function glColor3d:Void(red:GLdouble,green:GLdouble,blue:GLdouble)
Function glColor3dv:Void(v:GLdouble Ptr)
Function glColor3f:Void(red:GLfloat,green:GLfloat,blue:GLfloat)
Function glColor3fv:Void(v:GLfloat Ptr)
Function glColor3i:Void(red:GLint,green:GLint,blue:GLint)
Function glColor3iv:Void(v:GLint Ptr)
Function glColor3s:Void(red:GLshort,green:GLshort,blue:GLshort)
Function glColor3sv:Void(v:GLshort Ptr)
Function glColor3ub:Void(red:GLubyte,green:GLubyte,blue:GLubyte)
Function glColor3ubv:Void(v:CString)
Function glColor3ui:Void(red:GLuint,green:GLuint,blue:GLuint)
Function glColor3uiv:Void(v:GLuint Ptr)
Function glColor3us:Void(red:GLushort,green:GLushort,blue:GLushort)
Function glColor3usv:Void(v:GLushort Ptr)
Function glColor4b:Void(red:GLbyte,green:GLbyte,blue:GLbyte,alpha:GLbyte)
Function glColor4bv:Void(v:GLbyte Ptr)
Function glColor4d:Void(red:GLdouble,green:GLdouble,blue:GLdouble,alpha:GLdouble)
Function glColor4dv:Void(v:GLdouble Ptr)
Function glColor4f:Void(red:GLfloat,green:GLfloat,blue:GLfloat,alpha:GLfloat)
Function glColor4fv:Void(v:GLfloat Ptr)
Function glColor4i:Void(red:GLint,green:GLint,blue:GLint,alpha:GLint)
Function glColor4iv:Void(v:GLint Ptr)
Function glColor4s:Void(red:GLshort,green:GLshort,blue:GLshort,alpha:GLshort)
Function glColor4sv:Void(v:GLshort Ptr)
Function glColor4ub:Void(red:GLubyte,green:GLubyte,blue:GLubyte,alpha:GLubyte)
Function glColor4ubv:Void(v:CString)
Function glColor4ui:Void(red:GLuint,green:GLuint,blue:GLuint,alpha:GLuint)
Function glColor4uiv:Void(v:GLuint Ptr)
Function glColor4us:Void(red:GLushort,green:GLushort,blue:GLushort,alpha:GLushort)
Function glColor4usv:Void(v:GLushort Ptr)
Function glColorMask:Void(red:GLboolean,green:GLboolean,blue:GLboolean,alpha:GLboolean)
Function glColorMaterial:Void(face:GLenum,mode:GLenum)
Function glColorPointer:Void(size:GLint,type:GLenum,stride:GLsizei,pointer:Void Ptr)
Function glCopyPixels:Void(x:GLint,y:GLint,width:GLsizei,height:GLsizei,type:GLenum)
Function glCopyTexImage1D:Void(target:GLenum,level:GLint,internalFormat:GLenum,x:GLint,y:GLint,width:GLsizei,border:GLint)
Function glCopyTexImage2D:Void(target:GLenum,level:GLint,internalFormat:GLenum,x:GLint,y:GLint,width:GLsizei,height:GLsizei,border:GLint)
Function glCopyTexSubImage1D:Void(target:GLenum,level:GLint,xoffset:GLint,x:GLint,y:GLint,width:GLsizei)
Function glCopyTexSubImage2D:Void(target:GLenum,level:GLint,xoffset:GLint,yoffset:GLint,x:GLint,y:GLint,width:GLsizei,height:GLsizei)
Function glCullFace:Void(mode:GLenum)
Function glDeleteLists:Void(list:GLuint,range:GLsizei)
Function glDeleteTextures:Void(n:GLsizei,textures:GLuint Ptr)
Function glDepthFunc:Void(func:GLenum)
Function glDepthMask:Void(flag:GLboolean)
Function glDepthRange:Void(zNear:GLclampd,zFar:GLclampd)
Function glDisable:Void(cap:GLenum)
Function glDisableClientState:Void(a:GLenum)
Function glDrawArrays:Void(mode:GLenum,first:GLint,count:GLsizei)
Function glDrawBuffer:Void(mode:GLenum)
Function glDrawElements:Void(mode:GLenum,count:GLsizei,type:GLenum,indices:Void Ptr)
Function glDrawPixels:Void(width:GLsizei,height:GLsizei,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glEdgeFlag:Void(flag:GLboolean)
Function glEdgeFlagPointer:Void(stride:GLsizei,pointer:Void Ptr)
Function glEdgeFlagv:Void(flag:GLboolean Ptr)
Function glEnable:Void(cap:GLenum)
Function glEnableClientState:Void(a:GLenum)
Function glEnd:Void()
Function glEndList:Void()
Function glEvalCoord1d:Void(u:GLdouble)
Function glEvalCoord1dv:Void(u:GLdouble Ptr)
Function glEvalCoord1f:Void(u:GLfloat)
Function glEvalCoord1fv:Void(u:GLfloat Ptr)
Function glEvalCoord2d:Void(u:GLdouble,v:GLdouble)
Function glEvalCoord2dv:Void(u:GLdouble Ptr)
Function glEvalCoord2f:Void(u:GLfloat,v:GLfloat)
Function glEvalCoord2fv:Void(u:GLfloat Ptr)
Function glEvalMesh1:Void(mode:GLenum,i1:GLint,i2:GLint)
Function glEvalMesh2:Void(mode:GLenum,i1:GLint,i2:GLint,j1:GLint,j2:GLint)
Function glEvalPoint1:Void(i:GLint)
Function glEvalPoint2:Void(i:GLint,j:GLint)
Function glFeedbackBuffer:Void(size:GLsizei,type:GLenum,buffer:GLfloat Ptr)
Function glFinish:Void()
Function glFlush:Void()
Function glFogf:Void(pname:GLenum,param:GLfloat)
Function glFogfv:Void(pname:GLenum,params:GLfloat Ptr)
Function glFogi:Void(pname:GLenum,param:GLint)
Function glFogiv:Void(pname:GLenum,params:GLint Ptr)
Function glFrontFace:Void(mode:GLenum)
Function glFrustum:Void(left:GLdouble,right:GLdouble,bottom:GLdouble,top:GLdouble,zNear:GLdouble,zFar:GLdouble)
Function glGenLists:GLuint(range:GLsizei)
Function glGenTextures:Void(n:GLsizei,textures:GLuint Ptr)
Function glGetBooleanv:Void(pname:GLenum,params:GLboolean Ptr)
Function glGetClipPlane:Void(plane:GLenum,equation:GLdouble Ptr)
Function glGetDoublev:Void(pname:GLenum,params:GLdouble Ptr)
Function glGetError:GLenum()
Function glGetFloatv:Void(pname:GLenum,params:GLfloat Ptr)
Function glGetIntegerv:Void(pname:GLenum,params:GLint Ptr)
Function glGetLightfv:Void(light:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glGetLightiv:Void(light:GLenum,pname:GLenum,params:GLint Ptr)
Function glGetMapdv:Void(target:GLenum,query:GLenum,v:GLdouble Ptr)
Function glGetMapfv:Void(target:GLenum,query:GLenum,v:GLfloat Ptr)
Function glGetMapiv:Void(target:GLenum,query:GLenum,v:GLint Ptr)
Function glGetMaterialfv:Void(face:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glGetMaterialiv:Void(face:GLenum,pname:GLenum,params:GLint Ptr)
Function glGetPixelMapfv:Void(map:GLenum,values:GLfloat Ptr)
Function glGetPixelMapuiv:Void(map:GLenum,values:GLuint Ptr)
Function glGetPixelMapusv:Void(map:GLenum,values:GLushort Ptr)
Function glGetPointerv:Void(pname:GLenum,params:Void Ptr Ptr)
Function glGetPolygonStipple:Void(mask:GLubyte Ptr)
Function glGetString:CString(name:GLenum)
Function glGetTexEnvfv:Void(target:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glGetTexEnviv:Void(target:GLenum,pname:GLenum,params:GLint Ptr)
Function glGetTexGendv:Void(coord:GLenum,pname:GLenum,params:GLdouble Ptr)
Function glGetTexGenfv:Void(coord:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glGetTexGeniv:Void(coord:GLenum,pname:GLenum,params:GLint Ptr)
Function glGetTexImage:Void(target:GLenum,level:GLint,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glGetTexLevelParameterfv:Void(target:GLenum,level:GLint,pname:GLenum,params:GLfloat Ptr)
Function glGetTexLevelParameteriv:Void(target:GLenum,level:GLint,pname:GLenum,params:GLint Ptr)
Function glGetTexParameterfv:Void(target:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glGetTexParameteriv:Void(target:GLenum,pname:GLenum,params:GLint Ptr)
Function glHint:Void(target:GLenum,mode:GLenum)
Function glIndexMask:Void(mask:GLuint)
Function glIndexPointer:Void(type:GLenum,stride:GLsizei,pointer:Void Ptr)
Function glIndexd:Void(c:GLdouble)
Function glIndexdv:Void(c:GLdouble Ptr)
Function glIndexf:Void(c:GLfloat)
Function glIndexfv:Void(c:GLfloat Ptr)
Function glIndexi:Void(c:GLint)
Function glIndexiv:Void(c:GLint Ptr)
Function glIndexs:Void(c:GLshort)
Function glIndexsv:Void(c:GLshort Ptr)
Function glIndexub:Void(c:GLubyte)
Function glIndexubv:Void(c:CString)
Function glInitNames:Void()
Function glInterleavedArrays:Void(format:GLenum,stride:GLsizei,pointer:Void Ptr)
Function glIsEnabled:GLboolean(cap:GLenum)
Function glIsList:GLboolean(list:GLuint)
Function glIsTexture:GLboolean(texture:GLuint)
Function glLightModelf:Void(pname:GLenum,param:GLfloat)
Function glLightModelfv:Void(pname:GLenum,params:GLfloat Ptr)
Function glLightModeli:Void(pname:GLenum,param:GLint)
Function glLightModeliv:Void(pname:GLenum,params:GLint Ptr)
Function glLightf:Void(light:GLenum,pname:GLenum,param:GLfloat)
Function glLightfv:Void(light:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glLighti:Void(light:GLenum,pname:GLenum,param:GLint)
Function glLightiv:Void(light:GLenum,pname:GLenum,params:GLint Ptr)
Function glLineStipple:Void(factor:GLint,pattern:GLushort)
Function glLineWidth:Void(width:GLfloat)
Function glListBase:Void(base:GLuint)
Function glLoadIdentity:Void()
Function glLoadMatrixd:Void(m:GLdouble Ptr)
Function glLoadMatrixf:Void(m:GLfloat Ptr)
Function glLoadName:Void(name:GLuint)
Function glLogicOp:Void(opcode:GLenum)
Function glMap1d:Void(target:GLenum,u1:GLdouble,u2:GLdouble,stride:GLint,order:GLint,points:GLdouble Ptr)
Function glMap1f:Void(target:GLenum,u1:GLfloat,u2:GLfloat,stride:GLint,order:GLint,points:GLfloat Ptr)
Function glMap2d:Void(target:GLenum,u1:GLdouble,u2:GLdouble,ustride:GLint,uorder:GLint,v1:GLdouble,v2:GLdouble,vstride:GLint,vorder:GLint,points:GLdouble Ptr)
Function glMap2f:Void(target:GLenum,u1:GLfloat,u2:GLfloat,ustride:GLint,uorder:GLint,v1:GLfloat,v2:GLfloat,vstride:GLint,vorder:GLint,points:GLfloat Ptr)
Function glMapGrid1d:Void(un:GLint,u1:GLdouble,u2:GLdouble)
Function glMapGrid1f:Void(un:GLint,u1:GLfloat,u2:GLfloat)
Function glMapGrid2d:Void(un:GLint,u1:GLdouble,u2:GLdouble,vn:GLint,v1:GLdouble,v2:GLdouble)
Function glMapGrid2f:Void(un:GLint,u1:GLfloat,u2:GLfloat,vn:GLint,v1:GLfloat,v2:GLfloat)
Function glMaterialf:Void(face:GLenum,pname:GLenum,param:GLfloat)
Function glMaterialfv:Void(face:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glMateriali:Void(face:GLenum,pname:GLenum,param:GLint)
Function glMaterialiv:Void(face:GLenum,pname:GLenum,params:GLint Ptr)
Function glMatrixMode:Void(mode:GLenum)
Function glMultMatrixd:Void(m:GLdouble Ptr)
Function glMultMatrixf:Void(m:GLfloat Ptr)
Function glNewList:Void(list:GLuint,mode:GLenum)
Function glNormal3b:Void(nx:GLbyte,ny:GLbyte,nz:GLbyte)
Function glNormal3bv:Void(v:GLbyte Ptr)
Function glNormal3d:Void(nx:GLdouble,ny:GLdouble,nz:GLdouble)
Function glNormal3dv:Void(v:GLdouble Ptr)
Function glNormal3f:Void(nx:GLfloat,ny:GLfloat,nz:GLfloat)
Function glNormal3fv:Void(v:GLfloat Ptr)
Function glNormal3i:Void(nx:GLint,ny:GLint,nz:GLint)
Function glNormal3iv:Void(v:GLint Ptr)
Function glNormal3s:Void(nx:GLshort,ny:GLshort,nz:GLshort)
Function glNormal3sv:Void(v:GLshort Ptr)
Function glNormalPointer:Void(type:GLenum,stride:GLsizei,pointer:Void Ptr)
Function glOrtho:Void(left:GLdouble,right:GLdouble,bottom:GLdouble,top:GLdouble,zNear:GLdouble,zFar:GLdouble)
Function glPassThrough:Void(token:GLfloat)
Function glPixelMapfv:Void(map:GLenum,mapsize:GLsizei,values:GLfloat Ptr)
Function glPixelMapuiv:Void(map:GLenum,mapsize:GLsizei,values:GLuint Ptr)
Function glPixelMapusv:Void(map:GLenum,mapsize:GLsizei,values:GLushort Ptr)
Function glPixelStoref:Void(pname:GLenum,param:GLfloat)
Function glPixelStorei:Void(pname:GLenum,param:GLint)
Function glPixelTransferf:Void(pname:GLenum,param:GLfloat)
Function glPixelTransferi:Void(pname:GLenum,param:GLint)
Function glPixelZoom:Void(xfactor:GLfloat,yfactor:GLfloat)
Function glPointSize:Void(size:GLfloat)
Function glPolygonMode:Void(face:GLenum,mode:GLenum)
Function glPolygonOffset:Void(factor:GLfloat,units:GLfloat)
Function glPolygonStipple:Void(mask:CString)
Function glPopAttrib:Void()
Function glPopClientAttrib:Void()
Function glPopMatrix:Void()
Function glPopName:Void()
Function glPrioritizeTextures:Void(n:GLsizei,textures:GLuint Ptr,priorities:GLclampf Ptr)
Function glPushAttrib:Void(mask:GLbitfield)
Function glPushClientAttrib:Void(mask:GLbitfield)
Function glPushMatrix:Void()
Function glPushName:Void(name:GLuint)
Function glRasterPos2d:Void(x:GLdouble,y:GLdouble)
Function glRasterPos2dv:Void(v:GLdouble Ptr)
Function glRasterPos2f:Void(x:GLfloat,y:GLfloat)
Function glRasterPos2fv:Void(v:GLfloat Ptr)
Function glRasterPos2i:Void(x:GLint,y:GLint)
Function glRasterPos2iv:Void(v:GLint Ptr)
Function glRasterPos2s:Void(x:GLshort,y:GLshort)
Function glRasterPos2sv:Void(v:GLshort Ptr)
Function glRasterPos3d:Void(x:GLdouble,y:GLdouble,z:GLdouble)
Function glRasterPos3dv:Void(v:GLdouble Ptr)
Function glRasterPos3f:Void(x:GLfloat,y:GLfloat,z:GLfloat)
Function glRasterPos3fv:Void(v:GLfloat Ptr)
Function glRasterPos3i:Void(x:GLint,y:GLint,z:GLint)
Function glRasterPos3iv:Void(v:GLint Ptr)
Function glRasterPos3s:Void(x:GLshort,y:GLshort,z:GLshort)
Function glRasterPos3sv:Void(v:GLshort Ptr)
Function glRasterPos4d:Void(x:GLdouble,y:GLdouble,z:GLdouble,w:GLdouble)
Function glRasterPos4dv:Void(v:GLdouble Ptr)
Function glRasterPos4f:Void(x:GLfloat,y:GLfloat,z:GLfloat,w:GLfloat)
Function glRasterPos4fv:Void(v:GLfloat Ptr)
Function glRasterPos4i:Void(x:GLint,y:GLint,z:GLint,w:GLint)
Function glRasterPos4iv:Void(v:GLint Ptr)
Function glRasterPos4s:Void(x:GLshort,y:GLshort,z:GLshort,w:GLshort)
Function glRasterPos4sv:Void(v:GLshort Ptr)
Function glReadBuffer:Void(mode:GLenum)
Function glReadPixels:Void(x:GLint,y:GLint,width:GLsizei,height:GLsizei,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glRectd:Void(x1:GLdouble,y1:GLdouble,x2:GLdouble,y2:GLdouble)
Function glRectdv:Void(v1:GLdouble Ptr,v2:GLdouble Ptr)
Function glRectf:Void(x1:GLfloat,y1:GLfloat,x2:GLfloat,y2:GLfloat)
Function glRectfv:Void(v1:GLfloat Ptr,v2:GLfloat Ptr)
Function glRecti:Void(x1:GLint,y1:GLint,x2:GLint,y2:GLint)
Function glRectiv:Void(v1:GLint Ptr,v2:GLint Ptr)
Function glRects:Void(x1:GLshort,y1:GLshort,x2:GLshort,y2:GLshort)
Function glRectsv:Void(v1:GLshort Ptr,v2:GLshort Ptr)
Function glRenderMode:GLint(mode:GLenum)
Function glRotated:Void(angle:GLdouble,x:GLdouble,y:GLdouble,z:GLdouble)
Function glRotatef:Void(angle:GLfloat,x:GLfloat,y:GLfloat,z:GLfloat)
Function glScaled:Void(x:GLdouble,y:GLdouble,z:GLdouble)
Function glScalef:Void(x:GLfloat,y:GLfloat,z:GLfloat)
Function glScissor:Void(x:GLint,y:GLint,width:GLsizei,height:GLsizei)
Function glSelectBuffer:Void(size:GLsizei,buffer:GLuint Ptr)
Function glShadeModel:Void(mode:GLenum)
Function glStencilFunc:Void(func:GLenum,ref:GLint,mask:GLuint)
Function glStencilMask:Void(mask:GLuint)
Function glStencilOp:Void(fail:GLenum,zfail:GLenum,zpass:GLenum)
Function glTexCoord1d:Void(s:GLdouble)
Function glTexCoord1dv:Void(v:GLdouble Ptr)
Function glTexCoord1f:Void(s:GLfloat)
Function glTexCoord1fv:Void(v:GLfloat Ptr)
Function glTexCoord1i:Void(s:GLint)
Function glTexCoord1iv:Void(v:GLint Ptr)
Function glTexCoord1s:Void(s:GLshort)
Function glTexCoord1sv:Void(v:GLshort Ptr)
Function glTexCoord2d:Void(s:GLdouble,t:GLdouble)
Function glTexCoord2dv:Void(v:GLdouble Ptr)
Function glTexCoord2f:Void(s:GLfloat,t:GLfloat)
Function glTexCoord2fv:Void(v:GLfloat Ptr)
Function glTexCoord2i:Void(s:GLint,t:GLint)
Function glTexCoord2iv:Void(v:GLint Ptr)
Function glTexCoord2s:Void(s:GLshort,t:GLshort)
Function glTexCoord2sv:Void(v:GLshort Ptr)
Function glTexCoord3d:Void(s:GLdouble,t:GLdouble,r:GLdouble)
Function glTexCoord3dv:Void(v:GLdouble Ptr)
Function glTexCoord3f:Void(s:GLfloat,t:GLfloat,r:GLfloat)
Function glTexCoord3fv:Void(v:GLfloat Ptr)
Function glTexCoord3i:Void(s:GLint,t:GLint,r:GLint)
Function glTexCoord3iv:Void(v:GLint Ptr)
Function glTexCoord3s:Void(s:GLshort,t:GLshort,r:GLshort)
Function glTexCoord3sv:Void(v:GLshort Ptr)
Function glTexCoord4d:Void(s:GLdouble,t:GLdouble,r:GLdouble,q:GLdouble)
Function glTexCoord4dv:Void(v:GLdouble Ptr)
Function glTexCoord4f:Void(s:GLfloat,t:GLfloat,r:GLfloat,q:GLfloat)
Function glTexCoord4fv:Void(v:GLfloat Ptr)
Function glTexCoord4i:Void(s:GLint,t:GLint,r:GLint,q:GLint)
Function glTexCoord4iv:Void(v:GLint Ptr)
Function glTexCoord4s:Void(s:GLshort,t:GLshort,r:GLshort,q:GLshort)
Function glTexCoord4sv:Void(v:GLshort Ptr)
Function glTexCoordPointer:Void(size:GLint,type:GLenum,stride:GLsizei,pointer:Void Ptr)
Function glTexEnvf:Void(target:GLenum,pname:GLenum,param:GLfloat)
Function glTexEnvfv:Void(target:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glTexEnvi:Void(target:GLenum,pname:GLenum,param:GLint)
Function glTexEnviv:Void(target:GLenum,pname:GLenum,params:GLint Ptr)
Function glTexGend:Void(coord:GLenum,pname:GLenum,param:GLdouble)
Function glTexGendv:Void(coord:GLenum,pname:GLenum,params:GLdouble Ptr)
Function glTexGenf:Void(coord:GLenum,pname:GLenum,param:GLfloat)
Function glTexGenfv:Void(coord:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glTexGeni:Void(coord:GLenum,pname:GLenum,param:GLint)
Function glTexGeniv:Void(coord:GLenum,pname:GLenum,params:GLint Ptr)
Function glTexImage1D:Void(target:GLenum,level:GLint,internalformat:GLint,width:GLsizei,border:GLint,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glTexImage2D:Void(target:GLenum,level:GLint,internalformat:GLint,width:GLsizei,height:GLsizei,border:GLint,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glTexParameterf:Void(target:GLenum,pname:GLenum,param:GLfloat)
Function glTexParameterfv:Void(target:GLenum,pname:GLenum,params:GLfloat Ptr)
Function glTexParameteri:Void(target:GLenum,pname:GLenum,param:GLint)
Function glTexParameteriv:Void(target:GLenum,pname:GLenum,params:GLint Ptr)
Function glTexSubImage1D:Void(target:GLenum,level:GLint,xoffset:GLint,width:GLsizei,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glTexSubImage2D:Void(target:GLenum,level:GLint,xoffset:GLint,yoffset:GLint,width:GLsizei,height:GLsizei,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glTranslated:Void(x:GLdouble,y:GLdouble,z:GLdouble)
Function glTranslatef:Void(x:GLfloat,y:GLfloat,z:GLfloat)
Function glVertex2d:Void(x:GLdouble,y:GLdouble)
Function glVertex2dv:Void(v:GLdouble Ptr)
Function glVertex2f:Void(x:GLfloat,y:GLfloat)
Function glVertex2fv:Void(v:GLfloat Ptr)
Function glVertex2i:Void(x:GLint,y:GLint)
Function glVertex2iv:Void(v:GLint Ptr)
Function glVertex2s:Void(x:GLshort,y:GLshort)
Function glVertex2sv:Void(v:GLshort Ptr)
Function glVertex3d:Void(x:GLdouble,y:GLdouble,z:GLdouble)
Function glVertex3dv:Void(v:GLdouble Ptr)
Function glVertex3f:Void(x:GLfloat,y:GLfloat,z:GLfloat)
Function glVertex3fv:Void(v:GLfloat Ptr)
Function glVertex3i:Void(x:GLint,y:GLint,z:GLint)
Function glVertex3iv:Void(v:GLint Ptr)
Function glVertex3s:Void(x:GLshort,y:GLshort,z:GLshort)
Function glVertex3sv:Void(v:GLshort Ptr)
Function glVertex4d:Void(x:GLdouble,y:GLdouble,z:GLdouble,w:GLdouble)
Function glVertex4dv:Void(v:GLdouble Ptr)
Function glVertex4f:Void(x:GLfloat,y:GLfloat,z:GLfloat,w:GLfloat)
Function glVertex4fv:Void(v:GLfloat Ptr)
Function glVertex4i:Void(x:GLint,y:GLint,z:GLint,w:GLint)
Function glVertex4iv:Void(v:GLint Ptr)
Function glVertex4s:Void(x:GLshort,y:GLshort,z:GLshort,w:GLshort)
Function glVertex4sv:Void(v:GLshort Ptr)
Function glVertexPointer:Void(size:GLint,type:GLenum,stride:GLsizei,pointer:Void Ptr)
Function glViewport:Void(x:GLint,y:GLint,width:GLsizei,height:GLsizei)
Function glCopyTexSubImage3D:Void(target:GLenum,level:GLint,xoffset:GLint,yoffset:GLint,zoffset:GLint,x:GLint,y:GLint,width:GLsizei,height:GLsizei)
Function glDrawRangeElements:Void(mode:GLenum,start:GLuint,e:GLuint,count:GLsizei,type:GLenum,indices:Void Ptr)
Function glTexImage3D:Void(target:GLenum,level:GLint,internalFormat:GLint,width:GLsizei,height:GLsizei,depth:GLsizei,border:GLint,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glTexSubImage3D:Void(target:GLenum,level:GLint,xoffset:GLint,yoffset:GLint,zoffset:GLint,width:GLsizei,height:GLsizei,depth:GLsizei,format:GLenum,type:GLenum,pixels:Void Ptr)
Function glActiveTexture:Void(texture:GLenum)
Function glClientActiveTexture:Void(texture:GLenum)
Function glCompressedTexImage1D:Void(target:GLenum,level:GLint,internalformat:GLenum,width:GLsizei,border:GLint,imageSize:GLsizei,data:Void Ptr)
Function glCompressedTexImage2D:Void(target:GLenum,level:GLint,internalformat:GLenum,width:GLsizei,height:GLsizei,border:GLint,imageSize:GLsizei,data:Void Ptr)
Function glCompressedTexImage3D:Void(target:GLenum,level:GLint,internalformat:GLenum,width:GLsizei,height:GLsizei,depth:GLsizei,border:GLint,imageSize:GLsizei,data:Void Ptr)
Function glCompressedTexSubImage1D:Void(target:GLenum,level:GLint,xoffset:GLint,width:GLsizei,format:GLenum,imageSize:GLsizei,data:Void Ptr)
Function glCompressedTexSubImage2D:Void(target:GLenum,level:GLint,xoffset:GLint,yoffset:GLint,width:GLsizei,height:GLsizei,format:GLenum,imageSize:GLsizei,data:Void Ptr)
Function glCompressedTexSubImage3D:Void(target:GLenum,level:GLint,xoffset:GLint,yoffset:GLint,zoffset:GLint,width:GLsizei,height:GLsizei,depth:GLsizei,format:GLenum,imageSize:GLsizei,data:Void Ptr)
Function glGetCompressedTexImage:Void(target:GLenum,lod:GLint,img:Void Ptr)
Function glLoadTransposeMatrixd:Void(m:GLdouble)
Function glLoadTransposeMatrixf:Void(m:GLfloat)
Function glMultTransposeMatrixd:Void(m:GLdouble)
Function glMultTransposeMatrixf:Void(m:GLfloat)
Function glMultiTexCoord1d:Void(target:GLenum,s:GLdouble)
Function glMultiTexCoord1dv:Void(target:GLenum,v:GLdouble Ptr)
Function glMultiTexCoord1f:Void(target:GLenum,s:GLfloat)
Function glMultiTexCoord1fv:Void(target:GLenum,v:GLfloat Ptr)
Function glMultiTexCoord1i:Void(target:GLenum,s:GLint)
Function glMultiTexCoord1iv:Void(target:GLenum,v:GLint Ptr)
Function glMultiTexCoord1s:Void(target:GLenum,s:GLshort)
Function glMultiTexCoord1sv:Void(target:GLenum,v:GLshort Ptr)
Function glMultiTexCoord2d:Void(target:GLenum,s:GLdouble,t:GLdouble)
Function glMultiTexCoord2dv:Void(target:GLenum,v:GLdouble Ptr)
Function glMultiTexCoord2f:Void(target:GLenum,s:GLfloat,t:GLfloat)
Function glMultiTexCoord2fv:Void(target:GLenum,v:GLfloat Ptr)
Function glMultiTexCoord2i:Void(target:GLenum,s:GLint,t:GLint)
Function glMultiTexCoord2iv:Void(target:GLenum,v:GLint Ptr)
Function glMultiTexCoord2s:Void(target:GLenum,s:GLshort,t:GLshort)
Function glMultiTexCoord2sv:Void(target:GLenum,v:GLshort Ptr)
Function glMultiTexCoord3d:Void(target:GLenum,s:GLdouble,t:GLdouble,r:GLdouble)
Function glMultiTexCoord3dv:Void(target:GLenum,v:GLdouble Ptr)
Function glMultiTexCoord3f:Void(target:GLenum,s:GLfloat,t:GLfloat,r:GLfloat)
Function glMultiTexCoord3fv:Void(target:GLenum,v:GLfloat Ptr)
Function glMultiTexCoord3i:Void(target:GLenum,s:GLint,t:GLint,r:GLint)
Function glMultiTexCoord3iv:Void(target:GLenum,v:GLint Ptr)
Function glMultiTexCoord3s:Void(target:GLenum,s:GLshort,t:GLshort,r:GLshort)
Function glMultiTexCoord3sv:Void(target:GLenum,v:GLshort Ptr)
Function glMultiTexCoord4d:Void(target:GLenum,s:GLdouble,t:GLdouble,r:GLdouble,q:GLdouble)
Function glMultiTexCoord4dv:Void(target:GLenum,v:GLdouble Ptr)
Function glMultiTexCoord4f:Void(target:GLenum,s:GLfloat,t:GLfloat,r:GLfloat,q:GLfloat)
Function glMultiTexCoord4fv:Void(target:GLenum,v:GLfloat Ptr)
Function glMultiTexCoord4i:Void(target:GLenum,s:GLint,t:GLint,r:GLint,q:GLint)
Function glMultiTexCoord4iv:Void(target:GLenum,v:GLint Ptr)
Function glMultiTexCoord4s:Void(target:GLenum,s:GLshort,t:GLshort,r:GLshort,q:GLshort)
Function glMultiTexCoord4sv:Void(target:GLenum,v:GLshort Ptr)
Function glSampleCoverage:Void(value:GLclampf,invert:GLboolean)
Function glBlendColor:Void(red:GLclampf,green:GLclampf,blue:GLclampf,alpha:GLclampf)
Function glBlendEquation:Void(mode:GLenum)
Function glBlendFuncSeparate:Void(sfactorRGB:GLenum,dfactorRGB:GLenum,sfactorAlpha:GLenum,dfactorAlpha:GLenum)
Function glFogCoordPointer:Void(type:GLenum,stride:GLsizei,pointer:Void Ptr)
Function glFogCoordd:Void(coord:GLdouble)
Function glFogCoorddv:Void(coord:GLdouble Ptr)
Function glFogCoordf:Void(coord:GLfloat)
Function glFogCoordfv:Void(coord:GLfloat Ptr)
Function glMultiDrawArrays:Void(mode:GLenum,first:GLint Ptr,count:GLsizei Ptr,drawcount:GLsizei)
Function glMultiDrawElements:Void(mode:GLenum,count:GLsizei Ptr,type:GLenum,indices:Void Ptr Ptr,drawcount:GLsizei)
Function glPointParameterf:Void(pname:GLenum,param:GLfloat)
Function glPointParameterfv:Void(pname:GLenum,params:GLfloat Ptr)
Function glPointParameteri:Void(pname:GLenum,param:GLint)
Function glPointParameteriv:Void(pname:GLenum,params:GLint Ptr)
Function glSecondaryColor3b:Void(red:GLbyte,green:GLbyte,blue:GLbyte)
Function glSecondaryColor3bv:Void(v:GLbyte Ptr)
Function glSecondaryColor3d:Void(red:GLdouble,green:GLdouble,blue:GLdouble)
Function glSecondaryColor3dv:Void(v:GLdouble Ptr)
Function glSecondaryColor3f:Void(red:GLfloat,green:GLfloat,blue:GLfloat)
Function glSecondaryColor3fv:Void(v:GLfloat Ptr)
Function glSecondaryColor3i:Void(red:GLint,green:GLint,blue:GLint)
Function glSecondaryColor3iv:Void(v:GLint Ptr)
Function glSecondaryColor3s:Void(red:GLshort,green:GLshort,blue:GLshort)
Function glSecondaryColor3sv:Void(v:GLshort Ptr)
Function glSecondaryColor3ub:Void(red:GLubyte,green:GLubyte,blue:GLubyte)
Function glSecondaryColor3ubv:Void(v:CString)
Function glSecondaryColor3ui:Void(red:GLuint,green:GLuint,blue:GLuint)
Function glSecondaryColor3uiv:Void(v:GLuint Ptr)
Function glSecondaryColor3us:Void(red:GLushort,green:GLushort,blue:GLushort)
Function glSecondaryColor3usv:Void(v:GLushort Ptr)
Function glSecondaryColorPointer:Void(size:GLint,type:GLenum,stride:GLsizei,pointer:Void Ptr)
Function glWindowPos2d:Void(x:GLdouble,y:GLdouble)
Function glWindowPos2dv:Void(p:GLdouble Ptr)
Function glWindowPos2f:Void(x:GLfloat,y:GLfloat)
Function glWindowPos2fv:Void(p:GLfloat Ptr)
Function glWindowPos2i:Void(x:GLint,y:GLint)
Function glWindowPos2iv:Void(p:GLint Ptr)
Function glWindowPos2s:Void(x:GLshort,y:GLshort)
Function glWindowPos2sv:Void(p:GLshort Ptr)
Function glWindowPos3d:Void(x:GLdouble,y:GLdouble,z:GLdouble)
Function glWindowPos3dv:Void(p:GLdouble Ptr)
Function glWindowPos3f:Void(x:GLfloat,y:GLfloat,z:GLfloat)
Function glWindowPos3fv:Void(p:GLfloat Ptr)
Function glWindowPos3i:Void(x:GLint,y:GLint,z:GLint)
Function glWindowPos3iv:Void(p:GLint Ptr)
Function glWindowPos3s:Void(x:GLshort,y:GLshort,z:GLshort)
Function glWindowPos3sv:Void(p:GLshort Ptr)
Function glBeginQuery:Void(target:GLenum,id:GLuint)
Function glBindBuffer:Void(target:GLenum,buffer:GLuint)
Function glBufferData:Void(target:GLenum,size:GLsizeiptr,data:Void Ptr,usage:GLenum)
Function glBufferSubData:Void(target:GLenum,offset:GLintptr,size:GLsizeiptr,data:Void Ptr)
Function glDeleteBuffers:Void(n:GLsizei,buffers:GLuint Ptr)
Function glDeleteQueries:Void(n:GLsizei,ids:GLuint Ptr)
Function glEndQuery:Void(target:GLenum)
Function glGenBuffers:Void(n:GLsizei,buffers:GLuint Ptr)
Function glGenQueries:Void(n:GLsizei,ids:GLuint Ptr)
Function glGetBufferParameteriv:Void(target:GLenum,pname:GLenum,params:GLint Ptr)
Function glGetBufferPointerv:Void(target:GLenum,pname:GLenum,params:Void Ptr Ptr)
Function glGetBufferSubData:Void(target:GLenum,offset:GLintptr,size:GLsizeiptr,data:Void Ptr)
Function glGetQueryObjectiv:Void(id:GLuint,pname:GLenum,params:GLint Ptr)
Function glGetQueryObjectuiv:Void(id:GLuint,pname:GLenum,params:GLuint Ptr)
Function glGetQueryiv:Void(target:GLenum,pname:GLenum,params:GLint Ptr)
Function glIsBuffer:GLboolean(buffer:GLuint)
Function glIsQuery:GLboolean(id:GLuint)
Function glMapBuffer:Void Ptr(target:GLenum,access:GLenum)
Function glUnmapBuffer:GLboolean(target:GLenum)
Function glAttachShader:Void(program:GLuint,shader:GLuint)
Function glBindAttribLocation:Void(program:GLuint,index:GLuint,name:CString)
Function glBlendEquationSeparate:Void(modeRGB:GLenum,modeAlpha:GLenum)
Function glCompileShader:Void(shader:GLuint)
Function glCreateProgram:GLuint()
Function glCreateShader:GLuint(type:GLenum)
Function glDeleteProgram:Void(program:GLuint)
Function glDeleteShader:Void(shader:GLuint)
Function glDetachShader:Void(program:GLuint,shader:GLuint)
Function glDisableVertexAttribArray:Void(index:GLuint)
Function glDrawBuffers:Void(n:GLsizei,bufs:GLenum Ptr)
Function glEnableVertexAttribArray:Void(index:GLuint)
Function glGetActiveAttrib:Void(program:GLuint,index:GLuint,maxLength:GLsizei,length:GLsizei Ptr,size:GLint Ptr,type:GLenum Ptr,name:GLchar Ptr)
Function glGetActiveUniform:Void(program:GLuint,index:GLuint,maxLength:GLsizei,length:GLsizei Ptr,size:GLint Ptr,type:GLenum Ptr,name:GLchar Ptr)
Function glGetAttachedShaders:Void(program:GLuint,maxCount:GLsizei,count:GLsizei Ptr,shaders:GLuint Ptr)
Function glGetAttribLocation:GLint(program:GLuint,name:CString)
Function glGetProgramInfoLog:Void(program:GLuint,bufSize:GLsizei,length:GLsizei Ptr,infoLog:GLchar Ptr)
Function glGetProgramiv:Void(program:GLuint,pname:GLenum,param:GLint Ptr)
Function glGetShaderInfoLog:Void(shader:GLuint,bufSize:GLsizei,length:GLsizei Ptr,infoLog:GLchar Ptr)
Function glGetShaderSource:Void(obj:GLuint,maxLength:GLsizei,length:GLsizei Ptr,source:GLchar Ptr)
Function glGetShaderiv:Void(shader:GLuint,pname:GLenum,param:GLint Ptr)
Function glGetUniformLocation:GLint(program:GLuint,name:CString)
Function glGetUniformfv:Void(program:GLuint,location:GLint,params:GLfloat Ptr)
Function glGetUniformiv:Void(program:GLuint,location:GLint,params:GLint Ptr)
Function glGetVertexAttribPointerv:Void(index:GLuint,pname:GLenum,pointer:Void Ptr Ptr)
Function glGetVertexAttribdv:Void(index:GLuint,pname:GLenum,params:GLdouble Ptr)
Function glGetVertexAttribfv:Void(index:GLuint,pname:GLenum,params:GLfloat Ptr)
Function glGetVertexAttribiv:Void(index:GLuint,pname:GLenum,params:GLint Ptr)
Function glIsProgram:GLboolean(program:GLuint)
Function glIsShader:GLboolean(shader:GLuint)
Function glLinkProgram:Void(program:GLuint)
Function glShaderSource:Void(shader:GLuint,count:GLsizei,s:GLcchar Ptr Ptr,length:GLint Ptr)
Function glStencilFuncSeparate:Void(frontfunc:GLenum,backfunc:GLenum,ref:GLint,mask:GLuint)
Function glStencilMaskSeparate:Void(face:GLenum,mask:GLuint)
Function glStencilOpSeparate:Void(face:GLenum,sfail:GLenum,dpfail:GLenum,dppass:GLenum)
Function glUniform1f:Void(location:GLint,v0:GLfloat)
Function glUniform1fv:Void(location:GLint,count:GLsizei,value:GLfloat Ptr)
Function glUniform1i:Void(location:GLint,v0:GLint)
Function glUniform1iv:Void(location:GLint,count:GLsizei,value:GLint Ptr)
Function glUniform2f:Void(location:GLint,v0:GLfloat,v1:GLfloat)
Function glUniform2fv:Void(location:GLint,count:GLsizei,value:GLfloat Ptr)
Function glUniform2i:Void(location:GLint,v0:GLint,v1:GLint)
Function glUniform2iv:Void(location:GLint,count:GLsizei,value:GLint Ptr)
Function glUniform3f:Void(location:GLint,v0:GLfloat,v1:GLfloat,v2:GLfloat)
Function glUniform3fv:Void(location:GLint,count:GLsizei,value:GLfloat Ptr)
Function glUniform3i:Void(location:GLint,v0:GLint,v1:GLint,v2:GLint)
Function glUniform3iv:Void(location:GLint,count:GLsizei,value:GLint Ptr)
Function glUniform4f:Void(location:GLint,v0:GLfloat,v1:GLfloat,v2:GLfloat,v3:GLfloat)
Function glUniform4fv:Void(location:GLint,count:GLsizei,value:GLfloat Ptr)
Function glUniform4i:Void(location:GLint,v0:GLint,v1:GLint,v2:GLint,v3:GLint)
Function glUniform4iv:Void(location:GLint,count:GLsizei,value:GLint Ptr)
Function glUniformMatrix2fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glUniformMatrix3fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glUniformMatrix4fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glUseProgram:Void(program:GLuint)
Function glValidateProgram:Void(program:GLuint)
Function glVertexAttrib1d:Void(index:GLuint,x:GLdouble)
Function glVertexAttrib1dv:Void(index:GLuint,v:GLdouble Ptr)
Function glVertexAttrib1f:Void(index:GLuint,x:GLfloat)
Function glVertexAttrib1fv:Void(index:GLuint,v:GLfloat Ptr)
Function glVertexAttrib1s:Void(index:GLuint,x:GLshort)
Function glVertexAttrib1sv:Void(index:GLuint,v:GLshort Ptr)
Function glVertexAttrib2d:Void(index:GLuint,x:GLdouble,y:GLdouble)
Function glVertexAttrib2dv:Void(index:GLuint,v:GLdouble Ptr)
Function glVertexAttrib2f:Void(index:GLuint,x:GLfloat,y:GLfloat)
Function glVertexAttrib2fv:Void(index:GLuint,v:GLfloat Ptr)
Function glVertexAttrib2s:Void(index:GLuint,x:GLshort,y:GLshort)
Function glVertexAttrib2sv:Void(index:GLuint,v:GLshort Ptr)
Function glVertexAttrib3d:Void(index:GLuint,x:GLdouble,y:GLdouble,z:GLdouble)
Function glVertexAttrib3dv:Void(index:GLuint,v:GLdouble Ptr)
Function glVertexAttrib3f:Void(index:GLuint,x:GLfloat,y:GLfloat,z:GLfloat)
Function glVertexAttrib3fv:Void(index:GLuint,v:GLfloat Ptr)
Function glVertexAttrib3s:Void(index:GLuint,x:GLshort,y:GLshort,z:GLshort)
Function glVertexAttrib3sv:Void(index:GLuint,v:GLshort Ptr)
Function glVertexAttrib4Nbv:Void(index:GLuint,v:GLbyte Ptr)
Function glVertexAttrib4Niv:Void(index:GLuint,v:GLint Ptr)
Function glVertexAttrib4Nsv:Void(index:GLuint,v:GLshort Ptr)
Function glVertexAttrib4Nub:Void(index:GLuint,x:GLubyte,y:GLubyte,z:GLubyte,w:GLubyte)
Function glVertexAttrib4Nubv:Void(index:GLuint,v:CString)
Function glVertexAttrib4Nuiv:Void(index:GLuint,v:GLuint Ptr)
Function glVertexAttrib4Nusv:Void(index:GLuint,v:GLushort Ptr)
Function glVertexAttrib4bv:Void(index:GLuint,v:GLbyte Ptr)
Function glVertexAttrib4d:Void(index:GLuint,x:GLdouble,y:GLdouble,z:GLdouble,w:GLdouble)
Function glVertexAttrib4dv:Void(index:GLuint,v:GLdouble Ptr)
Function glVertexAttrib4f:Void(index:GLuint,x:GLfloat,y:GLfloat,z:GLfloat,w:GLfloat)
Function glVertexAttrib4fv:Void(index:GLuint,v:GLfloat Ptr)
Function glVertexAttrib4iv:Void(index:GLuint,v:GLint Ptr)
Function glVertexAttrib4s:Void(index:GLuint,x:GLshort,y:GLshort,z:GLshort,w:GLshort)
Function glVertexAttrib4sv:Void(index:GLuint,v:GLshort Ptr)
Function glVertexAttrib4ubv:Void(index:GLuint,v:CString)
Function glVertexAttrib4uiv:Void(index:GLuint,v:GLuint Ptr)
Function glVertexAttrib4usv:Void(index:GLuint,v:GLushort Ptr)
Function glVertexAttribPointer:Void(index:GLuint,size:GLint,type:GLenum,normalized:GLboolean,stride:GLsizei,pointer:Void Ptr)
Function glUniformMatrix2x3fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glUniformMatrix2x4fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glUniformMatrix3x2fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glUniformMatrix3x4fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glUniformMatrix4x2fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glUniformMatrix4x3fv:Void(location:GLint,count:GLsizei,transpose:GLboolean,value:GLfloat Ptr)
Function glBindFramebuffer:Void(target:GLenum,framebuffer:GLuint)
Function glBindRenderbuffer:Void(target:GLenum,renderbuffer:GLuint)
Function glBlitFramebuffer:Void(srcX0:GLint,srcY0:GLint,srcX1:GLint,srcY1:GLint,dstX0:GLint,dstY0:GLint,dstX1:GLint,dstY1:GLint,mask:GLbitfield,filter:GLenum)
Function glCheckFramebufferStatus:GLenum(target:GLenum)
Function glDeleteFramebuffers:Void(n:GLsizei,framebuffers:GLuint Ptr)
Function glDeleteRenderbuffers:Void(n:GLsizei,renderbuffers:GLuint Ptr)
Function glFramebufferRenderbuffer:Void(target:GLenum,attachment:GLenum,renderbuffertarget:GLenum,renderbuffer:GLuint)
Function glFramebufferTexture1D:Void(target:GLenum,attachment:GLenum,textarget:GLenum,texture:GLuint,level:GLint)
Function glFramebufferTexture2D:Void(target:GLenum,attachment:GLenum,textarget:GLenum,texture:GLuint,level:GLint)
Function glFramebufferTexture3D:Void(target:GLenum,attachment:GLenum,textarget:GLenum,texture:GLuint,level:GLint,layer:GLint)
Function glFramebufferTextureLayer:Void(target:GLenum,attachment:GLenum,texture:GLuint,level:GLint,layer:GLint)
Function glGenFramebuffers:Void(n:GLsizei,framebuffers:GLuint Ptr)
Function glGenRenderbuffers:Void(n:GLsizei,renderbuffers:GLuint Ptr)
Function glGenerateMipmap:Void(target:GLenum)
Function glGetFramebufferAttachmentParameteriv:Void(target:GLenum,attachment:GLenum,pname:GLenum,params:GLint Ptr)
Function glGetRenderbufferParameteriv:Void(target:GLenum,pname:GLenum,params:GLint Ptr)
Function glIsFramebuffer:GLboolean(framebuffer:GLuint)
Function glIsRenderbuffer:GLboolean(renderbuffer:GLuint)
Function glRenderbufferStorage:Void(target:GLenum,internalformat:GLenum,width:GLsizei,height:GLsizei)
Function glRenderbufferStorageMultisample:Void(target:GLenum,samples:GLsizei,internalformat:GLenum,width:GLsizei,height:GLsizei)

