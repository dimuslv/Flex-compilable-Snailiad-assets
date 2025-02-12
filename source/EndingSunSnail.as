package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class EndingSunSnail extends FlxSprite
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 16;
      
      private var _elapsed:Number = 0;
      
      public function EndingSunSnail(param1:int, param2:int) : void
      {
         super(param1,param2);
         loadGraphic(Art.SnailNpc,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[38 * 2,38 * 2 + 1],3.3,true);
         play("normal");
         active = true;
         scrollFactor.x = scrollFactor.y = 0;
      }
      
      override public function update() : void
      {
         _elapsed += FlxG.elapsed;
         offset.y = Math.sin(this._elapsed * 2) * 3;
         super.update();
      }
   }
}

