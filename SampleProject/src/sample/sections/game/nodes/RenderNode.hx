package sample.sections.game.nodes;
import ash.core.Node.Node;
import flash.display.DisplayObject;
import sample.sections.game.components.Display;
import sample.sections.game.components.Position;

/**
 * ...
 * @author Carmon
 */
class RenderNode extends Node<RenderNode>
{
	public var position:Position;
	private var display:Display;
	
	public var displayObject(get, never):DisplayObject;
	private inline function get_displayObject():DisplayObject
	{
		return display.displayObject;
	}
}