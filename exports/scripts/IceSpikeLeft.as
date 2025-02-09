package
{
   public class IceSpikeLeft extends Item
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private var _collidedThisFrame:Boolean;
      
      public function IceSpikeLeft(param1:int, param2:int, param3:Boolean)
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2,false);
         loadGraphic(Art.IceSpikeLeft,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         x += 2;
         y += 2;
         offset.x += 2;
         offset.y += 2;
         width -= 4;
         height -= 4;
         addAnimation("normal",[0]);
         play("normal");
         if(param3)
         {
            facing = LEFT;
         }
         this._collidedThisFrame = false;
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         if(this._collidedThisFrame)
         {
            return;
         }
         this._collidedThisFrame = true;
         if(!param1.isIcy())
         {
            param1.hurt(2);
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this._collidedThisFrame = false;
         super.update();
      }
   }
}

