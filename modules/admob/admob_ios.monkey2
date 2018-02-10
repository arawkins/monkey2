
Namespace admob

#Import "native/GoogleMobileAds-7.27.0/*.h"

#Import "native/adview_ios.mm"
#Import "native/adview_ios.h"

Extern Internal

Class BBAdView
	
	Protected
		
	Method New( size:String,layout:String="top",adUnitId:String="",show:Bool=True )
		
	Method start( callback:Int )

	Method setVisible( visible:Bool )
	
	Method getVisible:Bool()
		
	Method getState:Int()
		
	Method getRewardType:String()
	
	Method getRewardAmount:Int()
		
	Method consumeReward:Void()
		
	Method getError:Int()

	Method reload:Void()
End
