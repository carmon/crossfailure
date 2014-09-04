package sample.sections.game.systems;

import ash.core.Engine;
import ash.core.NodeList.NodeList;
import ash.core.System;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import sample.sections.game.components.Position;
import sample.sections.game.nodes.RenderNode;

/**
 * ...
 * @author Carmon
 */
class RenderSystem extends System
{
	public var container:DisplayObjectContainer;
	
	private var _nodes:NodeList<RenderNode>;

	public function new(container:DisplayObjectContainer) 
	{
		super();
		this.container = container;
	}
	
	override public function addToEngine(engine:Engine):Void 
	{
		_nodes = engine.getNodeList(RenderNode);
		for (node in _nodes)
			addToDisplay(node);
		_nodes.nodeAdded.add(addToDisplay);
		_nodes.nodeRemoved.add(removeFromDisplay);
	}
	
	private function addToDisplay(node:RenderNode):Void
	{
		container.addChild(node.displayObject);
	}
	
	private function removeFromDisplay(node:RenderNode):Void
	{
		container.removeChild(node.displayObject);
	}
	
	override public function update(time:Float):Void 
	{
		for (node in _nodes) 
		{
			var displayObject:DisplayObject = node.displayObject;
			var position:Position = node.position;
			
			displayObject.x = position.position.x;
			displayObject.y = position.position.y;
			displayObject.rotation = position.rotation * 180 / Math.PI;
		}
	}
	
	override public function removeFromEngine(engine:Engine):Void 
	{
		_nodes = null;
	}
}