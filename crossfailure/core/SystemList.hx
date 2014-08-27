package crossfailure.core;
import crossfailure.utils.classes.ListIterator;

/**
 * ...
 * @author Carmon
 */
class SystemList
{
	public var head(default, null):System;
	public var tail(default, null):System;

	public function new() 
	{
		
	}
	
	public function add(system:System):Void
	{
		if (head == null) {
			head = tail = system;
			system.next = system.prev = null;
		} else {
			tail.next = system;
			system.prev = tail;
			system.next = null;
			tail = system;
		}
	}
	
	public function remove(system:System):Void
	{
		if (head == system)
			head = head.next;
		if (tail == system)
			tail = tail.prev;
		if (system.prev.next != null)
			system.prev.next = system.next;
		if (system.next != null)
			system.next.prev = system.prev;
	}
	
	public function removeAll():Void
	{
		while (head != null) {
			var system:System = head;
			head = head.next;
			head.prev = null;
			head.next = null;
		}
		tail = null;
	}
	
	public inline function iterator():ListIterator<System>
	{
		return new ListIterator(head);
	}
}