package
{
   import org.flixel.*;
   
   public class StarInwardLayer extends FlxGroup
   {
      private const MAX_STARS:int = 24;
      
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
      
      public function StarInwardLayer() : void
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
      
      public function setAlpha(param1:Number) : void
      {
         for (var i:int = 0; i < MAX_STARS; i++)
         {
            stars[i].alpha = param1;
         }
      }
      
      public function makeStars() : void
      {
         for (var i:int = 0; i < MAX_STARS; i++)
         {
            stars[i] = new StarInward();
            add(stars[i]);
         }
      }
   }
}

