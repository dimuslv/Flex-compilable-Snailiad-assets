package
{
   import org.flixel.*;
   
   public class PowerNom extends FlxSprite
   {
      private static const IMG_WIDTH:int = 15;
      
      private static const IMG_HEIGHT:int = 4;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const DISAPPEAR_TIME:Number = 0.7;
      
      private var disappearTimer:Number;
      
      public function PowerNom(param1:int, param2:int) : void
      {
         x = param1;
         y = param2;
         solid = false;
         velocity.y = -20;
         disappearTimer = DISAPPEAR_TIME;
         loadGraphic(Art.Nom,true,true,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0,1,2,3],5,true);
         Sfx.playPickup4();
         play("normal");
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         disappearTimer -= FlxG.elapsed;
         if(disappearTimer <= 0)
         {
            kill();
         }
         super.update();
      }
   }
}

