package
{
   import org.flixel.*;
   
   public class EndingGroup extends FlxGroup
   {
      public var picture:EndingPicture;
      
      public var bg:EndingBg;
      
      public var elapsed:Number = 0;
      
      public function EndingGroup(param1:int) : void
      {
         super();
         this.picture = new EndingPicture(param1);
         this.bg = new EndingBg();
         this.updatePositions();
         add(this.bg);
         add(this.picture);
         active = true;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         picture = null;
         bg = null;
      }
      
      public function updatePositions() : void
      {
         var _loc1_:int = -30 + this.elapsed * 10;
         if(_loc1_ > 0)
         {
            _loc1_ = 0;
         }
         var _loc2_:int = 30 - this.elapsed * 10;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this.bg.x = _loc2_;
         this.picture.x = _loc1_;
      }
      
      override public function update() : void
      {
         elapsed += FlxG.elapsed;
         this.updatePositions();
         super.update();
      }
   }
}

