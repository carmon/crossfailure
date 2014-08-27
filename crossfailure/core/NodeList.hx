package crossfailure.core;

import crossfailure.utils.classes.ListIterator;
import crossfailure.signals.Signal1;

/**
 * ...
 * @author Carmon
 */
class NodeList<TNode:Node<TNode>>
{
    public var head(default, null):TNode;
    public var tail(default, null):TNode;
	
    public var nodeAdded(default, null):Signal1<TNode>;
    public var nodeRemoved(default, null):Signal1<TNode>;
	
	public function new()
    {
        nodeAdded = new Signal1<TNode>();
        nodeRemoved = new Signal1<TNode>();
    }
	
	public function add(node:TNode):Void
    {
        if (head == null)
        {
            head = tail = node;
            node.next = node.prev = null;
        }
        else
        {
            tail.next = node;
            node.prev = tail;
            node.next = null;
            tail = node;
        }
        nodeAdded.dispatch(node);
    }
	
	public function remove(node:TNode):Void
    {
        if (head == node)
            head = head.next;
        if (tail == node)
            tail = tail.prev;

        if (node.prev != null)
            node.prev.next = node.next;

        if (node.next != null)
            node.next.prev = node.prev;

        nodeRemoved.dispatch(node);
    }
	
	public function removeAll():Void
    {
        while (head != null)
        {
            var node:TNode = head;
            head = head.next;
            node.prev = null;
            node.next = null;
            nodeRemoved.dispatch(node);
        }
        tail = null;
    }
	
	public var empty(get_empty, never):Bool;

    private inline function get_empty():Bool
    {
        return head == null;
    }

    public inline function iterator():ListIterator<TNode>
    {
        return new ListIterator(head);
    }
	
	public function swap(node1:TNode, node2:TNode):Void
    {
        if (node1.prev == node2)
        {
            node1.prev = node2.prev;
            node2.prev = node1;
            node2.next = node1.next;
            node1.next = node2;
        }
        else if (node2.prev == node1)
        {
            node2.prev = node1.prev;
            node1.prev = node2;
            node1.next = node2.next;
            node2.next = node1;
        }
        else
        {
            var temp:TNode = node1.prev;
            node1.prev = node2.prev;
            node2.prev = temp;
            temp = node1.next;
            node1.next = node2.next;
            node2.next = temp;
        }
        if (head == node1)
            head = node2;
        else if (head == node2)
            head = node1;
        if (tail == node1)
            tail = node2;
        else if (tail == node2)
            tail = node1;
        if (node1.prev != null)
            node1.prev.next = node1;
        if (node2.prev != null)
            node2.prev.next = node2;
        if (node1.next != null)
            node1.next.prev = node1;
        if (node2.next != null)
            node2.next.prev = node2;
    }
	
	public function insertionSort(sortFunction:SortFunction<TNode>):Void
    {
        if (head == tail)
            return;

        var remains:TNode = head.next;
        var node:TNode = remains;
        while (node != null)
        {
            remains = node.next;

            var other:TNode = node.prev;
            while (other != null)
            {
                if (sortFunction(node, other) >= 0)
                {
                    // move node to after other
                    if (node != other.next)
                    {
                        // remove from place
                        if (tail == node)
                            tail = node.prev;

                        node.prev.next = node.next;
                        if (node.next != null)
                            node.next.prev = node.prev;

                        // insert after other
                        node.next = other.next;
                        node.prev = other;
                        node.next.prev = node;
                        other.next = node;
                    }
                    break; // exit the inner for loop
                }

                other = other.prev;
            }

            if (other == null) // the node belongs at the start of the list
            {
                // remove from place
                if (tail == node)
                    tail = node.prev;
                node.prev.next = node.next;
                if (node.next != null)
                    node.next.prev = node.prev;
                // insert at head
                node.next = head;
                head.prev = node;
                node.prev = null;
                head = node;
            }

            node = remains;
        }
    }
	
	public function mergeSort(sortFunction:SortFunction<TNode>):Void
    {
        if (head == tail)
            return;

        var lists:Array<TNode> = [];

        // disassemble the list
        var start:TNode = head;
        var end:TNode;
        while (start != null)
        {
            end = start;
            while (end.next != null && sortFunction(end, end.next) <= 0)
                end = end.next;

            var next:TNode = end.next;
            start.prev = end.next = null;
            lists.push(start);
            start = next;
        }

        // reassemble it in order
        while (lists.length > 1)
            lists.push(merge(lists.shift(), lists.shift(), sortFunction));

        // find the tail
        tail = head = lists[0];
        while (tail.next != null)
            tail = tail.next;
    }

    private function merge(head1:TNode, head2:TNode, sortFunction:SortFunction<TNode>):TNode
    {
        var node:TNode;
        var head:TNode;
        if (sortFunction(head1, head2) <= 0)
        {
            head = node = head1;
            head1 = head1.next;
        }
        else
        {
            head = node = head2;
            head2 = head2.next;
        }
        while (head1 != null && head2 != null)
        {
            if (sortFunction(head1, head2) <= 0)
            {
                node.next = head1;
                head1.prev = node;
                node = head1;
                head1 = head1.next;
            }
            else
            {
                node.next = head2;
                head2.prev = node;
                node = head2;
                head2 = head2.next;
            }
        }
        if (head1 != null)
        {
            node.next = head1;
            head1.prev = node;
        }
        else
        {
            node.next = head2;
            head2.prev = node;
        }
        return head;
    }
}

typedef SortFunction<TNode:Node<TNode>> = TNode -> TNode -> Int;