package
{
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   import org.flixel.FlxText;
   
   public class EnterKeyLayer extends FlxGroup
   {
      public var enterKeyText:FlxText;
      
      public var bg1:FlxSprite;
      
      public var bg2:FlxSprite;
      
      public var shown:Boolean;
      
      public function EnterKeyLayer()
      {
         super();
         scrollFactor.x = scrollFactor.y = 0;
         this.shown = false;
         visible = false;
         this.show();
      }
      
      public function show() : void
      {
         if(this.shown)
         {
            return;
         }
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
         this.enterKeyText = new FlxText(-1,FlxG.height / 2 - 11,FlxG.width);
         this.enterKeyText.alignment = "center";
         this.enterKeyText.color = 16777215;
         this.enterKeyText.size = 20;
         this.enterKeyText.font = Fonts.normal;
         this.enterKeyText.setShadowDistance(1);
         this.enterKeyText.scrollFactor.x = this.enterKeyText.scrollFactor.y = 0;
         this.enterKeyText.text = "PRESS A KEY";
         add(this.enterKeyText);
      }
   }
}

