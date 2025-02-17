package
{
   import org.flixel.*;
   
   public class MapRate extends FlxText
   {
      public var relY:int = 0;
      
      public function MapRate()
      {
         super(0,FlxG.height - 27,FlxG.width - 7 - 57 * 2);
         this.relY = FlxG.height - 27;
         font = Fonts.normal;
         size = 10;
         color = 16777215;
         shadow = 1;
         alignment = "right";
         scrollFactor.x = scrollFactor.y = 0;
         setShadowDistance(1);
      }
      
      public function setRate(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 >= 1)
         {
            NgMedal.unlockExplorer();
         }
         text = "MAP\n" + int(param1 * 100).toString() + "%";
         alpha = 1;
         active = true;
      }
      
      override public function update() : void
      {
         if(Boolean(PlayState.miniMap) && Boolean(PlayState.miniMap.subscreen))
         {
            y = this.relY + PlayState.miniMap.subscreen.panel.y;
         }
      }
   }
}

