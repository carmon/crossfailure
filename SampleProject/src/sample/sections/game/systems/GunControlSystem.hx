package sample.sections.game.systems;
import ash.tools.ListIteratingSystem.ListIteratingSystem;
import crossfailure.utils.input.Keyboard;
import crossfailure.utils.input.KeyPoll;
import sample.sections.game.components.Gun;
import sample.sections.game.components.GunControls;
import sample.sections.game.components.Position;
import sample.sections.game.EntityCreator;
import sample.sections.game.nodes.GunControlNode;

/**
 * ...
 * @author Carmon
 */
class GunControlSystem extends ListIteratingSystem<GunControlNode>
{
	private var _keyPoll:KeyPoll;
	private var _creator:EntityCreator;

	public function new(keyPoll:KeyPoll, creator:EntityCreator)
	{
		super(GunControlNode, updateNode);
		_keyPoll = keyPoll;
		_creator = creator;		
	}
	
	private function updateNode(node:GunControlNode, time:Float):Void
	{
		var control:GunControls = node.control;
		var position:Position = node.position;
		var gun:Gun = node.gun;
		
		gun.shooting = _keyPoll.isDown(control.trigger);
		gun.timeSinceLastShot += time;
		if (gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval)
		{
			_creator.createUserBullet(gun, position);
			gun.timeSinceLastShot = 0;
		}
	}
}