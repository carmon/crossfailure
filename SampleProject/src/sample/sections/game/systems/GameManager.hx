package sample.sections.game.systems;
import ash.core.Engine;
import ash.core.NodeList.NodeList;
import ash.core.System;
import flash.geom.Point;
import sample.SampleModel;
import sample.sections.game.EntityCreator;
import sample.sections.game.nodes.AsteroidCollisionNode;
import sample.sections.game.nodes.BulletCollisionNode;
import sample.sections.game.nodes.GameNode;
import sample.sections.game.nodes.SpaceshipNode;

/**
 * ...
 * @author Carmon
 */
class GameManager extends System
{
	private var _model		:SampleModel;
	private var _creator	:EntityCreator;

	private var _gameNodes	:NodeList<GameNode>;
	private var _spaceships	:NodeList<SpaceshipNode>;
	private var _asteroids	:NodeList<AsteroidCollisionNode>;
	private var _bullets	:NodeList<BulletCollisionNode>;
	
	public function new(creator:EntityCreator, model:SampleModel) 
	{
		super();
		
		_creator = creator;
		_model = model;
	}
	
	override public function addToEngine(engine:Engine):Void 
	{
		_gameNodes = engine.getNodeList(GameNode);
		_spaceships = engine.getNodeList(SpaceshipNode);
		_asteroids = engine.getNodeList(AsteroidCollisionNode);
		_bullets = engine.getNodeList(BulletCollisionNode);
	}
	
	override public function update(time:Float):Void 
	{
		for (node in _gameNodes) 
		{
			if (_spaceships.empty) 
			{
				if (node.state.lives > 0) 
				{
					var newSpaceshipPosition = new Point(_model.width * .5, _model.height * .5);
					var clearToAddSpaceship:Bool = true;
					
					for (asteroid in _asteroids)
					{
						if (Point.distance(asteroid.position.position, newSpaceshipPosition) <= asteroid.collision.radius + 50)
						{
							clearToAddSpaceship = false;
							break;
						}
					}
					
					if (clearToAddSpaceship) {
						_creator.createSpaceship();
						node.state.lives--;
					}
				}
				else 
				{
					_model.goto("../end");
				}
			}
			
			if (_asteroids.empty && _bullets.empty && !_spaceships.empty) 
			{
				//next level
				var spaceship:SpaceshipNode = _spaceships.head;
				node.state.level++;
				var asteroidCount:Int = 2 + node.state.level;
				for (i in 0...asteroidCount)
				{
					var position:Point;
					do
					{
						position = new Point(Math.random() * _model.width, Math.random() * _model.height);
					}
					while (Point.distance(position, spaceship.position.position) <= 80);
					_creator.createAsteroid(30, position.x, position.y);
				}
			}
		}
	}
	
	override public function removeFromEngine(engine:Engine):Void 
	{
		_gameNodes = null;
		_spaceships = null;
		_asteroids = null;
		_bullets = null;
	}
}