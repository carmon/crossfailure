package crossfailure.ui.buttons;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import openfl.Assets;
import ui.pxBitmapFont.BitmapFontBitmapFont;
import ui.pxBitmapFont.BitmapFontTextAlign;
import ui.pxBitmapFont.BitmapFontTextField;

/**
 * ...
 * @author Carmon
 */
class LabelledButton extends EventDispatcher
{
	private var _graphic		:AnimatedSprite;
	public var graphic(get, null):AnimatedSprite;
	function get_graphic() { return _graphic; }

	private var _states			:Array<String>;
	private var _currentState	:Int;

	private var _textField		:BitmapFontTextField;
	private var _background		:ScaleBitmap;

	public function new()
	{
		super();

		_states = [];
		_currentState = -1;
	}

	public function create(x:Float = 0, y:Float = 0, text:String="", width:Float = 60, height:Float = 60):Void
	{
		_graphic = new AnimatedSprite();
		_graphic.mouseChildren = false;
		_graphic.useHandCursor = _graphic.buttonMode = true;
		_graphic.addEventListener(MouseEvent.CLICK, onMouseClick);

		_background = new ScaleBitmap(Assets.getBitmapData('img/labeled_button_background.png'));
		_background.scale9Grid = new Rectangle(13, 13, 32, 32);
		_background.setSize(width, height);

		var font:BitmapFontBitmapFont = new BitmapFontBitmapFont().loadAngelCode(Assets.getBitmapData("font/CreatorCreditsBB_0.png"), Xml.parse(Assets.getText("font/CreatorCreditsBB.fnt")));

		_textField = new BitmapFontTextField(font);
		_textField.fontScale = .6;
		_textField.alignment = BitmapFontTextAlign.CENTER;
		_textField.x = 5;
		_textField.y = 1;
		_textField.color = 0x00;
		_textField.text = text;
		_textField.setWidth(cast(width, Int));
		_textField.drawText();

		var holder:Sprite = new Sprite();
		holder.addChild(_background);
		holder.addChild(_textField);

		var bmp:BitmapData = new BitmapData(cast(width,Int), cast(height,Int), true, 0x00000000);
		bmp.draw(holder);
		_graphic.setSpriteSheet(bmp, bmp.width, bmp.height);
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
		return _graphic.visible;
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
