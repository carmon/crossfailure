package crossfailure.core;

/**
 * ...
 * @author Carmon
 */
class Entity
{
	private static var countName	:Int = 0;
	
	public var name(default, set):String;

	public function new(name:String="") 
	{
		if (name != "")
            this.name = name;
        else
            this.name = "_entity" + (++nameCount);
	}
	
	private inline function set_name(value:String):String
	{
		name = value;
		return name;
	}
}