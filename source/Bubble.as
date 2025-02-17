package
{
   import org.flixel.*;
   
   public class Bubble extends Enemy
   {
      private static const IMG_WIDTH:int = 8;
      
      private static const IMG_HEIGHT:int = 8;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 50;
      
      private static const DEFENSE:int = 1;
      
      private static const OFFENSE:int = 3;
      
      private var originX:Number;
      
      private var originY:Number;
      
      private var theta:Number = 0;
      
      private var elapsed:Number = 0;
      
      private var speed:Number = 0;
      
      public function Bubble(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Bubble,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.originX = param1;
         this.originY = param2;
         this.speed = 4 + FlxU.random() * 16;
         this.updatePosition();
         addAnimation("normal",[int(FlxU.random() * 8)]);
         play("normal");
         active = true;
      }
      
      override public function triggerAi3() : void
      {
         kill();
      }
      
      override public function touch(param1:Player) : void
      {
      }
      
      public function updatePosition() : void
      {
         x = this.originX + 2 * Math.sin(this.theta / 1.2);
         y = this.originY - this.speed * this.elapsed;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         theta += FlxG.elapsed;
         elapsed += FlxG.elapsed;
         this.updatePosition();
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

