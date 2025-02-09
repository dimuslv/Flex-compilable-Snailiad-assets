package
{
   import org.flixel.*;
   
   public class BrokenBlock
   {
      public var X:int;
      
      public var Y:int;
      
      public var bgtile:int;
      
      public var fgtile:int;
      
      public function BrokenBlock(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this.X = param1;
         this.Y = param2;
         this.bgtile = param3;
         this.fgtile = param4;
      }
      
      public function repair() : void
      {
         PlayState.worldMap.bgmap.setTile(this.X,this.Y,this.bgtile);
         PlayState.worldMap.fgmap.setTile(this.X,this.Y,this.fgtile);
      }
   }
}

