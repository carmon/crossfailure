package crossfailure.components;
import crossfailure.components.basics.Transformation;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author Carmon
 */
class Camera
{
	public var position:Point;	
	public var width:Float;
	public var height:Float;
	
	public var target:Transformation;
	public var background:Sprite;

	public function new(position:Point, width:Float, height:Float, backgroundColor:UInt) 
	{
		this.position = position;
		this.width = width;
		this.height = height;
		
		background = new Sprite();
		background.graphics.beginFill(0x1ec7ff);
		background.graphics.drawRect(0, 0, this.width, this.height);
		background.graphics.endFill();
		background.mouseEnabled = false;
	}
	
	public function addTarget(target:Transformation):Void
	{
		this.target = target;
	}
	
	public function releaseTarget():Void
	{
		this.target = null;
	}
}