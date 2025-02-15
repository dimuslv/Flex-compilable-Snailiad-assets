package org.flixel.data
{
   import flash.events.KeyboardEvent;
   
   public class FlxInput
   {
      internal var _lookup:Object;
      
      internal var _map:Array;
      
      internal const _t:uint = 256;
      
      private var _lastKeys:Array;
      
      private const _ringLength:int = 20;
      
      private var _ringPos:int = 0;
      
      public function FlxInput()
      {
         super();
         this._lookup = new Object();
         this._map = new Array(this._t);
         this._lastKeys = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < this._ringLength)
         {
            this._lastKeys[_loc1_] = " ";
            _loc1_++;
         }
      }
      
      public function update() : void
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._t)
         {
            _loc2_ = this._map[_loc1_++];
            if(_loc2_ != null)
            {
               if(_loc2_.last == -1 && _loc2_.current == -1)
               {
                  _loc2_.current = 0;
               }
               else if(_loc2_.last == 2 && _loc2_.current == 2)
               {
                  _loc2_.current = 1;
               }
               _loc2_.last = _loc2_.current;
            }
         }
      }
      
      public function reset() : void
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._t)
         {
            _loc2_ = this._map[_loc1_++];
            if(_loc2_ != null)
            {
               this[_loc2_.name] = false;
               _loc2_.current = 0;
               _loc2_.last = 0;
            }
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
      
      public function pressed(param1:String) : Boolean
      {
         return this[param1];
      }
      
      public function justPressed(param1:String) : Boolean
      {
         return Boolean(this._lookup[param1]) && Boolean(this._map[this._lookup[param1]]) && this._map[this._lookup[param1]].current == 2;
      }
      
      public function justReleased(param1:String) : Boolean
      {
         return this._map[this._lookup[param1]].current == -1;
      }
      
      public function handleKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:Object = this._map[param1.keyCode];
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.current > 0)
         {
            _loc2_.current = 1;
         }
         else
         {
            _loc2_.current = 2;
         }
         this[_loc2_.name] = true;
         this._lastKeys[this._ringPos] = _loc2_.name;
         ++this._ringPos;
         this._ringPos %= this._ringLength;
      }
      
      public function getLastKeys(param1:int = 20) : String
      {
         if(param1 > this._ringLength)
         {
            param1 = this._ringLength;
         }
         var _loc2_:int = this._ringLength - param1;
         return this._lastKeys.slice(this._ringPos + _loc2_,this._ringPos + _loc2_ + param1).join("") + (this._ringPos - param1 >= 0 ? this._lastKeys.slice(this._ringPos - param1,this._ringPos).join("") : this._lastKeys.slice(0,this._ringPos).join(""));
      }
      
      public function handleKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:Object = this._map[param1.keyCode];
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.current > 0)
         {
            _loc2_.current = -1;
         }
         else
         {
            _loc2_.current = 0;
         }
         this[_loc2_.name] = false;
      }
      
      internal function addKey(param1:String, param2:uint) : void
      {
         this._lookup[param1] = param2;
         this._map[param2] = {
            "name":param1,
            "current":0,
            "last":0
         };
      }
   }
}

