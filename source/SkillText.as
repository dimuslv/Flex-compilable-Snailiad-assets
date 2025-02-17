package
{
   import org.flixel.*;
   
   public class SkillText extends FlxText
   {
      public var relY:int = 0;
      
      public function SkillText() : void
      {
         super(194,FlxG.height - 27,100);
         this.relY = FlxG.height - 27;
         font = Fonts.normal;
         size = 10;
         color = 16777215;
         shadow = 1;
         alignment = "left";
         scrollFactor.x = scrollFactor.y = 0;
         setShadowDistance(1);
         alpha = 1;
         visible = false;
      }
      
      public function updateText() : void
      {
         if(!PlayState.player)
         {
            return;
         }
         text = "SKILL\n";
         if(PlayState.player._insaneMode)
         {
            text += "INSANE";
         }
         else if(PlayState.player._hardMode)
         {
            text += "HARD";
         }
         else if(PlayState.player._easyMode)
         {
            text += "EASY";
         }
         else
         {
            text += "NORMAL";
         }
      }
      
      override public function update() : void
      {
         if(PlayState.miniMap && PlayState.miniMap.subscreen)
         {
            y = this.relY + PlayState.miniMap.subscreen.panel.y;
         }
      }
   }
}

