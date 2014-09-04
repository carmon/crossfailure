package crossfailure.utils.input;

import flash.display.DisplayObject;
import flash.events.KeyboardEvent;

class Keyboard extends Input
{
	public var ESCAPE:Bool;
	public var ONE:Bool;
	public var TWO:Bool;
	public var THREE:Bool;
	public var FOUR:Bool;
	public var FIVE:Bool;
	public var SIX:Bool;
	public var SEVEN:Bool;
	public var EIGHT:Bool;
	public var NINE:Bool;
	public var ZERO:Bool;
	public var PAGEUP:Bool;
	public var PAGEDOWN:Bool;
	public var HOME:Bool;
	public var END:Bool;
	public var INSERT:Bool;
	public var MINUS:Bool;
	public var PLUS:Bool;
	public var DELETE:Bool;
	public var BACKSPACE:Bool;
	public var TAB:Bool;
	public var Q:Bool;
	public var W:Bool;
	public var E:Bool;
	public var R:Bool;
	public var T:Bool;
	public var Y:Bool;
	public var U:Bool;
	public var I:Bool;
	public var O:Bool;
	public var P:Bool;
	public var LBRACKET:Bool;
	public var RBRACKET:Bool;
	public var BACKSLASH:Bool;
	public var CAPSLOCK:Bool;
	public var A:Bool;
	public var S:Bool;
	public var D:Bool;
	public var F:Bool;
	public var G:Bool;
	public var H:Bool;
	public var J:Bool;
	public var K:Bool;
	public var L:Bool;
	public var SEMICOLON:Bool;
	public var QUOTE:Bool;
	public var ENTER:Bool;
	public var SHIFT:Bool;
	public var Z:Bool;
	public var X:Bool;
	public var C:Bool;
	public var V:Bool;
	public var B:Bool;
	public var N:Bool;
	public var M:Bool;
	public var COMMA:Bool;
	public var PERIOD:Bool;
	public var SLASH:Bool;
	public var CONTROL:Bool;
	public var ALT:Bool;
	public var SPACE:Bool;
	public var UP:Bool;
	public var DOWN:Bool;
	public var LEFT:Bool;
	public var RIGHT:Bool;
	
	private var _displayObj	:DisplayObject;
	
	public function new(displayObj:DisplayObject) 
	{
		super();
		//Letters
		#if cpp
		for (letter in 97...123)
		{
			AddKey(String.fromCharCode(letter - 32), letter);
		}
		#else
		for (letter in 65...91)
		{
			AddKey(String.fromCharCode(letter), letter);
		}
		#end
		
		_displayObj = displayObj;
		
		//Numbers
		AddKey("ZERO", 48);
		AddKey("ONE", 49);
		AddKey("TWO", 50);
		AddKey("THREE", 51);
		AddKey("FOUR", 52);
		AddKey("FIVE", 53);
		AddKey("SIX", 54);
		AddKey("SEVEN", 55);
		AddKey("EIGHT", 56);
		AddKey("NINE", 57);
		
		AddKey("PAGEUP", 33);
		AddKey("PAGEDOWN", 34);
		AddKey("HOME", 36);
		AddKey("END", 35);
		AddKey("INSERT", 45);
		
		//Special Keys + Punctuation
		AddKey("ESCAPE", 27);
		AddKey("MINUS", 189);
		AddKey("PLUS", 187);
		AddKey("DELETE", 46);
		AddKey("BACKSPACE", 8);
		AddKey("LBRACKET", 219);
		AddKey("RBRACKET", 221);
		AddKey("BACKSLASH", 220);
		AddKey("CAPSLOCK", 20);
		AddKey("SEMICOLON", 186);
		AddKey("QUOTE", 222);
		AddKey("ENTER", 13);
		AddKey("SHIFT", 16);
		AddKey("COMMA", 188);
		AddKey("PERIOD", 190);
		AddKey("SLASH", 191);
		AddKey("CONTROL", 17);
		AddKey("ALT", 18);
		AddKey("SPACE", 32);
		AddKey("UP", 38);
		AddKey("DOWN", 40);
		AddKey("LEFT", 37);
		AddKey("RIGHT", 39);
		AddKey("TAB", 9);
	}
	
	override public function start():Void 
	{
		super.start();
        _displayObj.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
        _displayObj.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);		
	}
	
	private function handleKeyDown(freshEvent:KeyboardEvent):Void
	{
		var keyObject:Key = _map[freshEvent.keyCode];
		if (keyObject == null)
		{
			return;
		}
		if (keyObject.Current > 0)
		{
			keyObject.Current = 1;
		} else {
			keyObject.Current = 2;
		}
		Reflect.setField(this, keyObject.Name, true);
	}
	
	private function handleKeyUp(freshEvent:KeyboardEvent):Void
	{
		var keyObject:Key = _map[freshEvent.keyCode];
		if (keyObject == null)
		{
			return;
		}
		if (keyObject.Current > 0)
		{
			keyObject.Current = -1;
		} else {
			keyObject.Current = 0;
		}
		Reflect.setField(this, keyObject.Name, false);
	}
}