package
{
   import org.flixel.*;
   
   public class AiTriggerPool extends FlxGroup
   {
      public var triggers:Array;
      
      private const MAX_TRIGGERS:int = 250;
      
      public function AiTriggerPool()
      {
         this.triggers = new Array();
         super();
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_TRIGGERS)
         {
            this.triggers[_loc1_] = new AiTrigger();
            add(this.triggers[_loc1_]);
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this.triggers)
         {
            this.triggers[_loc1_].destroy();
         }
         super.destroy();
      }
      
      public function destroyAll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_TRIGGERS)
         {
            this.triggers[_loc1_].kill();
            _loc1_++;
         }
      }
      
      public function addNew(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:AiTrigger = getFirstAvail() as AiTrigger;
         if(_loc4_)
         {
            _loc4_.create(param1,param2,param3);
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
      }
   }
}

