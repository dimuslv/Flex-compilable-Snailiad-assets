package
{
   import org.flixel.*;
   
   public class Boss4RingCenter extends Enemy
   {
      private static const RING_NUM:int = 3;
      
      private static const RING_LIFETIME:Number = 5;
      
      private static const RING_THETA_VEL:Number = 2.2;
      
      private var TURN_SPEED:Number = 0.2;
      
      private var RADIUS_VEL:Number = 16;
      
      private var _radius:Number = 0;
      
      private var _rings:Array;
      
      private var _velocity:Number = 0;
      
      private var _acceleration:Number = 150;
      
      private var _theta:Number = 0;
      
      private var _ringTheta:Number = 0;
      
      override public function destroy() : void
      {
         for (var i:int = 0; i < RING_NUM; i++)
         {
            _rings[i] = null;
         }
         _rings = null;
         super.destroy();
      }
      
      public function Boss4RingCenter(param1:int, param2:int) : void
      {
         super(param1,param2,99999,0,0,true);
         _rings = new Array();
         for (var i:int = 0; i < RING_NUM; i++)
         {
            _rings[i] = PlayState.enemyBulletPool.getBullet(8);
            if(_rings[i])
            {
               _rings[i].shoot(x,y,0,0,RING_LIFETIME);
            }
         }
         _theta = Math.atan2(PlayState.player.y - y,PlayState.player.x - x);
         if(PlayState.player._slugMode)
         {
            _acceleration = 170;
            TURN_SPEED = 0.4;
         }
         visible = false;
         updateRingPos();
      }
      
      public function updateRingPos() : void
      {
         for (var i:int = 0; i < RING_NUM; i++)
         {
            _rings[i].x = x + _radius * Math.cos(_ringTheta + 2 * Math.PI / RING_NUM * i);
            _rings[i].y = y + _radius * Math.sin(_ringTheta + 2 * Math.PI / RING_NUM * i);
         }
      }
      
      public function updateAim() : void
      {
         var _loc1_:Number = Math.atan2(PlayState.player.y - y,PlayState.player.x - x);
         var _loc2_:Number = _loc1_ - _theta;
         while(_loc2_ > Math.PI)
         {
            _loc2_ -= 2 * Math.PI;
         }
         while(_loc2_ < -Math.PI)
         {
            _loc2_ += 2 * Math.PI;
         }
         if(_loc2_ > 0)
         {
            _theta += Math.PI * FlxG.elapsed * TURN_SPEED;
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _radius += RADIUS_VEL * FlxG.elapsed;
         _ringTheta += FlxG.elapsed * Math.PI * RING_THETA_VEL;
         _velocity += _acceleration * FlxG.elapsed;
         velocity.x = _velocity * Math.cos(_theta);
         velocity.y = _velocity * Math.sin(_theta);
         updateRingPos();
         updateAim();
         super.update();
         if(x > FlxG.MaxX + 250 || x + width < FlxG.MinX - 250 || y > FlxG.MaxY + 250 || y + height < FlxG.MinY - 250)
         {
            kill();
         }
      }
      
      override public function kill() : void
      {
         super.kill();
      }
      
      override public function touch(param1:Player) : void
      {
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

