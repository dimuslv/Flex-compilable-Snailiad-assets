package
{
   import org.flixel.*;
   
   public class ExplosionPool extends FlxGroup
   {
      public var groups:Array;
      
      public var explosionLists:Array;
	  
	  private var MAX_EXPLOSIONS:Array;
	  
	  private var TYPE_NUM:int;
      
      public function ExplosionPool()
      {
         var _loc2_:int = 0;
         this.groups = new Array();
         this.explosionLists = new Array();
         this.MAX_EXPLOSIONS = [120,120,20,20];
         this.TYPE_NUM = this.MAX_EXPLOSIONS.length;
         super();
         var _loc1_:int = 0;
         while(_loc1_ < this.TYPE_NUM)
         {
            this.groups[_loc1_] = new FlxGroup();
            this.explosionLists[_loc1_] = new Array();
            _loc2_ = 0;
            while(_loc2_ < this.MAX_EXPLOSIONS[_loc1_])
            {
               this.explosionLists[_loc1_][_loc2_] = this.makeExplosion(_loc1_);
               this.groups[_loc1_].add(this.explosionLists[_loc1_][_loc2_]);
               _loc2_++;
            }
            add(this.groups[_loc1_]);
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         for(_loc1_ in this.groups)
         {
            this.groups[_loc1_] = null;
         }
         this.groups = null;
         for(_loc1_ in this.explosionLists)
         {
            for(_loc2_ in this.explosionLists[_loc1_])
            {
               this.explosionLists[_loc1_][_loc2_] = null;
            }
            this.explosionLists[_loc1_] = null;
         }
         this.explosionLists = null;
         super.destroy();
      }
      
      private function makeExplosion(param1:int) : Explosion
      {
         switch(param1)
         {
            case 0:
               return new ExplosionSmall();
            case 1:
               return new ExplosionBig();
            case 2:
               return new ExplosionHuge();
            case 3:
               return new ExplosionTiny();
            default:
               throw new Error("Unknown explosion type: " + param1.toString());
         }
      }
      
      public function boom(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 1) : void
      {
         var _loc7_:Explosion = null;
         var _loc6_:int = 0;
         while(_loc6_ < param5)
         {
            _loc7_ = this.groups[param3].getFirstAvail();
            if(_loc7_)
            {
               _loc7_.boom(param1 + FlxU.random() * param4 * 2 - param4,param2 + FlxU.random() * param4 * 2 - param4);
            }
            _loc6_++;
         }
      }
      
      public function boomRadial(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 1) : void
      {
         var _loc7_:Explosion = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param5)
         {
            _loc7_ = this.groups[param3].getFirstAvail();
            if(_loc7_)
            {
               _loc8_ = FlxU.random() * param4;
               _loc9_ = FlxU.random() * 360;
               _loc10_ = param1 + Math.cos(_loc9_ * Math.PI / 180) * _loc8_;
               _loc11_ = param2 + Math.sin(_loc9_ * Math.PI / 180) * _loc8_;
               _loc7_.boom(param1 + Math.cos(_loc9_) * _loc8_,param2 + Math.sin(_loc9_) * _loc8_);
            }
            _loc6_++;
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
      }
   }
}

