package sample.sections.game.nodes;

import ash.core.Node;
import sample.sections.game.components.Motion;
import sample.sections.game.components.MotionControls;
import sample.sections.game.components.Position;

/**
 * ...
 * @author Carmon
 */
class MotionControlNode extends Node<MotionControlNode>
{
    public var control:MotionControls;
    public var position:Position;
    public var motion:Motion;	
}