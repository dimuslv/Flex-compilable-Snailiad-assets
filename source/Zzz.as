package
{
   import org.flixel.*;
   
   public class Zzz extends FlxSprite
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      public function Zzz() : void
      {
         loadGraphic(Art.Zzz,true,true,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0,1],2,true);
         play("normal");
         visible = false;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         x = PlayState.player.x + 12;
         y = PlayState.player.y - 8;
         super.update();
      }
   }
}

