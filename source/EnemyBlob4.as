package
{
   import org.flixel.*;
   
   public class EnemyBlob4 extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 1800;
      
      private static const DEFENSE:int = 30;
      
      private static const OFFENSE:int = 8;
      
      private static const HOP_TIMEOUTS:Array = [0.4,0.5,1.6,0.4,0.9,1.1,0.9,0.5,0.9];
      
      private static const HOP_HEIGHT:Array = [0.2,0.3,3,0.2,1.6,0.4,2.5,2.7,0.5];
      
      private static const SHOT_TIMEOUT:Number = 4;
      
      private static const SHOT_NUM:int = 4;
      
      private static const CLUSTER_NUM:int = 1;
      
      private var hopNum:int = 0;
      
      private var hopTimeout:Number = 0;
      
      private var shotTimeout:Number = 0;
      
      public function EnemyBlob4(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyBlob,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.hopNum = param1 % HOP_TIMEOUTS.length;
         this.hopTimeout = HOP_TIMEOUTS[this.hopNum];
         addAnimation("normal",[12]);
         addAnimation("quiver",[12,13,14,15,12,13,14,15,12,12,13,13,14,14,15,15,12,12,12,13,13,13,14,14,14,15],12,false);
         play("normal");
         this.shotTimeout = SHOT_TIMEOUT;
         acceleration.y = 1200;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:EnemyBulletRotaryPea = null;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(onScreen())
         {
            hopTimeout -= FlxG.elapsed;
            if(this.hopTimeout < 0)
            {
               if(x > PlayState.player.x)
               {
                  velocity.x = -100;
                  velocity.y = -200 * HOP_HEIGHT[this.hopNum];
               }
               else
               {
                  velocity.x = 100;
                  velocity.y = -200 * HOP_HEIGHT[this.hopNum];
               }
               ++this.hopNum;
               hopNum %= HOP_TIMEOUTS.length;
               hopTimeout = HOP_TIMEOUTS[this.hopNum];
            }
            shotTimeout -= FlxG.elapsed;
            if(this.shotTimeout <= 0)
            {
               shotTimeout = SHOT_TIMEOUT;
               Sfx.playShot7();
               _loc1_ = 0;
               while(_loc1_ < SHOT_NUM)
               {
                  _loc2_ = PlayState.enemyBulletPool.getBullet(7) as EnemyBulletRotaryPea;
                  if(_loc2_)
                  {
                     _loc2_.shootRotary(x + width / 2,y + height / 2,60,4,Math.PI * 2 / SHOT_NUM * _loc1_);
                  }
                  _loc1_++;
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
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         velocity.x = 0;
         velocity.y *= -0.1;
         if(velocity.y <= -5)
         {
            play("normal");
            play("quiver");
         }
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
         play("normal");
         play("quiver");
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
         play("normal");
         play("quiver");
      }
   }
}

