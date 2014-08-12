package sample;

import crossfailure.models.AbstractModel;

/**
 * ...
 * @author Carmon
 */
class SampleModel extends AbstractModel
{
	public static var GAME_WIDTH :Int = 800;
	public static var GAME_HEIGHT :Int = 480;
		
	public var username	:String;

	public function new() 
	{
		super();
		
		username = "";
	}
	
}