package
{
   import org.flixel.*;
   
   public class EnemyDandelion extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 50;
      
      private static const DEFENSE:int = 1;
      
      private static const OFFENSE:int = 3;
      
      private var originX:Number;
      
      private var originY:Number;
      
      private var theta:Number = 0;
      
      private var elapsed:Number = 0;
      
      public function EnemyDandelion(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyDandelion,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         originX = param1;
         originY = param2;
         updatePosition();
         addAnimation("normal",[0]);
         play("normal");
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function updatePosition() : void
      {
         x = originX + 48 * Math.sin(theta * 1.2);
         y = originY - 12 * elapsed;
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
   }
}

