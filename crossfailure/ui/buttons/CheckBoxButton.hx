package crossfailure.ui.buttons;

import flash.display.BitmapData;
import flash.events.Event;
import flash.events.MouseEvent;
import openfl.Assets;

/**
 * ...
 * @author Carmon
 */
@:meta(Event(name="change",type="flash.events.Event"))
class CheckBoxButton extends Button
{
	public static var STATE_CHECK	:String = "check";
	public static var STATE_UNCHECK	:String = "uncheck";

	public function new()
	{
		super();
	}

	override public function create(x:Float = 0, y:Float = 0, asset:BitmapData=null):Void
	{
		var bmp:BitmapData = Assets.getBitmapData("img/checkboxbutton_temp.png");
		super.create(x, y, bmp);
		if (_graphic.hasSpriteSheet()) {
			_graphic.removeSpriteSheet();
		}
		_graphic.setSpriteSheet(bmp, bmp.width * .5, bmp.height);

		addState(STATE_UNCHECK, 0);
		addState(STATE_CHECK, 1);
		setState(STATE_UNCHECK);
	}

	override private function onMouseClick(e:MouseEvent):Void
	{
		if (_states[_currentState] == STATE_UNCHECK) {
			setState(STATE_CHECK);
		} else {
			setState(STATE_UNCHECK);
		}
		dispatchEvent(new Event(Event.CHANGE));
	}

	public function isChecked():Bool
	{
		return _states[_currentState] == STATE_CHECK;
	}
}
