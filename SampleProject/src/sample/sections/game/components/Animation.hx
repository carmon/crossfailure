package sample.sections.game.components;
import sample.sections.game.graphics.IAnimatable;

/**
 * ...
 * @author Carmon
 */
class Animation
{
	public var animation:IAnimatable;

	public function new(animation:IAnimatable)
    {
        this.animation = animation;
    }
}