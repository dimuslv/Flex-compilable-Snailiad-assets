package
{
   public class SavePoint extends Item
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 48;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 32;
      
      private var _haveSavedYet:Boolean = false;
      
      public function SavePoint(param1:int, param2:int) : void
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2,false);
         loadGraphic(Art.SavePoint,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         _haveSavedYet = false;
         addAnimation("normal",[0,1,2,3],3,true);
         addAnimation("saved",[4,5,6,7],3,true);
         play("normal");
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         if(!_haveSavedYet)
         {
            _haveSavedYet = true;
            play("saved");
            PlayState.player.setSaveCoords(x,y);
            Sfx.playSave1();
         }
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

