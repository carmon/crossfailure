package ui.basics;

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

/**
 * ...
 * @author Carmon
 */
class InfoText extends Sprite
{
	private var _label	:TextField;
	private var _value	:TextField;

	public function new() 
	{
		super();
	
		_label = new TextField();
		_value = new TextField();
		_label.autoSize	 = TextFieldAutoSize.LEFT;
		_label.textColor = _value.textColor = 0xffffff;
		
		addChild(_label);
		addChild(_value);
	}
	
	public function create(label:String, value:String):Void
	{
		_label.text = label;
		_value.text = value;
	}
	
	public function setPos(x:Float, y:Float):Void
	{
		_label.x = x;
		_label.y = y;
		
		_value.x = x + _label.width + 5;
		_value.y = y;
	}
	
	public function update(value:String):Void
	{
		_value.text = value;
	}
	
	public function destroy():Void
	{
		removeChild(_value);
		removeChild(_label);
		
		_value = _label = null;
	}
}