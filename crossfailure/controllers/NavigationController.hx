package crossfailure.controllers;
import crossfailure.controllers.events.NavigationEvent;
import flash.events.EventDispatcher;

/**
 * ...
 * @author Carmon
 */
class NavigationController extends EventDispatcher
{

	public function new() 
	{
		super();
	}
	
	public function dispatchNavigateTo(target:String):Void
	{
		dispatchEvent(new NavigationEvent(NavigationEvent.NAVIGATE_TO, target));
	}
}