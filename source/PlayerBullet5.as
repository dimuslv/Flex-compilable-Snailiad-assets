package
{
   import org.flixel.*;
   
   public class PlayerBullet5 extends PlayerBullet
   {
      private static const WIDTH:int = 24;
      
      private static const HEIGHT:int = 24;
      
      private static const FIREPOWER:int = 50;
      
      public function PlayerBullet5() : void
      {
         super(FIREPOWER);
         loadGraphic(Art.PlayerBullet5,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         addAnimation("normal",[0,1,2,3,4,5,6,7],45,true);
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int) : void
      {
         super.shoot(param1,param2,param3,param4);
         acceleration.x = param3 * -1.5;
         acceleration.y = param4 * -1.5;
         Sfx.playShot2b();
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

