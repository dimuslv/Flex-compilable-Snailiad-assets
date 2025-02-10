package
{
   public class Boss2Eyelid extends Enemy
   {
      private static const IMG_WIDTH:int = 100;
      
      private static const IMG_HEIGHT:int = 52;
      
      private static const MAX_HP:int = 50000;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      public function Boss2Eyelid(param1:int, param2:int)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Boss2Eyelid,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         solid = false;
         addAnimation("open0",[6,3,0],20,false);
         addAnimation("blink0",[0,3,6,3,0],20,false);
         addAnimation("close0",[0,3,6],20,false);
         addAnimation("open1",[7,4,1],20,false);
         addAnimation("blink1",[1,4,7,4,1],20,false);
         addAnimation("close1",[1,4,7],20,false);
         addAnimation("open2",[8,5,2],20,false);
         addAnimation("blink2",[2,5,8,5,2],20,false);
         addAnimation("close2",[2,5,8],20,false);
         play("open0");
      }
      
      public function playOpen(param1:int) : void
      {
         play("open" + param1.toString());
      }
      
      public function playClose(param1:int) : void
      {
         play("close" + param1.toString());
      }
      
      public function playBlink(param1:int) : void
      {
         play("blink" + param1.toString());
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

