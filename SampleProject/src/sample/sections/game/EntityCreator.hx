package sample.sections.game;
import ash.core.Engine;
import ash.core.Entity;
import ash.fsm.EntityStateMachine;
import ash.tools.ComponentPool;
import flash.ui.Keyboard;
import sample.sections.game.components.Animation;
import sample.sections.game.components.Asteroid;
import sample.sections.game.components.Bullet;
import sample.sections.game.components.Collision;
import sample.sections.game.components.DeathThroes;
import sample.sections.game.components.Display;
import sample.sections.game.components.GameState;
import sample.sections.game.components.Gun;
import sample.sections.game.components.GunControls;
import sample.sections.game.components.Motion;
import sample.sections.game.components.MotionControls;
import sample.sections.game.components.Position;
import sample.sections.game.components.Spaceship;
import sample.sections.game.graphics.AsteroidView;
import sample.sections.game.graphics.BulletView;
import sample.sections.game.graphics.SpaceshipDeathView;
import sample.sections.game.graphics.SpaceshipView;

/**
 * ...
 * @author Carmon
 */
class EntityCreator
{
	private var _engine	:Engine;

	public function new(engine:Engine) 
	{
		_engine = engine;
	}
	
	public function destroyEntity(entity:Entity):Void
	{
		_engine.removeEntity(entity);
		if (entity.has(Asteroid)) {
			ComponentPool.dispose(entity.get(Asteroid));
		}
	}
	
	public function createGame():Entity
	{
		var gameEntity:Entity = new Entity()
		.add(new GameState());
		_engine.addEntity(gameEntity);
		return gameEntity;
	}
	
	public function createAsteroid(radius:Float, x:Float, y:Float):Entity
	{
		var asteroid:Entity = new Entity()
		.add(ComponentPool.get(Asteroid))
		.add(new Position(x, y, 0))
		.add(new Collision(radius))
		.add(new Motion((Math.random() - 0.5) * 4 * ( 50 - radius ), ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), Math.random() * 2 - 1, 0))
		.add(new Display(new AsteroidView(radius)));
		_engine.addEntity(asteroid);
		return asteroid;
	}
	
	public function createSpaceship():Entity
	{
		var spaceship:Entity = new Entity();
		var fsm:EntityStateMachine = new EntityStateMachine(spaceship);
		
		fsm.createState("playing")
		.add(Motion).withInstance(new Motion(0, 0, 0, 15))
		.add(MotionControls).withInstance(new MotionControls(Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, 100, 3))
		.add(Gun).withInstance(new Gun(8, 0, .3, 2))
		.add(GunControls).withInstance(new GunControls(Keyboard.SPACE))
		.add(Collision).withInstance(new Collision(9))
		.add(Display).withInstance(new Display(new SpaceshipView()));
		
		var deathView:SpaceshipDeathView = new SpaceshipDeathView();
		fsm.createState("destroyed")
		.add(DeathThroes).withInstance(new DeathThroes(5))
		.add(Display).withInstance(new Display(deathView))
		.add(Animation).withInstance(new Animation(deathView));
		
		spaceship.add(new Spaceship(fsm)).add(new Position(300, 225, 0));
		
		fsm.changeState("playing");
		_engine.addEntity(spaceship);
		
		return spaceship;
	}
	
	public function createUserBullet(gun:Gun, parentPosition:Position):Entity
	{
		var cos:Float = Math.cos(parentPosition.rotation);
		var sin:Float = Math.sin(parentPosition.rotation);
		var bullet:Entity = new Entity()
		.add(new Bullet(gun.bulletLifetime))
		.add(new Position(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, 0))
		.add(new Collision(0))
		.add(new Motion( cos * 150, sin * 150, 0, 0))
		.add(new Display(new BulletView() ));
		_engine.addEntity(bullet);
		return bullet;
	}
}