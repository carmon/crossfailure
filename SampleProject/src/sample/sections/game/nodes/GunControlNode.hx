package sample.sections.game.nodes;

import ash.core.Node;
import sample.sections.game.components.Gun;
import sample.sections.game.components.GunControls;
import sample.sections.game.components.Position;

/**
 * ...
 * @author Carmon
 */
class GunControlNode extends Node<GunControlNode>
{
	public var control:GunControls;
	public var gun:Gun;
	public var position:Position;	
}