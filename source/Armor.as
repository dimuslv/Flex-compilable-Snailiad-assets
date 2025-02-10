package
{
   public class Armor extends SuperUniqueItem
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 16;
      
      public function Armor(param1:int, param2:int) : void
      {
         super(param1,param2,true);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemArmor,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1,2,3],30,true);
         play("normal");
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addArmor();
         if(PlayState.player._slugMode)
         {
            PlayState.hud.itemName.setItem("FULL POWER SLUG");
         }
         else
         {
            PlayState.hud.itemName.setItem("FULL METAL SNAIL");
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

