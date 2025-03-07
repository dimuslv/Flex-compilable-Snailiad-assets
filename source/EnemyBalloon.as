package
{
   import org.flixel.*;
   
   public class EnemyBalloon extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 50;
      
      private static const DEFENSE:int = 1;
      
      private static const OFFENSE:int = 3;
      
      private static const WEAPON_SPEED:Number = 60;
      
      private static const SHOT_TIMEOUT:Number = 2.4;
      
      private static const SHOT_SPEED:Number = 1.6;
      
      private var originX:Number;
      
      private var originY:Number;
      
      private var theta:Number = 0;
      
      private var elapsed:Number = 0;
      
      private var shotTimeout:Number = 2.4;
      
      public function EnemyBalloon(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyBalloon,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         originX = param1;
         originY = param2;
         updatePosition();
         addAnimation("normal",[0]);
         play("normal");
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function updatePosition() : void
      {
         x = originX + 96 * Math.sin(theta * 1.2);
         y = originY - 24 * elapsed;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         theta += FlxG.elapsed;
         elapsed += FlxG.elapsed;
         updatePosition();
         if(onScreen())
         {
            shotTimeout -= FlxG.elapsed;
            if(shotTimeout <= 0)
            {
               shotTimeout = SHOT_TIMEOUT;
               var _loc1_:Number = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
               shoot(_loc1_);
            }
         }
         super.update();
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc2_:Number = WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         var _loc5_:EnemyBullet = PlayState.enemyBulletPool.getBullet(4);
         if(_loc5_)
         {
            _loc5_.shoot(x + width / 2,y + height - 2,_loc3_ * SHOT_SPEED,_loc4_ * SHOT_SPEED);
         }
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
      }
   }
}

