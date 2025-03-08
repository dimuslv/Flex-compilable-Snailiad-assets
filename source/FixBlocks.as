package
{
   import org.flixel.*;
   
   public class FixBlocks
   {
      public var blocks:Array;
      
      public function destroy() : void
      {
         for(var i:String in blocks)
         {
            blocks[i] = null;
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
         for (var i:int = 0; i < blocks.length; i++)
         {
            blocks[i].repair();
         }
         blocks = new Array();
      }
   }
}

