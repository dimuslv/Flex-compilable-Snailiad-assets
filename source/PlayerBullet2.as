package
{
   import org.flixel.*;
   
   public class PlayerBullet2 extends PlayerBullet
   {
      private static const WIDTH:int = 16;
      
      private static const HEIGHT:int = 16;
      
      private static const FIREPOWER:int = 20;
      
      public function PlayerBullet2() : void
      {
         super(FIREPOWER);
         loadGraphic(Art.PlayerBullet2,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         addAnimation("normal",[0,1,2,3,4,5,6,7],22,true);
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int) : void
      {
         super.shoot(param1,param2,param3,param4);
         acceleration.x = param3 * -1.5;
         acceleration.y = param4 * -1.5;
         Sfx.playShot2();
         play("normal");
      }
      
      override public function hitEnemy(param1:Enemy) : void
      {
         if(!onScreen())
         {
            return;
         }
         super.hitEnemy(param1);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(x > FlxG.MaxX + 250 || x + width < FlxG.MinX - 250 || y > FlxG.MaxY + 250 || y + height < FlxG.MinY - 250)
         {
            kill();
         }
      }
   }
}

