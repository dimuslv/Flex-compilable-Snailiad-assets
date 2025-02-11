package mx.effects.effectClasses
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class PropertyChanges
   {
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public var end:Object;
      
      public var start:Object;
      
      public var target:Object;
      
      public var stripUnchangedValues:Boolean = true;
      
      public function PropertyChanges(param1:Object)
      {
         this.end = {};
         this.start = {};
         super();
         this.target = param1;
      }
   }
}

