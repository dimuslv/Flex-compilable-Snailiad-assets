package mx.core
{
   import flash.display.Shape;
   import mx.utils.NameUtil;
   
   use namespace mx_internal;
   
   public class FlexShape extends Shape
   {
      mx_internal static const VERSION:String = "4.1.0.21490";
      
      public function FlexShape()
      {
         super();
         try
         {
            name = NameUtil.createUniqueName(this);
         }
         catch(e:Error)
         {
         }
      }
      
      override public function toString() : String
      {
         return NameUtil.displayObjectToString(this);
      }
   }
}

