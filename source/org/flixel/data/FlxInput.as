package org.flixel.data
{
	import flash.events.KeyboardEvent;
	
	public class FlxInput
	{
		/**
		 * @private
		 */
		internal var _lookup:Object;
		/**
		 * @private
		 */
		internal var _map:Array;
		/**
		 * @private
		 */
		internal const _t:uint = 256;
		
		private var _lastKeys:Array;
		
		private const _ringLength:int = 20;
		
		private var _ringPos:int = 0;
		
		/**
		 * Constructor
		 */
		public function FlxInput()
		{
			_lookup = new Object();
			_map = new Array(_t);
			_lastKeys = new Array();
			for (var i:int = 0; i < _ringLength; i++) {
				_lastKeys[i] = " ";
			}
		}
		
		/**
		 * Updates the key states (for tracking just pressed, just released, etc).
		 */
		public function update():void
		{
			var i:uint = 0;
			while(i < _t)
			{
				var o:Object = _map[i++];
				if(o == null) continue;
				if((o.last == -1) && (o.current == -1)) o.current = 0;
				else if((o.last == 2) && (o.current == 2)) o.current = 1;
				o.last = o.current;
			}
		}
		
		/**
		 * Resets all the keys.
		 */
		public function reset():void
		{
			var i:uint = 0;
			while(i < _t)
			{
				var o:Object = _map[i++];
				if(o == null) continue;
				this[o.name] = false;
				o.current = 0;
				o.last = 0;
			}
		}
		
		public function unpress(param1:String) : void
		{
			this[param1] = false;
		}
		
		public function press(param1:String) : void
		{
			this[param1] = true;
		}
		
		/**
		 * Check to see if this key is pressed.
		 * 
		 * @param	Key		One of the key constants listed above (e.g. "LEFT" or "A").
		 * 
		 * @return	Whether the key is pressed
		 */
		public function pressed(Key:String):Boolean { return this[Key]; }
		
		/**
		 * Check to see if this key was just pressed.
		 * 
		 * @param	Key		One of the key constants listed above (e.g. "LEFT" or "A").
		 * 
		 * @return	Whether the key was just pressed
		 */
		public function justPressed(Key:String):Boolean { return _map[_lookup[Key]].current == 2; }
		
		/**
		 * Check to see if this key is just released.
		 * 
		 * @param	Key		One of the key constants listed above (e.g. "LEFT" or "A").
		 * 
		 * @return	Whether the key is just released.
		 */
		public function justReleased(Key:String):Boolean { return _map[_lookup[Key]].current == -1; }
		
		/**
		 * Event handler so FlxGame can toggle keys.
		 * 
		 * @param	event	A <code>KeyboardEvent</code> object.
		 */
		public function handleKeyDown(event:KeyboardEvent):void
		{
			var o:Object = _map[event.keyCode];
			if(o == null) return;
			if(o.current > 0) o.current = 1;
			else o.current = 2;
			this[o.name] = true;
			_lastKeys[_ringPos] = o.name;
			++_ringPos;
			_ringPos %= _ringLength;
		}
		
		public function getLastKeys(param1:int = _ringLength) : String
		{
			if (param1 > _ringLength) {
				param1 = _ringLength;
			}
			var _loc2_:int = _ringLength - param1;
			return _lastKeys.slice(_ringPos + _loc2_, _ringPos + _loc2_ + param1).join("") + (_ringPos - param1 >= 0 ? _lastKeys.slice(_ringPos - param1,_ringPos).join("") : _lastKeys.slice(0,_ringPos).join(""));
		}
		
		/**
		 * Event handler so FlxGame can toggle keys.
		 * 
		 * @param	event	A <code>KeyboardEvent</code> object.
		 */
		public function handleKeyUp(event:KeyboardEvent):void
		{
			var o:Object = _map[event.keyCode];
			if(o == null) return;
			if(o.current > 0) o.current = -1;
			else o.current = 0;
			this[o.name] = false;
		}
		
		/**
		 * An internal helper function used to build the key array.
		 * 
		 * @param	KeyName		String name of the key (e.g. "LEFT" or "A")
		 * @param	KeyCode		The numeric Flash code for this key.
		 */
		internal function addKey(KeyName:String,KeyCode:uint):void
		{
			_lookup[KeyName] = KeyCode;
			_map[KeyCode] = { name: KeyName, current: 0, last: 0 };
		}
	}
}
