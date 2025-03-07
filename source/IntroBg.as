package
{
   import org.flixel.*;
   
   public class IntroBg extends FlxGroup
   {
      private static const FADE_SPEED:Number = 0.8;
      
      private var _bg:FlxSprite;
      
      private var _fade:Number = 0;
      
      private var _fadingIn:Boolean = false;
      
      private var _fadingOut:Boolean = false;
      
      private var _spirals:Array;
      
      override public function destroy() : void
      {
         _bg = null;
         _spirals = null;
         super.destroy();
      }
      
      public function IntroBg() : void
      {
         _bg = new FlxSprite();
         _bg.scrollFactor.x = _bg.scrollFactor.y = 0;
         _bg.createGraphic(FlxG.width,FlxG.height,4278202416);
         _bg.alpha = 0;
         add(_bg);
         fadeIn();
         _spirals = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            var _loc3_:int = 0;
            while(_loc3_ < 6)
            {
               _spirals.push(new IntroSpiral(82 * _loc3_ + _loc1_ % 2 * 41,56 * _loc1_));
               _loc3_++;
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _spirals.length)
         {
            _spirals[_loc2_].alpha = _bg.alpha / 7;
            add(_spirals[_loc2_]);
            _loc2_++;
         }
      }
      
      public function isFadingIn() : Boolean
      {
         return _fadingIn;
      }
      
      public function fadeIn() : void
      {
         _fadingIn = true;
         _fade = 0.0;
      }
      
      public function fadeOut() : void
      {
         _fadingOut = true;
         _fade = 1;
      }
      
      override public function update() : void
      {
         if(_fadingOut)
         {
            _fade -= FlxG.elapsed * FADE_SPEED;
            if(_fade < 0)
            {
               _fade = 0;
               _fadingOut = false;
            }
            _bg.alpha = _fade;
         }
         else if(_fadingIn)
         {
            _fade += FlxG.elapsed * FADE_SPEED;
            if(_fade >= 1)
            {
               _fade = 1;
               _fadingIn = false;
            }
            _bg.alpha = _fade;
         }
         var _loc1_:int = 0;
         while(_loc1_ < _spirals.length)
         {
            _spirals[_loc1_].alpha = _bg.alpha / 7;
            _loc1_++;
         }
         super.update();
      }
   }
}

