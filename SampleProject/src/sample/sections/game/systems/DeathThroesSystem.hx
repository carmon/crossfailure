package sample.sections.game.systems;
import ash.tools.ListIteratingSystem.ListIteratingSystem;
import sample.sections.game.EntityCreator;
import sample.sections.game.nodes.DeathThroesNode;

/**
 * ...
 * @author Carmon
 */
class DeathThroesSystem extends ListIteratingSystem<DeathThroesNode>
{
	private var _creator:EntityCreator;

	public function new(creator:EntityCreator) 
	{
		super(DeathThroesNode, updateNode);
		_creator = creator;
	}
	
	private function updateNode(node:DeathThroesNode, time:Float):Void
	{
		node.death.countdown -= time;
		if ( node.death.countdown <= 0)
		{
			_creator.destroyEntity(node.entity);
		}
	}
}