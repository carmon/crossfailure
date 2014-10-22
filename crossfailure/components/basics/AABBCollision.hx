package crossfailure.components.basics ;
import openfl.geom.Point;

/**
 * ...
 * @author Carmon
 */
class AABBCollision
{
	public var min:Point;
	public var max:Point;

	public function new(min:Point, max:Point) 
	{
		this.min = min;
		this.max = max;
	}
	
}