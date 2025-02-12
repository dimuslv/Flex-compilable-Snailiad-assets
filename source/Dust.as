package
{
   import org.flixel.FlxSprite;
   
   public class Dust extends FlxSprite
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      public function Dust() : void
      {
         super();
         loadGraphic(Art.Dust,true,true,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0,1,2,3,4,5,6,7],30,true);
         play("normal");
      }
   }
}

