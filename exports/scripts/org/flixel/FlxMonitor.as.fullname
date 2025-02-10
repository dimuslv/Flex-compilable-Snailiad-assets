package org.flixel
{
   public class FlxMonitor
   {
      protected var _size:uint;
      
      protected var _itr:uint;
      
      protected var _data:Array;
      
      public function FlxMonitor(param1:uint, param2:Number = 0)
      {
         var _loc4_:* = undefined;
         super();
         this._size = param1;
         if(this._size <= 0)
         {
            this._size = 1;
         }
         this._itr = 0;
         this._data = new Array(this._size);
         var _loc3_:uint = 0;
         while(_loc3_ < this._size)
         {
            var _loc5_:*;
            this._data[_loc5_ = _loc4_ = _loc3_++] = param2;
         }
      }
      
      public function add(param1:Number) : void
      {
         var _loc2_:* = this._itr++;
         this._data[_loc2_] = param1;
         if(this._itr >= this._size)
         {
            this._itr = 0;
         }
      }
      
      public function average() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this._size)
         {
            _loc1_ += this._data[_loc2_++];
         }
         return _loc1_ / this._size;
      }
   }
}

