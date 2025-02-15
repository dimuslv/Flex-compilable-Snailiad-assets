package
{
   public class TurboFire extends UniqueItem
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 16;
      
      public function TurboFire(param1:int, param2:int) : void
      {
         super(param1,param2);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemRapidFire,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1,2,3,4,5,6,7,8,9,10,11],8,true);
         play("normal");
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addTurbo();
         PlayState.hud.itemName.setItem("RAPID FIRE");
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

