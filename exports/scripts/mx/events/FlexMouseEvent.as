package mx.events
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class FlexMouseEvent extends MouseEvent
   {
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const MOUSE_DOWN_OUTSIDE:String = "mouseDownOutside";
      
      public static const MOUSE_WHEEL_OUTSIDE:String = "mouseWheelOutside";
      
      public function FlexMouseEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 0, param5:Number = 0, param6:InteractiveObject = null, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:int = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function clone() : Event
      {
         return new FlexMouseEvent(type,bubbles,cancelable,localX,localY,relatedObject,ctrlKey,altKey,shiftKey,buttonDown,delta);
      }
   }
}

