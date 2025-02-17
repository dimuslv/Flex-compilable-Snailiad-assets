package
{
   import flash.utils.*;
   import org.flixel.*;
   
   public class AreaName extends FlxText
   {
      private static const FADEIN_END:int = 700;
      
      private static const FADEOUT_START:int = 3300;
      
      private static const FADEOUT_END:int = 4000;
	  
	  private static var _fadeInStart:int;
      
      private static var _fadeInEnd:int;
      
      private static var _fadeOutStart:int;
      
      private static var _fadeOutEnd:int;
      
      public function AreaName() : void
      {
         super(0,FlxG.height / 2 - 20,FlxG.width);
         font = Fonts.normal;
         size = 20;
         color = 16777215;
         shadow = 1;
         alignment = "center";
         scrollFactor.x = scrollFactor.y = 0;
         setShadowDistance(1);
      }
      
      public function setArea(param1:String) : void
      {
         _fadeInStart = getTimer();
         _fadeInEnd = _fadeInStart + FADEIN_END;
         _fadeOutStart = _fadeInStart + FADEOUT_START;
         _fadeOutEnd = _fadeInStart + FADEOUT_END;
         text = param1;
         alpha = 0.0;
         active = true;
      }
      
      public function increaseTimer(param1:Number) : void
      {
         _fadeOutStart += param1 * 1000;
         _fadeOutEnd += param1 * 1000;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         var _loc1_:int = getTimer();
         if(_loc1_ > _fadeOutEnd)
         {
            text = "";
            active = false;
         }
         else if(_loc1_ > _fadeOutStart)
         {
            alpha = 1 - (_loc1_ - _fadeOutStart) / (_fadeOutEnd - _fadeOutStart);
         }
         else if(_loc1_ > _fadeInEnd)
         {
            alpha = 1;
         }
         else
         {
            alpha = (_loc1_ - _fadeInStart) / (_fadeInEnd - _fadeInStart);
         }
         super.update();
      }
   }
}

