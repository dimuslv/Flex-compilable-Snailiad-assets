package
{
   public class Gun1 extends UniqueItem
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 16;
      
      public function Gun1(param1:int, param2:int) : void
      {
         super(param1,param2);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemGun1,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1,2,3],11,true);
         play("normal");
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addWeapon(0);
         PlayState.hud.itemName.setItem("PEA SHOOTER");
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
   }
}

