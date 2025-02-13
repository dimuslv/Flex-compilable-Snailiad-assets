package
{
   import org.flixel.FlxG;
   
   public class EnemyBird2 extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 1;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 3;
      
      private var flySpeed:Number = 90;
      
      private var thetaMult:Number = 4;
      
      private var flyAmplitude:Number = 30;
      
      private var theta:Number = 0;
      
      private var originY:Number = 0;
      
      private var goingUp:Boolean = true;
      
      public function EnemyBird2(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyBird2,true,true,IMG_WIDTH,IMG_HEIGHT);
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
      
      override public function update() : void
      {
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
         theta += FlxG.elapsed;
         var _loc1_:Number = y;
         y = this.originY + Math.sin(this.theta * this.thetaMult) * this.flyAmplitude;
         if(y < _loc1_ && !this.goingUp)
         {
            goingUp = true;
            play("up");
         }
         if(y > _loc1_ && this.goingUp)
         {
            goingUp = false;
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

