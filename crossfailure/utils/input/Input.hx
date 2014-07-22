package crossfailure.utils.input;

class Input 
{
	private var _lookup:Map<String,Int>;
	private var _map:Array<Key>;
	private var _total:Int;
	
	public function new() 
	{
		_total = 256;
		_lookup = new Map<String,Int>();
		_map = new Array<Key>();
		for (i in 0..._total)
		{
			_map[i] = null;
		}
	}
	
	public function Update():Void
	{
		var i:Int = 0;
		while (i < _total)
		{
			var o:Key = _map[i];
			i++;
			if (o == null)
			{
				continue;
			}
			if ((o.Last == -1) && (o.Current == -1))
			{
				o.Current = 0;
			}
			else if ((o.Last == 2) && (o.Current == 2))
			{
				o.Current = 1;
			}
			o.Last = o.Current;
		}
	}
	
	public function Reset():Void
	{
		var i:Int = 0;
		while (i < _total)
		{
			var o:Key = _map[i];
			i++;
			if (o == null)
			{
				continue;
			}
			Reflect.setField(this, o.Name, false);
			o.Current = 0;
			o.Last = 0;
		}
	}
	
	public function Pressed(freshPressed:String):Bool
	{
		return Reflect.field(this, freshPressed);
	}
	
	public function JustPressed(freshPressed:String):Bool
	{
		return _map[_lookup.get(freshPressed)].Current == 2;
	}
	
	public function JustReleased(freshReleased:String):Bool
	{
		return _map[_lookup.get(freshReleased)].Current == -1;
	}
	
	public function GetKeyCode(freshName:String):Int
	{
		return _lookup.get(freshName);
	}
	
	public function Any():Bool
	{
		var i:Int = 0;
		while (i < _total)
		{
			var o:Key = _map[i];
			i++;
			if ((o != null) && (o.Current > 0))
			{
				return true;
			}
		}
		return false;
	}
	
	public function AddKey(freshName:String, freshCode:Int):Void
	{
		_lookup.set(freshName, freshCode);
		_map[freshCode] = new Key(freshName, 0, 0);
	}
	
	public function Destroy():Void
	{
		_lookup = null;
		_map = null;
	}
}