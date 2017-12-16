#Import "<std>"

Using std..

Class Parser
	
	Method New( text:String )
		
		_text=text
		
		Bump()
	End
	
	Property Text:String()
		
		Return _text
	End
	
	Property Toke:String()
		
		Return _toke
	End
	
	Property TokePos:Int()
		
		Return _tokePos
	End
	
	Method Bump:String()
		
		While PeekChr() And PeekChr()<=32
			ParseChr()
		End
		
		_tokePos=_pos
		Local chr:=ParseChr()
		
		If IsAlpha( chr ) Or chr=95
			
			While IsIdent( PeekChr() )
				ParseChr()
			Wend
			
		Else If chr=35 And (IsAlpha( PeekChr() ) Or PeekChr()=95 )		'#ident

			ParseChr()
			While IsIdent( PeekChr() )
				ParseChr()
			Wend
			
		Else If chr=48 And PeekChr()=120			'0x
			
			ParseChr()
			While IsHexDigit( PeekChr() )
				ParseChr()
			Wend
			
		Else If IsDigit( chr )

			While IsDigit( PeekChr() )
				ParseChr()
			Wend
			
		Endif
		
		_toke=_text.Slice( _tokePos,_pos )
		
		Return _toke
	End
	
	Method Error( err:String )
		
		Print "ERROR: "+err
		
		Print "Text: "+_text
		
		Print "Toke: "+Toke
	End
	
	Method Parse:String()
		
		Local toke:=Toke
		
		If Not toke Error( "Unexpected EOI" )
		
		Bump()
		
		Return toke
	End
	
	Method Parse( toke:String )
		
		If toke<>Toke Error( "Expecting:"+toke )
			
		Bump()
	End
	
	Method CParse:Bool( toke:String )
		
		If toke=Toke Bump() ; Return True
		
		Return False
	End

	Method ParseIdent:String()
		
		If Toke And IsIdent( Toke[0] ) 
			Local ident:=Toke
			Bump()
			Return ident
		End
		
		Error( "Expecting identifier" )
		
		Return ""
	End
	
	Method CParseIdent:String()

		If Toke And IsIdent( Toke[0] ) 
			Local ident:=Toke
			Bump()
			Return ident
		End
		
		Return ""
	End
	
	Method ParseType:String()
		
		Local isconst:=CParse( "const" )
		
		Local type:=Parse()
		If type="void" Or type="GLvoid" type="Void"
		
		If CParse( "*" )
			If isconst And (type="GLchar" Or type="GLubyte") type="CString" Else type+=" Ptr"
		Endif
		
		isconst=CParse( "const" )
		
		If CParse( "*" ) type+=" Ptr"
			
		If type="CString Ptr" type="GLcchar Ptr Ptr"
		
		Return type
	End
	
	Private

	Field _text:String
	Field _toke:String
	Field _pos:Int
	Field _tokePos:Int
	
	Method PeekChr:Int()
		
		Return _pos<_text.Length ? _text[_pos] Else 0
	End
	
	Method ParseChr:Int()
		
		Local chr:=PeekChr()

		If _pos<_text.Length _pos+=1
			
		Return chr
	End
	
End

Function FixIdent:String( ident:String )
	Select ident
	Case "ptr" Return "p"
	Case "string" Return "s"
	Case "array" Return "a"
	Case "end" Return "e"
	End
	Return ident
End

Class GLApi
	
	Field ident:String
	
	Field pfnident:String

	Field rtype:String
	Field crtype:String
		
	Field args:String
	Field cargs:String
	
	Method ParseRType( p:Parser )

		Local pos:=p.TokePos			
		rtype=p.ParseType()
		crtype=p.Text.Slice( pos,p.TokePos ).Trim()
		
	End
	
	Method ParseArgs( p:Parser )
		
		args=""
		cargs=""

		p.Parse( "(" )
		
		If p.Toke<>")"
			
			Repeat
			
				Local pos:=p.TokePos
				Local argty:=p.ParseType()
				If argty="Void" Exit
				
				Local argid:=FixIdent( p.ParseIdent() )
				
				If p.CParse( "[" )
					While p.Toke And Not p.CParse( "]" )
						p.Bump()
					Wend
				Endif
				
				
				If args args+=","
				args+=argid+":"+argty
				
				If cargs cargs+=","
				cargs+=p.Text.Slice( pos,p.TokePos )
				
				If Not p.CParse( "," ) Exit
				
			Forever
		
		Endif
		
		p.Parse( ")" )
		
	End
	
	Method Mx2Decl:String()
		
		Return "Function "+ident+":"+rtype+"("+args+")"	'=~qbb"+ident+"~q"
	End
	
	Method CDecl:String()
		
		Return "GLAPI "+crtype+" GLFUN("+ident+")("+cargs+");"
	End
	
	Method CDef:String()
		
		Return "#define "+ident+" bb"+ident
	End
	
	Method CInit:String()
		
		Return "bb"+ident+"=SDL_GL_GetProcAddress(~q"+ident+"~q);"
	End
	
End

Function Main()
	
	ChangeDir( "modules/opengl/autogen" )
	
	Local src:=LoadString( "gl_version_2_1.h" )
	src+="~n"+LoadString( "gl_extensions.h" )
	Assert( src )
	
	Local lines:=New StringStack
	
	Local defvals:=New StringMap<String>
	
	Local pfnapis:=New StringMap<GLApi>
	
	Local apis:=New Stack<GLApi>
	
	Local defs:=New Stack<String>
	
	For Local line:=Eachin src.Split( "~n" )
		
		line=line.Trim()
		If Not line Continue
		
		Local p:=New Parser( line )
		Select p.Toke
		Case "#define"
			
			p.Bump()
			
			Local ident:=p.ParseIdent()
			
			Local value:=p.Toke
			
			If defvals.Contains( ident )
				If  defvals[ident]<>value Print "Error: #define error for: "+ident
				Continue
			Endif
			
			defvals[ident]=value
				
			If value="GLEW_GET_FUN"
				
				Local pfnident:="PFN"+ident.ToUpper()+"PROC"
				
				Local api:=pfnapis[pfnident]
				
				If Not api
					Print "Api for "+pfnident+" not found!"
					Continue
				Endif
					
				api.ident=ident
				
				apis.Add( api )
				
				Continue
			Endif

			If Not ident.StartsWith( "GL_" ) Continue
			
			defs.Add( ident )

		Case "typedef"
			
			p.Bump()

			'typedef Void (GLAPIENTRY * PFNGLMULTITEXCOORD2DPROC) (GLenum target, GLdouble s, GLdouble t);

			Local api:=New GLApi
			
			api.ParseRType( p )
			
			If Not p.CParse( "(" ) Continue
			
			p.Parse( "GLAPIENTRY" )
			p.Parse( "*" )
			
			api.pfnident=p.ParseIdent()
			
			p.Parse( ")" )
			
			api.ParseArgs( p )
			
			p.Parse( ";" )
			
			pfnapis[api.pfnident]=api
			
'			api.crtype+"!"+api.pfnident+" ("+api.cargs+");"
		
		Case "GLAPI"
			
			p.Bump()
			
			Local api:=New GLApi
			
			api.ParseRType( p )
			
			p.Parse( "GLAPIENTRY" )
			
			api.ident=p.ParseIdent()
			
			Local pfnident:="PFN"+api.ident.ToUpper()+"PROC"
			
			If pfnapis.Contains( pfnident )
				Print "Api for "+pfnident+" already found!"
				Continue
			Endif

			api.pfnident=pfnident

			api.ParseArgs( p )
			
			pfnapis[pfnident]=api
		
			apis.Add( api )
			
		End
	
	Next
	
	Local buf:=New StringStack,str:=""
	
	CreateDir( "../native" )
	
	'***** create bbopengl.h file *****
	'
	For Local def:=Eachin defs
		buf.Add( "#define "+def+" "+defvals[def] )
	Next
	Local hdefs:=buf.Join( "~n" )
	
	buf.Clear()
	For Local api:=Eachin apis
		buf.Add( api.CDecl() )
	Next
	Local cdecls:=buf.Join( "~n" )
	
	buf.Clear()
	For Local api:=Eachin apis
		buf.Add( api.CDef() )
	End
	Local cdefs:=buf.Join( "~n" )
	
	str=LoadString( "bbopengl_.h" )
	str=str.Replace( "${DEFS}",hdefs )
	str=str.Replace( "${DECLS}",cdecls )
	str=str.Replace( "${CDEFS}",cdefs )
	
	SaveString( str,"../native/bbopengl.h" )
	
	'***** create bbopengl.c file *****
	'
	buf.Clear()
	For Local api:=Eachin apis
		buf.Add( "~t"+api.CInit() )
	Next
	Local cinits:=buf.Join( "~n" )
	
	str=LoadString( "bbopengl_.c" )
	str=str.Replace( "${INITS}",cinits )
	
	SaveString( str,"../native/bbopengl.c" )
	
	'***** create opengl.monkey2 file *****
	'
	buf.Clear()
	For Local def:=Eachin defs
		buf.Add( "Const "+def+":Int" )
	Next
	Local mx2defs:=buf.Join( "~n" )

	buf.Clear()
	For Local api:=Eachin apis
		
		Local decl:=api.Mx2Decl()
		If Not decl Continue
		
		buf.Add( api.Mx2Decl() )
	Next
	Local mx2decls:=buf.Join( "~n" )
	
	str=LoadString( "bbopengl_.monkey2" )
	str=str.Replace( "${DEFS}",mx2defs )
	str=str.Replace( "${DECLS}",mx2decls )
	
	SaveString( str,"../native/bbopengl.monkey2" )
	
End
