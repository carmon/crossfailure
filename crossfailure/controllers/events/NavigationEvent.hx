package crossfailure.controllers.events;

import flash.events.Event;

/**
 * ...
 * @author Carmon
 */
class NavigationEvent extends Event
{
	public inline static var NAVIGATE_TO	:String = "navigateTo";
	
	public var data:String;

	public function new(type:String, data:String) 
	{
		this.data = data;
		super(type, false, false);		
	}	
}