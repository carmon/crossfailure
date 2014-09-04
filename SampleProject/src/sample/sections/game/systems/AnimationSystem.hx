package sample.sections.game.systems;
import ash.tools.ListIteratingSystem.ListIteratingSystem;
import sample.sections.game.nodes.AnimationNode;

/**
 * ...
 * @author Carmon
 */
class AnimationSystem extends ListIteratingSystem<AnimationNode>
{
	public function new() 
	{
		super(AnimationNode, updateNode);
	}
	
	private function updateNode(node:AnimationNode, time:Float):Void
	{
		node.animation.animation.animate(time);
	}
}