package
{
   import org.flixel.*;
   
   public class DustRing extends FlxGroup
   {
      private static const SPIN_SPEED:Number = Math.PI * 2;
      
      private static const DUST_NUM:int = 16;
      
      private static const RADIUS:Number = 234;
      
      private var originX:int;
      
      private var originY:int;
      
      private var elapsed:Number = 0;
      
      private var INWARD_SPEED:Number = 90;
      
      private var radius:Number = 234;
      
      private var repeats:int = 0;
      
      public function DustRing(param1:int, param2:int, param3:int = 0, param4:Number = 1.0) : void
      {
         originX = param1;
         originY = param2;
         radius = RADIUS + param3;
         INWARD_SPEED *= param4;
         var _loc5_:int = 0;
         while(_loc5_ < DUST_NUM)
         {
            add(new Dust());
            _loc5_++;
         }
         updatePositions();
      }
      
      override public function update() : void
      {
         originX = PlayState.player.x;
         originY = PlayState.player.y;
         elapsed += FlxG.elapsed;
         radius -= FlxG.elapsed * INWARD_SPEED;
         if(radius <= 0)
         {
            --repeats;
            if(repeats <= 0)
            {
               kill();
               return;
            }
            radius = RADIUS;
         }
         updatePositions();
         super.update();
      }
      
      public function updatePositions() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < DUST_NUM)
         {
            var _loc2_:Number = Math.PI * 2 / DUST_NUM * _loc1_ + elapsed * SPIN_SPEED;
            members[_loc1_].x = originX + Math.cos(_loc2_) * radius;
            members[_loc1_].y = originY + Math.sin(_loc2_) * radius;
            _loc1_++;
         }
      }
   }
}

