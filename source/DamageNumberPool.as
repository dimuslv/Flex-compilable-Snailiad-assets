package
{
   import org.flixel.*;
   
   public class DamageNumberPool extends FlxGroup
   {
      private const MAX_NUMBER:int = 80;
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      public function DamageNumberPool() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_NUMBER)
         {
            add(new DamageNumber());
            _loc1_++;
         }
      }
      
      public function makeText(param1:int, param2:int, param3:String, param4:int = 1, param5:int = 0, param6:int = 0) : DamageNumber
      {
         var _loc7_:DamageNumber = getFirstAvail() as DamageNumber;
         if(_loc7_)
         {
            _loc7_.makeText(param1 + FlxU.random() * param5 * 2 - param5,param2 + FlxU.random() * param6 * 2 - param6,param3,param4);
         }
         return _loc7_;
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

