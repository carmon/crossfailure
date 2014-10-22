package crossfailure.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import crossfailure.components.Camera;
import crossfailure.components.basics.Transformation;
import crossfailure.nodes.RenderNode;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;

/**
 * ...
 * @author Carmon
 */
class RenderSystem extends System
{
	public var container:DisplayObjectContainer;
	public var camera:Camera;
	
	private var _nodes:NodeList<RenderNode>;

	public function new(container:DisplayObjectContainer, ?camera:Camera=null) 
	{
		super();
		this.container = container;
		this.camera = camera;
		if(camera != null) this.container.addChild(this.camera.background);
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
		container.addChild(node.display.displayObject);
	}
	
	private function removeFromDisplay(node:RenderNode):Void
	{
		container.removeChild(node.display.displayObject);
	}
	
	override public function update(time:Float):Void 
	{
		for (node in _nodes) 
		{
			var displayObject:DisplayObject = node.display.displayObject;
			var transformation:Transformation = node.transformation;
			
			if (camera != null && !node.display.isUI()) {
				if (camera.target != null) {
					camera.position.x = camera.target.position.x - camera.width * .5;
				}				
				displayObject.x = transformation.position.x - camera.position.x;
				displayObject.y = transformation.position.y - camera.position.y;
			} else {
				displayObject.x = transformation.position.x;
				displayObject.y = transformation.position.y;
			}
			displayObject.rotation = transformation.rotation * 180 / Math.PI;
		}
	}
	
	override public function removeFromEngine(engine:Engine):Void 
	{
		_nodes = null;
	}
}