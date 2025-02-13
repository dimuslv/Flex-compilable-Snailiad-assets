package
{
   import org.flixel.*;
   
   public class EnemyKitty2 extends Enemy
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 900;
      
      private static const DEFENSE:int = 1;
      
      private static const OFFENSE:int = 2;
      
      private static const MAX_SHOTS:int = 10;
      
      private static const SHOT_TIMEOUT:Number = 0.08;
      
      private static const HOP_TIMEOUTS:Array = [0.7,0.8,0.6,0.7,0.8,0.6,0.7,0.8,0.6];
      
      private static const HOP_HEIGHT:Array = [1,1,1,1.2,1.3,1,1.2,1,0.9];
      
      private static const WEAPON_SPEED:Number = 80;
      
      private var hopNum:int = 0;
      
      private var hopTimeout:Number = 0;
      
      private var nextAttack:int = 2;
      
      private var attacking:Boolean = false;
      
      private var goingUp:Boolean = true;
      
      private var shots:int = -1;
      
      private var shotTimeout:Number;
      
      public function EnemyKitty2(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyKitty2,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.hopNum = param1 % HOP_TIMEOUTS.length;
         this.hopTimeout = HOP_TIMEOUTS[this.hopNum];
         addAnimation("normal",[0]);
         addAnimation("up",[1]);
         addAnimation("down",[2]);
         acceleration.y = 1200;
         if(x > PlayState.player.x)
         {
            facing = RIGHT;
         }
         else
         {
            facing = LEFT;
         }
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function shoot(param1:Number) : void
      {
         if(facing == RIGHT)
         {
            param1 = Math.PI - param1;
         }
         var _loc2_:Number = WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         var _loc5_:EnemyBullet = PlayState.enemyBulletPool.getBullet(1);
         if(_loc5_)
         {
            _loc5_.shoot(x + width / 2,y + height / 2,_loc3_,_loc4_);
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
            shotTimeout -= FlxG.elapsed;
            if(this.attacking && this.shotTimeout < 0 && this.shots >= 0)
            {
               --this.shots;
               shotTimeout = SHOT_TIMEOUT;
               this.shoot(Math.PI - Math.PI * 0.6 * this.shots / MAX_SHOTS);
            }
            if(this.shots <= 0)
            {
               hopTimeout -= FlxG.elapsed;
               if(this.hopTimeout < 0)
               {
                  if(!this.attacking && this.nextAttack == 0)
                  {
                     attacking = true;
                     shots = MAX_SHOTS;
                     shotTimeout = SHOT_TIMEOUT;
                     nextAttack = 3;
                  }
                  else
                  {
                     --this.nextAttack;
                     attacking = false;
                     if(x > PlayState.player.x)
                     {
                        velocity.x = -120;
                        velocity.y = -310 * HOP_HEIGHT[this.hopNum];
                     }
                     else
                     {
                        velocity.x = 120;
                        velocity.y = -310 * HOP_HEIGHT[this.hopNum];
                     }
                  }
                  ++this.hopNum;
                  hopNum %= HOP_TIMEOUTS.length;
                  hopTimeout = HOP_TIMEOUTS[this.hopNum];
               }
            }
         }
         if(velocity.y < -5)
         {
            play("up");
         }
         else if(velocity.y > 5)
         {
            play("down");
         }
         else
         {
            play("normal");
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
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         velocity.x = 0;
         velocity.y *= -0.1;
         if(velocity.y <= -5)
         {
            play("quiver");
         }
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
         play("quiver");
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
         play("quiver");
      }
   }
}

