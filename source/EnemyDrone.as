package
{
   import org.flixel.*;
   
   public class EnemyDrone extends Enemy
   {
      private static const IMG_WIDTH:int = 24;
      
      private static const IMG_HEIGHT:int = 29;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 1850;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 4;
      
      private static const MODE_WAIT:int = 0;
      
      private static const MODE_COS_UP_LEFT:int = 1;
      
      private static const MODE_COS_DOWN_LEFT:int = 2;
      
      private static const MODE_COS_UP_RIGHT:int = 3;
      
      private static const MODE_COS_DOWN_RIGHT:int = 4;
      
      private static const MODE_SEMICIRCLE_LEFT_UP:int = 5;
      
      private static const MODE_SEMICIRCLE_LEFT_DOWN:int = 6;
      
      private static const MODE_SEMICIRCLE_RIGHT_UP:int = 7;
      
      private static const MODE_SEMICIRCLE_RIGHT_DOWN:int = 8;
      
      private static const MODE_ATTACK:int = 9;
      
      private static const SHOT_TIMEOUT:Number = 0.08;
      
      private static const SHOT_SPEED:Number = 700;
      
      private static const SHOT_NUM:int = 4;
      
      private var mode:int = 0;
      
      private var originX:Number;
      
      private var originY:Number;
      
      private var theta:Number = 0;
      
      private var elapsed:Number = 0;
      
      private var X_RADIUS:Number = 130;
      
      private var Y_RADIUS:Number = 40;
      
      private var MOVE_TIME:Number = 2.2;
      
      private var shotTimeout:Number = 0;
      
      private var shotNum:int = 0;
      
      public function EnemyDrone(param1:int, param2:int) : void
      {
         if(PlayState.player && PlayState.player._insaneMode)
         {
            MOVE_TIME = 1.3;
            X_RADIUS = 110;
            Y_RADIUS = 60;
         }
         else if(PlayState.player && PlayState.player._hardMode)
         {
            MOVE_TIME = 1.6;
            X_RADIUS = 100;
            Y_RADIUS = 50;
         }
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.EnemyDrone,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         originX = param1;
         originY = param2;
         elapsed = MOVE_TIME;
         addAnimation("normal",[0,1],18,true);
         play("normal");
         active = true;
         visible = true;
      }
      
      private function normalizedSigmoid(param1:Number) : Number
      {
         return 1 / (1 + Math.exp(-(param1 * 12 - 6)));
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function updatePosition() : void
      {
         if(mode == MODE_WAIT || mode == MODE_ATTACK)
         {
            return;
         }
         var _loc1_:Number = normalizedSigmoid(elapsed / MOVE_TIME);
         switch(mode)
         {
            case MODE_COS_UP_LEFT:
               x = originX - X_RADIUS * _loc1_;
               y = originY - Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_COS_DOWN_LEFT:
               x = originX - X_RADIUS * _loc1_;
               y = originY + Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_COS_UP_RIGHT:
               x = originX + X_RADIUS * _loc1_;
               y = originY - Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_COS_DOWN_RIGHT:
               x = originX + X_RADIUS * _loc1_;
               y = originY + Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_SEMICIRCLE_LEFT_UP:
               x = originX - Y_RADIUS * Math.sin(_loc1_ * Math.PI);
               y = originY - Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_SEMICIRCLE_LEFT_DOWN:
               x = originX - Y_RADIUS * Math.sin(_loc1_ * Math.PI);
               y = originY + Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_SEMICIRCLE_RIGHT_UP:
               x = originX + Y_RADIUS * Math.sin(_loc1_ * Math.PI);
               y = originY - Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_SEMICIRCLE_RIGHT_DOWN:
               x = originX + Y_RADIUS * Math.sin(_loc1_ * Math.PI);
               y = originY + Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
			   break;
         }
      }
      
      public function shoot() : void
      {
         var _loc1_:EnemyBullet = null;
         if(facing == RIGHT)
         {
            _loc1_ = PlayState.enemyBulletPool.getBullet(5);
            if(_loc1_)
            {
               _loc1_.shoot(x + width / 2,y + height / 2,SHOT_SPEED,0);
            }
         }
         else
         {
            _loc1_ = PlayState.enemyBulletPool.getBullet(5);
            if(_loc1_)
            {
               _loc1_.shoot(x + width / 2,y + height / 2,-SHOT_SPEED,0);
            }
         }
      }
      
      public function shootDonuts() : void
      {
         var _loc1_:int = 3;
         Sfx.playShot7();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            var _loc3_:EnemyBulletRotaryPea = PlayState.enemyBulletPool.getBullet(7) as EnemyBulletRotaryPea;
            if(_loc3_)
            {
               _loc3_.shootRotary(x + width / 2,y + height / 2,60,4,Math.PI * 2 / _loc1_ * _loc2_);
            }
            _loc2_++;
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
            if(PlayState.player.x < x)
            {
               facing = LEFT;
            }
            else
            {
               facing = RIGHT;
            }
            if(mode == MODE_ATTACK)
            {
               shotTimeout -= FlxG.elapsed;
               if(shotTimeout <= 0)
               {
                  shotTimeout = SHOT_TIMEOUT;
                  --shotNum;
                  if(shotNum <= 0)
                  {
                     mode = MODE_WAIT;
                     shootDonuts();
                  }
                  shoot();
               }
               elapsed += FlxG.elapsed;
            }
            else
            {
               elapsed += FlxG.elapsed;
               updatePosition();
               if(elapsed >= MOVE_TIME && mode != MODE_WAIT)
               {
                  mode = MODE_ATTACK;
                  shotNum = SHOT_NUM;
               }
               else if(mode == MODE_WAIT)
               {
                  elapsed = 0;
                  originX = x;
                  originY = y;
                  if(PlayState.player.x < x)
                  {
                     if(facing == LEFT)
                     {
                        if(PlayState.player.y < y)
                        {
                           mode = MODE_COS_UP_LEFT;
                        }
                        else
                        {
                           mode = MODE_COS_DOWN_LEFT;
                        }
                     }
                     else if(PlayState.player.y < y)
                     {
                        mode = MODE_SEMICIRCLE_RIGHT_UP;
                     }
                     else
                     {
                        mode = MODE_SEMICIRCLE_RIGHT_DOWN;
                     }
                  }
                  else if(facing == RIGHT)
                  {
                     if(PlayState.player.y < y)
                     {
                        mode = MODE_COS_UP_RIGHT;
                     }
                     else
                     {
                        mode = MODE_COS_DOWN_RIGHT;
                     }
                  }
                  else if(PlayState.player.y < y)
                  {
                     mode = MODE_SEMICIRCLE_LEFT_UP;
                  }
                  else
                  {
                     mode = MODE_SEMICIRCLE_LEFT_DOWN;
                  }
               }
            }
         }
         super.update();
      }
   }
}

