package
{
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   
   public class SplashLayer extends FlxGroup
   {
      private static const FADE_IN_TIME:Number = 0.78;
      
      private static const STATIC_TIME:Number = 1.12;
      
      private static const FADE_OUT_TIME:Number = 0.78;
      
      private var splash:SponsorSplash;
      
      private var bg:FlxSprite;
      
      private var elapsed:Number = 0;
      
      public function SplashLayer()
      {
         super();
         FlxG.mouse.show();
         FlxG.noPause = true;
         this.bg = new FlxSprite();
         this.bg.y = 0;
         this.bg.x = 0;
         this.bg.createGraphic(FlxG.width,FlxG.height,4278190080);
         this.bg.scrollFactor.x = this.bg.scrollFactor.y = 0;
         add(this.bg);
         this.splash = new SponsorSplash();
         this.splash.alpha = 0;
         add(this.splash);
      }
      
      override public function destroy() : void
      {
         this.splash = null;
         this.bg = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         this.elapsed += FlxG.elapsed;
         if(this.elapsed < FADE_IN_TIME)
         {
            this.splash.alpha = this.elapsed / FADE_IN_TIME;
         }
         else if(this.elapsed < FADE_IN_TIME + STATIC_TIME)
         {
            this.splash.alpha = 1;
         }
         else
         {
            if(this.elapsed >= FADE_IN_TIME + STATIC_TIME + FADE_OUT_TIME)
            {
               this.bg.visible = false;
               this.splash.visible = false;
               FlxG.noPause = false;
               kill();
               return;
            }
            this.splash.alpha = 1 - (this.elapsed - (FADE_IN_TIME + STATIC_TIME)) / FADE_OUT_TIME;
         }
         super.update();
      }
   }
}

