package
{
   import org.flixel.*;
   
   public class BossRushTimer extends FlxText
   {
      public var now:ShadowNumber;
      
      public var started:Boolean = false;
      
      public var going:Boolean = false;
      
      override public function destroy() : void
      {
         now = null;
         super.destroy();
      }
      
      public function BossRushTimer() : void
      {
         super(0,4,FlxG.width - 4);
         now = new ShadowNumber();
         font = Fonts.normal;
         size = 20;
         color = 16777215;
         shadow = 1;
         alignment = "right";
         scrollFactor.x = scrollFactor.y = 0;
         setShadowDistance(1);
         now.value = 0;
         going = false;
         started = false;
      }
      
      public function padZero(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1.toString();
         }
         return param1.toString();
      }
      
      public function getTime() : String
      {
         return int(now.value / 60).toString() + ":" + padZero(int(now.value % 60));
      }
      
      public function getTimeExact() : String
      {
         return int(now.value / 60).toString() + ":" + padZero(int(now.value % 60)) + "." + padZero(int(now.value * 100 % 100));
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(going)
         {
            now.value += FlxG.elapsed;
            text = getTime();
         }
         visible = started;
         super.update();
      }
   }
}

