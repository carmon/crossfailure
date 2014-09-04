package sample.sections.game.systems;
import ash.tools.ListIteratingSystem.ListIteratingSystem;
import sample.sections.game.components.Bullet;
import sample.sections.game.EntityCreator;
import sample.sections.game.nodes.BulletAgeNode;

/**
 * ...
 * @author Carmon
 */
class BulletAgeSystem extends ListIteratingSystem<BulletAgeNode>
{
	private var _creator:EntityCreator;

	public function new(creator:EntityCreator) 
	{
		super(BulletAgeNode, updateNode);
		_creator = creator;
	}
	
	private function updateNode(node:BulletAgeNode, time:Float):Void
	{
		var bullet:Bullet = node.bullet;
		bullet.lifeRemaining -= time;
		if (bullet.lifeRemaining <= 0) {
			_creator.destroyEntity(node.entity);
		}
	}
}