package sample.sections.game.components;
import flash.display.DisplayObject;

/**
 * ...
 * @author Carmon
 */
class Display
{
	public var displayObject(default, null):DisplayObject;
	
	public function new(displayObject:DisplayObject) 
	{
		this.displayObject = displayObject;
	}
	
}