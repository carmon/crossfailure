package sample.sections.game.graphics;

import flash.display.Shape;

/**
 * ...
 * @author Carmon
 */
class BulletView extends Shape
{
	public function new() 
	{
		super();
        graphics.beginFill(0xFFFFFF);
        graphics.drawCircle(0, 0, 2);
        graphics.endFill();
	}	
}