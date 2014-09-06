package sample;

import crossfailure.models.AbstractModel;
import sample.sections.game.components.GameState;

/**
 * ...
 * @author Carmon
 */
class SampleModel extends AbstractModel
{
	public static var GAME_WIDTH :Int = 800;
	public static var GAME_HEIGHT :Int = 600;
	
	public var width(get, never):Int;
	private function get_width():Int
	{
		return GAME_WIDTH;
	}
	
	public var height(get, never):Int;
	private function get_height():Int
	{
		return GAME_HEIGHT;
	}
		
	public var username	:String = "";	
	public var state	:GameState;

	public function new() 
	{
		super();
		
		username = "";
		state = new GameState();
	}
	
}