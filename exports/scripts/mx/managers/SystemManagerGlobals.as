package mx.managers
{
   public class SystemManagerGlobals
   {
      public static var bootstrapLoaderInfoURL:String;
      
      public static var showMouseCursor:Boolean;
      
      public static var changingListenersInOtherSystemManagers:Boolean;
      
      public static var dispatchingEventToOtherSystemManagers:Boolean;
      
      public static var info:Object;
      
      public static var parameters:Object;
      
      public static var topLevelSystemManagers:Array = [];
      
      public function SystemManagerGlobals()
      {
         super();
      }
   }
}

