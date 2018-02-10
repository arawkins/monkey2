
Namespace admob

#Import "<std>"

#If __MOBILE_TARGET__

#Import "<mojo>"

#If __TARGET__="android"

#Import "admob_android"

#Else If __TARGET__="ios"

#Import "admob_ios"

#Endif

Using mojo..

Enum AdState
	Initial=0
	Loading=1
	Ready=2
	Error=3
End

Class AdView Extends BBAdView
	
	Field Loading:Void()
	
	Field Ready:Void()
	
	Field Error:Void( error:Int )
	
	Field Rewarded:Void( type:String,amount:Int )
	
	Method New( size:String,layout:String,adUnitId:String,visible:Bool=True )
	
		Super.New( size,layout,adUnitId,visible )
		
		_rewardedVideo=(size="rewardedvideo")

		_interstitial=(size="interstitial")
		
		_state=AdState.Initial
		
		_callback=std.async.CreateAsyncCallback( StateChanged,False )
		
		Super.start( _callback )
		
		'BeginPolling()
	End
	
	Property Visible:Bool()
		
		Return Super.getVisible()
	
	Setter( visible:Bool )
		
		If _rewardedVideo Or _interstitial
			
			If Not visible Or _state<>AdState.Ready Return
			
			Super.setVisible( visible )
			
			_playing=True
		
'			BeginPolling()
			
		Endif
		
		Super.setVisible( visible )
	End
	
	Property State:AdState()
		
		Return _state
	End
	
	Method Reload()
		
		If _state<>AdState.Error Return
		
		_state=AdState.Initial
		
'		BeginPolling()
		
		Super.reload()
	End
	
	Private
	
	Field _rewardedVideo:Bool
	Field _interstitial:Bool
	Field _state:AdState
	Field _playing:Bool
	Field _callback:Int
	
	Method StateChanged()
	
		Local newstate:=Cast<AdState>( Super.getState() )
		
'		Print "StateChanged: state="+Int( _state )+", newstate="+Int( newstate )

		If _playing
			Select newstate
			Case AdState.Initial
				_state=newstate
				_playing=False
				Super.reload()
				If _rewardedVideo And Super.getRewardType()
					Local rewardType:=Super.getRewardType()
					Local rewardAmount:=Super.getRewardAmount()
					Super.consumeReward()
					Rewarded( rewardType,rewardAmount )
				Endif
			End
		Else If newstate<>_state
			Select newstate
			Case AdState.Loading
				Assert( _state=AdState.Initial )
				_state=newstate
				Loading()
			Case AdState.Ready
				Assert( _state=AdState.Initial Or _state=AdState.Loading )
				_state=newstate
				Ready()
			Case AdState.Error
				Assert( _state=AdState.Initial Or _state=AdState.Loading )
				_state=newstate
				Error( Super.getError() )
			End
		Endif
	End
	
	#rem
	
	Field _polling:Bool
	
	Method BeginPolling()
		If Not _polling And (_state=AdState.Initial Or _state=AdState.Loading Or _playing)
			App.Idle+=Poll
			_polling=True
		Endif
	End
	
	Method Poll()
		
		_polling=False
		
		StateChanged()
		
		BeginPolling()
	End
	
	#end
	
	
End
