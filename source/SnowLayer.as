package
{
   import org.flixel.*;
   
   public class SnowLayer extends FlxGroup
   {
      private const MAX_SNOWS:int = 60;
      
      public var snows:Array;
      
      public function SnowLayer() : void
      {
         this.snows = new Array();
         super();
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         super.destroy();
         for(_loc1_ in this.snows)
         {
            this.snows[_loc1_] = null;
         }
         snows = null;
      }
      
      public function destroyAll() : void
      {
         if(!this.snows[0])
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_SNOWS)
         {
            this.snows[_loc1_].kill();
            remove(this.snows[_loc1_],true);
            _loc1_++;
         }
      }
      
      public function makeSnows() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_SNOWS)
         {
            this.snows[_loc1_] = new Snow();
            add(this.snows[_loc1_]);
            _loc1_++;
         }
      }
   }
}

