package
{
   import org.flixel.*;
   
   public class ItemRateHud extends FlxText
   {
      public var oldTime:int = -1;
      
      public var relY:int = 0;
      
      public function ItemRateHud()
      {
         super(0,FlxG.height - 27,FlxG.width - 7 - 55 * 1);
         this.relY = FlxG.height - 27;
         font = Fonts.normal;
         size = 10;
         color = 16777215;
         shadow = 1;
         alignment = "right";
         scrollFactor.x = scrollFactor.y = 0;
         setShadowDistance(1);
         visible = false;
         this.setRate(PlayState.player.getPercentComplete());
      }
      
      public function setRate(param1:int) : void
      {
         text = "ITEMS\n" + param1.toString() + "%";
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

