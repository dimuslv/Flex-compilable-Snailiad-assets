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
         super.destroy();
         for(var i:String in groups)
         {
            groups[i] = null;
         }
         for(i in bulletLists)
         {
            bulletLists[i] = null;
         }
         groups = null;
         bulletLists = null;
      }
      
      public function EnemyBulletPool() : void
      {
         for (var i:int = 0; i < MAX_WEAPON; i++)
         {
            groups[i] = new FlxGroup();
            bulletLists[i] = new Array();
            for (var j:int = 0; j < MAX_BULLET[i]; j++)
            {
               bulletLists[i][j] = makeBullet(i);
               groups[i].add(bulletLists[i][j]);
            }
            add(groups[i]);
         }
      }
      
      public function destroyAll() : void
      {
         for (var i:int = 0; i < MAX_WEAPON; i++)
         {
            for (var j:int = 0; j < MAX_BULLET[i]; j++)
            {
               bulletLists[i][j].kill();
            }
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

