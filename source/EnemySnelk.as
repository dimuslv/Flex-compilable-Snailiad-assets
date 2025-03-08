package
{
   import org.flixel.*;
   
   public class EnemySnelk extends Enemy
   {
      private static const IMG_WIDTH:int = 24;
      
      private static const IMG_HEIGHT:int = 24;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 50;
      
      private static const DEFENSE:int = 1;
      
      private static const OFFENSE:int = 2;
      
      private static const HOP_HEIGHT:Array = [2,1,1.9,1.2,2,0.4,1.2,2,0.3];
      
      private var hopNum:int = 0;
      
      private var hopTimeout:Number = 0;
      
      private var _alwaysRun:Boolean = false;
      
      public function EnemySnelk(param1:int, param2:int, param3:Boolean = false) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.EnemySnelk,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         hopNum = param1 % HOP_HEIGHT.length;
         _alwaysRun = param3;
         addAnimation("normal",[0]);
         play("normal");
         if(x < PlayState.player.x)
         {
            facing = RIGHT;
         }
         else
         {
            facing = LEFT;
         }
         acceleration.y = 1200;
      }
      
      override public function touch(param1:Player) : void
      {
      }
      
      override public function hurt(param1:Number) : void
      {
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(hopTimeout < 0)
         {
            if(onScreen() && FlxU.random() > 0.4)
            {
               Sfx.playSnelk();
            }
            var _loc1_:int = -100;
            if(!_alwaysRun)
            {
               if(x > PlayState.player.x)
               {
                  _loc1_ = -100;
               }
               else
               {
                  _loc1_ = 100;
               }
               if(FlxU.random() > 0.8)
               {
                  _loc1_ *= -1;
               }
            }
            else if(x > PlayState.player.x)
            {
               _loc1_ = 140;
            }
            else
            {
               _loc1_ = -140;
            }
            velocity.x = _loc1_;
            velocity.y = -240 * HOP_HEIGHT[hopNum];
            ++hopNum;
            hopNum %= HOP_HEIGHT.length;
            hopTimeout = 1;
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
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         hopTimeout = -1;
         velocity.x = 0;
         velocity.y *= -0.1;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
      }
   }
}

