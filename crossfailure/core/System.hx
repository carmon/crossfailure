package crossfailure.core;

/**
 * ...
 * @author Carmon
 */
class System
{
	public var prev:System;
	public var next:System;
	
	public var priority:Int;
	
	public function new() 
	{
		priority = 0;
	}
	
	public function addToEngine(engine:Engine):Void
	{
	}
	
	public function removeFromEngine(engine:Engine):Void
	{		
	}
	
	public function update(time:Float):Void
	{
	}
}