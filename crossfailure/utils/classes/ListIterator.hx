package crossfailure.utils.classes;

/**
 * ...
 * @author Carmon
 */
class ListIterator<TNode:HasNext<TNode>>
{
	private var prev:HasNext<TNode>;
		
	public inline function new(head:TNode) 
	{
		this.prev = { next: head };
	}
	
	public inline function hasNext():Bool
	{
		return prev.next != null;
	}
	
	public inline function next():TNode
	{
		var node:TNode = prev.next;
		prev = node;
		return node;
	}
}

private typedef HasNext<T> =
{
    var next:T;
}