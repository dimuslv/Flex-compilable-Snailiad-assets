package
{
   import org.flixel.*;
   
   public class EndingGroup extends FlxGroup
   {
      public var picture:EndingPicture;
      
      public var bg:EndingBg;
      
      public var elapsed:Number = 0;
      
      override public function destroy() : void
      {
         super.destroy();
         picture = null;
         bg = null;
      }
      
      public function EndingGroup(param1:int) : void
      {
         picture = new EndingPicture(param1);
         bg = new EndingBg();
         updatePositions();
         add(bg);
         add(picture);
         active = true;
      }
      
      public function updatePositions() : void
      {
         var _loc1_:int = -30 + elapsed * 10;
         if(_loc1_ > 0)
         {
            _loc1_ = 0;
         }
         var _loc2_:int = 30 - elapsed * 10;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         bg.x = _loc2_;
         picture.x = _loc1_;
      }
      
      override public function update() : void
      {
         elapsed += FlxG.elapsed;
         updatePositions();
         super.update();
      }
   }
}

