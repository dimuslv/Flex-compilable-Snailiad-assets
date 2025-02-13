package
{
   import org.flixel.*;
   
   public class EnemyBlob2 extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 270;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 2;
      
      private static const HOP_TIMEOUTS:Array = [2.4,3.5,2.2,1.6,3.9,3.5,2.9,3.1,1.8];
      
      private static const HOP_HEIGHT:Array = [1,1,1,1.2,2,1,1.2,1,2];
      
      private var hopNum:int = 0;
      
      private var hopTimeout:Number = 0;
      
      public function EnemyBlob2(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyBlob,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.hopNum = param1 % HOP_TIMEOUTS.length;
         if(PlayState.player && PlayState.player._hardMode)
         {
            this.hopTimeout = HOP_TIMEOUTS[this.hopNum] / 2;
         }
         else
         {
            this.hopTimeout = HOP_TIMEOUTS[this.hopNum];
         }
         addAnimation("normal",[4]);
         addAnimation("quiver",[5,6,7,4,5,6,7,4,5,5,6,6,7,7,4,4,5,5,6,6,7,7,4],12,false);
         play("normal");
         acceleration.y = 1200;
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
         if(onScreen())
         {
            hopTimeout -= FlxG.elapsed;
            if(this.hopTimeout < 0)
            {
               if(x > PlayState.player.x)
               {
                  velocity.x = -100;
                  velocity.y = -240 * HOP_HEIGHT[this.hopNum];
               }
               else
               {
                  velocity.x = 100;
                  velocity.y = -240 * HOP_HEIGHT[this.hopNum];
               }
               ++this.hopNum;
               hopNum %= HOP_TIMEOUTS.length;
               if(PlayState.player && PlayState.player._hardMode)
               {
                  hopTimeout = HOP_TIMEOUTS[this.hopNum] / 2;
               }
               else
               {
                  hopTimeout = HOP_TIMEOUTS[this.hopNum];
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

