package
{
   public class Boss2Pupil extends Enemy
   {
      private static const IMG_WIDTH:int = 100;
      
      private static const IMG_HEIGHT:int = 52;
      
      private static const MAX_HP:int = 50000;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      public function Boss2Pupil(param1:int, param2:int)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Boss2Pupil,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         solid = false;
         addAnimation("normal",[0]);
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

