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
      
      public function PlayerBulletGroups() : void
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
            return groups[param1 + 3].getFirstAvail();
         }
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

