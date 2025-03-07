package
{
   import org.flixel.*;
   
   public class BrokenBlock
   {
      public var X:int;
      
      public var Y:int;
      
      public var bgtile:int;
      
      public var fgtile:int;
      
      public function BrokenBlock(param1:int, param2:int, param3:int, param4:int) : void
      {
         super();
         X = param1;
         Y = param2;
         bgtile = param3;
         fgtile = param4;
      }
      
      public function repair() : void
      {
         PlayState.worldMap.bgmap.setTile(X,Y,bgtile);
         PlayState.worldMap.fgmap.setTile(X,Y,fgtile);
      }
   }
}

