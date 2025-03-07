package
{
   import org.flixel.*;
   
   public class SnowLayer extends FlxGroup
   {
      private const MAX_SNOWS:int = 60;
      
      public var snows:Array = new Array();
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         super.destroy();
         for(_loc1_ in snows)
         {
            snows[_loc1_] = null;
         }
         snows = null;
      }
      
      public function SnowLayer() : void
      {
      }
      
      public function destroyAll() : void
      {
         if(!snows[0])
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < MAX_SNOWS)
         {
            snows[_loc1_].kill();
            remove(snows[_loc1_],true);
            _loc1_++;
         }
      }
      
      public function makeSnows() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < MAX_SNOWS)
         {
            snows[_loc1_] = new Snow();
            add(snows[_loc1_]);
            _loc1_++;
         }
      }
   }
}

