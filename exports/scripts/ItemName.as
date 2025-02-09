package
{
   import org.flixel.*;
   
   public class ItemName extends FlxText
   {
      private static var _fadeOutStart:Number;
      
      private static var _fadeOutEnd:Number;
      
      private static var _colorNum:Number;
      
      private static const FADEOUT_START:Number = 2.8;
      
      private static const FADEOUT_END:Number = 3.5;
      
      private static const _colors:Array = [16040160,16570500,11595992,12370116];
      
      public function ItemName()
      {
         super(0,FlxG.height / 2 + 40,FlxG.width);
         font = Fonts.normal;
         size = 20;
         color = 16040160;
         _colorNum = 0;
         shadow = 1;
         alignment = "center";
         scrollFactor.x = scrollFactor.y = 0;
         outline = true;
         outlineColor = 4278190080;
      }
      
      public function setItem(param1:String, param2:Number = 0) : void
      {
         _fadeOutStart = FADEOUT_START + param2;
         _fadeOutEnd = FADEOUT_END + param2;
         text = param1;
         alpha = 1;
         active = true;
         PlayState.hud.itemRate.setRate(PlayState.player.getPercentComplete(),param2);
         PlayState.itemRateHud.setRate(PlayState.player.getPercentComplete());
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _colorNum += FlxG.elapsed * 30;
         color = _colors[int(_colorNum) % _colors.length];
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

