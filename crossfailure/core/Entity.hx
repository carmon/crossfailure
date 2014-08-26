package crossfailure.core;
import crossfailure.signals.Signal2.Signal2;
import crossfailure.utils.classes.ClassMap;

/**
 * ...
 * @author Carmon
 */
class Entity
{
	private static var nameCount	:Int = 0;
	
	public var name(default, set):String;
	
	public var nameChanged:Signal2<Entity, String>;
	
	public var componentAdded(default, null):Signal2 < Entity, Class<Dynamic> > ;
	public var componentRemoved(default, null):Signal2 < Entity, Class<Dynamic> > ;

	public var components(default, null):ClassMap < Class<Dynamic>, Dynamic > ;
	
	public var prev:Entity;
	public var next:Entity;	
	
	public function new(name:String="") 
	{
		nameChanged = new Signal2<Entity, String>();
		componentAdded = new Signal2 < Entity, Class<Dynamic> > ();
		componentRemoved = new Signal2 < Entity, Class<Dynamic> > ();
		components = new ClassMap();
		
		if (name != "")
            this.name = name + "_entity" + (++nameCount);
        else
            this.name = "_entity" + (++nameCount);
	}
	
	private inline function set_name(value:String):String
	{
		if (name != value) {
			var previous = name;
			name = value + "_entity" + (++nameCount);
			nameChanged.dispatch(this, previous);
		}
		return name;
	}
	
	public function add<T>(component:T, componentClass:Class<Dynamic> = null):Entity
	{
		if (componentClass == null)
			componentClass = Type.getClass(component);
			
		if (components.exists(componentClass))
			remove(componentClass);
		
		components.set(componentClass, component);
		componentAdded.dispatch(this, componentClass);
		return this;
	}
	
	public function get<T>(componentClass:Class<Dynamic>):T
	{
		return components.get(componentClass);
	}
	
	public function remove<T>(componentClass:Class<Dynamic>):T
	{
		var component:T = components.get(componentClass);
		if (component != null) {
			components.remove(componentClass);
			componentRemoved.dispatch(this, componentClass);
			return component;
		}
		return null;
	}
	
	public function getAll():Array<Dynamic>
	{
		var array:Array<Dynamic> = new Array<Dynamic>();
		for (component in components)
			array.push(component);
		return array;
	}
	
	public function has(componentClass:Class<Dynamic>):Bool
	{
		return components.exists(componentClass);
	}
}