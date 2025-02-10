package
{
   import org.flixel.FlxSprite;
   
   public class HeartHudSingle extends FlxSprite
   {
      private static const IMG_WIDTH:int = 8;
      
      private static const IMG_HEIGHT:int = 8;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      public function HeartHudSingle(param1:int, param2:int)
      {
         super();
         x = param1;
         y = param2;
         loadGraphic(Art.HeartHudSingle,true,true,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("empty",[0]);
         addAnimation("0",[0]);
         addAnimation("1",[1]);
         addAnimation("2",[2]);
         addAnimation("3",[3]);
         addAnimation("full",[4]);
         scrollFactor.x = scrollFactor.y = 0;
         play("full");
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
      }
   }
}

