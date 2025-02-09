package org.flixel
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.flixel.data.FlxAnim;
   
   public class FlxSprite extends FlxObject
   {
      protected static var _gfxSprite:Sprite;
      
      protected static var _gfx:Graphics;
      
      public static const LEFT:uint = 0;
      
      public static const RIGHT:uint = 1;
      
      public static const UP:uint = 2;
      
      public static const DOWN:uint = 3;
      
      public var offset:FlxPoint;
      
      public var scale:FlxPoint;
      
      public var blend:String;
      
      public var antialiasing:Boolean;
      
      public var finished:Boolean;
      
      public var frameWidth:uint;
      
      public var frameHeight:uint;
      
      public var frames:uint;
      
      protected var _animations:Array;
      
      protected var _flipped:uint;
      
      protected var _curAnim:FlxAnim;
      
      protected var _curFrame:uint;
      
      protected var _caf:uint;
      
      protected var _frameTimer:Number;
      
      protected var _callback:Function;
      
      protected var _facing:uint;
      
      protected var _bakedRotation:Number;
      
      protected var _flashRect:Rectangle;
      
      protected var _flashRect2:Rectangle;
      
      protected var _flashPointZero:Point;
      
      protected var _pixels:BitmapData;
      
      protected var _framePixels:BitmapData;
      
      protected var _alpha:Number;
      
      protected var _color:uint;
      
      protected var _ct:ColorTransform;
      
      protected var _mtx:Matrix;
      
      protected var _bbb:BitmapData;
      
      protected var _boundsVisible:Boolean;
      
      public function FlxSprite(param1:Number = 0, param2:Number = 0, param3:Class = null)
      {
         super();
         x = param1;
         y = param2;
         this._flashRect = new Rectangle();
         this._flashRect2 = new Rectangle();
         this._flashPointZero = new Point();
         this.offset = new FlxPoint();
         this.scale = new FlxPoint(1,1);
         this._alpha = 1;
         this._color = 16777215;
         this.blend = null;
         this.antialiasing = false;
         this.finished = false;
         this._facing = RIGHT;
         this._animations = new Array();
         this._flipped = 0;
         this._curAnim = null;
         this._curFrame = 0;
         this._caf = 0;
         this._frameTimer = 0;
         this._mtx = new Matrix();
         this._callback = null;
         if(_gfxSprite == null)
         {
            _gfxSprite = new Sprite();
            _gfx = _gfxSprite.graphics;
         }
         if(param3 == null)
         {
            this.createGraphic(8,8);
         }
         else
         {
            this.loadGraphic(param3);
         }
      }
      
      public function loadGraphic(param1:Class, param2:Boolean = false, param3:Boolean = false, param4:uint = 0, param5:uint = 0, param6:Boolean = false) : FlxSprite
      {
         this._bakedRotation = 0;
         this._pixels = FlxG.addBitmap(param1,param3,param6);
         if(param3)
         {
            this._flipped = this._pixels.width >> 1;
         }
         else
         {
            this._flipped = 0;
         }
         if(param4 == 0)
         {
            if(param2)
            {
               param4 = uint(this._pixels.height);
            }
            else if(this._flipped > 0)
            {
               param4 = this._pixels.width * 0.5;
            }
            else
            {
               param4 = uint(this._pixels.width);
            }
         }
         width = this.frameWidth = param4;
         if(param5 == 0)
         {
            if(param2)
            {
               param5 = width;
            }
            else
            {
               param5 = uint(this._pixels.height);
            }
         }
         height = this.frameHeight = param5;
         this.resetHelpers();
         return this;
      }
      
      public function loadRotatedGraphic(param1:Class, param2:uint = 16, param3:int = -1, param4:Boolean = false, param5:Boolean = false) : FlxSprite
      {
         var _loc17_:uint = 0;
         var _loc22_:Boolean = false;
         var _loc6_:BitmapData = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Number = NaN;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         _loc17_ = Math.sqrt(param2);
         var _loc18_:BitmapData = FlxG.addBitmap(param1);
         if(param3 >= 0)
         {
            _loc6_ = _loc18_;
            _loc18_ = new BitmapData(_loc6_.height,_loc6_.height);
            _loc7_ = uint(param3 * _loc18_.width);
            _loc8_ = 0;
            _loc9_ = uint(_loc6_.width);
            if(_loc7_ >= _loc9_)
            {
               _loc8_ = uint(_loc7_ / _loc9_) * _loc18_.height;
               _loc7_ %= _loc9_;
            }
            this._flashRect.x = _loc7_;
            this._flashRect.y = _loc8_;
            this._flashRect.width = _loc18_.width;
            this._flashRect.height = _loc18_.height;
            _loc18_.copyPixels(_loc6_,this._flashRect,this._flashPointZero);
         }
         var _loc19_:uint = uint(_loc18_.width);
         if(_loc18_.height > _loc19_)
         {
            _loc19_ = uint(_loc18_.height);
         }
         if(param5)
         {
            _loc19_ *= 1.5;
         }
         var _loc20_:uint = FlxU.ceil(param2 / _loc17_);
         width = _loc19_ * _loc20_;
         height = _loc19_ * _loc17_;
         var _loc21_:String = String(param1) + ":" + param3 + ":" + width + "x" + height;
         _loc22_ = FlxG.checkBitmapCache(_loc21_);
         this._pixels = FlxG.createBitmap(width,height,0,true,_loc21_);
         width = this.frameWidth = this._pixels.width;
         height = this.frameHeight = this._pixels.height;
         this._bakedRotation = 360 / param2;
         if(!_loc22_)
         {
            _loc10_ = 0;
            _loc12_ = 0;
            _loc13_ = _loc18_.width * 0.5;
            _loc14_ = _loc18_.height * 0.5;
            _loc15_ = _loc19_ * 0.5;
            _loc16_ = _loc19_ * 0.5;
            while(_loc10_ < _loc17_)
            {
               _loc11_ = 0;
               while(_loc11_ < _loc20_)
               {
                  this._mtx.identity();
                  this._mtx.translate(-_loc13_,-_loc14_);
                  this._mtx.rotate(_loc12_ * 0.017453293);
                  this._mtx.translate(_loc19_ * _loc11_ + _loc15_,_loc16_);
                  _loc12_ += this._bakedRotation;
                  this._pixels.draw(_loc18_,this._mtx,null,null,null,param4);
                  _loc11_++;
               }
               _loc16_ += _loc19_;
               _loc10_++;
            }
         }
         this.frameWidth = this.frameHeight = width = height = _loc19_;
         this.resetHelpers();
         return this;
      }
      
      public function createGraphic(param1:uint, param2:uint, param3:uint = 4294967295, param4:Boolean = false, param5:String = null) : FlxSprite
      {
         this._bakedRotation = 0;
         this._pixels = FlxG.createBitmap(param1,param2,param3,param4,param5);
         width = this.frameWidth = this._pixels.width;
         height = this.frameHeight = this._pixels.height;
         this.resetHelpers();
         return this;
      }
      
      public function get pixels() : BitmapData
      {
         return this._pixels;
      }
      
      public function set pixels(param1:BitmapData) : void
      {
         this._pixels = param1;
         width = this.frameWidth = this._pixels.width;
         height = this.frameHeight = this._pixels.height;
         this.resetHelpers();
      }
      
      protected function resetHelpers() : void
      {
         this._boundsVisible = false;
         this._flashRect.x = 0;
         this._flashRect.y = 0;
         this._flashRect.width = this.frameWidth;
         this._flashRect.height = this.frameHeight;
         this._flashRect2.x = 0;
         this._flashRect2.y = 0;
         this._flashRect2.width = this._pixels.width;
         this._flashRect2.height = this._pixels.height;
         if(this._framePixels == null || this._framePixels.width != width || this._framePixels.height != height)
         {
            this._framePixels = new BitmapData(width,height);
         }
         if(this._bbb == null || this._bbb.width != width || this._bbb.height != height)
         {
            this._bbb = new BitmapData(width,height);
         }
         origin.x = this.frameWidth * 0.5;
         origin.y = this.frameHeight * 0.5;
         this._framePixels.copyPixels(this._pixels,this._flashRect,this._flashPointZero);
         this.frames = this._flashRect2.width / this._flashRect.width * (this._flashRect2.height / this._flashRect.height);
         if(this._ct != null)
         {
            this._framePixels.colorTransform(this._flashRect,this._ct);
         }
         if(FlxG.showBounds)
         {
            this.drawBounds();
         }
         this._caf = 0;
         refreshHulls();
      }
      
      override public function set solid(param1:Boolean) : void
      {
         var _loc2_:Boolean = _solid;
         _solid = param1;
         if(_loc2_ != _solid && FlxG.showBounds)
         {
            this.calcFrame();
         }
      }
      
      override public function set fixed(param1:Boolean) : void
      {
         var _loc2_:Boolean = _fixed;
         _fixed = param1;
         if(_loc2_ != _fixed && FlxG.showBounds)
         {
            this.calcFrame();
         }
      }
      
      public function get facing() : uint
      {
         return this._facing;
      }
      
      public function set facing(param1:uint) : void
      {
         var _loc2_:* = this._facing != param1;
         this._facing = param1;
         if(_loc2_)
         {
            this.calcFrame();
         }
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 == this._alpha)
         {
            return;
         }
         this._alpha = param1;
         if(this._alpha != 1 || this._color != 16777215)
         {
            this._ct = new ColorTransform((this._color >> 16) * 0.00392,(this._color >> 8 & 0xFF) * 0.00392,(this._color & 0xFF) * 0.00392,this._alpha);
         }
         else
         {
            this._ct = null;
         }
         this.calcFrame();
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         param1 &= 16777215;
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         if(this._alpha != 1 || this._color != 16777215)
         {
            this._ct = new ColorTransform((this._color >> 16) * 0.00392,(this._color >> 8 & 0xFF) * 0.00392,(this._color & 0xFF) * 0.00392,this._alpha);
         }
         else
         {
            this._ct = null;
         }
         this.calcFrame();
      }
      
      public function unFlashColor() : void
      {
         this._ct = null;
         this.calcFrame();
      }
      
      public function flashColor(param1:uint) : void
      {
         this._ct = new ColorTransform();
         this._ct.color = param1;
         this.calcFrame();
      }
      
      public function draw(param1:FlxSprite, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:BitmapData = param1._framePixels;
         if((param1.angle == 0 || param1._bakedRotation > 0) && param1.scale.x == 1 && param1.scale.y == 1 && param1.blend == null)
         {
            _flashPoint.x = param2;
            _flashPoint.y = param3;
            this._flashRect2.width = _loc4_.width;
            this._flashRect2.height = _loc4_.height;
            this._pixels.copyPixels(_loc4_,this._flashRect2,_flashPoint,null,null,true);
            this._flashRect2.width = this._pixels.width;
            this._flashRect2.height = this._pixels.height;
            this.calcFrame();
            return;
         }
         this._mtx.identity();
         this._mtx.translate(-param1.origin.x,-param1.origin.y);
         this._mtx.scale(param1.scale.x,param1.scale.y);
         if(param1.angle != 0)
         {
            this._mtx.rotate(param1.angle * 0.017453293);
         }
         this._mtx.translate(param2 + param1.origin.x,param3 + param1.origin.y);
         this._pixels.draw(_loc4_,this._mtx,null,param1.blend,null,param1.antialiasing);
         this.calcFrame();
      }
      
      public function drawLine(param1:Number, param2:Number, param3:Number, param4:Number, param5:uint, param6:uint = 1) : void
      {
         _gfx.clear();
         _gfx.moveTo(param1,param2);
         _gfx.lineStyle(param6,param5);
         _gfx.lineTo(param3,param4);
         this._pixels.draw(_gfxSprite);
         this.calcFrame();
      }
      
      public function fill(param1:uint) : void
      {
         this._pixels.fillRect(this._flashRect2,param1);
         if(this._pixels != this._framePixels)
         {
            this.calcFrame();
         }
      }
      
      protected function updateAnimation() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         if(this._bakedRotation)
         {
            _loc1_ = this._caf;
            _loc2_ = angle % 360;
            if(_loc2_ < 0)
            {
               _loc2_ += 360;
            }
            this._caf = _loc2_ / this._bakedRotation;
            if(_loc1_ != this._caf)
            {
               this.calcFrame();
            }
            return;
         }
         if(this._curAnim != null && this._curAnim.delay > 0 && (this._curAnim.looped || !this.finished))
         {
            this._frameTimer += FlxG.elapsed;
            while(this._frameTimer > this._curAnim.delay)
            {
               this._frameTimer -= this._curAnim.delay;
               if(this._curFrame == this._curAnim.frames.length - 1)
               {
                  if(this._curAnim.looped)
                  {
                     this._curFrame = 0;
                  }
                  this.finished = true;
               }
               else
               {
                  ++this._curFrame;
               }
               this._caf = this._curAnim.frames[this._curFrame];
               this.calcFrame();
            }
         }
      }
      
      override public function update() : void
      {
         updateMotion();
         this.updateAnimation();
         updateFlickering();
      }
      
      protected function renderSprite() : void
      {
         if(FlxG.showBounds != this._boundsVisible)
         {
            this.calcFrame();
         }
         this.getScreenXY(_point);
         _flashPoint.x = _point.x;
         _flashPoint.y = _point.y;
         if((angle == 0 || this._bakedRotation > 0) && this.scale.x == 1 && this.scale.y == 1 && this.blend == null)
         {
            FlxG.buffer.copyPixels(this._framePixels,this._flashRect,_flashPoint,null,null,true);
            return;
         }
         this._mtx.identity();
         this._mtx.translate(-origin.x,-origin.y);
         this._mtx.scale(this.scale.x,this.scale.y);
         if(angle != 0)
         {
            this._mtx.rotate(angle * 0.017453293);
         }
         this._mtx.translate(_point.x + origin.x,_point.y + origin.y);
         FlxG.buffer.draw(this._framePixels,this._mtx,null,this.blend,null,this.antialiasing);
      }
      
      override public function render() : void
      {
         this.renderSprite();
      }
      
      override public function overlapsPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         param1 += FlxU.floor(FlxG.scroll.x);
         param2 += FlxU.floor(FlxG.scroll.y);
         this.getScreenXY(_point);
         if(param3)
         {
            return this._framePixels.hitTest(new Point(0,0),255,new Point(param1 - _point.x,param2 - _point.y));
         }
         if(param1 <= _point.x || param1 >= _point.x + this.frameWidth || param2 <= _point.y || param2 >= _point.y + this.frameHeight)
         {
            return false;
         }
         return true;
      }
      
      public function onEmit() : void
      {
      }
      
      public function addAnimation(param1:String, param2:Array, param3:Number = 0, param4:Boolean = true) : void
      {
         this._animations.push(new FlxAnim(param1,param2,param3,param4));
      }
      
      public function addAnimationCallback(param1:Function) : void
      {
         this._callback = param1;
      }
      
      public function play(param1:String, param2:Boolean = false) : void
      {
         if(!param2 && this._curAnim != null && param1 == this._curAnim.name && (this._curAnim.looped || !this.finished))
         {
            return;
         }
         this._curFrame = 0;
         this._caf = 0;
         this._frameTimer = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = this._animations.length;
         while(_loc3_ < _loc4_)
         {
            if(this._animations[_loc3_].name == param1)
            {
               this._curAnim = this._animations[_loc3_];
               if(this._curAnim.delay <= 0)
               {
                  this.finished = true;
               }
               else
               {
                  this.finished = false;
               }
               this._caf = this._curAnim.frames[this._curFrame];
               this.calcFrame();
               return;
            }
            _loc3_++;
         }
      }
      
      public function randomFrame() : void
      {
         this._curAnim = null;
         this._caf = int(FlxU.random() * (this._pixels.width / this.frameWidth));
         this.calcFrame();
      }
      
      public function get frame() : uint
      {
         return this._caf;
      }
      
      public function set frame(param1:uint) : void
      {
         this._curAnim = null;
         this._caf = param1;
         this.calcFrame();
      }
      
      override public function getScreenXY(param1:FlxPoint = null) : FlxPoint
      {
         if(param1 == null)
         {
            param1 = new FlxPoint();
         }
         param1.x = FlxU.floor(x + FlxU.roundingError) + FlxU.floor(FlxG.scroll.x * scrollFactor.x) - this.offset.x;
         param1.y = FlxU.floor(y + FlxU.roundingError) + FlxU.floor(FlxG.scroll.y * scrollFactor.y) - this.offset.y;
         return param1;
      }
      
      protected function calcFrame() : void
      {
         this._boundsVisible = false;
         var _loc1_:uint = this._caf * this.frameWidth;
         var _loc2_:uint = 0;
         var _loc3_:uint = !!this._flipped ? this._flipped : uint(this._pixels.width);
         if(_loc1_ >= _loc3_)
         {
            _loc2_ = uint(_loc1_ / _loc3_) * this.frameHeight;
            _loc1_ %= _loc3_;
         }
         if(Boolean(this._flipped) && this._facing == LEFT)
         {
            _loc1_ = uint((this._flipped << 1) - _loc1_ - this.frameWidth);
         }
         this._flashRect.x = _loc1_;
         this._flashRect.y = _loc2_;
         this._framePixels.copyPixels(this._pixels,this._flashRect,this._flashPointZero);
         this._flashRect.x = this._flashRect.y = 0;
         if(this._ct != null)
         {
            this._framePixels.colorTransform(this._flashRect,this._ct);
         }
         if(FlxG.showBounds)
         {
            this.drawBounds();
         }
         if(this._callback != null)
         {
            this._callback(this._curAnim.name,this._curFrame,this._caf);
         }
      }
      
      protected function drawBounds() : void
      {
         this._boundsVisible = true;
         if(this._bbb == null || this._bbb.width != width || this._bbb.height != height)
         {
            this._bbb = new BitmapData(width,height);
         }
         var _loc1_:uint = getBoundingColor();
         this._bbb.fillRect(this._flashRect,0);
         var _loc2_:uint = this._flashRect.width;
         var _loc3_:uint = this._flashRect.height;
         this._flashRect.width = int(width);
         this._flashRect.height = int(height);
         this._bbb.fillRect(this._flashRect,_loc1_);
         this._flashRect.width -= 2;
         this._flashRect.height -= 2;
         this._flashRect.x = 1;
         this._flashRect.y = 1;
         this._bbb.fillRect(this._flashRect,0);
         this._flashRect.width = _loc2_;
         this._flashRect.height = _loc3_;
         this._flashRect.x = this._flashRect.y = 0;
         _flashPoint.x = int(this.offset.x);
         _flashPoint.y = int(this.offset.y);
         this._framePixels.copyPixels(this._bbb,this._flashRect,_flashPoint,null,null,true);
      }
      
      internal function unsafeBind(param1:BitmapData) : void
      {
         this._pixels = this._framePixels = param1;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.offset = this.scale = null;
         this._curAnim = null;
         this._callback = null;
         this._flashRect = this._flashRect2 = null;
         this._flashPointZero = null;
         this._framePixels.dispose();
         this._bbb.dispose();
         this._framePixels = this._bbb = null;
         this._ct = null;
         this._mtx = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._animations.length)
         {
            this._animations[_loc1_] = null;
            _loc1_++;
         }
         this._animations.length = 0;
         this._animations = null;
      }
   }
}

