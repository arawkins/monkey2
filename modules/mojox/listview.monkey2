
Namespace mojox

Class ListView Extends ScrollableView

	#rem monkeydoc Invoked when an item is clicked.
	#end
	Field ItemClicked:Void( item:Item )
	
	#rem monkeydoc Invoked when an item is double clicked.
	#end
	Field ItemDoubleClicked:Void( item:Item )

	#rem monkeydoc Invoked when an item is right clicked.
	#end
	Field ItemRightClicked:Void( item:Item )
	
	#rem monkeydoc Invoked when current selected item is changed.
	An item can be Null.
	#end
	Field SelectedChanged:Void( item:Item )
	
	Class Item Extends ViewCell
	
		Method New( text:String,icon:Image,list:ListView )
			Super.New( text,icon )
			_list=list
		End
		
		Private
		
		Field _list:ListView
		Field _rect:Recti
	
	End

	#rem monkeydoc Creates a new list view.
	#end
	Method New()	
		Style=GetStyle( "ListView" )
		ContentView.Style=GetStyle( "ListViewContent" )
		_itemStyle=GetStyle( "ListViewItem" )
	End

	#rem monkeydoc Currently selected item.
	#end
	Property Selected:Item()
	
		Return _selected
	
	Setter( selected:Item )
		
		If selected<>_selected
			_selected=selected
			_selIndex=IndexOfItem( _selected )
			SelectedChanged( _selected )
		Endif
		
		If _selected Then EnsureVisible( _selected._rect )
		
		RequestRender()
	End
	
	#rem monkeydoc Currently selected index.
	#end
	Property SelectedIndex:Int()
		
		Return _selIndex
		
	Setter( value:Int )
		
		Selected=ItemAtIndex( value )
	End
	
	#rem monkeydoc Items count in the list view.
	#end
	Property Count:Int()
	
		Return _items.Length
	End
	
	#rem monkeydoc Adds an item to the list view.
	#end
	Method AddItem:Item( text:String,icon:Image=Null )
	
		Return InsertItem( _items.Length,text,icon )
	End
	
	#rem monkeydoc Inserts an item to the list view at a given index.
	#end
	Method InsertItem:Item( index:Int,text:String,icon:Image=Null )
		
		Local item:=New Item( text,icon,Self )
		_items.Insert( index,item )
		
		RequestRender()
		
		Return item
	End
	
	#rem monkeydoc Removes an item from the list view.
	#end
	Method RemoveItem( index:Int )
	
		RemoveItems( index,index+1 )
	End
	
	#rem monkeydoc Removes an item from the list view.
	#end
	Method RemoveItem( item:Item )
	
		RemoveItem( IndexOfItem( item ) )
	End

	#rem monkeydoc Removes a sequence of items from the list view.
	#end	
	Method RemoveItems( index1:Int,index2:Int )
	
		For Local i:=index1 Until index2
			If _items[i]<>_selected Continue
			Selected=Null
			Exit
		Next
	
		_items.Erase( index1,index2 )
		
		RequestRender()
	End
	
	#rem monkeydoc Removes all items from the list view.
	#end
	Method RemoveAllItems()
	
		_items.Clear()
		
		Selected=Null
		
		_hover=Null
		
		RequestRender()
	End
	
	#rem monkeydoc Returns the index of a given item in the list view.
	#end
	Method IndexOfItem:Int( item:Item )

		For Local i:=0 Until _items.Length
			If _items[i]=item Return i
		Next
		
		Return -1
	End
	
	#rem monkeydoc Returns the item at a point in the list view.
	#end
	Method ItemAtPoint:Item( point:Vec2i )
	
		Local i:=IndexOfItemAtPoint( point )
		If i=-1 Return null
		
		Local item:=_items[i]
		If Not item._rect.Contains( point ) Return Null
		
		Return item
	End
	
	#rem monkeydoc Returns the item by index in the list view.
	#end
	Method ItemAtIndex:Item( index:Int )
		
		Return (index>=0 And index<_items.Length) ? _items[index] Else Null
	End
	
	Protected
	
	#rem monkeydoc @hidden
	#end
	Method OnMeasureContent:Vec2i() Override
	
		Local w:=0,h:=0
		
		For Local item:=Eachin _items
		
			Local style:=ItemStyle( item )
		
			Local size:=item.Measure( style )
			
			item._rect=New Recti( 0,h,size.x,h+size.y )
			
			w=Max( w,size.x )
			h+=size.y
		Next
		
		Return New Vec2i( w,h )

	End
	
	#rem monkeydoc @hidden
	#end
	Method OnRenderContent( canvas:Canvas ) Override
	
		If _items.Empty Return
	
		Local clip:=VisibleRect
		
		Local first:=IndexOfItemAtPoint( New Vec2i( 0,clip.Top ) ) 
		If first=-1 first=0
		
		Local last:=IndexOfItemAtPoint( New Vec2i( 0,clip.Bottom-1 ) )+1
		If Not last last=_items.Length
		
		For Local i:=first Until last
		
			Local item:=_items[i]
		
			Local style:=ItemStyle( item )
		
			item.Render( canvas,item._rect,style,New Vec2f( 0,.5 ) )
		Next
		
	End
	
	#rem monkeydoc @hidden
	#end
	Method OnContentMouseEvent( event:MouseEvent ) Override
	
		Select event.Type
		
		Case EventType.MouseDown,EventType.MouseWheel
		
			Return

		Case EventType.MouseClick
		
			Local item:=ItemAtPoint( event.Location )
			If item
				Selected=item
				ItemClicked( item )
			Endif
			
		Case EventType.MouseRightClick
		
			Local item:=ItemAtPoint( event.Location )
			If item
				Selected=item
				ItemRightClicked( item )
			Endif
			
		Case EventType.MouseDoubleClick
		
			Local item:=ItemAtPoint( event.Location )
			If item ItemDoubleClicked( item )
			
		Case EventType.MouseMove,EventType.MouseMove
		
			Local item:=ItemAtPoint( event.Location )
			If item<>_hover
				_hover=item
				RequestRender()
			Endif
			
		Case EventType.MouseLeave
		
			If _hover
				_hover=Null
				RequestRender()
			Endif

		End
		
		event.Eat()
	End
	
	Protected
	
	Method OnValidateStyle() Override
		_hoverStyle=_itemStyle.GetState( "hover" )
		_selectedStyle=_itemStyle.GetState( "selected" )
	End
	
	Private
	
	Field _items:=New Stack<Item>
	
	Field _itemStyle:Style
	Field _hoverStyle:Style
	Field _selectedStyle:Style
	
	Field _hover:Item
	Field _selected:Item
	Field _selIndex:Int
	
	Field _dirty:Bool

	Method ItemStyle:Style( item:Item )
	
		If item=_selected Return _selectedStyle
		
		If item=_hover Return _hoverStyle
		
		Return _itemStyle
	End
	
	Method IndexOfItemAtPoint:Int( p:Vec2i )

		If _items.Empty Or p.y<_items[0]._rect.Top Or p.y>=_items.Top._rect.Bottom Return -1
		
		Local min:=0,max:=_items.Length-1
		
		Repeat
			Local i:=(min+max)/2
			If p.y>=_items[i]._rect.Bottom
				min=i+1
			Else If max-min>1
				max=i
			Else
				Return i
			Endif
		Forever
		
		Return -1
	End
	
End
