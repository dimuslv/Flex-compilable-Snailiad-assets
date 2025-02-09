package org.flixel
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class FlxU
   {
      public static var quadTree:FlxQuadTree;
      
      internal static var roundingError:Number = 1e-7;
      
      public function FlxU()
      {
         super();
      }
      
      public static function openURL(param1:String) : void
      {
         navigateToURL(new URLRequest(param1),"_blank");
      }
      
      public static function abs(param1:Number) : Number
      {
         return param1 > 0 ? param1 : -param1;
      }
      
      public static function floor(param1:Number) : Number
      {
         var _loc2_:Number = int(param1);
         return param1 > 0 ? _loc2_ : (_loc2_ != param1 ? _loc2_ - 1 : _loc2_);
      }
      
      public static function ceil(param1:Number) : Number
      {
         var _loc2_:Number = int(param1);
         return param1 > 0 ? (_loc2_ != param1 ? _loc2_ + 1 : _loc2_) : _loc2_;
      }
      
      public static function min(param1:Number, param2:Number) : Number
      {
         return param1 <= param2 ? param1 : param2;
      }
      
      public static function max(param1:Number, param2:Number) : Number
      {
         return param1 >= param2 ? param1 : param2;
      }
      
      public static function random(param1:Number = NaN) : Number
      {
         if(isNaN(param1))
         {
            return Math.random();
         }
         if(param1 == 0)
         {
            param1 = Number.MIN_VALUE;
         }
         if(param1 >= 1)
         {
            if(param1 % 1 == 0)
            {
               param1 /= Math.PI;
            }
            param1 %= 1;
         }
         else if(param1 < 0)
         {
            param1 = param1 % 1 + 1;
         }
         return 69621 * int(param1 * 2147483647) % 2147483647 / 2147483647;
      }
      
      public static function startProfile() : uint
      {
         return getTimer();
      }
      
      public static function endProfile(param1:uint, param2:String = "Profiler", param3:Boolean = true) : uint
      {
         var _loc4_:uint = uint(getTimer());
         if(param3)
         {
            FlxG.log(param2 + ": " + (_loc4_ - param1) / 1000 + "s");
         }
         return _loc4_;
      }
      
      public static function rotatePoint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:FlxPoint = null) : FlxPoint
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Number = param5 * -0.017453293;
         while(_loc9_ < -3.14159265)
         {
            _loc9_ += 6.28318531;
         }
         while(_loc9_ > 3.14159265)
         {
            _loc9_ -= 6.28318531;
         }
         if(_loc9_ < 0)
         {
            _loc7_ = 1.27323954 * _loc9_ + 0.405284735 * _loc9_ * _loc9_;
            if(_loc7_ < 0)
            {
               _loc7_ = 0.225 * (_loc7_ * -_loc7_ - _loc7_) + _loc7_;
            }
            else
            {
               _loc7_ = 0.225 * (_loc7_ * _loc7_ - _loc7_) + _loc7_;
            }
         }
         else
         {
            _loc7_ = 1.27323954 * _loc9_ - 0.405284735 * _loc9_ * _loc9_;
            if(_loc7_ < 0)
            {
               _loc7_ = 0.225 * (_loc7_ * -_loc7_ - _loc7_) + _loc7_;
            }
            else
            {
               _loc7_ = 0.225 * (_loc7_ * _loc7_ - _loc7_) + _loc7_;
            }
         }
         _loc9_ += 1.57079632;
         if(_loc9_ > 3.14159265)
         {
            _loc9_ -= 6.28318531;
         }
         if(_loc9_ < 0)
         {
            _loc8_ = 1.27323954 * _loc9_ + 0.405284735 * _loc9_ * _loc9_;
            if(_loc8_ < 0)
            {
               _loc8_ = 0.225 * (_loc8_ * -_loc8_ - _loc8_) + _loc8_;
            }
            else
            {
               _loc8_ = 0.225 * (_loc8_ * _loc8_ - _loc8_) + _loc8_;
            }
         }
         else
         {
            _loc8_ = 1.27323954 * _loc9_ - 0.405284735 * _loc9_ * _loc9_;
            if(_loc8_ < 0)
            {
               _loc8_ = 0.225 * (_loc8_ * -_loc8_ - _loc8_) + _loc8_;
            }
            else
            {
               _loc8_ = 0.225 * (_loc8_ * _loc8_ - _loc8_) + _loc8_;
            }
         }
         _loc10_ = param1 - param3;
         _loc11_ = param4 - param2;
         if(param6 == null)
         {
            param6 = new FlxPoint();
         }
         param6.x = param3 + _loc8_ * _loc10_ - _loc7_ * _loc11_;
         param6.y = param4 - _loc7_ * _loc10_ - _loc8_ * _loc11_;
         return param6;
      }
      
      public static function getAngle(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = 3.14159265 / 4;
         var _loc4_:Number = 3 * _loc3_;
         var _loc5_:Number = param2 < 0 ? -param2 : param2;
         var _loc6_:Number = 0;
         if(param1 >= 0)
         {
            _loc6_ = _loc3_ - _loc3_ * ((param1 - _loc5_) / (param1 + _loc5_));
         }
         else
         {
            _loc6_ = _loc4_ - _loc3_ * ((param1 + _loc5_) / (_loc5_ - param1));
         }
         return (param2 < 0 ? -_loc6_ : _loc6_) * 57.2957796;
      }
      
      public static function getColor(param1:uint, param2:uint, param3:uint, param4:Number = 1) : uint
      {
         return ((param4 > 1 ? param4 : param4 * 255) & 0xFF) << 24 | (param1 & 0xFF) << 16 | (param2 & 0xFF) << 8 | param3 & 0xFF;
      }
      
      public static function getColorHSB(param1:Number, param2:Number, param3:Number, param4:Number = 1) : uint
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(param2 == 0)
         {
            _loc5_ = param3;
            _loc6_ = param3;
            _loc7_ = param3;
         }
         else
         {
            if(param1 == 360)
            {
               param1 = 0;
            }
            _loc8_ = param1 / 60;
            _loc9_ = param1 / 60 - _loc8_;
            _loc10_ = param3 * (1 - param2);
            _loc11_ = param3 * (1 - param2 * _loc9_);
            _loc12_ = param3 * (1 - param2 * (1 - _loc9_));
            switch(_loc8_)
            {
               case 0:
                  _loc5_ = param3;
                  _loc6_ = _loc12_;
                  _loc7_ = _loc10_;
                  break;
               case 1:
                  _loc5_ = _loc11_;
                  _loc6_ = param3;
                  _loc7_ = _loc10_;
                  break;
               case 2:
                  _loc5_ = _loc10_;
                  _loc6_ = param3;
                  _loc7_ = _loc12_;
                  break;
               case 3:
                  _loc5_ = _loc10_;
                  _loc6_ = _loc11_;
                  _loc7_ = param3;
                  break;
               case 4:
                  _loc5_ = _loc12_;
                  _loc6_ = _loc10_;
                  _loc7_ = param3;
                  break;
               case 5:
                  _loc5_ = param3;
                  _loc6_ = _loc10_;
                  _loc7_ = _loc11_;
                  break;
               default:
                  _loc5_ = 0;
                  _loc6_ = 0;
                  _loc7_ = 0;
            }
         }
         return ((param4 > 1 ? param4 : param4 * 255) & 0xFF) << 24 | uint(_loc5_ * 255) << 16 | uint(_loc6_ * 255) << 8 | uint(_loc7_ * 255);
      }
      
      public static function getRGBA(param1:uint, param2:Array = null) : Array
      {
         if(param2 == null)
         {
            param2 = new Array();
         }
         param2[0] = param1 >> 16 & 0xFF;
         param2[1] = param1 >> 8 & 0xFF;
         param2[2] = param1 & 0xFF;
         param2[3] = Number(param1 >> 24 & 0xFF) / 255;
         return param2;
      }
      
      public static function getHSB(param1:uint, param2:Array = null) : Array
      {
         if(param2 == null)
         {
            param2 = new Array();
         }
         var _loc3_:Number = Number(param1 >> 16 & 0xFF) / 255;
         var _loc4_:Number = Number(param1 >> 8 & 0xFF) / 255;
         var _loc5_:Number = Number(param1 & 0xFF) / 255;
         var _loc6_:Number = _loc3_ > _loc4_ ? _loc3_ : _loc4_;
         var _loc7_:Number = _loc6_ > _loc5_ ? _loc6_ : _loc5_;
         _loc6_ = _loc3_ > _loc4_ ? _loc4_ : _loc3_;
         var _loc8_:Number = _loc6_ > _loc5_ ? _loc5_ : _loc6_;
         var _loc9_:Number = _loc7_ - _loc8_;
         param2[2] = _loc7_;
         param2[1] = 0;
         param2[0] = 0;
         if(_loc7_ != 0)
         {
            param2[1] = _loc9_ / _loc7_;
         }
         if(param2[1] != 0)
         {
            if(_loc3_ == _loc7_)
            {
               param2[0] = (_loc4_ - _loc5_) / _loc9_;
            }
            else if(_loc4_ == _loc7_)
            {
               param2[0] = 2 + (_loc5_ - _loc3_) / _loc9_;
            }
            else if(_loc5_ == _loc7_)
            {
               param2[0] = 4 + (_loc3_ - _loc4_) / _loc9_;
            }
            param2[0] *= 60;
            if(param2[0] < 0)
            {
               param2[0] += 360;
            }
         }
         param2[3] = Number(param1 >> 24 & 0xFF) / 255;
         return param2;
      }
      
      public static function getClassName(param1:Object, param2:Boolean = false) : String
      {
         var _loc3_:String = getQualifiedClassName(param1);
         _loc3_ = _loc3_.replace("::",".");
         if(param2)
         {
            _loc3_ = _loc3_.substr(_loc3_.lastIndexOf(".") + 1);
         }
         return _loc3_;
      }
      
      public static function getClass(param1:String) : Class
      {
         return getDefinitionByName(param1) as Class;
      }
      
      public static function computeVelocity(param1:Number, param2:Number = 0, param3:Number = 0, param4:Number = 10000) : Number
      {
         var _loc5_:Number = NaN;
         if(param2 != 0)
         {
            param1 += param2 * FlxG.elapsed;
         }
         else if(param3 != 0)
         {
            _loc5_ = param3 * FlxG.elapsed;
            if(param1 - _loc5_ > 0)
            {
               param1 -= _loc5_;
            }
            else if(param1 + _loc5_ < 0)
            {
               param1 += _loc5_;
            }
            else
            {
               param1 = 0;
            }
         }
         if(param1 != 0 && param4 != 10000)
         {
            if(param1 > param4)
            {
               param1 = param4;
            }
            else if(param1 < -param4)
            {
               param1 = -param4;
            }
         }
         return param1;
      }
      
      public static function setWorldBounds(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:uint = 3) : void
      {
         if(FlxQuadTree.bounds == null)
         {
            FlxQuadTree.bounds = new FlxRect();
         }
         FlxQuadTree.bounds.x = param1;
         FlxQuadTree.bounds.y = param2;
         if(param3 > 0)
         {
            FlxQuadTree.bounds.width = param3;
         }
         if(param4 > 0)
         {
            FlxQuadTree.bounds.height = param4;
         }
         if(param5 > 0)
         {
            FlxQuadTree.divisions = param5;
         }
      }
      
      public static function overlap(param1:FlxObject, param2:FlxObject, param3:Function = null) : Boolean
      {
         if(param1 == null || !param1.exists || param2 == null || !param2.exists)
         {
            return false;
         }
         quadTree = new FlxQuadTree(FlxQuadTree.bounds.x,FlxQuadTree.bounds.y,FlxQuadTree.bounds.width,FlxQuadTree.bounds.height);
         quadTree.add(param1,FlxQuadTree.A_LIST);
         if(param1 === param2)
         {
            return quadTree.overlap(false,param3);
         }
         quadTree.add(param2,FlxQuadTree.B_LIST);
         return quadTree.overlap(true,param3);
      }
      
      public static function collide(param1:FlxObject, param2:FlxObject) : Boolean
      {
         if(param1 == null || !param1.exists || param2 == null || !param2.exists)
         {
            return false;
         }
         quadTree = new FlxQuadTree(FlxQuadTree.bounds.x,FlxQuadTree.bounds.y,FlxQuadTree.bounds.width,FlxQuadTree.bounds.height);
         quadTree.add(param1,FlxQuadTree.A_LIST);
         var _loc3_:* = param1 === param2;
         if(!_loc3_)
         {
            quadTree.add(param2,FlxQuadTree.B_LIST);
         }
         var _loc4_:Boolean = quadTree.overlap(!_loc3_,solveXCollision);
         var _loc5_:Boolean = quadTree.overlap(!_loc3_,solveYCollision);
         return _loc4_ || _loc5_;
      }
      
      public static function solveXCollision(param1:FlxObject, param2:FlxObject) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:FlxRect = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = param1.colVector.x;
         var _loc19_:Number = param2.colVector.x;
         if(_loc18_ == _loc19_)
         {
            return false;
         }
         param1.preCollide(param2);
         param2.preCollide(param1);
         var _loc20_:Boolean = false;
         var _loc21_:* = _loc18_ == 0;
         var _loc22_:* = _loc18_ < 0;
         var _loc23_:* = _loc18_ > 0;
         var _loc24_:* = _loc19_ == 0;
         var _loc25_:* = _loc19_ < 0;
         var _loc26_:* = _loc19_ > 0;
         _loc9_ = param1.colHullX;
         var _loc27_:FlxRect = param2.colHullX;
         var _loc28_:Array = param1.colOffsets;
         var _loc29_:Array = param2.colOffsets;
         var _loc30_:uint = _loc28_.length;
         var _loc31_:uint = _loc29_.length;
         _loc6_ = _loc21_ && _loc25_ || _loc23_ && _loc24_ || _loc23_ && _loc25_ || _loc22_ && _loc25_ && (_loc18_ > 0 ? _loc18_ : -_loc18_) < (_loc19_ > 0 ? _loc19_ : -_loc19_) || _loc23_ && _loc26_ && (_loc18_ > 0 ? _loc18_ : -_loc18_) > (_loc19_ > 0 ? _loc19_ : -_loc19_);
         if(_loc6_ ? !param1.collideRight || !param2.collideLeft : !param1.collideLeft || !param2.collideRight)
         {
            return false;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc30_)
         {
            _loc10_ = Number(_loc28_[_loc7_].x);
            _loc11_ = Number(_loc28_[_loc7_].y);
            _loc9_.x += _loc10_;
            _loc9_.y += _loc11_;
            _loc8_ = 0;
            while(_loc8_ < _loc31_)
            {
               _loc12_ = Number(_loc29_[_loc8_].x);
               _loc13_ = Number(_loc29_[_loc8_].y);
               _loc27_.x += _loc12_;
               _loc27_.y += _loc13_;
               if(_loc9_.x + _loc9_.width < _loc27_.x + roundingError || _loc9_.x + roundingError > _loc27_.x + _loc27_.width || _loc9_.y + _loc9_.height < _loc27_.y + roundingError || _loc9_.y + roundingError > _loc27_.y + _loc27_.height)
               {
                  _loc27_.x -= _loc12_;
                  _loc27_.y -= _loc13_;
                  _loc8_++;
               }
               else
               {
                  if(_loc6_)
                  {
                     if(_loc22_)
                     {
                        _loc14_ = _loc9_.x + param1.colHullY.width;
                     }
                     else
                     {
                        _loc14_ = _loc9_.x + _loc9_.width;
                     }
                     if(_loc25_)
                     {
                        _loc15_ = _loc27_.x;
                     }
                     else
                     {
                        _loc15_ = _loc27_.x + _loc27_.width - param2.colHullY.width;
                     }
                  }
                  else
                  {
                     if(_loc25_)
                     {
                        _loc14_ = -_loc27_.x - param2.colHullY.width;
                     }
                     else
                     {
                        _loc14_ = -_loc27_.x - _loc27_.width;
                     }
                     if(_loc22_)
                     {
                        _loc15_ = -_loc9_.x;
                     }
                     else
                     {
                        _loc15_ = -_loc9_.x - _loc9_.width + param1.colHullY.width;
                     }
                  }
                  _loc5_ = _loc14_ - _loc15_;
                  _loc3_ = param1.fixed;
                  _loc4_ = param2.fixed;
                  if(_loc3_ && _loc4_)
                  {
                     _loc3_ &&= param1.colVector.x == 0 && _loc18_ == 0;
                     _loc4_ &&= param2.colVector.x == 0 && _loc19_ == 0;
                  }
                  if(_loc5_ == 0 || !_loc3_ && (_loc5_ > 0 ? _loc5_ : -_loc5_) > _loc9_.width * 0.8 || !_loc4_ && (_loc5_ > 0 ? _loc5_ : -_loc5_) > _loc27_.width * 0.8)
                  {
                     _loc27_.x -= _loc12_;
                     _loc27_.y -= _loc13_;
                     _loc8_++;
                  }
                  else
                  {
                     _loc20_ = true;
                     _loc16_ = param2.velocity.x;
                     _loc17_ = param1.velocity.x;
                     if(!_loc3_ && _loc4_)
                     {
                        if(param1._group)
                        {
                           param1.reset(param1.x - _loc5_,param1.y);
                        }
                        else
                        {
                           param1.x -= _loc5_;
                        }
                     }
                     else if(_loc3_ && !_loc4_)
                     {
                        if(param2._group)
                        {
                           param2.reset(param2.x + _loc5_,param2.y);
                        }
                        else
                        {
                           param2.x += _loc5_;
                        }
                     }
                     else if(!_loc3_ && !_loc4_)
                     {
                        _loc5_ /= 2;
                        if(param1._group)
                        {
                           param1.reset(param1.x - _loc5_,param1.y);
                        }
                        else
                        {
                           param1.x -= _loc5_;
                        }
                        if(param2._group)
                        {
                           param2.reset(param2.x + _loc5_,param2.y);
                        }
                        else
                        {
                           param2.x += _loc5_;
                        }
                        _loc16_ *= 0.5;
                        _loc17_ *= 0.5;
                     }
                     if(_loc6_)
                     {
                        param1.hitRight(param2,_loc16_);
                        param2.hitLeft(param1,_loc17_);
                     }
                     else
                     {
                        param1.hitLeft(param2,_loc16_);
                        param2.hitRight(param1,_loc17_);
                     }
                     if(!_loc3_ && _loc5_ != 0)
                     {
                        if(_loc6_)
                        {
                           _loc9_.width -= _loc5_;
                        }
                        else
                        {
                           _loc9_.x -= _loc5_;
                           _loc9_.width += _loc5_;
                        }
                        param1.colHullY.x -= _loc5_;
                     }
                     if(!_loc4_ && _loc5_ != 0)
                     {
                        if(_loc6_)
                        {
                           _loc27_.x += _loc5_;
                           _loc27_.width -= _loc5_;
                        }
                        else
                        {
                           _loc27_.width += _loc5_;
                        }
                        param2.colHullY.x += _loc5_;
                     }
                     _loc27_.x -= _loc12_;
                     _loc27_.y -= _loc13_;
                     _loc8_++;
                  }
               }
            }
            _loc9_.x -= _loc10_;
            _loc9_.y -= _loc11_;
            _loc7_++;
         }
         return _loc20_;
      }
      
      public static function solveYCollision(param1:FlxObject, param2:FlxObject) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = param1.colVector.y;
         var _loc18_:Number = param2.colVector.y;
         if(_loc17_ == _loc18_)
         {
            return false;
         }
         param1.preCollide(param2);
         param2.preCollide(param1);
         var _loc19_:Boolean = false;
         var _loc20_:* = _loc17_ == 0;
         var _loc21_:* = _loc17_ < 0;
         var _loc22_:* = _loc17_ > 0;
         var _loc23_:* = _loc18_ == 0;
         var _loc24_:* = _loc18_ < 0;
         var _loc25_:* = _loc18_ > 0;
         var _loc26_:FlxRect = param1.colHullY;
         var _loc27_:FlxRect = param2.colHullY;
         var _loc28_:Array = param1.colOffsets;
         var _loc29_:Array = param2.colOffsets;
         var _loc30_:uint = _loc28_.length;
         var _loc31_:uint = _loc29_.length;
         _loc6_ = _loc20_ && _loc24_ || _loc22_ && _loc23_ || _loc22_ && _loc24_ || _loc21_ && _loc24_ && (_loc17_ > 0 ? _loc17_ : -_loc17_) < (_loc18_ > 0 ? _loc18_ : -_loc18_) || _loc22_ && _loc25_ && (_loc17_ > 0 ? _loc17_ : -_loc17_) > (_loc18_ > 0 ? _loc18_ : -_loc18_);
         if(_loc6_ ? !param1.collideBottom || !param2.collideTop : !param1.collideTop || !param2.collideBottom)
         {
            return false;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc30_)
         {
            _loc9_ = Number(_loc28_[_loc7_].x);
            _loc10_ = Number(_loc28_[_loc7_].y);
            _loc26_.x += _loc9_;
            _loc26_.y += _loc10_;
            _loc8_ = 0;
            while(_loc8_ < _loc31_)
            {
               _loc11_ = Number(_loc29_[_loc8_].x);
               _loc12_ = Number(_loc29_[_loc8_].y);
               _loc27_.x += _loc11_;
               _loc27_.y += _loc12_;
               if(_loc26_.x + _loc26_.width < _loc27_.x + roundingError || _loc26_.x + roundingError > _loc27_.x + _loc27_.width || _loc26_.y + _loc26_.height < _loc27_.y + roundingError || _loc26_.y + roundingError > _loc27_.y + _loc27_.height)
               {
                  _loc27_.x -= _loc11_;
                  _loc27_.y -= _loc12_;
                  _loc8_++;
               }
               else
               {
                  if(_loc6_)
                  {
                     if(_loc21_)
                     {
                        _loc13_ = _loc26_.y + param1.colHullX.height;
                     }
                     else
                     {
                        _loc13_ = _loc26_.y + _loc26_.height;
                     }
                     if(_loc24_)
                     {
                        _loc14_ = _loc27_.y;
                     }
                     else
                     {
                        _loc14_ = _loc27_.y + _loc27_.height - param2.colHullX.height;
                     }
                  }
                  else
                  {
                     if(_loc24_)
                     {
                        _loc13_ = -_loc27_.y - param2.colHullX.height;
                     }
                     else
                     {
                        _loc13_ = -_loc27_.y - _loc27_.height;
                     }
                     if(_loc21_)
                     {
                        _loc14_ = -_loc26_.y;
                     }
                     else
                     {
                        _loc14_ = -_loc26_.y - _loc26_.height + param1.colHullX.height;
                     }
                  }
                  _loc5_ = _loc13_ - _loc14_;
                  _loc3_ = param1.fixed;
                  _loc4_ = param2.fixed;
                  if(_loc3_ && _loc4_)
                  {
                     _loc3_ &&= param1.colVector.x == 0 && _loc17_ == 0;
                     _loc4_ &&= param2.colVector.x == 0 && _loc18_ == 0;
                  }
                  if(_loc5_ == 0 || !_loc3_ && (_loc5_ > 0 ? _loc5_ : -_loc5_) > _loc26_.height * 0.8 || !_loc4_ && (_loc5_ > 0 ? _loc5_ : -_loc5_) > _loc27_.height * 0.8)
                  {
                     _loc27_.x -= _loc11_;
                     _loc27_.y -= _loc12_;
                     _loc8_++;
                  }
                  else
                  {
                     _loc19_ = true;
                     _loc15_ = param2.velocity.y;
                     _loc16_ = param1.velocity.y;
                     if(!_loc3_ && _loc4_)
                     {
                        if(param1._group)
                        {
                           param1.reset(param1.x,param1.y - _loc5_);
                        }
                        else
                        {
                           param1.y -= _loc5_;
                        }
                     }
                     else if(_loc3_ && !_loc4_)
                     {
                        if(param2._group)
                        {
                           param2.reset(param2.x,param2.y + _loc5_);
                        }
                        else
                        {
                           param2.y += _loc5_;
                        }
                     }
                     else if(!_loc3_ && !_loc4_)
                     {
                        _loc5_ /= 2;
                        if(param1._group)
                        {
                           param1.reset(param1.x,param1.y - _loc5_);
                        }
                        else
                        {
                           param1.y -= _loc5_;
                        }
                        if(param2._group)
                        {
                           param2.reset(param2.x,param2.y + _loc5_);
                        }
                        else
                        {
                           param2.y += _loc5_;
                        }
                        _loc15_ *= 0.5;
                        _loc16_ *= 0.5;
                     }
                     if(_loc6_)
                     {
                        param1.hitBottom(param2,_loc15_);
                        param2.hitTop(param1,_loc16_);
                     }
                     else
                     {
                        param1.hitTop(param2,_loc15_);
                        param2.hitBottom(param1,_loc16_);
                     }
                     if(!_loc3_ && _loc5_ != 0)
                     {
                        if(_loc6_)
                        {
                           _loc26_.y -= _loc5_;
                           if(_loc4_ && param2.moves)
                           {
                              _loc15_ = param2.colVector.x;
                              param1.x += _loc15_;
                              _loc26_.x += _loc15_;
                              param1.colHullX.x += _loc15_;
                           }
                        }
                        else
                        {
                           _loc26_.y -= _loc5_;
                           _loc26_.height += _loc5_;
                        }
                     }
                     if(!_loc4_ && _loc5_ != 0)
                     {
                        if(_loc6_)
                        {
                           _loc27_.y += _loc5_;
                           _loc27_.height -= _loc5_;
                        }
                        else
                        {
                           _loc27_.height += _loc5_;
                           if(_loc3_ && param1.moves)
                           {
                              _loc16_ = param1.colVector.x;
                              param2.x += _loc16_;
                              _loc27_.x += _loc16_;
                              param2.colHullX.x += _loc16_;
                           }
                        }
                     }
                     _loc27_.x -= _loc11_;
                     _loc27_.y -= _loc12_;
                     _loc8_++;
                  }
               }
            }
            _loc26_.x -= _loc9_;
            _loc26_.y -= _loc10_;
            _loc7_++;
         }
         return _loc19_;
      }
   }
}

