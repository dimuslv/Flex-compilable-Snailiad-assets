package mx.utils
{
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import mx.binding.BindabilityInfo;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class DescribeTypeCache
   {
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static var typeCache:Object = {};
      
      private static var cacheHandlers:Object = {};
      
      registerCacheHandler("bindabilityInfo",bindabilityInfoHandler);
      
      public function DescribeTypeCache()
      {
         super();
      }
      
      public static function describeType(param1:*) : DescribeTypeCacheRecord
      {
         var _loc2_:String = null;
         var _loc3_:* = null;
         var _loc4_:XML = null;
         var _loc5_:DescribeTypeCacheRecord = null;
         if(param1 is String)
         {
            _loc3_ = _loc2_ = param1;
         }
         else
         {
            _loc3_ = _loc2_ = getQualifiedClassName(param1);
         }
         if(param1 is Class)
         {
            _loc3_ += "$";
         }
         if(_loc3_ in typeCache)
         {
            return typeCache[_loc3_];
         }
         if(param1 is String)
         {
            param1 = getDefinitionByName(param1);
         }
         _loc4_ = describeType(param1);
         _loc5_ = new DescribeTypeCacheRecord();
         _loc5_.typeDescription = _loc4_;
         _loc5_.typeName = _loc2_;
         typeCache[_loc3_] = _loc5_;
         return _loc5_;
      }
      
      public static function registerCacheHandler(param1:String, param2:Function) : void
      {
         cacheHandlers[param1] = param2;
      }
      
      internal static function extractValue(param1:String, param2:DescribeTypeCacheRecord) : *
      {
         if(param1 in cacheHandlers)
         {
            return cacheHandlers[param1](param2);
         }
         return undefined;
      }
      
      private static function bindabilityInfoHandler(param1:DescribeTypeCacheRecord) : *
      {
         return new BindabilityInfo(param1.typeDescription);
      }
   }
}

