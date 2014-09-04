package sample.sections.game.systems;
import ash.tools.ListIteratingSystem.ListIteratingSystem;
import sample.SampleModel;
import sample.sections.game.components.Motion;
import sample.sections.game.components.Position;
import sample.sections.game.nodes.MovementNode;

/**
 * ...
 * @author Carmon
 */
class MovementSystem extends ListIteratingSystem<MovementNode>
{
	private var _model:SampleModel;

	public function new(model:SampleModel) 
	{
		_model = model;
		super(MovementNode, updateNode);
	}
	
	private function updateNode(node:MovementNode, time:Float):Void
	{
		var position:Position = node.position;
		var motion:Motion = node.motion;
		
		position.position.x += motion.velocity.x * time;
		position.position.y += motion.velocity.y * time;
		if (position.position.x < 0)
		{
			position.position.x += _model.width;
		}
		if (position.position.x > _model.width)
		{
			position.position.x -= _model.width;
		}
		if (position.position.y < 0)
		{
			position.position.y += _model.height;
		}
		if (position.position.y > _model.height)
		{
			position.position.y -= _model.height;
		}
		position.rotation += motion.angularVelocity * time;
		if (motion.damping > 0) 
		{
			var xDamp:Float = Math.abs(Math.cos(position.rotation) * motion.damping * time);
			var yDamp:Float = Math.abs(Math.sin(position.rotation) * motion.damping * time);
			if (motion.velocity.x > xDamp) 
			{
				motion.velocity.x -= xDamp;
			}
			else if (motion.velocity.x < -xDamp) 
			{
				motion.velocity.x += xDamp;
			}
			else
			{
				motion.velocity.x = 0;
			}
			if (motion.velocity.y > yDamp) 
			{
				motion.velocity.y -= yDamp;
			}
			else if (motion.velocity.y < -yDamp) 
			{
				motion.velocity.y += yDamp;
			}
			else
			{
				motion.velocity.y = 0;
			}
		}
	}
}