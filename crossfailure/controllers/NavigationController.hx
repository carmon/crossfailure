package crossfailure.controllers;
import crossfailure.signals.Signal1.Signal1;

/**
 * ...
 * @author Carmon
 */
class NavigationController
{
	public var navigateTo(default, null):Signal1<String>;

	public function new() 
	{		
		navigateTo = new Signal1<String>();
	}
	
	public function dispatchNavigateTo(target:String):Void
	{
		navigateTo.dispatch(target);
	}
}