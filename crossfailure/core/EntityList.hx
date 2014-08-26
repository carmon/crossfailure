package crossfailure.core;
import crossfailure.utils.classes.ListIterator.ListIterator;

/**
 * ...
 * @author Carmon
 */
class EntityList
{
	public var head(default, null):Entity;
	public var tail(default, null):Entity;

	public function new() 
	{
		
	}
	
	public function add(entity:Entity):Void
	{
		if (head == null) {
			head = tail = entity;
			entity.next = entity.prev = null;
		} else {
			tail.next = entity;
			entity.prev = tail;
			entity.next = null;
			tail = entity;
		}
	}
	
	public function remove(entity:Entity):Void
	{
		if (head == entity)
			head = head.next;
		if (tail == entity)
			tail = tail.prev;
		if (entity.prev.next != null)
			entity.prev.next = entity.next;
		if (entity.next != null)
			entity.next.prev = entity.prev;
	}
	
	public function removeAll():Void
	{
		while (head != null) {
			var entity:Entity = head;
			head = head.next;
			entity.prev = null;
			entity.next = null;
		}
		tail = null;
	}
	
	public inline function iterator():ListIterator<Entity>
	{
		return new ListIterator(head);
	}
}