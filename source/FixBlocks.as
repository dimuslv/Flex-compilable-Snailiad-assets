package
{
   import org.flixel.*;
   
   public class FixBlocks
   {
      public var blocks:Array;
      
      public function destroy() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in blocks)
         {
            blocks[_loc1_] = null;
         }
         blocks = null;
      }
      
      public function FixBlocks() : void
      {
         blocks = new Array();
      }
      
      public function rememberBlock(param1:int, param2:int, param3:int, param4:int) : void
      {
         blocks.push(new BrokenBlock(param1,param2,param3,param4));
      }
      
      public function repairAll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < blocks.length)
         {
            blocks[_loc1_].repair();
            _loc1_++;
         }
         blocks = new Array();
      }
   }
}

