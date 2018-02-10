
Namespace admob

#Import "<jni>"

#Import "native/Monkey2AdView.java"

Using jni..

Class BBAdView
	
	Method New( size:String,layout:String="top",adUnitId:String="",visible:bool=True )
		
		Init()
		
		Local instance:=Env.NewObject( _class,_ctor,New Variant[]( size,layout,adUnitId,visible ) )
		
		_instance=Env.NewGlobalRef( instance )
		
		Env.DeleteLocalRef( instance )
	
	End
	
	Method start( callback:Int )
	
		Env.CallVoidMethod( _instance,_start,New Variant[]( callback ) )
	End

	Method setVisible( visible:Bool )

		Env.CallVoidMethod( _instance,_setVisible,New Variant[]( visible ) )
	End
	
	Method getVisible:Bool()
		
		Return Env.CallBooleanMethod( _instance,_getVisible,Null )
	
	End

	Method getState:Int()

		Return Env.CallIntMethod( _instance,_getState,Null )
	End
	
	Method getRewardType:String()
		
		Return Env.CallStringMethod( _instance,_getRewardType,Null )
		
	End
	
	Method getRewardAmount:Int()
		
		Return Env.CallIntMethod( _instance,_getRewardAmount,Null )
		
	End
	
	Method consumeReward()
		
		Env.CallVoidMethod( _instance,_consumeReward,Null )
	
	End
	
	Method getError:Int()

		Return Env.CallIntMethod( _instance,_getError,Null )
	
	End

	Method reload:Void()

		Env.CallVoidMethod( _instance,_reload,Null )

	End
	
	Private
	
	Global _class:jclass
	Global _ctor:jmethodID
	Global _start:jmethodID
	Global _setVisible:jmethodID
	Global _getVisible:jmethodID
	Global _getState:jmethodID
	Global _getRewardType:jmethodID
	Global _getRewardAmount:jmethodID
	Global _consumeReward:jmethodID
	Global _getError:jmethodID
	Global _reload:jmethodID
	
	Field _instance:jobject
	Field _globalref:jobject
	
	Function Init()
	
		If _class Return

		Local env:=sdl2.Android_JNI_GetEnv()

		_class=env.FindClass( "com/monkey2/lib/Monkey2AdView" )
		_ctor=env.GetMethodID( _class,"<init>","(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V" )
		_start=env.GetMethodID( _class,"start","(I)V" )
		_setVisible=env.GetMethodID( _class,"setVisible","(Z)V" )
		_getVisible=env.GetMethodID( _class,"getVisible","()Z" )
		_getState=env.GetMethodID( _class,"getState","()I" )
		_getRewardType=env.GetMethodID( _class,"getRewardType","()Ljava/lang/String;" )
		_getRewardAmount=env.GetMethodID( _class,"getRewardAmount","()I" )
		_consumeReward=env.GetMethodID( _class,"consumeReward","()V" )
		_getError=env.GetMethodID( _class,"getError","()I" )
		_reload=env.GetMethodID( _class,"reload","()V" )
		
	End
	
	Property Env:JNIEnv()
		
		Return sdl2.Android_JNI_GetEnv()
	End
	
End
