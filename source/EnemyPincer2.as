package
{
   import org.flixel.*;
   
   public class EnemyPincer2 extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 850;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 6;
      
      private static const WEAPON_SPEED:Number = 80;
      
      private static const MOVE_TIMEOUT:Array = [0.4,0.3,0.4,0.2,0.4,0.3,0.4,0.2,0.4,0.3,0.4,0.2,0.2,0.2,0.2,0.1,0.4];
      
      private static const JUMP_HEIGHT:Array = [1,1,1,1,2,1,1,1,2,1,1,1,0.5,0.5,0.5,0.0,2.5];
      
      private static const SPEED:Number = 200;
      
      private static const SHOT_TIMEOUT:Number = 0.4;
      
      private var moveTimeoutIndex:int = 0;
      
      private var REACT_DISTANCE:int = 540;
      
      private var moveTimeout:Number = 0;
      
      private var shotTimeout:Number = 0.4;
      
      private var landed:Boolean = true;
      
      public function EnemyPincer2(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyPincer2,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         moveTimeoutIndex = int(param1 / 16 + param2 / 8) % MOVE_TIMEOUT.length;
         moveTimeout = MOVE_TIMEOUT[moveTimeoutIndex];
         addAnimation("normal",[0,1],10,true);
         play("normal");
         acceleration.y = -1200;
         drag.x = SPEED * 2;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc2_:Number = WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         if(PlayState.player && PlayState.player._insaneMode)
         {
            var _loc5_:EnemyBullet = PlayState.enemyBulletPool.getBullet(1);
            if(_loc5_)
            {
               _loc5_.shoot(x + width / 2,y + height / 2,_loc3_ * 1.3,_loc4_ * 1.3);
            }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(onScreen())
         {
            moveTimeout -= FlxG.elapsed;
            if(moveTimeout < 0 && Math.abs(PlayState.player.x - x) < REACT_DISTANCE)
            {
               ++moveTimeoutIndex;
               moveTimeoutIndex %= MOVE_TIMEOUT.length;
               moveTimeout = MOVE_TIMEOUT[moveTimeoutIndex];
               if(FlxU.random() > 0.9 && landed)
               {
                  velocity.y = 130 * JUMP_HEIGHT[moveTimeoutIndex];
                  landed = false;
               }
               if(FlxU.random() > 0.77)
               {
                  velocity.x = FlxU.random() < 0.5 ? -SPEED : SPEED;
               }
               else if(PlayState.player.x < x)
               {
                  velocity.x = -SPEED;
               }
               else
               {
                  velocity.x = SPEED;
               }
            }
            shotTimeout -= FlxG.elapsed;
            if(shotTimeout <= 0)
            {
               shotTimeout = SHOT_TIMEOUT;
               var _loc1_:Number = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
               shoot(_loc1_);
            }
         }
         if(velocity.x < 0)
         {
            facing = RIGHT;
         }
         if(velocity.x > 0)
         {
            facing = LEFT;
         }
         super.update();
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         landed = true;
         velocity.y *= -0.1;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
      }
   }
}

