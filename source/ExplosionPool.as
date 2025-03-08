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
         for(var i:String in groups)
         {
            groups[i] = null;
         }
         groups = null;
         for(i in explosionLists)
         {
            for(var j:String in explosionLists[i])
            {
               explosionLists[i][j] = null;
            }
            explosionLists[i] = null;
         }
         explosionLists = null;
         super.destroy();
      }
      
      public function ExplosionPool() : void
      {
         for (var i:int = 0; i < TYPE_NUM; i++)
         {
            groups[i] = new FlxGroup();
            explosionLists[i] = new Array();
            for (var j:int = 0; j < MAX_EXPLOSIONS[i]; j++)
            {
               explosionLists[i][j] = makeExplosion(i);
               groups[i].add(explosionLists[i][j]);
            }
            add(groups[i]);
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
         for (var i:int = 0; i < param5; i++)
         {
            var _loc7_:Explosion = groups[param3].getFirstAvail();
            if(_loc7_)
            {
               _loc7_.boom(param1 + FlxU.random() * param4 * 2 - param4,param2 + FlxU.random() * param4 * 2 - param4);
            }
         }
      }
      
      public function boomRadial(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 1) : void
      {
         for (var i:int = 0; i < param5; i++)
         {
            var _loc7_:Explosion = groups[param3].getFirstAvail();
            if(_loc7_)
            {
               var _loc8_:int = FlxU.random() * param4;
               var _loc9_:int = FlxU.random() * 360;
               var _loc10_:int = param1 + Math.cos(_loc9_ * Math.PI / 180) * _loc8_;
               var _loc11_:int = param2 + Math.sin(_loc9_ * Math.PI / 180) * _loc8_;
               _loc7_.boom(param1 + Math.cos(_loc9_) * _loc8_,param2 + Math.sin(_loc9_) * _loc8_);
            }
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

