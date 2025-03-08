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
         for (var i:int = 0; i < 6; i++)
         {
            for (var j:int = 0; j < 6; j++)
            {
               _spirals.push(new IntroSpiral(82 * j + i % 2 * 41,56 * i));
            }
         }
         for (var k:int = 0; k < _spirals.length; k++)
         {
            _spirals[k].alpha = _bg.alpha / 7;
            add(_spirals[k]);
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
         for (var i:int = 0; i < _spirals.length; i++)
         {
            _spirals[i].alpha = _bg.alpha / 7;
         }
         super.update();
      }
   }
}

