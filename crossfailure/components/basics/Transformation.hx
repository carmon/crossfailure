package crossfailure.components.basics ;
import openfl.geom.Point;

/**
 * ...
 * @author Carmon
 */
class Transformation
{
	public var position	:Point;
	public var rotation :Float;

	public function new(x:Float, y:Float, rotation:Float) 
	{
		position = new Point(x, y);
		this.rotation = rotation;
	}
	
	public function clone():Transformation
	{
		return new Transformation(position.x, position.y, rotation);
	}
}