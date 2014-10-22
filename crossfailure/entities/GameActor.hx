package crossfailure.entities;
import ash.core.Entity;
import crossfailure.components.basics.Display;
import crossfailure.components.basics.Transformation;
import crossfailure.components.PhysicsBody;
import crossfailure.utils.Tracker;

/**
 * ...
 * @author Carmon
 */
class GameActor extends Entity
{
	public static var TYPE:String = "actor";
	
	public var body:PhysicsBody;
	public var transform:Transformation;
	public var display:Display;

	public function new(?body:PhysicsBody=null, ?transform:Transformation=null, display:Display) 
	{
		this.body = body != null ? body : new PhysicsBody();
		this.transform = transform != null ? transform : new Transformation(0,0,0);
		this.display = display;
				
		super(TYPE + "_" + Tracker.getInstance().getEntityTypeCount(TYPE));		
		add(this.body).add(this.transform).add(this.display);
	}
	
}