package
{
   import org.flixel.*;
   
   public class Snow extends FlxSprite
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private var elapsed:Number = 0;
      
      private var speed:Number = 0;
      
      private var oldScrollX:Number = 0;
      
      private var oldScrollY:Number = 0;
      
      public function Snow() : void
      {
         oldScrollX = FlxG.scroll.x;
         oldScrollY = FlxG.scroll.y;
         loadGraphic(Art.Snow,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[(int)(FlxU.random() * 32)]);
         play("normal");
         x = FlxU.random() * FlxG.width;
         y = FlxU.random() * FlxG.height;
         scrollFactor.x = scrollFactor.y = 0;
         velocity.y = 30 + FlxU.random() * 60;
         elapsed = FlxU.random() * Math.PI * 2;
         speed = 40;
      }
      
      override public function update() : void
      {
         x += FlxG.scroll.x - oldScrollX;
         y += FlxG.scroll.y - oldScrollY;
         oldScrollX = FlxG.scroll.x;
         oldScrollY = FlxG.scroll.y;
         elapsed += FlxG.elapsed;
         if(x > FlxG.width)
         {
            x = -width;
         }
         else if(x < -width)
         {
            x += FlxG.width;
         }
         if(y > FlxG.height)
         {
            y = -height;
         }
         else if(y < -height)
         {
            y += FlxG.height;
         }
         velocity.x = (Math.sin(elapsed * 4) - 1) * speed;
         super.update();
      }
   }
}

