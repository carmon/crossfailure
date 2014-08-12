package sample.sections;

import crossfailure.controllers.AbstractController;
import crossfailure.models.AbstractModel;
import sample.sections.game.Character;

/**
 * ...
 * @author Carmon
 */
class GameSectionController extends AbstractController
{
	private var _character	:Character;

	public function new(model:AbstractModel) 
	{
		super(model);
		
		_character = new Character();		
	}
	
	override public function start():Void 
	{
		super.start();
		
		_graphic.addChild(_character.sprite);
	}
	
	override public function update():Void 
	{
		//TODO: agregar keyinput
		
		super.update();
		_character.update();
	}
}