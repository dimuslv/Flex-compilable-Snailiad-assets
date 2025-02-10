package
{
   public class Devastator extends SuperUniqueItem
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 64;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 48;
      
      public function Devastator(param1:int, param2:int)
      {
         super(param1,param2,false);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemDevastator,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1,2,3],8,true);
         play("normal");
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addTurbo();
         PlayState.player.addDevastator();
         PlayState.hud.itemName.setItem("DEVASTATOR");
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

