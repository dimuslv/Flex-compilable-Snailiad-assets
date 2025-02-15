package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class SponsorSplash extends FlxSprite
   {
      private static const IMG_WIDTH:int = 200;
      
      private static const IMG_HEIGHT:int = 200;
      
      public function SponsorSplash() : void
      {
         super();
         x = FlxG.width / 2 - IMG_WIDTH / 2;
         y = FlxG.height / 2 - IMG_HEIGHT / 2;
         scrollFactor.x = 0;
         scrollFactor.y = 0;
         visible = true;
         loadGraphic(Art.SponsorSplash,false,false,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0]);
         play("normal");
      }
   }
}

