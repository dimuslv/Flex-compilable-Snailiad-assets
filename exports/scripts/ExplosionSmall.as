package
{
   public class ExplosionSmall extends Explosion
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      public function ExplosionSmall()
      {
         super();
         loadGraphic(Art.ExplosionSmall,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("boom",[0,1,2,3,4],30,false);
      }
      
      override public function boom(param1:int, param2:int) : void
      {
         x = param1;
         y = param2;
         super.boom(param1,param2);
      }
   }
}

