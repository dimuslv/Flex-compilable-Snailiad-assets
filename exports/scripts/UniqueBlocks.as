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
         var _loc1_:XML = null;
         var _loc2_:XML = <uniqueBlocks/>;
         var _loc3_:int = 0;
         while(_loc3_ < this.blocks.length)
         {
            _loc1_ = <b/>;
            _loc1_.@x = this.blocks[_loc3_].x;
            _loc1_.@y = this.blocks[_loc3_].y;
            _loc2_.appendChild(_loc1_);
            _loc3_++;
         }
         if(PlayState.saveData.xml.uniqueBlocks != null)
         {
            delete PlayState.saveData.xml.uniqueBlocks;
         }
         PlayState.saveData.xml.appendChild(_loc2_);
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

