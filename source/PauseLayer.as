package
{
   import org.flixel.*;
   
   public class PauseLayer extends FlxGroup
   {
      public static var hideMe:Boolean = false;
      
      public var pauseText:FlxText;
      
      public var bg1:FlxSprite;
      
      public var bg2:FlxSprite;
      
      public function PauseLayer() : void
      {
         scrollFactor.x = scrollFactor.y = 0;
         bg1 = new FlxSprite();
         bg1.x = FlxG.width / 4 - 1;
         bg1.y = FlxG.height / 12 * 5 - 1;
         bg1.createGraphic(FlxG.width / 2 + 2,FlxG.height / 6 + 2,4026531839);
         bg1.scrollFactor.x = bg1.scrollFactor.y = 0;
         add(bg1);
         bg2 = new FlxSprite();
         bg2.x = bg1.x + 1;
         bg2.y = bg1.y + 1;
         bg2.createGraphic(FlxG.width / 2,FlxG.height / 6,4009758784);
         bg2.scrollFactor.x = bg2.scrollFactor.y = 0;
         add(bg2);
         pauseText = new FlxText(-2,FlxG.height / 2 - 11,FlxG.width);
         pauseText.alignment = "center";
         pauseText.color = 16777215;
         pauseText.size = 20;
         pauseText.font = Fonts.normal;
         pauseText.setShadowDistance(1);
         pauseText.scrollFactor.x = pauseText.scrollFactor.y = 0;
         pauseText.text = "- GAME PAUSED -";
         add(pauseText);
      }
      
      override public function update() : void
      {
         pauseText.visible = !hideMe;
         bg1.visible = !hideMe;
         bg2.visible = !hideMe;
         if(FlxG.mouse.justPressed() || FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("P") || FlxG.keys.justPressed("ESCAPE") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER"))
         {
            FlxG.pause = false;
         }
      }
   }
}

