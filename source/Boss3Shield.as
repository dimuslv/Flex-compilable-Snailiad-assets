package
{
   public class Boss3Shield extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const MAX_HP:int = 100;
      
      private static const DEFENSE:int = 1000;
      
      private static const OFFENSE:int = 4;
      
      public function Boss3Shield() : void
      {
         super(0,0,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Boss3Shield,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         visible = false;
         solid = false;
         active = false;
         addAnimation("normal",[0,1,2,3,4,5],30,false);
      }
      
      public function create() : void
      {
         visible = true;
         solid = true;
         active = true;
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

