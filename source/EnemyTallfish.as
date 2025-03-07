package
{
   import org.flixel.*;
   
   public class EnemyTallfish extends Enemy
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 48;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 500;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 4;
      
      private static const MOVE_TIMEOUT:Number = 2.3;
      
      private static const SHOT_TIMEOUT:Number = 0.25;
      
      private static const SHOT_NUM:int = 3;
      
      private static const WEAPON_SPEED:int = 100;
      
      private static const SPEED:Number = 160;
      
      private var elapsed:Number = 0;
      
      private var moveTimeout:Number = 0;
      
      private var shotTimeout:Number = 0;
      
      private var originY:Number = 0;
      
      private var shotNum:int = 0;
      
      public function EnemyTallfish(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyTallfish,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         originY = param2;
         moveTimeout = MOVE_TIMEOUT / 8;
         addAnimation("normal",[0]);
         addAnimation("swim",[0,1,2,3,3,0,0,1,1,1,2,2,2,2,3,3,3,3,0],10,false);
         play("swim");
         drag.x = SPEED * 0.6;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         elapsed += FlxG.elapsed;
         y = originY + 4 * Math.sin(elapsed * 2);
         if(onScreen())
         {
            moveTimeout -= FlxG.elapsed;
            if(moveTimeout < 0)
            {
               if(PlayState.player.x < x)
               {
                  velocity.x = -SPEED;
               }
               else
               {
                  velocity.x = SPEED;
               }
               shotNum = SHOT_NUM;
               shotTimeout = 0;
               moveTimeout = MOVE_TIMEOUT;
               play("normal");
               play("swim");
            }
            shotTimeout -= FlxG.elapsed;
            if(shotTimeout <= 0 && shotNum > 0)
            {
               var _loc1_:Number = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
               shoot(_loc1_);
               shotTimeout = SHOT_TIMEOUT;
               --shotNum;
            }
         }
         if(velocity.x < 0)
         {
            facing = LEFT;
         }
         if(velocity.x > 0)
         {
            facing = RIGHT;
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
            _loc5_.shoot(x + width / 2,y + height / 2,_loc3_,_loc4_);
         }
      }
   }
}

