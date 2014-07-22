package crossfailure.ui.sprites;

import crossfailure.ui.common.Animation;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.Timer;
import openfl.display.Tilesheet;

/**
 * ...
 * @author Carmon
 */
class AnimatedSprite extends Sprite
{
	private var _playing		:Bool;	
	private var _playTimer		:Float;
	
	private var _currentFrame	:Int;
	private var _currentAnim	:Int;
	private var _animations		:Array<Animation>;
	
	private var _xTiles			:Int;
	private var _yTiles			:Int;
	private var _tileWidth		:Float;
	private var _tileHeight		:Float;
	
	private var _tileSheet		:Tilesheet;
	
	public var tileWidth(get, set):Float;
	function get_tileWidth():Float
	{
		return _tileWidth;
	}
	function set_tileWidth(value:Float):Float
	{
		_tileWidth = value;
		return _tileWidth;
	}
	
	public var tileHeight(get, set):Float;
	function get_tileHeight():Float
	{
		return _tileHeight;
	}
	function set_tileHeight(value:Float):Float
	{
		_tileHeight = value;
		return _tileHeight;
	}
	
	public function new() 
	{
		super();
		
		cacheAsBitmap = true;
	
		_animations 	= [];
		_currentFrame 	= 0;
		_playing		= false;
	}
	
	public function setSpriteSheet(bmp:BitmapData, frameWidth:Float, frameHeight:Float):Void
	{
		_tileWidth = frameWidth;
		_tileHeight = frameHeight;
				
		_xTiles = Std.int(bmp.width / _tileWidth);
		_yTiles = Std.int(bmp.height / _tileHeight);
				
		_tileSheet = new Tilesheet(bmp);		
		for (i in 0..._xTiles) {
			for (j in 0..._yTiles) {
				_tileSheet.addTileRect(new Rectangle(i * _tileWidth, j * _tileHeight, _tileWidth, _tileHeight));
			}
		}
		_tileSheet.drawTiles(graphics, [0, 0, 0]);
	}
	
	public function hasSpriteSheet():Bool
	{
		return _tileSheet != null;
	}
	
	public function removeSpriteSheet():Void
	{
		graphics.clear();
		_tileSheet = null;
	}
	
	public function addAnimation(name:String, frames:Array<Int>, loopable:Bool, frameRate:Int):Void
	{
		_animations.push(new Animation(name, frames, loopable, frameRate));
	}
	
	public function play(name:String):Void
	{
		for (i in 0..._animations.length) {
			var anim:Animation = _animations[i];
			if (anim.name == name) {
				_currentFrame = 0;
				_currentAnim = i;
				render();
				_playTimer = Timer.stamp();
				_playing = true;
			}
		}
	}
	
	public function stop():Void
	{
		_playing = false;
	}
	
	public function update():Void
	{
		if (!_playing) return;
		
		var anim:Animation = _animations[_currentAnim];
		var currentTimer:Float = Timer.stamp();
		if (currentTimer - _playTimer > 1 / anim.frameRate) {
			_playTimer = currentTimer;
			
			if (_currentFrame == anim.frames.length) {
				if (anim.loopable) {
					_currentFrame = 0;
				} else {
					_playing = false;
					return;
				}
			}
			render();
		}		
	}
	
	private function render():Void
	{
		graphics.clear();
		var anim:Animation = _animations[_currentAnim];
		var realFrame:Int = anim.frames[_currentFrame];
		_tileSheet.drawTiles(graphics, [0, 0, realFrame]);
		_currentFrame++;
	}
}