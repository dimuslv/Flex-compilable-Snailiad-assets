package
{
   import org.flixel.*;
   
   public class EndingPicture extends FlxSprite
   {
      private static const IMG_WIDTH:int = 400;
      
      private static const IMG_HEIGHT:int = 240;
      
      public function EndingPicture(param1:int) : void
      {
         super();
         x = 0;
         y = 0;
         switch(param1)
         {
            case 1:
               loadGraphic(Art.EndingPicture1,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 2:
               loadGraphic(Art.EndingPicture2,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 3:
               loadGraphic(Art.EndingPicture3,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 4:
               loadGraphic(Art.EndingPicture4,false,false,IMG_WIDTH,IMG_HEIGHT);
               break;
            case 5:
               loadGraphic(Art.EndingPicture5,false,false,IMG_WIDTH,IMG_HEIGHT);
			   break;
         }
         addAnimation("normal",[0]);
         scrollFactor.x = scrollFactor.y = 0;
         play("normal");
      }
   }
}

