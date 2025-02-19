package
{
   import org.flixel.*;
   
   public class EnemyWalleye extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 400;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      private static const SHOT_TIMEOUT:Number = 0.08;
      
      private static const SHOT_SPEED:Number = 700;
      
      private var shotTimeout:Number = 0;
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      public function EnemyWalleye(param1:int, param2:int, param3:Boolean) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyWalleye,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         addAnimation("normal",[0]);
         play("normal");
         if(param3)
         {
            facing = LEFT;
         }
         else
         {
            facing = RIGHT;
         }
         solid = false;
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
      }
      
      override public function update() : void
      {
         var _loc1_:EnemyBullet = null;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         shotTimeout -= FlxG.elapsed;
         if(Math.abs(PlayState.player.y - y) < 4)
         {
            if(facing == RIGHT && PlayState.player.x > x)
            {
               if(this.shotTimeout <= 0)
               {
                  shotTimeout = SHOT_TIMEOUT;
                  _loc1_ = PlayState.enemyBulletPool.getBullet(5);
                  if(_loc1_)
                  {
                     _loc1_.shoot(x + width / 2,y + height / 2,SHOT_SPEED,0);
                  }
               }
            }
            else if(facing == LEFT && PlayState.player.x < x)
            {
               if(this.shotTimeout <= 0)
               {
                  shotTimeout = SHOT_TIMEOUT;
                  _loc1_ = PlayState.enemyBulletPool.getBullet(5);
                  if(_loc1_)
                  {
                     _loc1_.shoot(x + width / 2,y + height / 2,-SHOT_SPEED,0);
                  }
               }
            }
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

