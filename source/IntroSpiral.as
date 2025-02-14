package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class IntroSpiral extends FlxSprite
   {
      private static const IMG_WIDTH:int = 48;
      
      private static const IMG_HEIGHT:int = 48;
      
      private static var spiralNum:int = 0;
      
      public function IntroSpiral(param1:int, param2:int) : void
      {
         super(param1,param2);
         loadGraphic(Art.IntroSpiral,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         ++spiralNum;
         if(spiralNum == 4)
         {
            spiralNum = 0;
         }
         addAnimation("normal",[(3 + spiralNum) % 4],2.3,true);
         play("normal");
         active = true;
         scrollFactor.x = scrollFactor.y = 0;
         velocity.x = -34;
         velocity.y = -34;
      }
      
      override public function update() : void
      {
         if(y < -height)
         {
            y += FlxG.height + height * 2;
         }
         if(x < -width)
         {
            x += FlxG.width + width * 2;
         }
         super.update();
      }
   }
}

