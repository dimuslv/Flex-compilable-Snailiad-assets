package
{
   import org.flixel.*;
   
   public class Boss4BulletGroups extends FlxGroup
   {
      private static const MAX_BULLET:Array = [20,20,60];
      
      private static const MAX_WEAPON:int = 3;
      
      public var groups:Array = new Array();
      
      public var bulletLists:Array = new Array();
      
      override public function destroy() : void
      {
         super.destroy();
         for(var i:String in this.groups)
         {
            this.groups[i] = null;
         }
         for(i in this.bulletLists)
         {
            this.bulletLists[i] = null;
         }
         groups = null;
         bulletLists = null;
      }
      
      public function destroyAll() : void
      {
         for (var i:int = 0; i < MAX_WEAPON; i++)
         {
            for (var j:int = 0; j < MAX_BULLET[i]; j++)
            {
               this.bulletLists[i][j].kill();
            }
         }
      }
      
      public function Boss4BulletGroups() : void
      {
         for (var i:int = 0; i < MAX_WEAPON; i++)
         {
            this.groups[i] = new FlxGroup();
            this.bulletLists[i] = new Array();
            for (var j:int = 0; j < MAX_BULLET[i]; j++)
            {
               this.bulletLists[i][j] = this.makeBullet(i);
               this.groups[i].add(this.bulletLists[i][j]);
            }
            add(this.groups[i]);
         }
      }
      
      private function makeBullet(param1:int) : Boss4Bullet
      {
         switch(param1)
         {
            case 0:
               return new Boss4Bullet4();
            case 1:
               return new Boss4Bullet5();
            case 2:
               return new Boss4Bullet6();
         }
		 throw new Error("Unknown bullet type: " + param1.toString());
      }
      
      public function getBullet(param1:int) : Boss4Bullet
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

