package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class MainMenuCursor extends FlxSprite
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = -2;
      
      private static const IMG_OFS_Y:int = 15;
      
      private var targetX:Number;
      
      private var targetY:Number;
      
      public function MainMenuCursor() : void
      {
         super();
         loadGraphic(Art.SnailySnail,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         offset.x = IMG_OFS_X;
         offset.y = IMG_OFS_Y;
         addAnimation("normal",[0,1],3,true);
         play("normal");
         scrollFactor.x = scrollFactor.y = 0;
      }
      
      public function moveTo(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         if(param3)
         {
            x = param1;
            y = param2;
         }
         targetX = param1;
         targetY = param2;
      }
      
      override public function update() : void
      {
         x = Utility.integrate(x,this.targetX,10,FlxG.elapsed);
         y = Utility.integrate(y,this.targetY,10,FlxG.elapsed);
         super.update();
      }
   }
}

