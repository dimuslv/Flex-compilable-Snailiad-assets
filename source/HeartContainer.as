package
{
   public class HeartContainer extends UniqueItem
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 16;
      
      public function HeartContainer(param1:int, param2:int) : void
      {
         super(param1,param2);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemHeartContainer,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[2,2,1,1,0,0,0,1,1,2,2,3,3,4,4,4,3,3],3.7,true);
         play("normal");
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addHeartContainer();
         PlayState.hud.itemName.setItem("HEART CONTAINER #" + (PlayState.player.getMaxHp() / PlayState.player.hpPerHeart() - 3).toString());
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

