
Namespace ted2go


Class Ted2CodeTextView Extends CodeTextView
	
	Method New( doc:Ted2Document )
		
		_document=doc
		
		AdjustFileType()
		
		_document.Renamed+=Lambda( newPath:String,oldPath:String )
			
			AdjustFileType()
		End
	End
	
	Property FileType:String() 'where else we can store this type?
		
		Return _type
		
	Setter( value:String )
		
		If value=_type Return
		_type=value
		Keywords=KeywordsManager.Get(_type)
		Highlighter=HighlightersManager.Get(_type)
		Formatter=FormattersManager.Get(_type)
		Document.TextHighlighter=Highlighter.Painter
	End
	
	Property FilePath:String()
		return _path
	Setter(value:String)
		_path = value
	End
	
	Method LoadCode( path:String,type:String=".monkey2" )
		
		If Not type Then type=ExtractExt( path )
		FileType=type
		FilePath=path
		Text=LoadString( path )
	End
	
	
	Protected
	
	Field _document:Ted2Document
	
	Method AdjustFileType()
		
		FileType=_document.FileExtension
		FilePath=_document.Path
	End
	
	Method OnKeyEvent( event:KeyEvent ) Override
	
		TextViewKeyEventFilter.FilterKeyEvent( event,Self,FileType )
		
		If Not event.Eaten
			Super.OnKeyEvent( event )
		Endif
		
	End
	
	Private
	
	Field _type:String
	Field _path:String
	
End
