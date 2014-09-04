package sample.sections;

import ash.core.Engine;
import crossfailure.controllers.AbstractController;
import crossfailure.models.AbstractModel;
import crossfailure.utils.input.KeyPoll;
import flash.events.SampleDataEvent;
import sample.SampleModel;
import sample.sections.game.EntityCreator;
import sample.sections.game.systems.AnimationSystem;
import sample.sections.game.systems.BulletAgeSystem;
import sample.sections.game.systems.CollisionSystem;
import sample.sections.game.systems.DeathThroesSystem;
import sample.sections.game.systems.GameManager;
import sample.sections.game.systems.GunControlSystem;
import sample.sections.game.systems.MotionControlSystem;
import sample.sections.game.systems.MovementSystem;
import sample.sections.game.systems.RenderSystem;
import sample.sections.game.systems.SystemPriorities;

/**
 * ...
 * @author Carmon
 */
class GameSectionController extends AbstractController
{
	private var _engine	:Engine;
	private var _creator:EntityCreator;
	private var _keyPoll:KeyPoll;
	
	private var _modelCast	:SampleModel;

	public function new(model:AbstractModel) 
	{
		super(model);		
		
		_modelCast = cast(model, SampleModel);
	}
	
	override public function start():Void 
	{
		super.start();
		
		_engine = new Engine();
		_creator = new EntityCreator(_engine);
		_keyPoll = new KeyPoll(_graphic.stage);
		
		_engine.addSystem(new GameManager( _creator, _modelCast), SystemPriorities.preUpdate);
		_engine.addSystem(new MotionControlSystem(_keyPoll), SystemPriorities.update);
		_engine.addSystem(new GunControlSystem(_keyPoll, _creator), SystemPriorities.update);
		_engine.addSystem(new BulletAgeSystem(_creator), SystemPriorities.update);
		_engine.addSystem(new DeathThroesSystem(_creator), SystemPriorities.update);
		_engine.addSystem(new MovementSystem(_modelCast), SystemPriorities.move);
		_engine.addSystem(new CollisionSystem(_creator), SystemPriorities.resolveCollisions);
		_engine.addSystem(new AnimationSystem(), SystemPriorities.animate);
		_engine.addSystem(new RenderSystem(_graphic), SystemPriorities.render);
		
		_creator.createGame();
	}
	
	override public function update(tick:Float):Void 
	{
		//TODO: agregar keyinput
		super.update(tick);
		_engine.update(tick);
	}
}