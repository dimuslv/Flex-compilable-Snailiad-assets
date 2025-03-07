package
{
   import org.flixel.*;
   
   public class SplashLayer extends FlxGroup
   {
      private static const FADE_IN_TIME:Number = 0.78;
      
      private static const STATIC_TIME:Number = 1.12;
      
      private static const FADE_OUT_TIME:Number = 0.78;
      
      private var splash:SponsorSplash;
      
      private var bg:FlxSprite;
      
      private var elapsed:Number = 0;
      
      override public function destroy() : void
      {
         splash = null;
         bg = null;
         super.destroy();
      }
      
      public function SplashLayer() : void
      {
         FlxG.mouse.show();
         FlxG.noPause = true;
         bg = new FlxSprite();
         bg.y = 0;
         bg.x = 0;
         bg.createGraphic(FlxG.width,FlxG.height,4278190080);
         bg.scrollFactor.x = bg.scrollFactor.y = 0;
         add(bg);
         splash = new SponsorSplash();
         splash.alpha = 0;
         add(splash);
      }
      
      override public function update() : void
      {
         elapsed += FlxG.elapsed;
         if(elapsed < FADE_IN_TIME)
         {
            splash.alpha = elapsed / FADE_IN_TIME;
         }
         else if(elapsed < FADE_IN_TIME + STATIC_TIME)
         {
            splash.alpha = 1;
         }
         else
         {
            if(elapsed < FADE_IN_TIME + STATIC_TIME + FADE_OUT_TIME)
            {
			   splash.alpha = 1 - (elapsed - (FADE_IN_TIME + STATIC_TIME)) / FADE_OUT_TIME;
            } else {
               bg.visible = false;
               splash.visible = false;
               FlxG.noPause = false;
               kill();
               return;
			}
         }
         super.update();
      }
   }
}

