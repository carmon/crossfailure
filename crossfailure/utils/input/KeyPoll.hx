package crossfailure.utils.input;

import haxe.io.Bytes;
import haxe.Log;

import flash.events.KeyboardEvent;
import flash.events.Event;
import flash.display.DisplayObject;

/**
 * <p>Games often need to get the current state of various keys in order to respond to user input.
 * This is not the same as responding to key down and key up events, but is rather a case of discovering
 * if a particular key is currently pressed.</p>
 *
 * <p>In Actionscript 2 this was a simple matter of calling Key.isDown() with the appropriate key code.
 * But in Actionscript 3 Key.isDown no longer exists and the only intrinsic way to react to the keyboard
 * is via the keyUp and keyDown events.</p>
 *
 * <p>The KeyPoll class rectifies this. It has isDown and isUp methods, each taking a key code as a
 * parameter and returning a Boolean.</p>
 */
class KeyPoll
{
    private var states:Bytes;
    private var dispObj:DisplayObject;

    /**
     * Constructor
     *
     * @param displayObj a display object on which to test listen for keyboard events. To catch all key events use the stage.
     */
    public function new(displayObj:DisplayObject)
    {
        states = Bytes.alloc(8);
        dispObj = displayObj;
		
        dispObj.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
        dispObj.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
        dispObj.addEventListener(Event.ACTIVATE, activateListener);
        dispObj.addEventListener(Event.DEACTIVATE, deactivateListener);
    }

    private function keyDownListener(ev:KeyboardEvent):Void
    {
        var pos:Int = ev.keyCode >>> 3;
        states.set(pos, states.get(pos) | 1 << (ev.keyCode & 7));
    }

    private function keyUpListener(ev:KeyboardEvent):Void
    {
        var pos:Int = ev.keyCode >>> 3;
        states.set(pos, states.get(pos) & ~(1 << (ev.keyCode & 7)));
    }

    private function activateListener(ev:Event):Void
    {
        for (i in 0...8)
            states.set(i, 0);
    }

    private function deactivateListener(ev:Event):Void
    {
        for (i in 0...8)
            states.set(i, 0);
    }

    /**
     * To test whether a key is down.
     *
     * @param keyCode code for the key to test.
     *
     * @return true if the key is down, false otherwise.
     *
     * @see isUp
     */

    public function isDown(keyCode:Int):Bool
    {
        return ( states.get(keyCode >>> 3) & (1 << (keyCode & 7)) ) != 0;
    }

    /**
     * To test whether a key is up.
     *
     * @param keyCode code for the key to test.
     *
     * @return true if the key is up, false otherwise.
     *
     * @see isDown
     */

    public function isUp(keyCode:Int):Bool
    {
        return ( states.get(keyCode >>> 3) & (1 << (keyCode & 7)) ) == 0;
    }
}
