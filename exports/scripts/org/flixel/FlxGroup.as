package org.flixel
{
   public class FlxGroup extends FlxObject
   {
      public static const ASCENDING:int = -1;
      
      public static const DESCENDING:int = 1;
      
      public var members:Array;
      
      protected var _last:FlxPoint;
      
      protected var _first:Boolean;
      
      protected var _sortIndex:String;
      
      protected var _sortOrder:int;
      
      public function FlxGroup()
      {
         super();
         _group = true;
         solid = false;
         this.members = new Array();
         this._last = new FlxPoint();
         this._first = true;
      }
      
      public function add(param1:FlxObject, param2:Boolean = false) : FlxObject
      {
         if(this.members.indexOf(param1) < 0)
         {
            this.members[this.members.length] = param1;
         }
         if(param2)
         {
            param1.scrollFactor = scrollFactor;
         }
         return param1;
      }
      
      public function replace(param1:FlxObject, param2:FlxObject) : FlxObject
      {
         var _loc3_:int = int(this.members.indexOf(param1));
         if(_loc3_ < 0 || _loc3_ >= this.members.length)
         {
            return null;
         }
         this.members[_loc3_] = param2;
         return param2;
      }
      
      public function remove(param1:FlxObject, param2:Boolean = false) : FlxObject
      {
         var _loc3_:int = int(this.members.indexOf(param1));
         if(_loc3_ < 0 || _loc3_ >= this.members.length)
         {
            return null;
         }
         if(param2)
         {
            this.members.splice(_loc3_,1);
         }
         else
         {
            this.members[_loc3_] = null;
         }
         return param1;
      }
      
      public function sort(param1:String = "y", param2:int = -1) : void
      {
         this._sortIndex = param1;
         this._sortOrder = param2;
         this.members.sort(this.sortHandler);
      }
      
      public function getFirstAvail() : FlxObject
      {
         var _loc2_:FlxObject = null;
         var _loc1_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.members[_loc1_++] as FlxObject;
            if(_loc2_ != null && !_loc2_.exists)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getFirstNull() : int
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = this.members.length;
         while(_loc1_ < _loc2_)
         {
            if(this.members[_loc1_] == null)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function resetFirstAvail(param1:Number = 0, param2:Number = 0) : Boolean
      {
         var _loc3_:FlxObject = this.getFirstAvail();
         if(_loc3_ == null)
         {
            return false;
         }
         _loc3_.reset(param1,param2);
         return true;
      }
      
      public function getFirstExtant() : FlxObject
      {
         var _loc2_:FlxObject = null;
         var _loc1_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.members[_loc1_++] as FlxObject;
            if(_loc2_ != null && _loc2_.exists)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getFirstAlive() : FlxObject
      {
         var _loc2_:FlxObject = null;
         var _loc1_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.members[_loc1_++] as FlxObject;
            if(_loc2_ != null && _loc2_.exists && !_loc2_.dead)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getFirstDead() : FlxObject
      {
         var _loc2_:FlxObject = null;
         var _loc1_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.members[_loc1_++] as FlxObject;
            if(_loc2_ != null && _loc2_.dead)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function countLiving() : int
      {
         var _loc3_:FlxObject = null;
         var _loc1_:int = -1;
         var _loc2_:uint = 0;
         var _loc4_:uint = this.members.length;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = this.members[_loc2_++] as FlxObject;
            if(_loc3_ != null)
            {
               if(_loc1_ < 0)
               {
                  _loc1_ = 0;
               }
               if(_loc3_.exists && !_loc3_.dead)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function countDead() : int
      {
         var _loc3_:FlxObject = null;
         var _loc1_:int = -1;
         var _loc2_:uint = 0;
         var _loc4_:uint = this.members.length;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = this.members[_loc2_++] as FlxObject;
            if(_loc3_ != null)
            {
               if(_loc1_ < 0)
               {
                  _loc1_ = 0;
               }
               if(_loc3_.dead)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function countOnScreen() : int
      {
         var _loc3_:FlxObject = null;
         var _loc1_:int = -1;
         var _loc2_:uint = 0;
         var _loc4_:uint = this.members.length;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = this.members[_loc2_++] as FlxObject;
            if(_loc3_ != null)
            {
               if(_loc1_ < 0)
               {
                  _loc1_ = 0;
               }
               if(_loc3_.onScreen())
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function getRandom() : FlxObject
      {
         var _loc1_:uint = 0;
         var _loc2_:FlxObject = null;
         var _loc3_:uint = this.members.length;
         var _loc4_:uint = uint(FlxU.random() * _loc3_);
         while(_loc2_ == null && _loc1_ < this.members.length)
         {
            _loc2_ = this.members[++_loc4_ % _loc3_] as FlxObject;
            _loc1_++;
         }
         return _loc2_;
      }
      
      protected function saveOldPosition() : void
      {
         if(this._first)
         {
            this._first = false;
            this._last.x = 0;
            this._last.y = 0;
            return;
         }
         this._last.x = x;
         this._last.y = y;
      }
      
      protected function updateMembers() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:FlxObject = null;
         var _loc3_:Boolean = false;
         if(x != this._last.x || y != this._last.y)
         {
            _loc3_ = true;
            _loc1_ = x - this._last.x;
            _loc2_ = y - this._last.y;
         }
         var _loc4_:uint = 0;
         var _loc6_:uint = this.members.length;
         while(_loc4_ < _loc6_)
         {
            _loc5_ = this.members[_loc4_++] as FlxObject;
            if(_loc5_ != null && _loc5_.exists)
            {
               if(_loc3_)
               {
                  if(_loc5_._group)
                  {
                     _loc5_.reset(_loc5_.x + _loc1_,_loc5_.y + _loc2_);
                  }
                  else
                  {
                     _loc5_.x += _loc1_;
                     _loc5_.y += _loc2_;
                  }
               }
               if(_loc5_.active)
               {
                  _loc5_.update();
               }
               if(_loc3_ && _loc5_.solid)
               {
                  _loc5_.colHullX.width += _loc1_ > 0 ? _loc1_ : -_loc1_;
                  if(_loc1_ < 0)
                  {
                     _loc5_.colHullX.x += _loc1_;
                  }
                  _loc5_.colHullY.x = x;
                  _loc5_.colHullY.height += _loc2_ > 0 ? _loc2_ : -_loc2_;
                  if(_loc2_ < 0)
                  {
                     _loc5_.colHullY.y += _loc2_;
                  }
                  _loc5_.colVector.x += _loc1_;
                  _loc5_.colVector.y += _loc2_;
               }
            }
         }
      }
      
      override public function update() : void
      {
         this.saveOldPosition();
         updateMotion();
         this.updateMembers();
         updateFlickering();
      }
      
      protected function renderMembers() : void
      {
         var _loc2_:FlxObject = null;
         var _loc1_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.members[_loc1_++] as FlxObject;
            if(_loc2_ != null && _loc2_.exists && _loc2_.visible)
            {
               _loc2_.render();
            }
         }
      }
      
      override public function render() : void
      {
         this.renderMembers();
      }
      
      protected function killMembers() : void
      {
         var _loc2_:FlxObject = null;
         var _loc1_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.members[_loc1_++] as FlxObject;
            if(_loc2_ != null)
            {
               _loc2_.kill();
            }
         }
      }
      
      override public function kill() : void
      {
         this.killMembers();
         super.kill();
      }
      
      protected function destroyMembers() : void
      {
         var _loc2_:FlxObject = null;
         var _loc1_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.members[_loc1_++] as FlxObject;
            if(_loc2_ != null)
            {
               _loc2_.destroy();
            }
         }
         this.members.length = 0;
      }
      
      override public function destroy() : void
      {
         this.destroyMembers();
         super.destroy();
      }
      
      override public function reset(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc7_:FlxObject = null;
         this.saveOldPosition();
         super.reset(param1,param2);
         var _loc5_:Boolean = false;
         if(x != this._last.x || y != this._last.y)
         {
            _loc5_ = true;
            _loc3_ = x - this._last.x;
            _loc4_ = y - this._last.y;
         }
         var _loc6_:uint = 0;
         var _loc8_:uint = this.members.length;
         while(_loc6_ < _loc8_)
         {
            _loc7_ = this.members[_loc6_++] as FlxObject;
            if(_loc7_ != null && _loc7_.exists)
            {
               if(_loc5_)
               {
                  if(_loc7_._group)
                  {
                     _loc7_.reset(_loc7_.x + _loc3_,_loc7_.y + _loc4_);
                  }
                  else
                  {
                     _loc7_.x += _loc3_;
                     _loc7_.y += _loc4_;
                     if(solid)
                     {
                        _loc7_.colHullX.width += _loc3_ > 0 ? _loc3_ : -_loc3_;
                        if(_loc3_ < 0)
                        {
                           _loc7_.colHullX.x += _loc3_;
                        }
                        _loc7_.colHullY.x = x;
                        _loc7_.colHullY.height += _loc4_ > 0 ? _loc4_ : -_loc4_;
                        if(_loc4_ < 0)
                        {
                           _loc7_.colHullY.y += _loc4_;
                        }
                        _loc7_.colVector.x += _loc3_;
                        _loc7_.colVector.y += _loc4_;
                     }
                  }
               }
            }
         }
      }
      
      protected function sortHandler(param1:FlxObject, param2:FlxObject) : int
      {
         if(param1[this._sortIndex] < param2[this._sortIndex])
         {
            return this._sortOrder;
         }
         if(param1[this._sortIndex] > param2[this._sortIndex])
         {
            return -this._sortOrder;
         }
         return 0;
      }
   }
}

