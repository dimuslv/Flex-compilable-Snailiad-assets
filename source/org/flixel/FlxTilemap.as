package org.flixel
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import mx.utils.*;
   
   public class FlxTilemap extends FlxObject
   {
      public static var ImgAuto:Class = FlxTilemap_ImgAuto;
      
      public static var ImgAutoAlt:Class = FlxTilemap_ImgAutoAlt;
      
      public static const OFF:uint = 0;
      
      public static const AUTO:uint = 1;
      
      public static const ALT:uint = 2;
      
      public static const TILE_ACCESS_BEHAVIOR_NORMAL:int = 0;
      
      public static const TILE_ACCESS_BEHAVIOR_WRAP:int = 1;
      
      public static const TILE_ACCESS_BEHAVIOR_ZEROES_AFTER_EDGE:int = 2;
      
      public static const TILE_ACCESS_BEHAVIOR_REPEATING_EDGE:int = 3;
      
      public var getTile:Function;
      
      public var setTile:Function;
      
      private var _tileAccessBehavior:int = 0;
      
      public var collideIndex:uint;
      
      public var startingIndex:uint;
      
      public var drawIndex:uint;
      
      public var auto:uint;
      
      public var refresh:Boolean;
      
      public var widthInTiles:uint;
      
      public var heightInTiles:uint;
      
      public var totalTiles:uint;
      
      public var _flashRect:Rectangle;
      
      public var _flashRect2:Rectangle;
      
      public var _pixels:BitmapData;
      
      public var _bbPixels:BitmapData;
      
      public var _buffer:BitmapData;
      
      public var _bufferLoc:FlxPoint;
      
      public var _bbKey:String;
      
      public var _data:Array;
      
      public var _rects:Array;
      
      public var _tileWidth:uint;
      
      public var _tileHeight:uint;
      
      public var _block:FlxObject;
      
      public var _callbacks:Array;
      
      public var _screenRows:uint;
      
      public var _screenCols:uint;
      
      public var _boundsVisible:Boolean;
      
      public var _wrapCenterOffsetX:uint;
      
      public var _wrapCenterOffsetY:uint;
      
      public static function arrayToCSV(param1:Array, param2:int) : String
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc3_:uint = 0;
         var _loc6_:int = param1.length / param2;
         while(_loc3_ < _loc6_)
         {
            _loc4_ = 0;
            while(_loc4_ < param2)
            {
               if(_loc4_ == 0)
               {
                  if(_loc3_ == 0)
                  {
                     _loc5_ += param1[0];
                  }
                  else
                  {
                     _loc5_ += "\n" + param1[_loc3_ * param2];
                  }
               }
               else
               {
                  _loc5_ += ", " + param1[_loc3_ * param2 + _loc4_];
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function bitmapToCSV(param1:BitmapData, param2:Boolean = false, param3:uint = 1) : String
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc10_:BitmapData = null;
         var _loc11_:Matrix = null;
         if(param3 > 1)
         {
            _loc10_ = param1;
            param1 = new BitmapData(param1.width * param3,param1.height * param3);
            _loc11_ = new Matrix();
            _loc11_.scale(param3,param3);
            param1.draw(_loc10_,_loc11_);
         }
         var _loc4_:uint = 0;
         var _loc8_:uint = uint(param1.width);
         var _loc9_:uint = uint(param1.height);
         while(_loc4_ < _loc9_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc6_ = param1.getPixel(_loc5_,_loc4_);
               if(param2 && _loc6_ > 0 || !param2 && _loc6_ == 0)
               {
                  _loc6_ = 1;
               }
               else
               {
                  _loc6_ = 0;
               }
               if(_loc5_ == 0)
               {
                  if(_loc4_ == 0)
                  {
                     _loc7_ += _loc6_;
                  }
                  else
                  {
                     _loc7_ += "\n" + _loc6_;
                  }
               }
               else
               {
                  _loc7_ += ", " + _loc6_;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc7_;
      }
      
      public static function imageToCSV(param1:Class, param2:Boolean = false, param3:uint = 1) : String
      {
         return bitmapToCSV(new param1().bitmapData,param2,param3);
      }
      
      public function loadMap(param1:String, param2:Class, param3:uint = 0, param4:uint = 0, param5:String = "") : FlxTilemap
      {
         var _loc7_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         this.refresh = true;
         var _loc6_:int = getTimer();
         var _loc8_:Array = param1.split("\n");
         this.heightInTiles = _loc8_.length;
         this._data = new Array();
         var _loc9_:uint = 0;
         while(_loc9_ < this.heightInTiles)
         {
            _loc7_ = _loc8_[_loc9_++].split(",");
            if(_loc7_.length <= 1)
            {
               --this.heightInTiles;
            }
            else
            {
               if(this.widthInTiles == 0)
               {
                  this.widthInTiles = _loc7_.length;
               }
               _loc10_ = 0;
               while(_loc10_ < this.widthInTiles)
               {
                  this._data.push(uint(_loc7_[_loc10_++]));
               }
            }
         }
         this._wrapCenterOffsetX = uint.MAX_VALUE / 2 - uint.MAX_VALUE / 2 % this.widthInTiles;
         this._wrapCenterOffsetY = uint.MAX_VALUE / 2 - uint.MAX_VALUE / 2 % this.heightInTiles;
         this.totalTiles = this.widthInTiles * this.heightInTiles;
         if(this.auto > OFF)
         {
            this.collideIndex = this.startingIndex = this.drawIndex = 1;
            _loc11_ = 0;
            while(_loc11_ < this.totalTiles)
            {
               this.autoTile(_loc11_++);
            }
         }
         this._pixels = FlxG.addBitmap(param2);
         this._tileWidth = param3;
         if(this._tileWidth == 0)
         {
            this._tileWidth = this._pixels.height;
         }
         this._tileHeight = param4;
         if(this._tileHeight == 0)
         {
            this._tileHeight = this._tileWidth;
         }
         this._block.width = this._tileWidth;
         this._block.height = this._tileHeight;
         width = this.widthInTiles * this._tileWidth;
         height = this.heightInTiles * this._tileHeight;
         this._rects = new Array(this.totalTiles);
         _loc11_ = 0;
         while(_loc11_ < this.totalTiles)
         {
            this.updateTile(_loc11_++);
         }
         var _loc12_:uint = (FlxU.ceil(FlxG.width / this._tileWidth) + 1) * this._tileWidth;
         var _loc13_:uint = (FlxU.ceil(FlxG.height / this._tileHeight) + 1) * this._tileHeight;
         this._buffer = new BitmapData(_loc12_,_loc13_,true,0);
         this._screenRows = Math.ceil(FlxG.height / this._tileHeight) + 1;
         if(this._screenRows > this.heightInTiles)
         {
            this._screenRows = this.heightInTiles;
         }
         this._screenCols = Math.ceil(FlxG.width / this._tileWidth) + 1;
         if(this._screenCols > this.widthInTiles)
         {
            this._screenCols = this.widthInTiles;
         }
         this._bbKey = String(param2);
         this.generateBoundingTiles();
         this.refreshHulls();
         this._flashRect.x = 0;
         this._flashRect.y = 0;
         this._flashRect.width = this._buffer.width;
         this._flashRect.height = this._buffer.height;
         return this;
      }
      
      public function generateBoundingTiles() : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:BitmapData = null;
         var _loc6_:BitmapData = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         this.refresh = true;
         if(this._bbKey == null || this._bbKey.length <= 0)
         {
            return;
         }
         var _loc1_:uint = getBoundingColor();
         var _loc2_:String = this._bbKey + ":BBTILES" + _loc1_;
         var _loc3_:Boolean = FlxG.checkBitmapCache(_loc2_);
         this._bbPixels = FlxG.createBitmap(this._pixels.width,this._pixels.height,0,true,_loc2_);
         if(!_loc3_)
         {
            this._flashRect.width = this._pixels.width;
            this._flashRect.height = this._pixels.height;
            _flashPoint.x = 0;
            _flashPoint.y = 0;
            this._bbPixels.copyPixels(this._pixels,this._flashRect,_flashPoint);
            this._flashRect.width = this._tileWidth;
            this._flashRect.height = this._tileHeight;
            _loc4_ = _solid;
            _solid = false;
            _loc1_ = getBoundingColor();
            _loc2_ = "BBTILESTAMP" + this._tileWidth + "X" + this._tileHeight + _loc1_;
            _loc3_ = FlxG.checkBitmapCache(_loc2_);
            _loc5_ = FlxG.createBitmap(this._tileWidth,this._tileHeight,0,true,_loc2_);
            if(!_loc3_)
            {
               _loc5_.fillRect(this._flashRect,_loc1_);
               this._flashRect.x = this._flashRect.y = 1;
               this._flashRect.width -= 2;
               this._flashRect.height -= 2;
               _loc5_.fillRect(this._flashRect,0);
               this._flashRect.x = this._flashRect.y = 0;
               this._flashRect.width = this._tileWidth;
               this._flashRect.height = this._tileHeight;
            }
            _solid = _loc4_;
            _loc1_ = getBoundingColor();
            _loc2_ = "BBTILESTAMP" + this._tileWidth + "X" + this._tileHeight + _loc1_;
            _loc3_ = FlxG.checkBitmapCache(_loc2_);
            _loc6_ = FlxG.createBitmap(this._tileWidth,this._tileHeight,0,true,_loc2_);
            if(!_loc3_)
            {
               _loc6_.fillRect(this._flashRect,_loc1_);
               this._flashRect.x = this._flashRect.y = 1;
               this._flashRect.width -= 2;
               this._flashRect.height -= 2;
               _loc6_.fillRect(this._flashRect,0);
               this._flashRect.x = this._flashRect.y = 0;
               this._flashRect.width = this._tileWidth;
               this._flashRect.height = this._tileHeight;
            }
            _loc7_ = 0;
            _loc9_ = 0;
            while(_loc7_ < this._bbPixels.height)
            {
               _loc8_ = 0;
               while(_loc8_ < this._bbPixels.width)
               {
                  _flashPoint.x = _loc8_;
                  _flashPoint.y = _loc7_;
                  if(_loc9_++ < this.collideIndex)
                  {
                     this._bbPixels.copyPixels(_loc5_,this._flashRect,_flashPoint,null,null,true);
                  }
                  else
                  {
                     this._bbPixels.copyPixels(_loc6_,this._flashRect,_flashPoint,null,null,true);
                  }
                  _loc8_ += this._tileWidth;
               }
               _loc7_ += this._tileHeight;
            }
            this._flashRect.x = 0;
            this._flashRect.y = 0;
            this._flashRect.width = this._buffer.width;
            this._flashRect.height = this._buffer.height;
         }
      }
      
      public function renderTilemap() : void
      {
         var _loc1_:BitmapData = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this._buffer.fillRect(this._flashRect,0);
         if(FlxG.showBounds)
         {
            _loc1_ = this._bbPixels;
            this._boundsVisible = true;
         }
         else
         {
            _loc1_ = this._pixels;
            this._boundsVisible = false;
         }
         getScreenXY(_point);
         _flashPoint.x = _point.x;
         _flashPoint.y = _point.y;
         var _loc2_:int = Math.floor(-_flashPoint.x / this._tileWidth);
         var _loc3_:int = Math.floor(-_flashPoint.y / this._tileHeight);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > this.widthInTiles - this._screenCols)
         {
            _loc2_ = this.widthInTiles - this._screenCols;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > this.heightInTiles - this._screenRows)
         {
            _loc3_ = this.heightInTiles - this._screenRows;
         }
         var _loc4_:int = _loc3_ * this.widthInTiles + _loc2_;
         _flashPoint.y = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < this._screenRows)
         {
            _loc7_ = uint(_loc4_);
            _loc6_ = 0;
            _flashPoint.x = 0;
            while(_loc6_ < this._screenCols)
            {
               this._flashRect = this._rects[_loc7_++] as Rectangle;
               if(this._flashRect != null)
               {
                  this._buffer.copyPixels(_loc1_,this._flashRect,_flashPoint,null,null,true);
               }
               _flashPoint.x += this._tileWidth;
               _loc6_++;
            }
            _loc4_ += this.widthInTiles;
            _flashPoint.y += this._tileHeight;
            _loc5_++;
         }
         this._flashRect = this._flashRect2;
         this._bufferLoc.x = _loc2_ * this._tileWidth;
         this._bufferLoc.y = _loc3_ * this._tileHeight;
      }
      
      override public function update() : void
      {
         super.update();
         getScreenXY(_point);
         _point.x += this._bufferLoc.x;
         _point.y += this._bufferLoc.y;
         if(_point.x > 0 || _point.y > 0 || _point.x + this._buffer.width < FlxG.width || _point.y + this._buffer.height < FlxG.height)
         {
            this.refresh = true;
         }
      }
      
      override public function render() : void
      {
         if(FlxG.showBounds != this._boundsVisible)
         {
            this.refresh = true;
         }
         if(this.refresh)
         {
            this.renderTilemap();
            this.refresh = false;
         }
         getScreenXY(_point);
         _flashPoint.x = _point.x + this._bufferLoc.x;
         _flashPoint.y = _point.y + this._bufferLoc.y;
         FlxG.buffer.copyPixels(this._buffer,this._flashRect,_flashPoint,null,null,true);
      }
      
      override public function set solid(param1:Boolean) : void
      {
         var _loc2_:Boolean = _solid;
         _solid = param1;
         if(_loc2_ != _solid)
         {
            this.generateBoundingTiles();
         }
      }
      
      override public function set fixed(param1:Boolean) : void
      {
         var _loc2_:Boolean = _fixed;
         _fixed = param1;
         if(_loc2_ != _fixed)
         {
            this.generateBoundingTiles();
         }
      }
      
      override public function overlaps(param1:FlxObject) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:Array = new Array();
         var _loc5_:uint = Math.floor((param1.x - x) / this._tileWidth);
         var _loc6_:uint = Math.floor((param1.y - y) / this._tileHeight);
         var _loc7_:uint = Math.ceil(param1.width / this._tileWidth) + 1;
         var _loc8_:uint = Math.ceil(param1.height / this._tileHeight) + 1;
         var _loc9_:uint = 0;
         while(_loc9_ < _loc8_)
         {
            if(_loc9_ >= this.heightInTiles)
            {
               break;
            }
            _loc2_ = (_loc6_ + _loc9_) * this.widthInTiles + _loc5_;
            _loc10_ = 0;
            while(_loc10_ < _loc7_)
            {
               if(_loc10_ >= this.widthInTiles)
               {
                  break;
               }
               _loc3_ = this._data[_loc2_ + _loc10_] as uint;
               if(_loc3_ >= this.collideIndex)
               {
                  _loc4_.push({
                     "x":x + (_loc5_ + _loc10_) * this._tileWidth,
                     "y":y + (_loc6_ + _loc9_) * this._tileHeight,
                     "data":_loc3_
                  });
               }
               _loc10_++;
            }
            _loc9_++;
         }
         var _loc11_:uint = _loc4_.length;
         var _loc12_:Boolean = false;
         var _loc13_:uint = 0;
         while(_loc13_ < _loc11_)
         {
            this._block.x = _loc4_[_loc13_].x;
            this._block.y = _loc4_[_loc13_++].y;
            if(this._block.overlaps(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      override public function overlapsPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return this.getTile(uint((param1 - x) / this._tileWidth),uint((param2 - y) / this._tileHeight)) >= this.collideIndex;
      }
      
      override public function refreshHulls() : void
      {
         colHullX.x = 0;
         colHullX.y = 0;
         colHullX.width = this._tileWidth;
         colHullX.height = this._tileHeight;
         colHullY.x = 0;
         colHullY.y = 0;
         colHullY.width = this._tileWidth;
         colHullY.height = this._tileHeight;
      }
      
      override public function preCollide(param1:FlxObject) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         colHullX.x = 0;
         colHullX.y = 0;
         colHullY.x = 0;
         colHullY.y = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = FlxU.floor((param1.x - x) / this._tileWidth);
         var _loc7_:int = FlxU.floor((param1.y - y) / this._tileHeight);
         var _loc8_:uint = _loc6_ + FlxU.ceil(param1.width / this._tileWidth) + 1;
         var _loc9_:uint = _loc7_ + FlxU.ceil(param1.height / this._tileHeight) + 1;
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         if(_loc7_ < 0)
         {
            _loc7_ = 0;
         }
         if(_loc8_ > this.widthInTiles)
         {
            _loc8_ = this.widthInTiles;
         }
         if(_loc9_ > this.heightInTiles)
         {
            _loc9_ = this.heightInTiles;
         }
         _loc4_ = _loc7_ * this.widthInTiles;
         _loc2_ = uint(_loc7_);
         while(_loc2_ < _loc9_)
         {
            _loc3_ = uint(_loc6_);
            while(_loc3_ < _loc8_)
            {
               if(this._data[_loc4_ + _loc3_] as uint >= this.collideIndex)
               {
                  var _loc10_:*;
                  colOffsets[_loc10_ = _loc5_++] = new FlxPoint(x + _loc3_ * this._tileWidth,y + _loc2_ * this._tileHeight);
               }
               _loc3_++;
            }
            _loc4_ += this.widthInTiles;
            _loc2_++;
         }
         if(colOffsets.length != _loc5_)
         {
            colOffsets.length = _loc5_;
         }
      }
      
      public function get tileAccessBehavior() : int
      {
         return this._tileAccessBehavior;
      }
      
      public function set tileAccessBehavior(param1:int) : void
      {
         switch(param1)
         {
            case TILE_ACCESS_BEHAVIOR_NORMAL:
               this.getTile = this.getTileNoWrap;
               this.setTile = this.setTileNoWrap;
               break;
            case TILE_ACCESS_BEHAVIOR_WRAP:
               this.getTile = this.getTileWrap;
               this.setTile = this.setTileWrap;
               break;
            case TILE_ACCESS_BEHAVIOR_ZEROES_AFTER_EDGE:
               this.getTile = this.getTileZeroesAfterEdge;
               this.setTile = this.setTileZeroesAfterEdge;
               break;
            case TILE_ACCESS_BEHAVIOR_REPEATING_EDGE:
               this.getTile = this.getTileRepeatingEdge;
               this.setTile = this.setTileRepeatingEdge;
               break;
            default:
               throw new Error("Unknown tile access behavior: " + param1.toString());
         }
         this._tileAccessBehavior = param1;
      }
      
      public function getTileNoWrap(param1:uint, param2:uint) : uint
      {
         return this.getTileByIndex(param2 * this.widthInTiles + param1);
      }
      
      public function getTileWrap(param1:uint, param2:uint) : uint
      {
         param1 = (param1 + this._wrapCenterOffsetX) % this.widthInTiles;
         param2 = (param2 + this._wrapCenterOffsetY) % this.heightInTiles;
         return this.getTileNoWrap(param1,param2);
      }
      
      public function getTileZeroesAfterEdge(param1:uint, param2:uint) : uint
      {
         if(param1 < 0 || param2 < 0 || param1 >= this.widthInTiles || param2 >= this.heightInTiles)
         {
            return 0;
         }
         return this.getTileNoWrap(param1,param2);
      }
      
      public function getTileRepeatingEdge(param1:uint, param2:uint) : uint
      {
         if(int(param1) < 0)
         {
            param1 = 0;
         }
         else if(param1 > this.widthInTiles - 1)
         {
            param1 = this.widthInTiles - 1;
         }
         if(int(param2) < 0)
         {
            param2 = 0;
         }
         else if(param2 > this.heightInTiles - 1)
         {
            param2 = this.heightInTiles - 1;
         }
         return this.getTileNoWrap(param1,param2);
      }
      
      public function setTileZeroesAfterEdge(param1:uint, param2:uint, param3:uint, param4:Boolean = true) : Boolean
      {
         if(param1 < 0 || param2 < 0 || param1 >= this.widthInTiles || param2 >= this.heightInTiles)
         {
            return false;
         }
         return this.setTileNoWrap(param1,param2,param3,param4);
      }
      
      public function setTileWrap(param1:uint, param2:uint, param3:uint, param4:Boolean = true) : Boolean
      {
         param1 = (param1 + this._wrapCenterOffsetX) % this.widthInTiles;
         param2 = (param2 + this._wrapCenterOffsetY) % this.heightInTiles;
         return this.setTileNoWrap(param1,param2,param3,param4);
      }
      
      public function setTileRepeatingEdge(param1:uint, param2:uint, param3:uint, param4:Boolean = true) : Boolean
      {
         if(int(param1) < 0)
         {
            param1 = 0;
         }
         else if(param1 > this.widthInTiles - 1)
         {
            param1 = this.widthInTiles - 1;
         }
         if(int(param2) < 0)
         {
            param2 = 0;
         }
         else if(param2 > this.heightInTiles - 1)
         {
            param2 = this.heightInTiles - 1;
         }
         return this.setTileNoWrap(param1,param2,param3,param4);
      }
      
      public function setTileNoWrap(param1:uint, param2:uint, param3:uint, param4:Boolean = true) : Boolean
      {
         if(param1 >= this.widthInTiles || param2 >= this.heightInTiles)
         {
            return false;
         }
         return this.setTileByIndex(param2 * this.widthInTiles + param1,param3,param4);
      }
      
      public function getTileByIndex(param1:uint) : uint
      {
         return this._data[param1] as uint;
      }
      
      public function setTileByIndex(param1:uint, param2:uint, param3:Boolean = true) : Boolean
      {
         var _loc5_:uint = 0;
         if(param1 >= this._data.length)
         {
            return false;
         }
         var _loc4_:Boolean = true;
         this._data[param1] = param2;
         if(!param3)
         {
            return _loc4_;
         }
         this.refresh = true;
         if(this.auto == OFF)
         {
            this.updateTile(param1);
            return _loc4_;
         }
         var _loc6_:int = int(param1 / this.widthInTiles) - 1;
         var _loc7_:int = _loc6_ + 3;
         var _loc8_:int = param1 % this.widthInTiles - 1;
         var _loc9_:int = _loc8_ + 3;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = _loc9_ - 3;
            while(_loc8_ < _loc9_)
            {
               if(_loc6_ >= 0 && _loc6_ < this.heightInTiles && _loc8_ >= 0 && _loc8_ < this.widthInTiles)
               {
                  _loc5_ = _loc6_ * this.widthInTiles + _loc8_;
                  this.autoTile(_loc5_);
                  this.updateTile(_loc5_);
               }
               _loc8_++;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function setCallback(param1:uint, param2:Function, param3:uint = 1) : void
      {
         FlxG.log("WARNING: FlxTilemap.setCallback()\nhas been temporarily deprecated.");
      }
      
      public function follow(param1:int = 0) : void
      {
         FlxG.followBounds(x + param1 * this._tileWidth,y + param1 * this._tileHeight,width - param1 * this._tileWidth,height - param1 * this._tileHeight);
      }
      
      public function ray(param1:Number, param2:Number, param3:Number, param4:Number, param5:FlxPoint, param6:Number = 1) : Boolean
      {
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc7_:Number = this._tileWidth;
         if(this._tileHeight < this._tileWidth)
         {
            _loc7_ = this._tileHeight;
         }
         _loc7_ /= param6;
         var _loc8_:Number = param3 - param1;
         var _loc9_:Number = param4 - param2;
         var _loc10_:Number = Math.sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_);
         var _loc11_:uint = Math.ceil(_loc10_ / _loc7_);
         var _loc12_:Number = _loc8_ / _loc11_;
         var _loc13_:Number = _loc9_ / _loc11_;
         var _loc14_:Number = param1 - _loc12_;
         var _loc15_:Number = param2 - _loc13_;
         var _loc18_:uint = 0;
         while(_loc18_ < _loc11_)
         {
            _loc14_ += _loc12_;
            _loc15_ += _loc13_;
            if(_loc14_ < 0 || _loc14_ > width || _loc15_ < 0 || _loc15_ > height)
            {
               _loc18_++;
            }
            else
            {
               _loc16_ = _loc14_ / this._tileWidth;
               _loc17_ = _loc15_ / this._tileHeight;
               if(this._data[_loc17_ * this.widthInTiles + _loc16_] as uint >= this.collideIndex)
               {
                  _loc16_ *= this._tileWidth;
                  _loc17_ *= this._tileHeight;
                  _loc19_ = 0;
                  _loc20_ = 0;
                  _loc22_ = _loc14_ - _loc12_;
                  _loc23_ = _loc15_ - _loc13_;
                  _loc21_ = _loc16_;
                  if(_loc8_ < 0)
                  {
                     _loc21_ += this._tileWidth;
                  }
                  _loc19_ = _loc21_;
                  _loc20_ = _loc23_ + _loc13_ * ((_loc21_ - _loc22_) / _loc12_);
                  if(_loc20_ > _loc17_ && _loc20_ < _loc17_ + this._tileHeight)
                  {
                     if(param5 == null)
                     {
                        param5 = new FlxPoint();
                     }
                     param5.x = _loc19_;
                     param5.y = _loc20_;
                     return true;
                  }
                  _loc21_ = _loc17_;
                  if(_loc9_ < 0)
                  {
                     _loc21_ += this._tileHeight;
                  }
                  _loc19_ = _loc22_ + _loc12_ * ((_loc21_ - _loc23_) / _loc13_);
                  _loc20_ = _loc21_;
                  if(_loc19_ > _loc16_ && _loc19_ < _loc16_ + this._tileWidth)
                  {
                     if(param5 == null)
                     {
                        param5 = new FlxPoint();
                     }
                     param5.x = _loc19_;
                     param5.y = _loc20_;
                     return true;
                  }
                  return false;
               }
               _loc18_++;
            }
         }
         return false;
      }
      
      public function autoTile(param1:uint) : void
      {
         if(this._data[param1] == 0)
         {
            return;
         }
         this._data[param1] = 0;
         if(param1 - this.widthInTiles < 0 || this._data[param1 - this.widthInTiles] > 0)
         {
            this._data[param1] += 1;
         }
         if(param1 % this.widthInTiles >= this.widthInTiles - 1 || this._data[param1 + 1] > 0)
         {
            this._data[param1] += 2;
         }
         if(param1 + this.widthInTiles >= this.totalTiles || this._data[param1 + this.widthInTiles] > 0)
         {
            this._data[param1] += 4;
         }
         if(param1 % this.widthInTiles <= 0 || this._data[param1 - 1] > 0)
         {
            this._data[param1] += 8;
         }
         if(this.auto == ALT && this._data[param1] == 15)
         {
            if(param1 % this.widthInTiles > 0 && param1 + this.widthInTiles < this.totalTiles && this._data[param1 + this.widthInTiles - 1] <= 0)
            {
               this._data[param1] = 1;
            }
            if(param1 % this.widthInTiles > 0 && param1 - this.widthInTiles >= 0 && this._data[param1 - this.widthInTiles - 1] <= 0)
            {
               this._data[param1] = 2;
            }
            if(param1 % this.widthInTiles < this.widthInTiles - 1 && param1 - this.widthInTiles >= 0 && this._data[param1 - this.widthInTiles + 1] <= 0)
            {
               this._data[param1] = 4;
            }
            if(param1 % this.widthInTiles < this.widthInTiles - 1 && param1 + this.widthInTiles < this.totalTiles && this._data[param1 + this.widthInTiles + 1] <= 0)
            {
               this._data[param1] = 8;
            }
         }
         this._data[param1] += 1;
      }
      
      public function updateTile(param1:uint) : void
      {
         if(this._data[param1] < this.drawIndex)
         {
            this._rects[param1] = null;
            return;
         }
         var _loc2_:uint = (this._data[param1] - this.startingIndex) * this._tileWidth;
         var _loc3_:uint = 0;
         if(_loc2_ >= this._pixels.width)
         {
            _loc3_ = uint(_loc2_ / this._pixels.width) * this._tileHeight;
            _loc2_ %= this._pixels.width;
         }
         this._rects[param1] = new Rectangle(_loc2_,_loc3_,this._tileWidth,this._tileHeight);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._flashRect = null;
         this._bbPixels.dispose();
         this._bbPixels = null;
         this._block.destroy();
         this._data.length = 0;
         this._data = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._rects.length)
         {
            this._rects[_loc1_] = null;
            _loc1_++;
         }
         this._rects.length = 0;
         this._rects = null;
         this._callbacks.length = 0;
         this._callbacks = null;
      }
      
      public function FlxTilemap()
      {
         this.getTile = this.getTileNoWrap;
         this.setTile = this.setTileNoWrap;
         super();
         this.auto = OFF;
         this.collideIndex = 1;
         this.startingIndex = 0;
         this.drawIndex = 1;
         this.widthInTiles = 0;
         this.heightInTiles = 0;
         this.totalTiles = 0;
         this._buffer = null;
         this._bufferLoc = new FlxPoint();
         this._flashRect2 = new Rectangle();
         this._flashRect = this._flashRect2;
         this._data = null;
         this._tileWidth = 0;
         this._tileHeight = 0;
         this._rects = null;
         this._pixels = null;
         this._block = new FlxObject();
         this._block.width = this._block.height = 0;
         this._block.fixed = true;
         this._callbacks = new Array();
         this.fixed = true;
      }
   }
}

