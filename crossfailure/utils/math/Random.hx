package crossfailure.utils.math;

/**
 * ...
 * @author Carmon
 */
class Random
{
	public static function randRange(min:Float, max:Float):Float
	{
		return (Math.floor(Math.random() * (max - min + 1)) + min);
	}
}