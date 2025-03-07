package
{
   import org.flixel.*;
   
   public class EnemyCannon extends Enemy
   {
      private static const IMG_WIDTH:int = 48;
      
      private static const IMG_HEIGHT:int = 48;
      
      private static const IMG_OFS_X:int = -24;
      
      private static const IMG_OFS_Y:int = -24;
      
      private static const MAX_HP:int = 2000;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      private static const AIM_TIMEOUT:Number = 0.25;
      
      private static const SHOT_TIMEOUT:Number = 4;
      
      private static const SHOT_SPEED:Number = 140;
      
      private var dx:int;
      
      private var dy:int;
      
      private var aimTimeout:Number;
      
      private var shotTimeout:Number;
      
      private var velx:Number;
      
      private var vely:Number;
      
      public function EnemyCannon(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyCannon,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         var _loc3_:Array = ["left","left_up","up","right_up","right","right_down","down","left_down"];
         var _loc4_:int = 0;
         while(_loc4_ < 8)
         {
            addAnimation(_loc3_[_loc4_],[_loc4_]);
            _loc4_++;
         }
         play(_loc3_[0]);
         aimTimeout = x / 38.2 % 0.25;
         shotTimeout = SHOT_TIMEOUT + x / 96 % 6;
      }
      
      public function aimCannon() : void
      {
         var _loc1_:Number = Math.atan2(PlayState.player.y - y,PlayState.player.x - x);
         _loc1_ = int((_loc1_ + Math.PI / 8) * 4 / Math.PI) / 4 * Math.PI;
         velx = Math.cos(_loc1_) * SHOT_SPEED;
         vely = Math.sin(_loc1_) * SHOT_SPEED;
         if(velx < -0.1)
         {
            if(vely < -0.1)
            {
               play("left_up");
            }
            else if(vely > 0.1)
            {
               play("left_down");
            }
            else
            {
               play("left");
            }
         }
         else if(velx > 0.1)
         {
            if(vely < -0.1)
            {
               play("right_up");
            }
            else if(vely > 0.1)
            {
               play("right_down");
            }
            else
            {
               play("right");
            }
         }
         else if(vely < -0.1)
         {
            play("up");
         }
         else if(vely > 0.1)
         {
            play("down");
         }
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function shoot(param1:int, param2:int) : void
      {
         var _loc3_:EnemyBullet = PlayState.enemyBulletPool.getBullet(3);
         if(_loc3_)
         {
            _loc3_.shoot(x + width / 2,y + height / 2,param1,param2);
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         aimTimeout -= FlxG.elapsed;
         if(aimTimeout < 0)
         {
            aimTimeout = AIM_TIMEOUT;
            aimCannon();
         }
         if(onScreen())
         {
            shotTimeout -= FlxG.elapsed * 0.6;
            if(shotTimeout < 0)
            {
               shotTimeout = SHOT_TIMEOUT;
               shoot(velx,vely);
            }
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
      }
   }
}

