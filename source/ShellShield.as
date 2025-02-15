package
{
   public class ShellShield extends UniqueItem
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 16;
      
      public function ShellShield(param1:int, param2:int) : void
      {
         super(param1,param2);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemShellShield,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,0,1,1,1,2,2,3,3,3],10,true);
         play("normal");
         if(PlayState.player._slugMode)
         {
            exists = false;
         }
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addShellShield();
         PlayState.hud.itemName.setItem("SHELL SHIELD");
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

