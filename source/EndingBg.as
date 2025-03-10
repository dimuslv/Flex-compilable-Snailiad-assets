package
{
   import org.flixel.*;
   
   public class EndingBg extends FlxSprite
   {
      private static const IMG_WIDTH:int = 600;
      
      private static const IMG_HEIGHT:int = 240;
      
      public function EndingBg() : void
      {
         x = 0;
         y = 0;
         offset.x = 100;
         loadGraphic(Art.EndingBg,false,false,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0]);
         scrollFactor.x = scrollFactor.y = 0;
         play("normal");
      }
   }
}

