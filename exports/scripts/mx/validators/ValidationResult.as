package mx.validators
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class ValidationResult
   {
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public var errorCode:String;
      
      public var errorMessage:String;
      
      public var isError:Boolean;
      
      public var subField:String;
      
      public function ValidationResult(param1:Boolean, param2:String = "", param3:String = "", param4:String = "")
      {
         super();
         this.isError = param1;
         this.subField = param2;
         this.errorMessage = param4;
         this.errorCode = param3;
      }
   }
}

