package
{
   import org.flixel.*;
   
   public class Star extends FlxSprite
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      public function Star() : void
      {
         super();
         loadGraphic(Art.Star,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[(int)(FlxU.random() * 32)]);
         play("normal");
         x = FlxU.random() * FlxG.width;
         y = FlxU.random() * FlxG.height;
         scrollFactor.x = scrollFactor.y = 0;
         velocity.x = -FlxU.random() * 100 - 10;
      }
      
      override public function update() : void
      {
         if(x < -width)
         {
            x += FlxG.width + width * 2;
         }
         super.update();
      }
   }
}

