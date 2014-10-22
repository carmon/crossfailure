package crossfailure.utils;
import openfl.Lib;

/**
 * ...
 * @author Carmon
 */
class Tracker
{
	private static var _instance :Tracker = null;
	
	public static function getInstance():Tracker 
	{
		if (_instance == null) {
			_instance = new Tracker();
		}
		return _instance;
	}
	
	private var _entitiesMap:Map<String,Int>;

	public function new() 
	{
		if(_instance != null){
			Lib.trace("Tracker must be instanciated.");
			return;
		}
		
		_entitiesMap = new Map<String,Int>();
	}
	
	public function registerEntityType(key:String):Void
	{
		if (_entitiesMap.exists(key)) {
			Lib.trace("Entity type "+key+" already exists.");
		} else {
			_entitiesMap.set(key, 0);
		}
	}
	
	public function getEntityTypeCount(key:String):Int
	{
		var temp:Int = _entitiesMap.get(key);
		_entitiesMap.set(key, temp + 1);
		return temp;
	}
}