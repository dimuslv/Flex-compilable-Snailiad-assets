package
{
   import org.flixel.*;
   
   public class UniqueBlocks
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
      
      public function UniqueBlocks() : void
      {
         blocks = new Array();
      }
      
      public function rememberBlock(param1:int, param2:int) : void
      {
         blocks.push(new FlxPoint(param1,param2));
      }
      
      public function saveAll() : void
      {
         var _loc1_:XML = <uniqueBlocks/>;
         for (var i:int = 0; i < blocks.length; i++)
         {
            var _loc3_:XML = <b/>;
            _loc3_.@x = blocks[i].x;
            _loc3_.@y = blocks[i].y;
            _loc1_.appendChild(_loc3_);
         }
         if(PlayState.saveData.xml.uniqueBlocks != null)
         {
            delete PlayState.saveData.xml.uniqueBlocks;
         }
         PlayState.saveData.xml.appendChild(_loc1_);
      }
      
      public function loadAll() : void
      {
         blocks = new Array();
         if(!PlayState.saveData.data)
         {
            return;
         }
         for each(var i:XML in PlayState.saveData.xml.uniqueBlocks.b)
         {
            var _loc2_:int = i.@x;
            var _loc3_:int = i.@y;
            blocks.push(new FlxPoint(_loc2_,_loc3_));
            PlayState.worldMap.spmap.setTile(_loc2_,_loc3_,0);
         }
      }
   }
}

