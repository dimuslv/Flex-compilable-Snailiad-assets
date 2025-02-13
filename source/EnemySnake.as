package
{
   import org.flixel.FlxG;
   import org.flixel.FlxObject;
   
   public class EnemySnake extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 250;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 4;
      
      private static const MOVE_TIMEOUT:Number = 1.2;
      
      private static const REACT_DISTANCE:int = 100;
      
      private static const SPEED:Number = 180;
      
      private var moveTimeout:Number = 0;
      
      private var REACT_DISTANCE:int = 100;
      
      public function EnemySnake(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemySnake,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.moveTimeout = MOVE_TIMEOUT;
         addAnimation("normal",[0,1],10,true);
         play("normal");
         acceleration.y = 1200;
         drag.x = SPEED * 2;
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
            moveTimeout -= FlxG.elapsed;
            if(this.moveTimeout < 0 && Math.abs(PlayState.player.x - x) < this.REACT_DISTANCE)
            {
               if(PlayState.player.x < x)
               {
                  velocity.x = -SPEED;
               }
               else
               {
                  velocity.x = SPEED;
               }
               moveTimeout = MOVE_TIMEOUT;
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
         velocity.y *= -0.1;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
      }
   }
}

