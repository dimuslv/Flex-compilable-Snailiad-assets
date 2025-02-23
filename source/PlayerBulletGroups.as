package
{
   import org.flixel.*;
   
   public class PlayerBulletGroups extends FlxGroup
   {
      public var groups:Array = new Array();
      
      public var bulletLists:Array = new Array();
	  
	  private const MAX_BULLET:Array = [4,20,60,20,20,60];
      
      private const MAX_WEAPON:int = 6;
      
      override public function destroy() : void
      {
         super.destroy();
         for(var _loc1_:String in this.groups)
         {
            this.groups[_loc1_] = null;
         }
         for(_loc1_ in this.bulletLists)
         {
            this.bulletLists[_loc1_] = null;
         }
         groups = null;
         bulletLists = null;
      }
      
      public function PlayerBulletGroups() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_WEAPON)
         {
            this.groups[_loc1_] = new FlxGroup();
            this.bulletLists[_loc1_] = new Array();
            var _loc2_:int = 0;
            while(_loc2_ < this.MAX_BULLET[_loc1_])
            {
               this.bulletLists[_loc1_][_loc2_] = this.makeBullet(_loc1_);
               this.groups[_loc1_].add(this.bulletLists[_loc1_][_loc2_]);
               _loc2_++;
            }
            add(this.groups[_loc1_]);
            _loc1_++;
         }
      }
      
      public function destroyAll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_WEAPON)
         {
            var _loc2_:int = 0;
            while(_loc2_ < this.MAX_BULLET[_loc1_])
            {
               this.bulletLists[_loc1_][_loc2_].kill();
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function makeBullet(param1:int) : PlayerBullet
      {
         switch(param1)
         {
            case 0:
               return new PlayerBullet1();
            case 1:
               return new PlayerBullet2();
            case 2:
               return new PlayerBullet3();
            case 3:
               return new PlayerBullet4();
            case 4:
               return new PlayerBullet5();
            case 5:
               return new PlayerBullet6();
         }
		 throw new Error("Unknown bullet type: " + param1.toString());
      }
      
      public function getBullet(param1:int, param2:Boolean) : PlayerBullet
      {
         if(param2)
         {
            return this.groups[param1 + 3].getFirstAvail();
         }
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

