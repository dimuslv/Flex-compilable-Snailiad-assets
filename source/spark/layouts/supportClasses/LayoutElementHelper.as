package spark.layouts.supportClasses
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class LayoutElementHelper
   {
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public function LayoutElementHelper()
      {
         super();
      }
      
      public static function pinBetween(param1:Number, param2:Number, param3:Number) : Number
      {
         return Math.min(param3,Math.max(param2,param1));
      }
      
      public static function parseConstraintValue(param1:Object) : Number
      {
         if(param1 is Number)
         {
            return Number(param1);
         }
         var _loc2_:String = param1 as String;
         if(!_loc2_)
         {
            return NaN;
         }
         var _loc3_:Array = parseConstraintExp(_loc2_);
         if(!_loc3_ || _loc3_.length < 1)
         {
            return NaN;
         }
         return _loc3_[0];
      }
      
      private static function parseConstraintExp(param1:String) : Array
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:String = param1.replace(/:/g," ");
         return _loc2_.split(/\s+/);
      }
   }
}

