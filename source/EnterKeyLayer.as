package
{
   import org.flixel.*;
   
   public class EnterKeyLayer extends FlxGroup
   {
      public var enterKeyText:FlxText;
      
      public var bg1:FlxSprite;
      
      public var bg2:FlxSprite;
      
      public var shown:Boolean;
      
      public function EnterKeyLayer() : void
      {
         scrollFactor.x = scrollFactor.y = 0;
         shown = false;
         visible = false;
         show();
      }
      
      public function show() : void
      {
         if(shown)
         {
            return;
         }
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
         enterKeyText = new FlxText(-1,FlxG.height / 2 - 11,FlxG.width);
         enterKeyText.alignment = "center";
         enterKeyText.color = 16777215;
         enterKeyText.size = 20;
         enterKeyText.font = Fonts.normal;
         enterKeyText.setShadowDistance(1);
         enterKeyText.scrollFactor.x = enterKeyText.scrollFactor.y = 0;
         enterKeyText.text = "PRESS A KEY";
         add(enterKeyText);
      }
   }
}

