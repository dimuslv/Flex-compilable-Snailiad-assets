package
{
   import org.flixel.*;
   
   public class EnemyBulletPool extends FlxGroup
   {
      public var groups:Array;
      
      public var bulletLists:Array;
      
      private var MAX_BULLET:Array;
      
      private var MAX_WEAPON:int;
      
      public function EnemyBulletPool()
      {
         var _loc1_:int = 0;
         this.groups = new Array();
         this.bulletLists = new Array();
         this.MAX_BULLET = [40,200,100,10,60,10,10,90,20];
         this.MAX_WEAPON = this.MAX_BULLET.length;
         super();
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_WEAPON)
         {
            this.groups[_loc2_] = new FlxGroup();
            this.bulletLists[_loc2_] = new Array();
            _loc1_ = 0;
            while(_loc1_ < this.MAX_BULLET[_loc2_])
            {
               this.bulletLists[_loc2_][_loc1_] = this.makeBullet(_loc2_);
               this.groups[_loc2_].add(this.bulletLists[_loc2_][_loc1_]);
               _loc1_++;
            }
            add(this.groups[_loc2_]);
            _loc2_++;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         super.destroy();
         for(_loc1_ in this.groups)
         {
            this.groups[_loc1_] = null;
         }
         for(_loc1_ in this.bulletLists)
         {
            this.bulletLists[_loc1_] = null;
         }
         this.groups = null;
         this.bulletLists = null;
      }
      
      public function destroyAll() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_WEAPON)
         {
            _loc1_ = 0;
            while(_loc1_ < this.MAX_BULLET[_loc2_])
            {
               this.bulletLists[_loc2_][_loc1_].kill();
               _loc1_++;
            }
            _loc2_++;
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
            default:
               throw new Error("Unknown bullet type: " + param1.toString());
         }
      }
      
      public function getBullet(param1:int) : EnemyBullet
      {
         return this.groups[param1].getFirstAvail();
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

