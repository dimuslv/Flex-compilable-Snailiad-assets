package
{
   import flash.events.*;
   import flash.net.*;
   import org.flixel.*;
   
   public class JayIsGames extends FlxSprite
   {
      private static const IMG_WIDTH:int = 93;
      
      private static const IMG_HEIGHT:int = 25;
      
      private static const _jigUrl:String = "http://jayisgames.com/archives/2011/06/snailiad.php";
      
      private var _initialized:Boolean = false;
      
      override public function destroy() : void
      {
         if(FlxG.stage != null)
         {
            FlxG.stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
         }
      }
      
      public function JayIsGames() : void
      {
         x = 0;
         y = FlxG.height - IMG_HEIGHT;
         scrollFactor.x = 0;
         scrollFactor.y = 0;
         visible = true;
         loadGraphic(Art.JayIsGames,false,false,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0]);
         play("normal");
      }
      
      public function show() : void
      {
         alpha = 1;
         visible = true;
      }
      
      public function hide() : void
      {
         alpha = 0.05;
         visible = true;
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         if(!exists || !visible || !active || !FlxG.mouse.justReleased() || FlxG.pause)
         {
            return;
         }
         if(!overlapsPoint(FlxG.mouse.x,FlxG.mouse.y))
         {
            return;
         }
         if(!dead && alpha == 1)
         {
            navigateToURL(new URLRequest(_jigUrl),"_blank");
         }
      }
      
      override public function update() : void
      {
         if(!_initialized)
         {
            if(FlxG.stage != null)
            {
               FlxG.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
               _initialized = true;
            }
         }
         super.update();
      }
   }
}

