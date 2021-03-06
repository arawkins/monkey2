
Namespace stargate

Global fragNoise:=New Float[4096]

'actor types
Const ACTOR_PLAYER:=1
Const ACTOR_HUMANOID:=2
Const ACTOR_LAZER:=3
Const ACTOR_LANDER:=4
Const ACTOR_MUTANT:=5
Const ACTOR_BOMBER:=6
Const ACTOR_BAITER:=7
Const ACTOR_POD:=8
Const ACTOR_SWARMER:=9

Const ACTOR_BULLET:=16
Const ACTOR_BOMB:=17
Const ACTOR_BONUS:=20

'actor states
Const ACTOR_FRAGGING:=-1
Const ACTOR_DEAD:=0
Const ACTOR_ALIVE:=1

'actor flags
Const ACTOR_WRAPY:=1		'wrap positon.y
Const ACTOR_CLAMPY:=2		'clamp positon.y
Const ACTOR_AUTODESTROY:=4	'remove if offscreen
Const ACTOR_XFLIPIMAGE:=8

Global ActorStacks:Stack<Actor>[]=New Stack<Actor>[32]

Global ActiveActors:Int[]=New Int[32]

Global Collisions:Int[][]=New Int[][32]

Global BlipColors:Vec4f[]=New Vec4f[32]

Global ActorPoints:=New Int[32]

Class Actor

	Field type:Int
	Field state:Int
	Field flags:Int
	
	Field inview:Bool
	Field renderx:Float
	Field position:Vec2f
	Field velocity:Vec2f
	Field collRect:Rectf
	
	Field image:Image
	Field anim:Image[]
	Field animTime:Float
	Field animSpeed:Float
	
	Field frag:Image
	Field fragTime:Float
	Field fragSpeed:Float
	Field fragScale:Float
	
	Field fireTimer:Int
	Field fireMin:Int
	Field fireMax:Int
	
	Field destroyTimer:Int

	Method New( type:Int )
		If type AddActor( Self,type )
	End
	
	Method Implode()
		If image
			frag=image
		Else If anim
			frag=anim[animTime]
		Else
			Return
		Endif
		fragTime=1
		fragSpeed=-.01
		fragScale=50
		state=ACTOR_FRAGGING
	End
	
	Method Explode()

'		PlaySound( "asset::Explosion6.wav" )
	
		If state>0 ActiveActors[type]-=1
		If image
			frag=image
		Else If anim
			frag=anim[animTime]
		Else
			Destroy()
			Return
		End
		fragTime=0
		fragSpeed=.01
		fragScale=50		
		state=ACTOR_FRAGGING
	End
	
	Method Destroy()
		If state>0 ActiveActors[type]-=1
		state=ACTOR_DEAD
	End
	
	Method Destroy( timeout:Int )
		destroyTimer=timeout
	End
	
	'internal
	'
	Method Update()
	
		If state=ACTOR_FRAGGING
		
			fragTime+=fragSpeed
			
			If fragTime>0
				inview=True
				renderx=RenderX( position.x )
				If fragTime>=1 state=ACTOR_DEAD
				Return
			Endif
			
			state=ACTOR_ALIVE

		Endif
		
		OnUpdate()
		
		If state<=0 Return
		
		If destroyTimer
			destroyTimer-=1
			If destroyTimer<=0
				Destroy()
				Return
			Endif
		Endif
		
		If inview And fireTimer
			fireTimer-=1
			If fireTimer<=0
				New Bullet( Self )
				fireTimer=Rnd( fireMin,fireMax )
			Endif
		Endif
	
	End
	
	'virtual methods
	'
	Method OnUpdate() Virtual
	
		inview=False

		If state=ACTOR_FRAGGING
		
			fragTime+=fragSpeed
			
			If fragTime>0
				renderx=RenderX( position.x )
				If fragTime>=1 state=ACTOR_DEAD
				Return
			Endif
			
			state=ACTOR_ALIVE

		Endif
		
		position+=velocity
		position.x=WrapX( position.x )
		
		If anim
			animTime=(animTime+animSpeed) Mod anim.Length
			image=anim[animTime]
		Endif
		
		inview=False
		
		If Not image Return
		
		If flags & ACTOR_CLAMPY
			position.y=Clamp( position.y,-image.Bounds.Top,ViewHeight-image.Bounds.Bottom )
		Else If flags & ACTOR_WRAPY
			If position.y<0 
				position.y+=ViewHeight
			Else If position.y>=ViewHeight
				position.y-=ViewHeight
			Endif
		Endif

		If type=ACTOR_PLAYER
			inview=True
			ScrollX=WrapX( position.x-renderx-ViewX )
		Else
			renderx=RenderX( position.x )
			inview=renderx+image.Bounds.Right>0 And renderx+image.Bounds.Left<ViewWidth
		Endif
		
		If flags & ACTOR_AUTODESTROY And Not inview
			Destroy()
			Return
		Endif

		Local x0:=position.x+image.Bounds.Left
		Local y0:=position.y+image.Bounds.Top
		If x0+image.Width>PlanetWidth x0-=PlanetWidth
		collRect=New Rectf( x0,y0,x0+image.Width,y0+image.Height )
	End
	
	Method OnCollide( actor:Actor ) Virtual
		actor.OnKilled()
		Explode()
	End
	
	Method OnKilled() Virtual
		Explode()
	End
	
	Method OnRender( canvas:Canvas ) Virtual
	
		If state=ACTOR_FRAGGING

			Local i:=0
			For Local iy:=1 Until frag.Height-1 Step 3
				Local dy:=frag.Bounds.Top+iy
				For Local ix:=1 Until frag.Width-1 Step 3
					Local dx:=frag.Bounds.Left+ix
					Local t:=(fragNoise[i] * fragScale) * fragTime + 1
					canvas.DrawRect( renderx+dx*t-1,position.y+dy*t-1,3,3,frag,ix-1,iy-1,3,3 )
					i+=1
				Next
			Next
			
			Return
		Endif
		
		If Not inview Return
		
		Local xscale:=1
		If flags & ACTOR_XFLIPIMAGE xscale=-1

		canvas.DrawImage( image,renderx,position.y,0,xscale,1 )
		If flags & ACTOR_WRAPY
			If position.y< -image.Bounds.Top
			canvas.DrawImage( image,renderx,position.y+ViewHeight,0,xscale,1 )
			Else If position.y> ViewHeight-image.Bounds.Bottom
				canvas.DrawImage( image,renderx,position.y-ViewHeight,0,xscale,1 )
			Endif
		Endif
	
	End
	
	Method SetFireTimer( easy:Int,hard:Int )
		fireMin=0
		fireMax=(hard-easy)*Difficulty+easy
		fireTimer=Rnd( fireMin,fireMax )
	End
	
End

Function ClearActors()
	For Local id:=1 Until 32
		ActorStacks[id]=New Stack<Actor>
		ActiveActors[id]=0
	Next
End

Function AddActor( actor:Actor,type:Int )
	actor.type=type
	actor.state=ACTOR_ALIVE
	
	ActorStacks[type].Push( actor )
	ActiveActors[type]+=1
End

Function UpdateActors()

	'update
	For Local id:=1 Until 32
	
		Local actors:=ActorStacks[id]
	
		Local put:=0
		
		For Local get:=0 Until actors.Length
		
			Local actor:=actors[get]
			
			If Not actor.state Continue
			
			actor.Update()
			
			If Not actor.state Continue
					
			actors[put]=actor
			put+=1

		Next
		
		actors.Resize( put )
	Next
	
End

Function CollideActors()

	For Local id:=1 Until 32

		Local ids:=Collisions[id]
		If Not ids Continue
	
		Local actors:=ActorStacks[id]
		
		For Local actor:=Eachin actors
			If actor.state<=0 Continue
		
			For Local id2:=Eachin ids
		
				Local actors2:=ActorStacks[id2]
				
				For Local actor2:=Eachin actors2
					If actor2.state<=0 Continue
				
					If actor.collRect.Intersects( actor2.collRect )
					
						actor.OnCollide( actor2 )
						If actor.state<=0 Exit
					
					Endif
				
				Next
			Next
			
		Next
	
	Next
	
End

Function RenderActors( canvas:Canvas )

	For Local id:=1 Until 32
	
		Local actors:=ActorStacks[id]
	
		For Local actor:=Eachin actors
			If actor.state=ACTOR_DEAD Continue
		
			actor.OnRender( canvas )
		Next
	
	Next
End

Function RenderBlips( canvas:Canvas )

	Local sx:=Float(ScannerWidth)/PlanetWidth
	Local sy:=Float(ScannerHeight)/PlanetHeight

	For Local id:=1 Until 32
	
		Local color:=BlipColors[id]
		If Not color.w Continue
		
		Local actors:=ActorStacks[id]
		
		canvas.Color=New Color( color.x,color.y,color.z,color.w )
		
		For Local actor:=Eachin actors
			If actor.state<=0 Continue
			
			Local x:=ScannerX( actor.position.x ) * sx
			Local y:=actor.position.y * sy
			
			canvas.DrawRect( x-1,y-1,3,3 )
		Next
	Next
	
	canvas.Color=Color.White
	
End

Function FindRandomActor:Actor( type:Int,state:Int )

	Local actors:=ActorStacks[type]
	Local i:=Int( Rnd( actors.Length ) )
	While i<actors.Length
		If actors[i].state=state Return actors[i]
		i+=1
	Wend
	Return Null
	
End

Function InitActor()

	For Local i:=0 Until fragNoise.Length
		fragNoise[i]=Rnd( 1,1.5 )
	Next
	
End
 