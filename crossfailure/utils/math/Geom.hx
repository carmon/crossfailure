package crossfailure.utils.math;

import flash.geom.Point;
/**
 * ...
 * @author Carmon
 */
class Geom
{

	public static function pointInsidePoly(p:Point, poly:Array<Point>):Bool
	{
		var minX :Float = poly[0].x;
		var minY :Float = poly[0].y;
		var maxX :Float = poly[0].x;
		var maxY :Float = poly[0].y;
		
		for (vert in poly) {
			if (vert.x < minX) minX = vert.x; 
			if (vert.y < minY) minY = vert.y; 
			if (vert.x > maxX) maxX = vert.x; 
			if (vert.y > maxY) maxY = vert.y; 
		}
		
		if (p.x < minX || p.x > maxX || p.y < minY || p.y > maxY) {
			return false;
		} else {
			var numVert	:Int = poly.length;
			var j		:Int = numVert-1;
			var v1		:Point;
			var v2		:Point;
			var count	:Int = 0;
			for (i in 0...numVert) {
				j = i + 1 == numVert ? 0: i + 1;
				v1 = poly[i];
				v2 = poly[j];
				if (isLeft(p, v1, v2)) {
					if ((p.y > v1.y && p.y <= v2.y) || (p.y > v2.y && p.y <= v1.y))	{
						count++;
					}
				}
			}
			if (count % 2 == 0)	{
				return false;
			} else {
				return true;
			}
		}
	}
	
	private static function isLeft(p:Point, v1:Point, v2:Point):Bool
	{
		if (v1.x == v2.x) {
			if (p.x <= v1.x) {
				return true;
			} else {
				return false;
			}
		} else {
			var m:Float = (v2.y - v1.y) / (v2.x - v1.x);
			var x2:Float = (p.y - v1.y) / m + v1.x;
			if (p.x <= x2) {
				return true;
			} else {
				return false;
			}
		}
	}
	
}