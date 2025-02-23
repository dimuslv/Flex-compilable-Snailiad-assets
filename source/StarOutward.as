package
{
   import org.flixel.*;
   
   public class StarOutward extends FlxSprite
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      public function StarOutward() : void
      {
         loadGraphic(Art.Star,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[(int)(FlxU.random() * 32)]);
         play("normal");
         scrollFactor.x = scrollFactor.y = 0;
         this.placeRandom();
      }
      
      public function placeRandom() : void
      {
         x = FlxG.width / 2 - width / 2;
         y = FlxG.height / 2 - height / 2;
         var _loc1_:Number = FlxU.random() * Math.PI * 2;
         var _loc2_:Number = FlxU.random() * 120 + 60;
         velocity.x = _loc2_ * Math.cos(_loc1_);
         velocity.y = _loc2_ * Math.sin(_loc1_);
         x += width / 2 * Math.cos(_loc1_);
         y += height / 2 * Math.sin(_loc1_);
      }
      
      override public function update() : void
      {
         if(x < -width)
         {
            this.placeRandom();
         }
         if(y < -height)
         {
            this.placeRandom();
         }
         if(x > FlxG.width)
         {
            this.placeRandom();
         }
         if(y > FlxG.height)
         {
            this.placeRandom();
         }
         super.update();
      }
   }
}

