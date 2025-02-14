package
{
   public class Fire extends Item
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private var _collidedThisFrame:Boolean;
      
      public function Fire(param1:int, param2:int) : void
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2,false);
         loadGraphic(Art.Fire,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("anim1",[0,1,2,3],9);
         addAnimation("anim2",[3,2,0,1],10);
         addAnimation("anim3",[1,0,3,2],11);
         addAnimation("anim4",[2,3,1,0],13);
         switch(((int)(param1 / 16)) % 4)
         {
            case 0:
               play("anim1");
               break;
            case 1:
               play("anim2");
               break;
            case 2:
               play("anim3");
               break;
            case 3:
               play("anim4");
			   break;
         }
         _collidedThisFrame = false;
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         if(this._collidedThisFrame)
         {
            return;
         }
         _collidedThisFrame = true;
         if(param1.hasArmor())
		 {
		 }
		 else if(param1.isIcy())
         {
            param1.hurt(1);
         }
         else
         {
            param1.hurt(4);
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

