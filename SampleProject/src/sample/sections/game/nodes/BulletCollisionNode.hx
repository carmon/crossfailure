package sample.sections.game.nodes;

import ash.core.Node;
import sample.sections.game.components.Position;
import sample.sections.game.components.Bullet;
import sample.sections.game.components.Collision;

/**
 * ...
 * @author Carmon
 */
class BulletCollisionNode extends Node<BulletCollisionNode>
{
	public var bullet:Bullet;
	public var position:Position;
	public var collision:Collision;
}