package
{
   import org.flixel.FlxG;
   
   public class PlayerBullet1 extends PlayerBullet
   {
      private static const WIDTH:int = 4;
      
      private static const HEIGHT:int = 4;
      
      private static const FIREPOWER:int = 10;
      
      public function PlayerBullet1() : void
      {
         super(FIREPOWER);
         loadGraphic(Art.PlayerBullet1,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         addAnimation("normal",[0]);
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int) : void
      {
         super.shoot(param1,param2,param3,param4);
         Sfx.playShot1();
         play("normal");
      }
      
      override public function hitEnemy(param1:Enemy) : void
      {
         super.hitEnemy(param1);
         if(!(param1 is Bubble || param1 is EnemyBabyfish || param1 is EnemyBabyfish2))
         {
            this.kill();
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(!onScreen())
         {
            super.kill();
         }
         if(x > FlxG.MaxX || x + width < FlxG.MinX || y > FlxG.MaxY || y + height < FlxG.MinY)
         {
            this.kill();
         }
      }
      
      override public function kill() : void
      {
         if(onScreen() && !dead)
         {
            Sfx.playShotHit();
            PlayState.explosionPool.boom(x,y,3,8);
         }
         super.kill();
      }
   }
}

