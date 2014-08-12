package sample.sections.game;
import crossfailure.ui.sprites.AnimatedSprite;
import openfl.Assets;

/**
 * ...
 * @author Carmon
 */
class Character
{
	public static var DIR_LEFT	:String = "left";
	public static var DIR_RIGHT	:String = "right";
	public static var DIR_UP	:String = "up";
	public static var DIR_DOWN	:String = "down";
		
	private var _sprite	:AnimatedSprite;
	public var sprite(get, never):AnimatedSprite;
	function get_sprite():AnimatedSprite
	{
		return _sprite;
	}

	public function new() 
	{
		_sprite = new AnimatedSprite();
		_sprite.setSpriteSheet(Assets.getBitmapData("img/sprite_test.jpg"), 64, 64);
		_sprite.addAnimation(DIR_LEFT, [0], true, 8);
		_sprite.addAnimation(DIR_RIGHT, [1], true, 8);
		_sprite.addAnimation(DIR_UP, [2], true, 8);
		_sprite.addAnimation(DIR_DOWN, [3], true, 8);
	}
	
	public function update():Void
	{
		_sprite.update();
	}
}