package
{
   import org.flixel.*;
   
   public class EnemySnake3 extends Enemy
   {
      private static const IMG_WIDTH:int = 25;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 4;
      
      private static const WEAPON_SPEED:Number = 80;
      
      private static const THETA_OFFSET:Array = [0,Math.PI,0,Math.PI / 2,0,0,-Math.PI / 2,0,0,-Math.PI / 4,Math.PI / 4,0];
      
      private static const SHOT_TIMEOUT:Number = 1.2;
      
      private static const MOVE_TIMEOUT:Array = [1.2,1.3,1.4,1.1,1.6,1,1.8,0.9,1.9,2.1,0.9,1.3,1.7,1.4,2.1,1.2,0.9,0.8,1.2,1.3,1.4,0.2,1.6,1,1.8,0.4,1.9,2.1,0.9,0.7,1.7,1.2,2.3,1.1,0.9,0.8];
      
      private var MAX_HP:int = 450;
      
      private var REACT_DISTANCE:int = 390;
      
      private var X_SPEED:Number = 240;
      
      private var Y_SPEED:Number = 190;
      
      private var moveTimeout:Number = 0;
      
      private var thetaOffsetIndex:int = 0;
      
      private var shotTimeout:Number = 1.2;
      
      private var moveTimeoutIndex:int = 0;
      
      public function EnemySnake3(param1:int, param2:int)
      {
         if(Boolean(PlayState.player) && PlayState.player._easyMode)
         {
            this.MAX_HP *= 0.7;
            this.Y_SPEED = 120;
         }
         super(param1,param2,this.MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemySnake3,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.thetaOffsetIndex = int(x / 16 + y / 4);
         this.thetaOffsetIndex %= THETA_OFFSET.length;
         this.moveTimeoutIndex = int(x / 16 + y / 4);
         this.moveTimeoutIndex %= MOVE_TIMEOUT.length;
         this.moveTimeout = MOVE_TIMEOUT[this.moveTimeoutIndex] / 4;
         addAnimation("normal",[0,1],10,true);
         play("normal");
         drag.x = this.X_SPEED * 0.7;
         drag.y = this.Y_SPEED * 0.6;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc2_:EnemyBullet = null;
         var _loc3_:Number = WEAPON_SPEED;
         var _loc4_:Number = -Math.cos(param1) * _loc3_;
         var _loc5_:Number = -Math.sin(param1) * _loc3_;
         if(Boolean(PlayState.player) && PlayState.player._insaneMode)
         {
            _loc2_ = PlayState.enemyBulletPool.getBullet(4);
            if(_loc2_)
            {
               _loc2_.shoot(x + width / 2,y + height / 2,_loc4_ * 1.3,_loc5_ * 1.3);
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
            if(this.moveTimeout < 0 && Math.abs(PlayState.player.x - x) < this.REACT_DISTANCE && Math.abs(PlayState.player.y - y) < this.REACT_DISTANCE)
            {
               _loc1_ = Math.atan2(PlayState.player.y - y,PlayState.player.x - x);
               _loc1_ += THETA_OFFSET[this.thetaOffsetIndex];
               ++this.thetaOffsetIndex;
               this.thetaOffsetIndex %= THETA_OFFSET.length;
               velocity.x = Math.cos(_loc1_) * this.X_SPEED;
               velocity.y = Math.sin(_loc1_) * this.Y_SPEED;
               ++this.moveTimeout;
               this.moveTimeout %= MOVE_TIMEOUT.length;
               this.moveTimeout = MOVE_TIMEOUT[this.moveTimeoutIndex];
               this.shotTimeout -= FlxG.elapsed;
               if(this.shotTimeout <= 0)
               {
                  this.shotTimeout = SHOT_TIMEOUT;
                  _loc1_ = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
                  this.shoot(_loc1_);
               }
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
         velocity.y *= -1;
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         velocity.y *= -1;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
      }
   }
}

