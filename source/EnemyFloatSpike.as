package
{
   import org.flixel.*;
   
   public class EnemyFloatSpike extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 5;
      
      private static const DEFENSE:int = 59;
      
      private static const OFFENSE:int = 2;
      
      private var originY:int;
      
      private var theta:Number = 0;
      
      public function EnemyFloatSpike(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyFloatSpike,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         addAnimation("normal",[0]);
         play("normal");
         theta = param1 * param1 * 1.1 + param2 * 3.2 + 0.7;
         originY = param2;
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
         theta += FlxG.elapsed;
         y = originY + Math.sin(theta) * 1.8;
         super.update();
      }
   }
}

