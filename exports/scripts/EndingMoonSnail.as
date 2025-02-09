package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class EndingMoonSnail extends FlxSprite
   {
      private static const IMG_WIDTH:int = 80;
      
      private static const IMG_HEIGHT:int = 44;
      
      private static const ALPHA_RATE:Number = 1;
      
      private var _targetAlpha:Number = 0;
      
      public function EndingMoonSnail(param1:int, param2:int, param3:int)
      {
         super(param1,param2);
         loadGraphic(Art.SleepyMoonSnail,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[param3 * 2,param3 * 2 + 1],2.5,true);
         alpha = 0;
         play("normal");
         active = true;
         scrollFactor.x = scrollFactor.y = 0;
      }
      
      public function setTargetAlpha(param1:Number) : void
      {
         this._targetAlpha = param1;
      }
      
      override public function update() : void
      {
         alpha = Utility.integrate(alpha,this._targetAlpha,ALPHA_RATE,FlxG.elapsed,0.025);
         super.update();
      }
   }
}

