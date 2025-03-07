package
{
   import org.flixel.*;
   
   public class Hud extends FlxGroup
   {
      public var heartHud:HeartHud;
      
      public var bossBarHud:BossBarHud;
      
      public var areaName:AreaName;
      
      public var itemName:ItemName;
      
      public var itemRate:ItemRate;
      
      public var radar:Radar;
      
      override public function destroy() : void
      {
         heartHud = null;
         bossBarHud = null;
         areaName = null;
         itemName = null;
         itemRate = null;
         radar = null;
         super.destroy();
      }
      
      public function Hud() : void
      {
         heartHud = new HeartHud();
         add(heartHud);
         bossBarHud = new BossBarHud();
         add(bossBarHud);
         areaName = new AreaName();
         add(areaName);
         itemName = new ItemName();
         add(itemName);
         itemRate = new ItemRate();
         add(itemRate);
         radar = new Radar();
         add(radar);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            itemRate.visible = false;
            itemName.visible = false;
            bossBarHud.visible = false;
            radar.visible = false;
            return;
         }
         itemRate.visible = true;
         itemName.visible = true;
         bossBarHud.visible = true;
         radar.visible = true;
         super.update();
      }
   }
}

