package sample.sections.game.components;
import ash.fsm.EntityStateMachine;

/**
 * ...
 * @author Carmon
 */
class Spaceship
{
	public var fsm:EntityStateMachine;

	public function new(fsm:EntityStateMachine) 
	{
		this.fsm = fsm;
	}
	
}