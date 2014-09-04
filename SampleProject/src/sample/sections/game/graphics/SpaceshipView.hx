package sample.sections.game.graphics;

import flash.display.Shape;

/**
 * ...
 * @author Carmon
 */
class SpaceshipView extends Shape
{

	public function new() 
	{
        super();
        graphics.beginFill(0xFFFFFF);
        graphics.moveTo(10, 0);
        graphics.lineTo(-7, 7);
        graphics.lineTo(-4, 0);
        graphics.lineTo(-7, -7);
        graphics.lineTo(10, 0);
        graphics.endFill();
	}
	
}