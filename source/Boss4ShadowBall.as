package
{
   public class Boss4ShadowBall extends Enemy
   {
      private static const IMG_WIDTH:int = 24;
      
      private static const IMG_HEIGHT:int = 24;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 100;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      public function Boss4ShadowBall()
      {
         super(0,0,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Boss4ShadowBall,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,0,0,1,1,2,2,3,3,3,2,2,1,1],20,true);
         play("normal");
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
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

