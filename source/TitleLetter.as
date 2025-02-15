package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class TitleLetter extends FlxSprite
   {
      private static const IMG_WIDTH:int = 28;
      
      private static const IMG_HEIGHT:int = 43;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const ANIM_STOP_TIMEOUT:Number = 3;
      
      public var targetX:Number = 0;
      
      private var animStopTimeout:Number = 0;
      
      public function TitleLetter(param1:String) : void
      {
         super();
         this.animStopTimeout = ANIM_STOP_TIMEOUT;
         var _loc2_:int = 0;
         switch(param1)
         {
            case "S":
               _loc2_ = 0;
               break;
            case "N":
               _loc2_ = 1;
               break;
            case "A":
               _loc2_ = 2;
               break;
            case "I":
               _loc2_ = 3;
               break;
            case "L":
               _loc2_ = 4;
               break;
            case "D":
               _loc2_ = 5;
			   break;
         }
         loadGraphic(Art.TitleLetter,true,true,IMG_WIDTH,IMG_HEIGHT);
         switch(_loc2_)
         {
            case 0:
               width = 25;
               height = 43;
               break;
            case 1:
               width = 24;
               height = 43;
               break;
            case 2:
               width = 28;
               height = 43;
               break;
            case 3:
               width = 6;
               height = 43;
               break;
            case 4:
               width = 6;
               height = 43;
               break;
            case 5:
               width = 28;
               height = 43;
			   break;
         }
         addAnimation("normal",[6 * 0 + _loc2_,6 * 3 + _loc2_,6 * 4 + _loc2_,6 * 3 + _loc2_,6 * 0 + _loc2_],10,false);
         addAnimation("flash1",[6 * 0 + _loc2_,6 * 1 + _loc2_,6 * 2 + _loc2_,6 * 3 + _loc2_,6 * 4 + _loc2_,6 * 5 + _loc2_,6 * 6 + _loc2_,6 * 7 + _loc2_],30,true);
         addAnimation("flash2",[6 * 0 + _loc2_,6 * 1 + _loc2_,6 * 2 + _loc2_,6 * 3 + _loc2_,6 * 4 + _loc2_,6 * 5 + _loc2_,6 * 6 + _loc2_,6 * 7 + _loc2_],20,true);
         addAnimation("flash3",[6 * 0 + _loc2_,6 * 1 + _loc2_,6 * 2 + _loc2_,6 * 3 + _loc2_,6 * 4 + _loc2_,6 * 5 + _loc2_,6 * 6 + _loc2_,6 * 7 + _loc2_],10,true);
         scrollFactor.x = scrollFactor.y = 0;
         active = true;
         visible = false;
      }
      
      override public function update() : void
      {
         if(visible)
         {
            animStopTimeout -= FlxG.elapsed;
            if(this.animStopTimeout < 0)
            {
               play("normal");
            }
            else
            {
               play("flash1");
            }
         }
         super.update();
      }
   }
}

