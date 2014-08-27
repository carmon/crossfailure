package crossfailure.core;

/**
 * ...
 * @author Carmon
 */
@:autoBuild(crossfailure.core.NodeMacro.build())
class Node
{
    public var entity:Entity;
	
    public var prev:TNode;
    public var next:TNode;
}