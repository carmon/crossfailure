package sample.sections.game.systems;
import ash.core.Engine;
import ash.core.NodeList.NodeList;
import ash.core.System;
import flash.geom.Point;
import sample.sections.game.EntityCreator;
import sample.sections.game.nodes.AsteroidCollisionNode;
import sample.sections.game.nodes.BulletCollisionNode;
import sample.sections.game.nodes.SpaceshipCollisionNode;

/**
 * ...
 * @author Carmon
 */
class CollisionSystem extends System
{
	private var _creator	:EntityCreator;
	
	private var _spaceships:NodeList<SpaceshipCollisionNode>;
	private var _asteroids:NodeList<AsteroidCollisionNode>;
	private var _bullets:NodeList<BulletCollisionNode>;
	
	public function new(creator:EntityCreator) 
	{
		super();
		_creator = creator;
	}
	
	override public function addToEngine(engine:Engine):Void 
	{
		_spaceships = engine.getNodeList(SpaceshipCollisionNode);
		_asteroids = engine.getNodeList(AsteroidCollisionNode);
		_bullets = engine.getNodeList(BulletCollisionNode);
	}
	
	override public function update(time:Float):Void 
	{
		for (bullet in _bullets) 
		{
			for (asteroid in _asteroids)
			{
				if (Point.distance(asteroid.position.position, bullet.position.position) <= asteroid.collision.radius)
				{
					_creator.destroyEntity(bullet.entity);
					if (asteroid.collision.radius > 10)
					{
						_creator.createAsteroid(asteroid.collision.radius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5);
						_creator.createAsteroid(asteroid.collision.radius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5);
					}
					_creator.destroyEntity(asteroid.entity);
					break;
				}
			}
		}
		
		for (spaceship in _spaceships) 
		{
			for (asteroid in _asteroids) 
			{
				if (Point.distance(asteroid.position.position, spaceship.position.position) <= asteroid.collision.radius + spaceship.collision.radius)
				{
					spaceship.spaceship.fsm.changeState("destroyed");
					break;
				}
			}
		}
	}
	
	override public function removeFromEngine(engine:Engine):Void 
	{
		_spaceships = null;
		_asteroids = null;
		_bullets = null;
	}	
}