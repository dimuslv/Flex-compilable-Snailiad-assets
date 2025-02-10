package
{
   public class IceSnail extends SuperUniqueItem
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 16;
      
      public function IceSnail(param1:int, param2:int)
      {
         super(param1,param2,true);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemIceSnail,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1,2,3],8,true);
         play("normal");
         if(Boolean(PlayState.player) && PlayState.player._insaneMode)
         {
            exists = false;
         }
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addColdFoot();
         if(PlayState.player._slugMode)
         {
            PlayState.hud.itemName.setItem("ICE SLUG",2);
         }
         else
         {
            PlayState.hud.itemName.setItem("ICE SNAIL",2);
         }
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

