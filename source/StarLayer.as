package
{
   import org.flixel.*;
   
   public class StarLayer extends FlxGroup
   {
      private const MAX_STARS:int = 15;
      
      public var stars:Array = new Array();
      
      override public function destroy() : void
      {
         super.destroy();
         for(var i:String in stars)
         {
            stars[i] = null;
         }
         stars = null;
      }
      
      public function StarLayer() : void
      {
      }
      
      public function destroyAll() : void
      {
         if(!stars[0])
         {
            return;
         }
         for (var i:int = 0; i < MAX_STARS; i++)
         {
            stars[i].kill();
            remove(stars[i],true);
         }
      }
      
      public function makeStars() : void
      {
         for (var i:int = 0; i < MAX_STARS; i++)
         {
            stars[i] = new Star();
            add(stars[i]);
         }
      }
   }
}

