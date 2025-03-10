package
{
   import org.flixel.*;
   
   public class Boss4SecondFormBg extends FlxGroup
   {
      private static const FADE_SPEED:Number = 0.25;
      
      private var _bg:FlxSprite;
      
      private var _stars:StarInwardLayer;
      
      private var _oldAlpha:Number = 0;
      
      private var _fade:Number = 0;
      
      private var _fading:Boolean = true;
      
      private var _fadingOut:Boolean = false;
      
      private var r:Number = 0;
      
      private var g:Number = 0;
      
      private var b:Number = 0;
      
      private var targetR:Number = 0;
      
      private var targetG:Number = 0;
      
      private var targetB:Number = 0;
      
      public var bgColorSpeed:Number = 0.5;
      
      public function Boss4SecondFormBg()
      {
         super();
         this._bg = new FlxSprite();
         this._bg.scrollFactor.x = this._bg.scrollFactor.y = 0;
         this._bg.createGraphic(FlxG.width,FlxG.height,4278190080);
         this._bg.alpha = 0;
         add(this._bg);
         this._stars = new StarInwardLayer();
         this._stars.makeStars();
         this._stars.setAlpha(0);
         add(this._stars);
         this.r = 0;
         this.g = 0;
         this.b = 0;
         this.setTargetRgb(48,0,48);
      }
      
      public function setColor(param1:uint) : void
      {
         this._bg.flashColor(param1);
      }
      
      public function setAlpha(param1:Number) : void
      {
         if(this._oldAlpha == param1)
         {
            return;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._bg.alpha = param1;
         this._stars.setAlpha(param1);
         this._oldAlpha = param1;
         var _loc2_:int = 0;
         while(_loc2_ < PlayState.doors.length)
         {
            PlayState.doors[_loc2_].alpha = 1 - param1;
            _loc2_++;
         }
      }
      
      public function fadeOut() : void
      {
         this._fadingOut = true;
         this._fade = 1;
      }
      
      public function setTargetRgb(param1:int, param2:int, param3:int) : void
      {
         this.targetR = param1;
         this.targetG = param2;
         this.targetB = param3;
      }
      
      public function setRgb(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:int = this._bg.alpha * 256;
         if(_loc4_ > 255)
         {
            _loc4_ = 255;
         }
         if(param1 > 255)
         {
            param1 = 255;
         }
         if(param2 > 255)
         {
            param2 = 255;
         }
         if(param3 > 255)
         {
            param3 = 255;
         }
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param3 < 0)
         {
            param3 = 0;
         }
         this.setColor((_loc4_ << 24) + (param1 << 16) + (param2 << 8) + param3);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(this._fadingOut)
         {
            this._fade -= FlxG.elapsed * FADE_SPEED;
            if(this._fade < 0)
            {
               this._fade = 0;
            }
            this.setAlpha(this._fade);
         }
         else if(this._fading)
         {
            this._fade += FlxG.elapsed * FADE_SPEED;
            if(this._fade >= 1)
            {
               this._fade = 1;
               this._fading = false;
            }
            this.setAlpha(this._fade);
         }
         else
         {
            this.r = Utility.integrate(this.r,this.targetR,this.bgColorSpeed,FlxG.elapsed);
            this.g = Utility.integrate(this.g,this.targetG,this.bgColorSpeed,FlxG.elapsed);
            this.b = Utility.integrate(this.b,this.targetB,this.bgColorSpeed,FlxG.elapsed);
            this.setRgb(this.r,this.g,this.b);
         }
         super.update();
      }
      
      override public function destroy() : void
      {
         this._bg = null;
         this._stars = null;
         super.destroy();
      }
   }
}

