package sample.sections.game.nodes;
import ash.core.Node.Node;
import sample.sections.game.components.Asteroid;
import sample.sections.game.components.Collision;
import sample.sections.game.components.Position;

/**
 * ...
 * @author Carmon
 */
class AsteroidCollisionNode extends Node<AsteroidCollisionNode>
{
	public var asteroid:Asteroid;
	public var position:Position;
	public var collision:Collision;
}