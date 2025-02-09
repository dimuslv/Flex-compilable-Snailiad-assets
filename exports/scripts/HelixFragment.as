package
{
   public class HelixFragment extends UniqueItem
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      public function HelixFragment(param1:int, param2:int, param3:Boolean = false)
      {
         super(param1,param2,param3);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemHelixFragment,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1,2,3,4,5,6,7],24,true);
         play("normal");
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addHelixFragment();
         PlayState.hud.itemName.setItem("HELIX FRAGMENT #" + PlayState.player.getHelixFragments().toString());
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

