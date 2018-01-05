
Namespace reflection

#Import "<std>"

Using std..

#rem monkeydoc Debug reflected types.

Prints all reflected types and decls.

#end
Function DebugTypes()
	
	For Local type:=Eachin TypeInfo.GetTypes()
		
		Print type
		
		For Local decl:=Eachin type.GetDecls()
			
			Print "  "+decl
		Next
		
		Print ""
		
	Next
	
End

#rem monkeydoc Gets type extensions for a given type.

Returns an array containing all type extensions for a given type.

#end
Function GetTypeExtensions:TypeInfo[]( type:TypeInfo )

	Global _typeExts:StringMap<TypeInfo[]>
	
	If Not _typeExts
	
		Local typeExts:=New StringMap<Stack<TypeInfo>>
		
		For Local type:=Eachin TypeInfo.GetTypes()
			
			If Not type.Kind.EndsWith( " Extension" ) Continue
			
			If Not typeExts.Contains( type.SuperType ) typeExts[type.SuperType]=New Stack<TypeInfo>
	
			typeExts[type.SuperType].Add( type )
		
		Next
		
		_typeExts=New StringMap<TypeInfo[]>
		
		For Local it:=Eachin typeExts
			
			_typeExts[it.Key]=it.Value.ToArray()
		
		Next
	
	Endif
	
	Return _typeExts[type]
End

#rem monkeydoc Gets the value of a property.
#end
Function GetProperty:Variant( name:String,instance:Variant )
	
	Local type:=instance.Type
	
	While type
		
		Local decl:=type.GetDecl( name )
		
		If decl And decl.Kind="Property" And decl.Name=name Return decl.Get( instance )
		
		For Local type:=Eachin GetTypeExtensions( type )
			
			Local decl:=type.GetDecl( name )

			If decl And decl.Kind="Property" And decl.Name=name Return decl.Get( instance )
		
		Next
		
		type=type.SuperType
	
	Wend
	
	Return Null
End

Function GetProperty<T>:T( name:String,instance:Variant )
	
	Local value:=GetProperty( name,instance )
	
	If value Return Cast<T>( value )
	
	Return Null
End

#rem monkeydoc Sets a property to a value.
#end
Function SetProperty:Bool( name:String,instance:Variant,value:Variant )
	
	Local type:=instance.Type
	
	While type
		
		Local decl:=type.GetDecl( name )
		
		If decl And decl.Kind="Property" And decl.Name=name
			decl.Set( instance,value )
			Return True
		Endif
		
		For Local type:=Eachin GetTypeExtensions( type )

			Local decl:=type.GetDecl( name )
			
			If decl And decl.Kind="Property" And decl.Name=name
				decl.Set( instance,value )
				Return True
			Endif
		
		Next
		
		type=type.SuperType
	
	Wend
	
	Return False

End
