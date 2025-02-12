package
{
   import org.flixel.FlxG;
   import org.flixel.FlxText;
   
   public class BossRushTimer extends FlxText
   {
      public var now:ShadowNumber;
      
      public var started:Boolean = false;
      
      public var going:Boolean = false;
      
      public function BossRushTimer() : void
      {
         super(0,4,FlxG.width - 4);
         this.now = new ShadowNumber();
         font = Fonts.normal;
         size = 20;
         color = 16777215;
         shadow = 1;
         alignment = "right";
         scrollFactor.x = scrollFactor.y = 0;
         setShadowDistance(1);
         this.now.value = 0;
         this.going = false;
         this.started = false;
      }
      
      override public function destroy() : void
      {
         now = null;
         super.destroy();
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
         return int(this.now.value / 60).toString() + ":" + this.padZero(int(this.now.value % 60));
      }
      
      public function getTimeExact() : String
      {
         return int(this.now.value / 60).toString() + ":" + this.padZero(int(this.now.value % 60)) + "." + this.padZero(int(this.now.value * 100 % 100));
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(this.going)
         {
            this.now.value += FlxG.elapsed;
            text = this.getTime();
         }
         visible = this.started;
         super.update();
      }
   }
}

