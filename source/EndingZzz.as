package
{
   import org.flixel.*;
   
   public class EndingZzz extends FlxSprite
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const ALPHA_RATE:Number = 1;
      
      private var _targetAlpha:Number = 1;
      
      public function EndingZzz(param1:Number, param2:Number) : void
      {
         super(param1,param2);
         loadGraphic(Art.Zzz,true,true,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0,1],2,true);
         alpha = 0;
         play("normal");
      }
      
      override public function update() : void
      {
         alpha = Utility.integrate(alpha,this._targetAlpha,ALPHA_RATE,FlxG.elapsed);
         super.update();
      }
   }
}

