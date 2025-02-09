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
      
      public function Boss4RingCenter(param1:int, param2:int)
      {
         super(param1,param2,99999,0,0,true);
         this._rings = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < RING_NUM)
         {
            this._rings[_loc3_] = PlayState.enemyBulletPool.getBullet(8);
            if(this._rings[_loc3_])
            {
               this._rings[_loc3_].shoot(x,y,0,0,RING_LIFETIME);
            }
            _loc3_++;
         }
         this._theta = Math.atan2(PlayState.player.y - y,PlayState.player.x - x);
         if(PlayState.player._slugMode)
         {
            this._acceleration = 170;
            this.TURN_SPEED = 0.4;
         }
         visible = false;
         this.updateRingPos();
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < RING_NUM)
         {
            this._rings[_loc1_] = null;
            _loc1_++;
         }
         this._rings = null;
         super.destroy();
      }
      
      public function updateRingPos() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < RING_NUM)
         {
            this._rings[_loc1_].x = x + this._radius * Math.cos(this._ringTheta + 2 * Math.PI / RING_NUM * _loc1_);
            this._rings[_loc1_].y = y + this._radius * Math.sin(this._ringTheta + 2 * Math.PI / RING_NUM * _loc1_);
            _loc1_++;
         }
      }
      
      public function updateAim() : void
      {
         var _loc1_:Number = Math.atan2(PlayState.player.y - y,PlayState.player.x - x);
         var _loc2_:Number = _loc1_ - this._theta;
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
            this._theta += Math.PI * FlxG.elapsed * this.TURN_SPEED;
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this._radius += this.RADIUS_VEL * FlxG.elapsed;
         this._ringTheta += FlxG.elapsed * Math.PI * RING_THETA_VEL;
         this._velocity += this._acceleration * FlxG.elapsed;
         velocity.x = this._velocity * Math.cos(this._theta);
         velocity.y = this._velocity * Math.sin(this._theta);
         this.updateRingPos();
         this.updateAim();
         super.update();
         if(x > FlxG.MaxX + 250 || x + width < FlxG.MinX - 250 || y > FlxG.MaxY + 250 || y + height < FlxG.MinY - 250)
         {
            this.kill();
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

