package mx.effects.effectClasses
{
   import mx.core.mx_internal;
   import mx.effects.EffectTargetFilter;
   
   use namespace mx_internal;
   
   public class AddRemoveEffectTargetFilter extends EffectTargetFilter
   {
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public var add:Boolean = true;
      
      public function AddRemoveEffectTargetFilter()
      {
         super();
         filterProperties = ["parent"];
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
               if(this.add)
               {
                  return _loc5_.start["parent"] == null && _loc5_.end["parent"] != null;
               }
               return _loc5_.start["parent"] != null && _loc5_.end["parent"] == null;
            }
            _loc4_++;
         }
         return false;
      }
   }
}

