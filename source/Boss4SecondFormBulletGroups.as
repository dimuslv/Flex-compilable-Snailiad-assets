package
{
   import org.flixel.*;
   
   public class Boss4SecondFormBulletGroups extends FlxGroup
   {
      private static const MAX_BULLET:Array = [120,20];
      
      private static const MAX_WEAPON:int = 2;
      
      public var groups:Array;
      
      public var bulletLists:Array;
      
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
      
      public function Boss4SecondFormBulletGroups() : void
      {
         groups = new Array();
         bulletLists = new Array();
         super();
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
      
      private function makeBullet(param1:int) : Boss4Bullet
      {
         switch(param1)
         {
            case 0:
               return new Boss4Bullet4();
            case 1:
               return new Boss4Bullet7();
         }
		 throw new Error("Unknown bullet type: " + param1.toString());
      }
      
      public function getBullet(param1:int) : Boss4Bullet
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

