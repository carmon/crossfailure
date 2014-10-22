package crossfailure.components.basics ;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Carmon
 */
class Display
{
	private var _ui	:Bool;
	
	public var displayObject(default, null):DisplayObject;
	
	public function new(displayObject:DisplayObject, ?ui:Bool=false) 
	{
		this.displayObject = displayObject;
		_ui = ui;
	}
	
	public function isUI():Bool
	{
		return _ui;
	}
}