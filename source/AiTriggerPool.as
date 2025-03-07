package
{
   import org.flixel.*;
   
   public class AiTriggerPool extends FlxGroup
   {
      public var triggers:Array = new Array();
      
      private const MAX_TRIGGERS:int = 250;
      
      override public function destroy() : void
      {
         for(var i:String in triggers)
         {
            triggers[i].destroy();
         }
         super.destroy();
      }
      
      public function AiTriggerPool() : void
      {
         for (var i:int = 0; i < MAX_TRIGGERS; i++)
         {
            triggers[i] = new AiTrigger();
            add(triggers[i]);
         }
      }
      
      public function destroyAll() : void
      {
         for (var i:int = 0; i < MAX_TRIGGERS; i++)
         {
            triggers[i].kill();
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

