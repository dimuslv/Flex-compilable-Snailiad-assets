package
{
   public class Muck extends Item
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private var _collidedThisFrame:Boolean;
      
      public function Muck(param1:int, param2:int) : void
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2,false);
         loadGraphic(Art.Muck,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("anim",[(0 + param1 / 16) % 16,(2 + param1 / 16) % 16,(4 + param1 / 16) % 16,(6 + param1 / 16) % 16,(8 + param1 / 16) % 16,(10 + param1 / 16) % 16,(12 + param1 / 16) % 16,(14 + param1 / 16) % 16],4);
         play("anim");
         _collidedThisFrame = false;
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         if(_collidedThisFrame)
         {
            return;
         }
         _collidedThisFrame = true;
         if(param1.hasArmor())
		 {
		 }
		 else
         {
            param1.hurt(3);
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _collidedThisFrame = false;
         super.update();
      }
   }
}

