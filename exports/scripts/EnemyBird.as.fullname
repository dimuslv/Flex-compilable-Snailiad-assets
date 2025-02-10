package
{
   import org.flixel.FlxG;
   
   public class EnemyBird extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 1;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 2;
      
      private static const WEAPON_SPEED:Number = 60;
      
      private static const sineAccel:Number = 700;
      
      private static const SHOT_TIMEOUT:Number = 2.2;
      
      private var flySpeed:Number = 140;
      
      private var thetaMult:Number = 5;
      
      private var flyAmplitude:Number = 40;
      
      private var theta:Number = 0;
      
      private var originY:Number = 0;
      
      private var goingUp:Boolean = true;
      
      private var shotTimeout:Number = 2.2;
      
      public function EnemyBird(param1:int, param2:int)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyBird,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.originY = param2;
         addAnimation("down",[0]);
         addAnimation("up",[0,1],20,true);
         play("up");
         this.theta = param1 + param2 * 13.7;
         velocity.x = 0;
         this.thetaMult += Math.sin(param1 * 1.732 - param2 * 3.2);
         this.flySpeed += Math.sin(param1 * 2.332 - param2 * 1.9) * 10;
         this.flyAmplitude += Math.sin(param1 * 7.3 + param2) * 5;
      }
      
      override public function collideTerrain() : Boolean
      {
         return false;
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
         if(velocity.x == 0)
         {
            velocity.x = PlayState.player.x < x ? -this.flySpeed : this.flySpeed;
            if(velocity.x <= 0)
            {
               facing = RIGHT;
            }
            else
            {
               facing = LEFT;
            }
         }
         this.theta += FlxG.elapsed;
         var _loc2_:Number = y;
         y = this.originY + Math.sin(this.theta * this.thetaMult) * this.flyAmplitude;
         if(onScreen())
         {
            this.shotTimeout -= FlxG.elapsed;
            if(this.shotTimeout <= 0)
            {
               this.shotTimeout = SHOT_TIMEOUT;
               _loc1_ = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
               this.shoot(_loc1_);
            }
         }
         if(y < _loc2_ && !this.goingUp)
         {
            this.goingUp = true;
            play("up");
         }
         if(y > _loc2_ && this.goingUp)
         {
            this.goingUp = false;
            play("down");
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
         play("quiver");
      }
   }
}

