package sample;

import crossfailure.controllers.MainController;
import flash.display.DisplayObjectContainer;
import flash.events.SampleDataEvent;
import sample.sections.EndSectionController;
import sample.sections.GameSectionController;
import sample.sections.InitSectionController;

/**
 * ...
 * @author Carmon
 */
class SampleController extends MainController
{
	public function new(doc:DisplayObjectContainer, ?model:Dynamic) 
	{
		var sampleModel	:SampleModel = new SampleModel();
		sampleModel.username = "Guest";
		
		super(doc, sampleModel);
		
		addSection('init', new InitSectionController(sampleModel));
		addSection('game', new GameSectionController(sampleModel));
		addSection('end', new EndSectionController(sampleModel));
	}
	
	override public function init():Void
	{
		super.init();
		
		_model.init();
		_model.goto('init');
	}
}