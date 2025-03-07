package
{
   import org.flixel.*;
   
   public class EnemyBulletPool extends FlxGroup
   {
      public var groups:Array = new Array();
      
      public var bulletLists:Array = new Array();
	  
	  private const MAX_BULLET:Array = [40,200,100,10,60,10,10,90,20];
	  
	  private const MAX_WEAPON:int = MAX_BULLET.length;
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         super.destroy();
         for(_loc1_ in groups)
         {
            groups[_loc1_] = null;
         }
         for(_loc1_ in bulletLists)
         {
            bulletLists[_loc1_] = null;
         }
         groups = null;
         bulletLists = null;
      }
      
      public function EnemyBulletPool() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < MAX_WEAPON)
         {
            groups[_loc1_] = new FlxGroup();
            bulletLists[_loc1_] = new Array();
            var _loc2_:int = 0;
            while(_loc2_ < MAX_BULLET[_loc1_])
            {
               bulletLists[_loc1_][_loc2_] = makeBullet(_loc1_);
               groups[_loc1_].add(bulletLists[_loc1_][_loc2_]);
               _loc2_++;
            }
            add(groups[_loc1_]);
            _loc1_++;
         }
      }
      
      public function destroyAll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < MAX_WEAPON)
         {
            var _loc2_:int = 0;
            while(_loc2_ < MAX_BULLET[_loc1_])
            {
               bulletLists[_loc1_][_loc2_].kill();
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function makeBullet(param1:int) : EnemyBullet
      {
         switch(param1)
         {
            case 0:
               return new Boss1Boomerang();
            case 1:
               return new EnemyBulletPea();
            case 2:
               return new EnemyBulletFire();
            case 3:
               return new EnemyBulletSpikeBall();
            case 4:
               return new EnemyBulletDonut();
            case 5:
               return new EnemyBulletLaser();
            case 6:
               return new EnemyBulletSpikeBall2();
            case 7:
               return new EnemyBulletRotaryPea();
            case 8:
               return new EnemyBulletDonut2();
         }
		 throw new Error("Unknown bullet type: " + param1.toString());
      }
      
      public function getBullet(param1:int) : EnemyBullet
      {
         return groups[param1].getFirstAvail();
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

