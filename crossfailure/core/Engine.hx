package crossfailure.core;

import crossfailure.signals.Signal0;
import crossfailure.signals.Signal1;

/**
 * ...
 * @author Carmon
 */
class Engine
{
	public var entities(get_entities, never):Iterable<Entity>;
	public var systems(get_systems, never):Iterable<System>;	
	
	public var entityNames:Map<String, Entity>;
	public var entityList:EntityList;
	public var systemList:SystemList;
	
	public var updating(default, null):Bool;
	
	public var entityAdded(default, null):Signal1<Entity>;
	public var entityRemoved(default, null):Signal1<Entity>;
	
	public var updateComplete(default, null):Signal0;

	public function new() 
	{
		entityList = new EntityList();
		entityNames = new Map<String, Entity>();
		systemList = new SystemList();
		entityAdded = new Signal1<Entity>();
		entityRemoved = new Signal1<Entity>();
		updateComplete = new Signal0();
		updating = false;
	}
	
	public function addEntity(entity:Entity):Void
	{
		if (entityNames.exists(entity.name))
			throw "El nombre de la entidad " + entity.name + " ya está en uso.";
		entityList.add(entity);
		entityNames.set(entity.name, entity);
		
	}
	
}