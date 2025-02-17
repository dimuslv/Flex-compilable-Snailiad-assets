package
{
   import com.newgrounds.*;
   import flash.events.*;
   import org.flixel.*;
   
   public class SponsorMoreGames extends FlxSprite
   {
      private static const IMG_WIDTH:int = 80;
      
      private static const IMG_HEIGHT:int = 104;
      
      private var _initialized:Boolean = false;
      
      public function SponsorMoreGames() : void
      {
         super();
         x = FlxG.width - IMG_WIDTH;
         y = FlxG.height - IMG_HEIGHT;
         scrollFactor.x = 0;
         scrollFactor.y = 0;
         visible = true;
         loadGraphic(Art.SponsorMoreGames,false,false,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0]);
         play("normal");
      }
      
      override public function destroy() : void
      {
         if(FlxG.stage != null)
         {
            FlxG.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
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
            API.loadNewgrounds();
         }
      }
      
      public function show() : void
      {
         alpha = 1;
         visible = true;
      }
      
      public function hide() : void
      {
         alpha = 0.33;
         visible = true;
      }
      
      override public function update() : void
      {
         if(!this._initialized)
         {
            if(FlxG.stage != null)
            {
               FlxG.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
               _initialized = true;
            }
         }
         super.update();
      }
   }
}

