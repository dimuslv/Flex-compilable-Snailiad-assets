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
      
      private static const JUMP_HEIGHT:Array = [1,1,1,1,2,1,1,1,2,1,1,1,0.5,0.5,0.5,0,2.5];
      
      private static const SPEED:Number = 200;
      
      private static const SHOT_TIMEOUT:Number = 0.4;
      
      private var moveTimeoutIndex:int = 0;
      
      private var REACT_DISTANCE:int = 540;
      
      private var moveTimeout:Number = 0;
      
      private var shotTimeout:Number = 0.4;
      
      private var landed:Boolean = true;
      
      public function EnemyPincer2(param1:int, param2:int)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyPincer2,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.moveTimeoutIndex = int(param1 / 16 + param2 / 8) % MOVE_TIMEOUT.length;
         this.moveTimeout = MOVE_TIMEOUT[this.moveTimeoutIndex];
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
         var _loc5_:EnemyBullet = null;
         var _loc2_:Number = WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         if(Boolean(PlayState.player) && PlayState.player._insaneMode)
         {
            _loc5_ = PlayState.enemyBulletPool.getBullet(1);
            if(_loc5_)
            {
               _loc5_.shoot(x + width / 2,y + height / 2,_loc3_ * 1.3,_loc4_ * 1.3);
            }
         }
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(onScreen())
         {
            this.moveTimeout -= FlxG.elapsed;
            if(this.moveTimeout < 0 && Math.abs(PlayState.player.x - x) < this.REACT_DISTANCE)
            {
               ++this.moveTimeoutIndex;
               this.moveTimeoutIndex %= MOVE_TIMEOUT.length;
               this.moveTimeout = MOVE_TIMEOUT[this.moveTimeoutIndex];
               if(FlxU.random() > 0.9 && this.landed)
               {
                  velocity.y = 130 * JUMP_HEIGHT[this.moveTimeoutIndex];
                  this.landed = false;
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
            this.shotTimeout -= FlxG.elapsed;
            if(this.shotTimeout <= 0)
            {
               this.shotTimeout = SHOT_TIMEOUT;
               _loc1_ = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
               this.shoot(_loc1_);
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
         this.landed = true;
         velocity.y *= -0.1;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
      }
   }
}

