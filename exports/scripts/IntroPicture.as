package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class IntroPicture extends FlxSprite
   {
      private static const IMG_WIDTH:int = 400;
      
      private static const IMG_HEIGHT:int = 138;
      
      private static const X_POS:int = 0;
      
      private static const Y_POS:int = 11;
      
      private static const FADE_SPEED:Number = 0.5;
      
      private var _fadingIn:Boolean = false;
      
      private var _fadingOut:Boolean = false;
      
      public function IntroPicture(param1:int)
      {
         super();
         x = X_POS;
         y = Y_POS;
         if(param1 == 5 && PlayState.introSlugMode)
         {
            param1 = 6;
         }
         switch(param1)
         {
            case 1:
               loadGraphic(Art.IntroPicture1,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 2:
               loadGraphic(Art.IntroPicture2,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 3:
               loadGraphic(Art.IntroPicture3,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 4:
               loadGraphic(Art.IntroPicture4,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 5:
               loadGraphic(Art.IntroPicture5,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 6:
               loadGraphic(Art.IntroPicture5Slug,false,false,IMG_WIDTH,IMG_HEIGHT);
         }
         addAnimation("normal",[0]);
         scrollFactor.x = scrollFactor.y = 0;
         play("normal");
         alpha = 0;
         this.fadeIn();
      }
      
      public function fadeOut() : void
      {
         this._fadingOut = true;
         alpha = 1;
      }
      
      public function fadeIn() : void
      {
         this._fadingIn = true;
         alpha = 0;
      }
      
      override public function update() : void
      {
         if(this._fadingOut)
         {
            alpha -= FlxG.elapsed * FADE_SPEED;
            if(alpha < 0)
            {
               alpha = 0;
               this._fadingOut = false;
            }
         }
         else if(this._fadingIn)
         {
            alpha += FlxG.elapsed * FADE_SPEED;
            if(alpha >= 1)
            {
               alpha = 1;
               this._fadingIn = false;
            }
         }
         super.update();
      }
   }
}

