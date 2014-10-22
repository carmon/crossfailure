package crossfailure.nodes;
import ash.core.Node;
import crossfailure.components.basics.Transformation;
import crossfailure.components.PhysicsBody;

/**
 * ...
 * @author Carmon
 */
class PhysicsNode extends Node<PhysicsNode>
{
	public var transform:Transformation;
	public var body:PhysicsBody;
}