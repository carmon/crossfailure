package crossfailure.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import crossfailure.components.basics.Transformation;
import crossfailure.components.PhysicsBody;
import crossfailure.nodes.PhysicsNode;

/**
 * ...
 * @author Carmon
 */
class PhysicsSystem extends System
{
	private var _nodes:NodeList<PhysicsNode>;

	public function new() 
	{
		super();		
	}
	
	override public function addToEngine(engine:Engine):Void 
	{
		_nodes = engine.getNodeList(PhysicsNode);
	}
	
	override public function update(time:Float):Void 
	{
		for (node in _nodes) 
		{
			var transform:Transformation = node.transform;
			var body:PhysicsBody = node.body;
			
			transform.position.x += body.velocity.x;
			transform.position.y += body.velocity.y;
		}
	}
	
	override public function removeFromEngine(engine:Engine):Void 
	{
		_nodes = null;
	}
}