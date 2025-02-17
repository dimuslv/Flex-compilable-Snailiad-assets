package
{
   import org.flixel.*;
   
   public class EnemyBat extends Enemy
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 120;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 3;
      
      private static const MOVE_TIMEOUT:Number = 1.2;
      
      private static const REACT_DISTANCE:int = 110;
      
      private static const SPEED:Number = 70;
      
      private var moveTimeout:Number = 0;
      
      public function EnemyBat(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyBat,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.moveTimeout = 0;
         addAnimation("normal",[0]);
         play("normal");
         addAnimation("flying",[1,2],6,true);
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
            if(this.moveTimeout < 0 && Math.abs(PlayState.player.x - x) < REACT_DISTANCE)
            {
               if(PlayState.player.x < x)
               {
                  velocity.x = -SPEED;
               }
               else
               {
                  velocity.x = SPEED;
               }
               velocity.y = Math.sqrt(Math.abs(PlayState.player.y - y + 40)) * SPEED / 4;
               acceleration.y = -SPEED * 2;
               play("flying");
               moveTimeout = 9999999999;
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
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
      }
   }
}

