package
{
   import org.flixel.FlxGroup;
   
   public class Hud extends FlxGroup
   {
      public var heartHud:HeartHud;
      
      public var bossBarHud:BossBarHud;
      
      public var areaName:AreaName;
      
      public var itemName:ItemName;
      
      public var itemRate:ItemRate;
      
      public var radar:Radar;
      
      public function Hud()
      {
         super();
         this.heartHud = new HeartHud();
         add(this.heartHud);
         this.bossBarHud = new BossBarHud();
         add(this.bossBarHud);
         this.areaName = new AreaName();
         add(this.areaName);
         this.itemName = new ItemName();
         add(this.itemName);
         this.itemRate = new ItemRate();
         add(this.itemRate);
         this.radar = new Radar();
         add(this.radar);
      }
      
      override public function destroy() : void
      {
         this.heartHud = null;
         this.bossBarHud = null;
         this.areaName = null;
         this.itemName = null;
         this.itemRate = null;
         this.radar = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            this.itemRate.visible = false;
            this.itemName.visible = false;
            this.bossBarHud.visible = false;
            this.radar.visible = false;
            return;
         }
         this.itemRate.visible = true;
         this.itemName.visible = true;
         this.bossBarHud.visible = true;
         this.radar.visible = true;
         super.update();
      }
   }
}

