
Namespace ted2go


Class DialogExt Extends Dialog
	
	Field OnShow:Void()
	Field OnHide:Void()
	
	Method New()
		Super.New()
	End
	
	Method New( title:String,contentView:View=Null )
		Super.New( title,contentView )
	End
	
	Property IsOpened:Bool()
		Return _opened
	End
	
	Property FadeEnabled:Bool()
		Return _fadeEnabled
	Setter( value:Bool )
		_fadeEnabled=value
	End
	
	Method Show()
		
		If _opened Return
		_opened = True
		
		TryAddFade()
		Open()
		OnShow()
	End
	
	Method ShowModal:Bool()
		
		If _opened Return False
		
		_opened = True
		
		TryAddFade()
		Open()
		OnShow()
		
		App.BeginModal( Self )
		_wait=New Future<Bool>
		Local ok:=_wait.Get()
		App.EndModal()
		
		Return ok
	End
	
	Method Hide()
	
		HideWithResult( True )
	End
	
	Method HideWithResult( ok:Bool )
		
		If Not _opened Return
		
		_opened = False
		
		If _fadeView
			Local wnd:=App.ActiveWindow
			wnd.RemoveChildView( _fadeView )
			_fadeView=Null
		Endif
		
		Close()
		OnHide()
		
		If _wait
			_wait.Set( ok )
			_wait=Null
		Endif
	End
	
	
	Private
	
	Field _opened:Bool
	Field _wait:Future<Bool>
	Field _fadeEnabled:Bool
	Field _fadeView:View
	
	Method TryAddFade()
		
		If Not _fadeEnabled Return
		
		Local wnd:=App.ActiveWindow
		_fadeView=New Label
		_fadeView.Layout="float"
		_fadeView.Gravity=New Vec2f
		_fadeView.MinSize=wnd.Frame.Size
		Local st:=_fadeView.Style.Copy()
		st.BackgroundColor=New Color( 0,0,0,0.33 )
		_fadeView.Style=st
		wnd.AddChildView( _fadeView )
	End
	
End
