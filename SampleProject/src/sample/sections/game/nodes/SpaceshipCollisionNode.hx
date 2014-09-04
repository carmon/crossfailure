package sample.sections.game.nodes;

import ash.core.Node;
import sample.sections.game.components.Collision;
import sample.sections.game.components.Position;
import sample.sections.game.components.Spaceship;

/**
 * ...
 * @author Carmon
 */
class SpaceshipCollisionNode extends Node<SpaceshipCollisionNode>
{
    public var spaceship:Spaceship;
    public var position:Position;
    public var collision:Collision;
}