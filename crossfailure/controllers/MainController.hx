package crossfailure.controllers;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.Lib;
import crossfailure.models.AbstractModel;

/**
 * ...
 * @author Carmon
 */
class MainController
{
	private var _doc			:DisplayObjectContainer;
	private var _model			:AbstractModel;	
	private var _sections		:Map<String, AbstractController>;		
	private var _steps			:Array<String>;
	private var _controllers	:Array<AbstractController>;
	
	private var _previousTime	:Float;
			
	public function new(doc:DisplayObjectContainer, ?model:Dynamic) 
	{
		_doc = doc;
		
		if (model != null) _model = model;
		else _model = new AbstractModel();
		_model.navigationController.navigateTo.add(navigateToHandler);
		
		_sections = new Map();
		_controllers = [];
		_steps = [];
	}
	
	public function init():Void
	{
		_previousTime = Lib.getTimer();
		_doc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):Void
	{
		var temp:Float = _previousTime;
		_previousTime = Lib.getTimer();
		var frameTime:Float = (_previousTime - temp) / 1000;
		if (_doc.numChildren > 0) {
			_controllers[_controllers.length - 1].update(frameTime);
		}
	}
	
	public function addSection(id:String, controller:AbstractController):Void
	{
		_sections[id] = controller;
	}
	
	private function navigateToHandler(target:String):Void
	{
		//Path de navegación, valores posibles: [id_sección] - [id_sección]/.../[id_subsección]/ - ..
		_steps = target.split('/');		
		for (i in 0..._steps.length) {
			if (_steps[i] == '..') {
				dettachCurrentSection();
			} else {
				attachNewSection(_steps[i]);
			}
		}	
	}
	
	private function attachNewSection(id:String):Void
	{
		var current:AbstractController;
		if (_controllers.length == 0) {
			current = _sections[id];
			if (current == null) throw "MainController::: La sección no existe.";
			_doc.addChild(current.graphic);
		} else {
			var parent:AbstractController = _controllers[_controllers.length - 1];
			current = parent.subsections[id];
			if (current == null) throw "MainController::: La subsección no existe.";
			parent.graphic.addChild(current.graphic);
		}
		_controllers.push(current);
		current.start();
	}
	
	private function dettachCurrentSection():Void
	{
		var current:AbstractController = _controllers.pop();
		current.end();
		if (_controllers.length == 0) {
			_doc.removeChild(current.graphic);
		} else {
			_controllers[_controllers.length - 1].graphic.removeChild(current.graphic);
		}
	}
}