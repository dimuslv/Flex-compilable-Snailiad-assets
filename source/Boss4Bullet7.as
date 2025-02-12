package
{
   import org.flixel.FlxG;
   
   public class Boss4Bullet7 extends Boss4Bullet
   {
      private static const DEFAULT_LIFETIME:Number = 2;
      
      private static const WIDTH:int = 35;
      
      private static const HEIGHT:int = 96;
      
      private static const FIREPOWER:int = 12;
      
      public function Boss4Bullet7() : void
      {
         super(PlayState.bossRush ? FIREPOWER / 6 : FIREPOWER);
         loadGraphic(Art.Boss4Bullet7,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         addAnimation("normal",[0,1,2,3],30,true);
         play("normal");
      }
      
      override public function hitPlayerBullet(param1:PlayerBullet) : void
      {
         if(param1.velocity.x != 0)
         {
            param1.kill();
         }
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int, param5:Number = 2.0) : void
      {
         super.shoot(param1,param2,param3,param4,param5);
         acceleration.x = param3 * 18;
         acceleration.y = param4 * 18;
         Sfx.playGigaWave();
         if(param3 < 0)
         {
            facing = LEFT;
         }
         else
         {
            facing = RIGHT;
         }
      }
      
      override public function hitPlayer(param1:Player) : void
      {
         super.hitPlayer(param1);
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
            kill();
         }
      }
   }
}

