package crossfailure.models;
import crossfailure.controllers.NavigationController;

/**
 * ...
 * @author Carmon
 */
class AbstractModel
{
	private var _navigation :NavigationController;
	
	public var navigationController(get, never):NavigationController;
	function get_navigationController():NavigationController
	{
		return _navigation;
	}

	public function new() 
	{
		_navigation = new NavigationController();
	}
	
	public function init():Void
	{		
		
	}
	
	public function goto(target:String):Void
	{
		_navigation.dispatchNavigateTo(target);
	}
	
	public function isInDebugMode():Bool
	{
		#if debug
		return true;
		#else 
		return false;
		#end
	}
}