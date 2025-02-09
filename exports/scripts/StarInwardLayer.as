package
{
   import org.flixel.*;
   
   public class StarInwardLayer extends FlxGroup
   {
      private const MAX_STARS:int = 24;
      
      public var stars:Array;
      
      public function StarInwardLayer()
      {
         this.stars = new Array();
         super();
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         super.destroy();
         for(_loc1_ in this.stars)
         {
            this.stars[_loc1_] = null;
         }
         this.stars = null;
      }
      
      public function destroyAll() : void
      {
         if(!this.stars[0])
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_STARS)
         {
            this.stars[_loc1_].kill();
            remove(this.stars[_loc1_],true);
            _loc1_++;
         }
      }
      
      public function setAlpha(param1:Number) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_STARS)
         {
            this.stars[_loc2_].alpha = param1;
            _loc2_++;
         }
      }
      
      public function makeStars() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_STARS)
         {
            this.stars[_loc1_] = new StarInward();
            add(this.stars[_loc1_]);
            _loc1_++;
         }
      }
   }
}

