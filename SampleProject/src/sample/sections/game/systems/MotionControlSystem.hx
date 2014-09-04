package sample.sections.game.systems;
import ash.tools.ListIteratingSystem.ListIteratingSystem;
import crossfailure.utils.input.KeyPoll;
import sample.sections.game.components.Motion;
import sample.sections.game.components.MotionControls;
import sample.sections.game.components.Position;

import sample.sections.game.nodes.MotionControlNode;

/**
 * ...
 * @author Carmon
 */
class MotionControlSystem extends ListIteratingSystem<MotionControlNode>
{
	private var _keyPoll:KeyPoll;

	public function new(keyPoll:KeyPoll) 
	{
		super(MotionControlNode, updateNode);
		_keyPoll = keyPoll;
	}
	
	private function updateNode(node:MotionControlNode, time:Float):Void
	{
		var control:MotionControls = node.control;
		var position:Position = node.position;
		var motion:Motion = node.motion;
		
		if (_keyPoll.isDown(control.left))
		{
			position.rotation -= control.rotationRate * time;
		}
		
		if (_keyPoll.isDown(control.right))
		{
			position.rotation += control.rotationRate * time;
		}
		
		if (_keyPoll.isDown(control.accelerate))
		{
			motion.velocity.x += Math.cos(position.rotation) * control.accelerationRate * time;
			motion.velocity.y += Math.sin(position.rotation) * control.accelerationRate * time;
		}
	}
}