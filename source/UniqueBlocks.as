package
{
   import org.flixel.*;
   
   public class UniqueBlocks
   {
      public var blocks:Array;
      
      public function UniqueBlocks()
      {
         super();
         this.blocks = new Array();
      }
      
      public function destroy() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this.blocks)
         {
            this.blocks[_loc1_] = null;
         }
         this.blocks = null;
      }
      
      public function rememberBlock(param1:int, param2:int) : void
      {
         this.blocks.push(new FlxPoint(param1,param2));
      }
      
      public function saveAll() : void
      {
         var _loc3_:XML = null;
         var _loc1_:XML = <uniqueBlocks/>;
         var _loc2_:int = 0;
         while(_loc2_ < this.blocks.length)
         {
            _loc3_ = <b/>;
            _loc3_.@x = this.blocks[_loc2_].x;
            _loc3_.@y = this.blocks[_loc2_].y;
            _loc1_.appendChild(_loc3_);
            _loc2_++;
         }
         if(PlayState.saveData.xml.uniqueBlocks != null)
         {
            delete PlayState.saveData.xml.uniqueBlocks;
         }
         PlayState.saveData.xml.appendChild(_loc1_);
      }
      
      public function loadAll() : void
      {
         var _loc1_:XML = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.blocks = new Array();
         if(!PlayState.saveData.data)
         {
            return;
         }
         for each(_loc1_ in PlayState.saveData.xml.uniqueBlocks.b)
         {
            _loc2_ = int(_loc1_.@x);
            _loc3_ = int(_loc1_.@y);
            this.blocks.push(new FlxPoint(_loc2_,_loc3_));
            PlayState.worldMap.spmap.setTile(_loc2_,_loc3_,0);
         }
      }
   }
}

