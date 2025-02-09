package
{
   import org.flixel.*;
   
   public class BubbleGenerator extends Enemy
   {
      private const BASE_TIMEOUT:Number = 12;
      
      private var timeout:Number = 0;
      
      private var listPos:int = 0;
      
      private var minX:Number = 0;
      
      private var minY:Number = 0;
      
      private var maxX:Number = 0;
      
      private var widthX:Number = 0;
      
      private var waterY:Number = 0;
      
      private var heightY:Number = 0;
      
      private var maxY:Number = 0;
      
      private var madeInitialBubbles:Boolean = false;
      
      private var group:FlxGroup;
      
      private var MAX_BUBBLES:int = 20;
	  
	  private var TIMEOUTS:Array;
      
      public function BubbleGenerator(param1:int, param2:int)
      {
         this.TIMEOUTS = [0.60153,0.48509,0.70037,0.66276,0.70802,0.79541,0.62043,0.5796,0.99605,0.15058,0.72121,0.86851,0.64371,0.76708,0.89401,0.52828,0.72309,0.15963,0.15116,0.1799,0.27829,0.40878,0.92538,0.45074,0.18865,0.59797,0.4318,0.94098,0.23463,0.29221,0.59734,0.34877,0.81676,0.57617,0.14883,0.16094,0.14123,0.57931,0.85924,0.22828,0.63834,0.10387,0.54746,0.24897,0.11105,0.49748,0.54746,0.19405,0.79792,0.36023,0.53726,0.78544,0.60425,0.83512,0.01696,0.10451,0.01513,0.78678,0.51617,0.24251];
         super(param1,param2,9999,0,0);
         this.minX = PlayState.worldMap.minX;
         this.minY = PlayState.worldMap.minY;
         this.maxX = PlayState.worldMap.maxX;
         this.maxY = PlayState.worldMap.maxY;
         this.widthX = this.maxX - this.minX;
         solid = false;
         visible = false;
         this.listPos = (param1 * 4 + param2 * 20) % this.TIMEOUTS.length;
         this.timeout = this.TIMEOUTS[this.listPos] * this.BASE_TIMEOUT;
         this.timeout %= param1 % 20;
         this.group = new FlxGroup();
         PlayState.bubbles.add(this.group);
      }
      
      override public function destroy() : void
      {
         PlayState.bubbles.remove(this.group);
         this.group = null;
         super.destroy();
      }
      
      override public function collideTerrain() : Boolean
      {
         return false;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Enemy = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(!this.madeInitialBubbles)
         {
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               _loc2_ = this.minX + FlxU.random() * this.widthX;
               this.waterY = PlayState.worldMap.waterLevelY[int(_loc2_ / 16)];
               if(!this.waterY || this.waterY < this.minY)
               {
                  this.waterY = this.minY;
               }
               this.heightY = this.maxY - this.minY;
               _loc3_ = this.waterY + FlxU.random() * this.heightY;
               _loc4_ = new Bubble(_loc2_,_loc3_);
               this.group.add(_loc4_);
               _loc1_++;
            }
            this.madeInitialBubbles = true;
         }
         this.timeout -= FlxG.elapsed;
         if(this.timeout < 0 && this.group.countLiving() < this.MAX_BUBBLES)
         {
            ++this.listPos;
            this.listPos %= this.TIMEOUTS.length;
            this.timeout = this.TIMEOUTS[this.listPos] * this.BASE_TIMEOUT;
            _loc5_ = this.minX + FlxU.random() * this.widthX;
            _loc6_ = -FlxG.scroll.y + FlxG.height;
            this.waterY = PlayState.worldMap.waterLevelY[int(_loc5_ / 16)];
            if(this.waterY < this.minY)
            {
               this.waterY = this.minY;
            }
            if(_loc6_ > this.waterY)
            {
               _loc4_ = new Bubble(_loc5_,_loc6_);
               if(_loc4_.collideTerrain())
               {
                  PlayState.enemies.add(_loc4_);
               }
               else
               {
                  PlayState.enemiesNoCollide.add(_loc4_);
               }
            }
         }
         super.update();
      }
      
      override public function kill() : void
      {
         PlayState.bubbles.remove(this.group);
         this.group = null;
         super.kill();
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
         play("quiver");
      }
   }
}

