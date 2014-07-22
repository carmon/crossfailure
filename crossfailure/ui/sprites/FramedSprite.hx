package ui;

import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;

/**
 * ...
 * @author Carmon
 */
class FramedSprite extends Sprite
{	
	public function new()
	{
		super();
	}
	
	public function create():Void
	{				
		
	}
	
	public function update():Void
	{
		
	}
	
	public function destroy():Void
	{		
		while (numChildren > 0) {
			removeChildAt(numChildren - 1);
		}
	}
	
	public function addNoInteractive(display:DisplayObject, ?at:Int=-1):Void
	{
		if (Std.is(display, InteractiveObject)) {
			var interactive:InteractiveObject = cast(display, InteractiveObject);
			interactive.mouseEnabled = false;
		}
		if (at != -1) {
			addChildAt(display, at);
		} else {
			addChild(display);
		}
	}
	
	public function removeNoInteractive(display:DisplayObject):Void
	{
		removeChild(display);
	}
	
	public function addInteractive(display:DisplayObject, ?at:Int=-1):Void
	{
		if (at != -1) {
			addChildAt(display, at);
		} else {
			addChild(display);
		}
	}
	
	public function removeInteractive(display:DisplayObject):Void
	{
		removeChild(display);
	}
}