package
{
   import org.flixel.*;
   
   public class HelixHud extends FlxSprite
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      public function HelixHud(param1:int, param2:int) : void
      {
         super(param1,param2);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemHelixFragment,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1,2,3,4,5,6,7],24,true);
         play("normal");
      }
   }
}

