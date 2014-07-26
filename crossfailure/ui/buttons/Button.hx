package crossfailure.ui.buttons;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

/**
 * ...
 * @author Carmon
 */

@:meta(MouseEvent(name="click",type="flash.events.MouseEvent"))
class Button extends EventDispatcher
{
	private var _graphic		:AnimatedSprite;
	public var graphic(get, null):AnimatedSprite;
	function get_graphic(){ return _graphic; }

	private var _states			:Array<String>;
	private var _currentState	:Int;

	public function new()
	{
		super();

		_states = [];
		_currentState = -1;
	}

	public function create(x:Float=0, y:Float=0, asset:BitmapData=null, tileWidth:Int=0, tileHeight:Int=0):Void
	{
		_graphic = new AnimatedSprite();
		_graphic.mouseChildren = false;
		_graphic.useHandCursor = _graphic.buttonMode = true;
		_graphic.addEventListener(MouseEvent.CLICK, onMouseClick);

		var width:Int = 0;
		var height:Int = 0;
		if (tileWidth == 0) {
			width = asset.width;
		} else {
			width = tileWidth;
		}
		if (tileHeight == 0) {
			height = asset.height;
		} else {
			height = tileHeight;
		}
		_graphic.setSpriteSheet(asset, width, height);

		_graphic.x = x;
		_graphic.y = y;
	}

	public var enabled(get, set):Bool;
	function set_enabled(value:Bool):Bool
	{
		_graphic.mouseEnabled = value;
		_graphic.useHandCursor = _graphic.buttonMode = value;
		if (value) {
			_graphic.addEventListener(MouseEvent.CLICK, onMouseClick);
		} else {
			_graphic.removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		return _graphic.mouseEnabled;
	}
	function get_enabled():Bool
	{
		return _graphic.mouseEnabled;
	}

	public var visible(get, set):Bool;
	function set_visible(value:Bool):Bool
	{
		_graphic.visible = value;
		return _graphic.visible;
	}
	function get_visible():Bool
	{
		return _graphic.visible;
	}

	public function addState(state:String, frame:Int):Void
	{
		_states.push(state);
		_graphic.addAnimation(state, [frame], false, 1);
	}

	public function setState(state:String):Void
	{
		if (state == _states[_currentState]) return;

		for (i in 0..._states.length) {
			if (state == _states[i]) {
				_graphic.play(_states[i]);
				_currentState = i;
			}
		}
	}

	private function onMouseClick(e:MouseEvent):Void
	{
		dispatchEvent(e);
	}

	public function destroy():Void
	{
		_graphic.removeEventListener(MouseEvent.CLICK, onMouseClick);
		_graphic = null;
	}
}
