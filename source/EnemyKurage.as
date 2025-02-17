package
{
   import org.flixel.*;
   
   public class EnemyKurage extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 350;
      
      private static const DEFENSE:int = 50;
      
      private static const OFFENSE:int = 3;
      
      private static const RADIUS:Number = 30;
      
      private var originX:Number;
      
      private var originY:Number;
      
      private var theta:Number = 0;
      
      private var elapsed:Number = 0;
      
      public function EnemyKurage(param1:int, param2:int) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.EnemyKurage,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.originX = param1;
         this.originY = param2;
         this.theta = x * 0.7 + y * 1.3;
         this.updatePosition();
         addAnimation("normal",[0,1,2,3],4,true);
         play("normal");
         active = true;
         visible = true;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function updatePosition() : void
      {
         x = this.originX + RADIUS * Math.sin(this.theta * 1.2) + Math.sin(this.theta * 12) * 0.3;
         y = this.originY - RADIUS * Math.cos(this.theta * 1.2) - Math.cos(this.theta * 12);
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
         super.hurt(param1);
      }
   }
}

