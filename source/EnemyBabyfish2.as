package
{
   import org.flixel.FlxG;
   import org.flixel.FlxObject;
   import org.flixel.FlxU;
   
   public class EnemyBabyfish2 extends Enemy
   {
      private static const IMG_WIDTH:int = 13;
      
      private static const IMG_HEIGHT:int = 10;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 40;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      private static const MOVE_TIMEOUT:Number = 1.7;
      
      private static const SPEED:Number = 80;
      
      private var elapsed:Number = 0;
      
      private var moveTimeout:Number = 0;
      
      private var originY:Number = 0;
      
      public function EnemyBabyfish2(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyBabyfish,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.originY = param2;
         this.moveTimeout = MOVE_TIMEOUT / 4;
         addAnimation("normal",[0]);
         addAnimation("swim",[2,3,2,3,2,3,2,2,3,3,2,2,2,3,3,3,3,3,2],12,false);
         play("swim");
         drag.x = SPEED * 0.6;
         drag.y = SPEED * 0.6;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
      }
      
      override public function touch(param1:Player) : void
      {
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         elapsed += FlxG.elapsed;
         y = this.originY + 4 * Math.sin(this.elapsed * 2);
         if(onScreen())
         {
            moveTimeout -= FlxG.elapsed;
            if(this.moveTimeout < 0)
            {
               if(PlayState.player.x < x)
               {
                  velocity.x = -SPEED;
               }
               else
               {
                  velocity.x = SPEED;
               }
               if(FlxU.random() > 0.8)
               {
                  velocity.x *= -1;
               }
               moveTimeout = MOVE_TIMEOUT;
               play("normal");
               play("swim");
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
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

