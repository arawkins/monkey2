
Namespace util

Function Fly( entity:Entity,view:View )

	If Keyboard.KeyDown( Key.Up )
		entity.RotateX( .05 )
	Else If Keyboard.KeyDown( Key.Down )
		entity.RotateX( -.05 )
	Endif
	
	If Keyboard.KeyDown( Key.Left )
		entity.RotateY( .025,True )
	Else If Keyboard.KeyDown( Key.Right )
		entity.RotateY( -.025,True )
	Endif

	If Keyboard.KeyDown( Key.Q )
		entity.RotateZ( .01 )
	Else If Keyboard.KeyDown( Key.W )
		entity.RotateZ( -.01 )
	Endif
	
	If Mouse.ButtonDown( MouseButton.Left )
		If Mouse.X<view.Width/3
			entity.RotateY( .1,True )
		Else If Mouse.X>view.Width/3*2
			entity.RotateY( -.1,True )
		Else
			entity.Move( New Vec3f( 0,0,.1 ) )
		Endif
	Endif
	
	If Keyboard.KeyDown( Key.A )
		entity.MoveZ( .1 )	'( New Vec3f( 0,0,.1 ) )
	Else If Keyboard.KeyDown( Key.Z )
		entity.MoveZ( -.1 )	'( New Vec3f( 0,0,-.1 ) )
	Endif
		
End
