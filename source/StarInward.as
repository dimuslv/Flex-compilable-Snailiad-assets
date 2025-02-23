package
{
   import org.flixel.*;
   
   public class StarInward extends FlxSprite
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      public function StarInward() : void
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
         switch(int(FlxU.random() * 4))
         {
            case 0:
               x = FlxU.random() * FlxG.width;
               y = -height;
               break;
            case 1:
               x = FlxU.random() * FlxG.width;
               y = FlxG.height;
               break;
            case 2:
               x = -width;
               y = FlxU.random() * FlxG.height;
               break;
            case 3:
               x = FlxG.width;
               y = FlxU.random() * FlxG.height;
			   break;
         }
         var _loc1_:int = FlxG.width / 2;
         var _loc2_:int = FlxG.height / 2;
         var _loc3_:Number = Math.atan2(_loc2_ - y,_loc1_ - x);
         var _loc4_:Number = FlxU.random() * 120 + 60;
         velocity.x = _loc4_ * Math.cos(_loc3_);
         velocity.y = _loc4_ * Math.sin(_loc3_);
      }
      
      override public function update() : void
      {
         if(velocity.x < 0 && x < FlxG.width / 2 + width / 2)
         {
            this.placeRandom();
         }
         if(velocity.x > 0 && x > FlxG.width / 2 - width / 2)
         {
            this.placeRandom();
         }
         super.update();
      }
   }
}

