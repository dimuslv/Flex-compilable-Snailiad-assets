package
{
   import org.flixel.FlxG;
   import org.flixel.FlxText;
   
   public class GameTimeDisplay extends FlxText
   {
      public var oldTime:int = -1;
      
      public var relY:int = 0;
      
      public static function padZero(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1.toString();
         }
         return param1.toString();
      }
      
      public static function format(param1:Number) : String
      {
         if(param1 > 60 * 60)
         {
            return int(param1 / 3600).toString() + ":" + padZero(int(param1 / 60 % 60)) + ":" + padZero(int(param1 % 60));
         }
         return int(param1 / 60).toString() + ":" + padZero(int(param1 % 60));
      }
      
      public static function formatExact(param1:Number) : String
      {
         if(param1 > 60 * 60)
         {
            return int(param1 / 3600).toString() + ":" + padZero(int(param1 / 60 % 60)) + ":" + padZero(int(param1 % 60)) + "." + padZero(int(param1 * 100 % 100));
         }
         return int(param1 / 60).toString() + ":" + padZero(int(param1 % 60)) + "." + padZero(int(param1 * 100 % 100));
      }
      
      override public function update() : void
      {
         if(!PlayState.player)
         {
            text = "";
            return;
         }
         if(PlayState.miniMap && PlayState.miniMap.subscreen)
         {
            y = this.relY + PlayState.miniMap.subscreen.panel.y;
         }
         var _loc1_:int = PlayState.player.gameTime.value;
         if(this.oldTime != _loc1_)
         {
            text = "TIME\n" + format(_loc1_);
            oldTime = _loc1_;
         }
      }
      
      public function GameTimeDisplay() : void
      {
         super(0,FlxG.height - 27,FlxG.width - 7);
         this.relY = FlxG.height - 27;
         font = Fonts.normal;
         size = 10;
         color = 16777215;
         shadow = 1;
         alignment = "right";
         scrollFactor.x = scrollFactor.y = 0;
         setShadowDistance(1);
         visible = false;
      }
   }
}

