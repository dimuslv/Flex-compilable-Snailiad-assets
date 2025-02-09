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
      
      public function DustRing(param1:int, param2:int, param3:int = 0, param4:Number = 1)
      {
         super();
         this.originX = param1;
         this.originY = param2;
         this.radius = RADIUS + param3;
         this.INWARD_SPEED *= param4;
         var _loc5_:int = 0;
         while(_loc5_ < DUST_NUM)
         {
            add(new Dust());
            _loc5_++;
         }
         this.updatePositions();
      }
      
      override public function update() : void
      {
         this.originX = PlayState.player.x;
         this.originY = PlayState.player.y;
         this.elapsed += FlxG.elapsed;
         this.radius -= FlxG.elapsed * this.INWARD_SPEED;
         if(this.radius <= 0)
         {
            --this.repeats;
            if(this.repeats <= 0)
            {
               kill();
               return;
            }
            this.radius = RADIUS;
         }
         this.updatePositions();
         super.update();
      }
      
      public function updatePositions() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < DUST_NUM)
         {
            _loc1_ = Math.PI * 2 / DUST_NUM * _loc2_ + this.elapsed * SPIN_SPEED;
            members[_loc2_].x = this.originX + Math.cos(_loc1_) * this.radius;
            members[_loc2_].y = this.originY + Math.sin(_loc1_) * this.radius;
            _loc2_++;
         }
      }
   }
}

