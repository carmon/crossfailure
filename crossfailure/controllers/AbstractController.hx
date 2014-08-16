package crossfailure.controllers;
import crossfailure.signals.Signal0;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import crossfailure.models.AbstractModel;

/**
 * ...
 * @author Carmon
 */
class AbstractController
{	
	private var _graphic:Sprite;
	public var graphic(get, null):Sprite;
	function get_graphic() { return _graphic; } 	
	
	private var _subsections	:Map<String, AbstractController>;
	public var subsections(get, never):Map<String, AbstractController>;
	function get_subsections():Map<String, AbstractController>
	{
		return _subsections;
	}	
	
	private var _model			:AbstractModel;

	public function new(model:AbstractModel) 
	{		
		_model = model;
		_graphic = new Sprite();
		_subsections = new Map();
	}
	
	public function start():Void
	{
		
	}
	
	public function update():Void
	{
		
	}
	
	public function end():Void
	{
		while (_graphic.numChildren > 0) {
			_graphic.removeChildAt(_graphic.numChildren - 1);
		}
	}
	
	public function addSubsection(id:String, controller:AbstractController):Void
	{
		_subsections[id] = controller;
	}
}