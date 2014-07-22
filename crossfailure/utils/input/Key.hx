package crossfailure.utils.input;

class Key 
{
	private var _keyName:String;
	private var _current:Int;
	private var _last:Int;
	
	public function new(freshName:String, freshCurrent:Int, freshLast:Int)
	{
		_keyName = freshName;
		_current = freshCurrent;
		_last = freshLast;
	}
	
	public var Name(get, null):String;
	private function get_Name():String
	{
		return _keyName;
	}
	
	public var Current(get, set):Int;
	private function get_Current():Int
	{
		return _current;
	}
	private function set_Current(freshCurrent:Int):Int
	{
		_current = freshCurrent;
		return _current;
	}
	
	public var Last(get, set):Int;
	private function get_Last():Int
	{
		return _last;
	}
	private function set_Last(freshLast:Int):Int
	{
		_last = freshLast;
		return _last;
	}
}