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
         super();
         scrollFactor.x = scrollFactor.y = 0;
         this.bg1 = new FlxSprite();
         this.bg1.x = FlxG.width / 4 - 1;
         this.bg1.y = FlxG.height / 12 * 5 - 1;
         this.bg1.createGraphic(FlxG.width / 2 + 2,FlxG.height / 6 + 2,4026531839);
         this.bg1.scrollFactor.x = this.bg1.scrollFactor.y = 0;
         add(this.bg1);
         this.bg2 = new FlxSprite();
         this.bg2.x = this.bg1.x + 1;
         this.bg2.y = this.bg1.y + 1;
         this.bg2.createGraphic(FlxG.width / 2,FlxG.height / 6,4009758784);
         this.bg2.scrollFactor.x = this.bg2.scrollFactor.y = 0;
         add(this.bg2);
         this.pauseText = new FlxText(-2,FlxG.height / 2 - 11,FlxG.width);
         this.pauseText.alignment = "center";
         this.pauseText.color = 16777215;
         this.pauseText.size = 20;
         this.pauseText.font = Fonts.normal;
         this.pauseText.setShadowDistance(1);
         this.pauseText.scrollFactor.x = this.pauseText.scrollFactor.y = 0;
         this.pauseText.text = "- GAME PAUSED -";
         add(this.pauseText);
      }
      
      override public function update() : void
      {
         this.pauseText.visible = !hideMe;
         this.bg1.visible = !hideMe;
         this.bg2.visible = !hideMe;
         if(FlxG.mouse.justPressed() || FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("P") || FlxG.keys.justPressed("ESCAPE") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER"))
         {
            FlxG.pause = false;
         }
      }
   }
}

