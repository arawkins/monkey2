
Namespace sdl2.mixer

#Import "<sdl2>"

#Import "makefile.monkey2"

#Import "SDL_mixer/*.h"
#Import "<SDL_mixer.h>"

Extern

Struct Mix_Chunk
End

Struct Mix_Music
End

Const MIX_INIT_FLAC:Int
Const MIX_INIT_MOD:Int
Const MIX_INIT_MODPLUG:Int
Const MIX_INIT_MP3:Int
Const MIX_INIT_OGG:Int
Const MIX_INIT_FLUIDSYNTH:Int

Const MIX_DEFAULT_FREQUENCY:Int	'22050
Const MIX_DEFAULT_FORMAT:Int		'AUDIO_S16
Const MIX_DEFAULT_CHANNELS:Int	'2
Const MIX_MAX_VOLUME:Int			'128

Function Mix_Init:Int( flags:Int )

Function Mix_Quit()

Function Mix_OpenAudio:Int( frequency:Int,format:UShort,channels:Int,chunksize:Int )

Function Mix_CloseAudio()

Function Mix_GetError:CString()


'samples

Function Mix_LoadWAV:Mix_Chunk Ptr( file:CString )

Function Mix_LoadWAV_RW:Mix_Chunk Ptr( src:SDL_RWops Ptr,freesrc:Int )

Function Mix_QuickLoad_WAV:Mix_Chunk Ptr( mem:UByte Ptr )

Function Mix_VolumeChunk:Int( chunk:Mix_Chunk Ptr,volume:Int )

Function Mix_FreeChunk( chunk:Mix_Chunk Ptr )

'channels

Function Mix_AllocateChannels:Int( numchans:Int )

Function Mix_Volume:Int( channel:Int,volume:Int )

Function Mix_PlayChannel:Int( channel:Int,chunk:Mix_Chunk Ptr,loops:Int )

Function Mix_Pause( channel:Int )

Function Mix_Resume( channel:Int )

Function Mix_HaltChannel:Int( channel:Int )

Function Mix_Playing:Int( channel:Int )

Function Mix_Paused:Int( channel:Int )

Function Mix_GetChunk:Mix_Chunk Ptr( channel:Int )

'groups

'music

Function Mix_LoadMUS:Mix_Music Ptr( file:CString )

Function Mix_FreeMusic( music:Mix_Music Ptr )

Function Mix_PlayMusic:Int( music:Mix_Music Ptr,loops:Int )



