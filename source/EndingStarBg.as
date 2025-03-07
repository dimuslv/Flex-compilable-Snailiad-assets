package
{
   import org.flixel.*;
   
   public class EndingStarBg extends FlxGroup
   {
      private static const FADE_SPEED:Number = 0.25;
      
      private var _bg:FlxSprite;
      
      private var _stars:StarOutwardLayer;
      
      private var _oldAlpha:Number = 0;
      
      private var _fade:Number = 0;
      
      private var _fading:Boolean = false;
      
      private var _fadingOut:Boolean = false;
      
      private var a:Number = 0;
      
      private var r:Number = 0;
      
      private var g:Number = 0;
      
      private var b:Number = 0;
      
      private var targetR:Number = 0;
      
      private var targetG:Number = 0;
      
      private var targetB:Number = 0;
      
      public var bgColorSpeed:Number = 0.5;
      
      private var targetA:Number = 0;
      
      public function EndingStarBg() : void
      {
         _bg = new FlxSprite();
         _bg.scrollFactor.x = _bg.scrollFactor.y = 0;
         _bg.createGraphic(FlxG.width,FlxG.height,4278190080);
         _bg.alpha = 1;
         add(_bg);
         r = 0;
         g = 0;
         b = 0;
         setTargetRgb(0,0,0);
         _stars = new StarOutwardLayer();
         _stars.makeStars();
         _stars.setAlpha(0);
         add(_stars);
      }
      
      public function fadeIn() : void
      {
         _fading = true;
         _fade = 0.0;
      }
      
      public function setColor(param1:uint) : void
      {
         _bg.flashColor(param1);
      }
      
      public function setAlpha(param1:Number) : void
      {
         if(_oldAlpha == param1)
         {
            return;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0.0)
         {
            param1 = 0.0;
         }
         if(_stars)
         {
            _stars.setAlpha(param1);
         }
         _oldAlpha = param1;
      }
      
      public function fadeOut() : void
      {
         _fadingOut = true;
         _fade = 1;
      }
      
      public function setTargetRgb(param1:int, param2:int, param3:int) : void
      {
         targetR = param1;
         targetG = param2;
         targetB = param3;
      }
      
      public function setRgb(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:int = _bg.alpha * 256;
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
         setColor((_loc4_ << 24) + (param1 << 16) + (param2 << 8) + param3);
      }
      
      override public function update() : void
      {
         if(_fadingOut)
         {
            _fade -= FlxG.elapsed * FADE_SPEED;
            if(_fade < 0)
            {
               _fade = 0;
            }
            setAlpha(_fade);
         }
         else if(_fading)
         {
            _fade += FlxG.elapsed * FADE_SPEED;
            if(_fade >= 1)
            {
               _fade = 1;
               _fading = false;
            }
            setAlpha(_fade);
         }
         else
         {
            r = Utility.integrate(r,targetR,bgColorSpeed,FlxG.elapsed);
            g = Utility.integrate(g,targetG,bgColorSpeed,FlxG.elapsed);
            b = Utility.integrate(b,targetB,bgColorSpeed,FlxG.elapsed);
            setRgb(r,g,b);
         }
         super.update();
      }
      
      override public function destroy() : void
      {
         _bg = null;
         _stars = null;
         super.destroy();
      }
   }
}

