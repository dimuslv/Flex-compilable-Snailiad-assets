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
         originX = param1;
         originY = param2;
         speed = 4 + FlxU.random() * 16;
         updatePosition();
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
         x = originX + 2 * Math.sin(theta / 1.2);
         y = originY - speed * elapsed;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         theta += FlxG.elapsed;
         elapsed += FlxG.elapsed;
         updatePosition();
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

