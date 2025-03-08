package
{
   import org.flixel.*;
   
   public class SnowLayer extends FlxGroup
   {
      private const MAX_SNOWS:int = 60;
      
      public var snows:Array = new Array();
      
      override public function destroy() : void
      {
         super.destroy();
         for(var i:String in snows)
         {
            snows[i] = null;
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
         for (var i:int = 0; i < MAX_SNOWS; i++)
         {
            snows[i].kill();
            remove(snows[i],true);
         }
      }
      
      public function makeSnows() : void
      {
         for (var i:int = 0; i < MAX_SNOWS; i++)
         {
            snows[i] = new Snow();
            add(snows[i]);
         }
      }
   }
}

