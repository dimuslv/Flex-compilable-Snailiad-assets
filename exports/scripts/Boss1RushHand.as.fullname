package
{
   public class Boss1RushHand extends Enemy
   {
      private static const IMG_WIDTH:int = 24;
      
      private static const IMG_HEIGHT:int = 24;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 100;
      
      private static const DEFENSE:int = 1000;
      
      private static const OFFENSE:int = 3;
      
      public function Boss1RushHand(param1:int, param2:int)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Boss1RushHand,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         addAnimation("normal",[5]);
         play("normal");
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
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

