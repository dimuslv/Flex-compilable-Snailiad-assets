package
{
   import org.flixel.*;
   
   public class EnemyBulletSpikeBall2 extends EnemyBullet
   {
      private static const WIDTH:int = 27;
      
      private static const HEIGHT:int = 28;
      
      private static const FIREPOWER:int = 4;
      
      private static const DEFAULT_LIFETIME:Number = 2.1;
      
      public function EnemyBulletSpikeBall2() : void
      {
         super(FIREPOWER);
         loadGraphic(Art.EnemyBulletSpikeBall,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         addAnimation("normal",[0]);
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int, param5:Number = 2.1) : void
      {
         super.shoot(param1,param2,param3,param4,param5);
         Sfx.playCannon2();
         play("normal");
      }
      
      override public function hitPlayer(param1:Player) : void
      {
         super.hitPlayer(param1);
      }
      
      override public function collideTerrain() : Boolean
      {
         return true;
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
         if(x > FlxG.MaxX + 250 || x + width < FlxG.MinX - 250 || y > FlxG.MaxY + 250 || y + height < FlxG.MinY - 250)
         {
            kill();
         }
      }
   }
}

