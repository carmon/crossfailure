package crossfailure.ui.common;

/**
 * ...
 * @author Carmon
 */
class Animation
{
	public var name		:String;
	public var frames	:Array<Int>;
	public var loopable	:Bool;
	public var frameRate:Int;

	public function new(name:String, frames:Array<Int>, loopable:Bool, frameRate:Int) 
	{
		this.name = name;
		this.frames = frames;
		this.loopable = loopable;
		this.frameRate = frameRate;
	}
	
}