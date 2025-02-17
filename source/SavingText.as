package
{
   import org.flixel.*;
   
   public class SavingText extends FlxText
   {
      private static const FADEOUT_START:Number = 1.8;
      
      private static const FADEOUT_END:Number = 2.5;
      
      private static var _fadeOutStart:Number;
      
      private static var _fadeOutEnd:Number;
      
      public function SavingText() : void
      {
         super(0,FlxG.height / 2 - 38,FlxG.width);
         font = Fonts.normal;
         size = 20;
         color = 16777215;
         shadow = 1;
         alignment = "center";
         scrollFactor.x = scrollFactor.y = 0;
         setShadowDistance(1);
      }
      
      public function setSaving() : void
      {
         text = "SAVING...";
         active = true;
         alpha = 1;
      }
      
      public function setSaved() : void
      {
         text = "GAME SAVED.";
         active = true;
         alpha = 1;
         _fadeOutStart = FADEOUT_START;
         _fadeOutEnd = FADEOUT_END;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _fadeOutStart -= FlxG.elapsed;
         _fadeOutEnd -= FlxG.elapsed;
         if(_fadeOutEnd < 0)
         {
            text = "";
            active = false;
         }
         else if(_fadeOutStart < 0)
         {
            alpha = _fadeOutEnd / (FADEOUT_END - FADEOUT_START);
         }
         super.update();
      }
   }
}

