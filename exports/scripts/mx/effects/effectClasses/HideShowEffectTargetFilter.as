package mx.effects.effectClasses
{
   import mx.core.mx_internal;
   import mx.effects.EffectTargetFilter;
   
   use namespace mx_internal;
   
   public class HideShowEffectTargetFilter extends EffectTargetFilter
   {
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public var show:Boolean = true;
      
      public function HideShowEffectTargetFilter()
      {
         super();
         filterProperties = ["visible"];
      }
      
      override protected function defaultFilterFunction(param1:Array, param2:Object) : Boolean
      {
         var _loc5_:PropertyChanges = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.target == param2)
            {
               return _loc5_.end["visible"] == this.show;
            }
            _loc4_++;
         }
         return false;
      }
   }
}

