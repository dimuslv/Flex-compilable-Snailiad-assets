package
{
   import org.flixel.*;
   
   public class ExplosionPool extends FlxGroup
   {
      public var groups:Array = new Array();
      
      public var explosionLists:Array = new Array();
	  
	  private const MAX_EXPLOSIONS:Array = [120,120,20,20];
	  
	  private const TYPE_NUM:int = MAX_EXPLOSIONS.length;
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         for(_loc1_ in this.groups)
         {
            this.groups[_loc1_] = null;
         }
         groups = null;
         for(_loc1_ in this.explosionLists)
         {
            for(_loc2_ in this.explosionLists[_loc1_])
            {
               this.explosionLists[_loc1_][_loc2_] = null;
            }
            this.explosionLists[_loc1_] = null;
         }
         explosionLists = null;
         super.destroy();
      }
      
      public function ExplosionPool() : void
      {
         super();
         var _loc1_:int = 0;
         while(_loc1_ < this.TYPE_NUM)
         {
            this.groups[_loc1_] = new FlxGroup();
            this.explosionLists[_loc1_] = new Array();
            var _loc2_:int = 0;
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
         }
		 
		 throw new Error("Unknown explosion type: " + param1.toString());
      }
      
      public function boom(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 1) : void
      {
         var _loc6_:int = 0;
         while(_loc6_ < param5)
         {
            var _loc7_:Explosion = this.groups[param3].getFirstAvail();
            if(_loc7_)
            {
               _loc7_.boom(param1 + FlxU.random() * param4 * 2 - param4,param2 + FlxU.random() * param4 * 2 - param4);
            }
            _loc6_++;
         }
      }
      
      public function boomRadial(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 1) : void
      {
         var _loc6_:int = 0;
         while(_loc6_ < param5)
         {
            var _loc7_:Explosion = this.groups[param3].getFirstAvail();
            if(_loc7_)
            {
               var _loc8_:int = FlxU.random() * param4;
               var _loc9_:int = FlxU.random() * 360;
               var _loc10_:int = param1 + Math.cos(_loc9_ * Math.PI / 180) * _loc8_;
               var _loc11_:int = param2 + Math.sin(_loc9_ * Math.PI / 180) * _loc8_;
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

