package mx.styles
{
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   import mx.core.IFlexModuleFactory;
   import mx.core.Singleton;
   import mx.core.mx_internal;
   import mx.managers.SystemManagerGlobals;
   
   use namespace mx_internal;
   
   public class StyleManager
   {
      private static var implClassDependency:StyleManagerImpl;
      
      private static var _impl:IStyleManager2;
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const NOT_A_COLOR:uint = 4294967295;
      
      public function StyleManager()
      {
         super();
      }
      
      private static function get impl() : IStyleManager2
      {
         if(!_impl)
         {
            _impl = IStyleManager2(Singleton.getInstance("mx.styles::IStyleManager2"));
         }
         return _impl;
      }
      
      public static function getStyleManager(param1:IFlexModuleFactory) : IStyleManager2
      {
         if(!param1)
         {
            param1 = SystemManagerGlobals.topLevelSystemManagers[0];
         }
         var _loc2_:IStyleManager2 = IStyleManager2(param1.getImplementation("mx.styles::IStyleManager2"));
         if(_loc2_ == null)
         {
            _loc2_ = impl;
         }
         return _loc2_;
      }
      
      mx_internal static function get stylesRoot() : Object
      {
         return impl.stylesRoot;
      }
      
      mx_internal static function set stylesRoot(param1:Object) : void
      {
         impl.stylesRoot = param1;
      }
      
      mx_internal static function get inheritingStyles() : Object
      {
         return impl.inheritingStyles;
      }
      
      mx_internal static function set inheritingStyles(param1:Object) : void
      {
         impl.inheritingStyles = param1;
      }
      
      mx_internal static function get typeHierarchyCache() : Object
      {
         return impl.typeHierarchyCache;
      }
      
      mx_internal static function set typeHierarchyCache(param1:Object) : void
      {
         impl.typeHierarchyCache = param1;
      }
      
      mx_internal static function get typeSelectorCache() : Object
      {
         return impl.typeSelectorCache;
      }
      
      mx_internal static function set typeSelectorCache(param1:Object) : void
      {
         impl.typeSelectorCache = param1;
      }
      
      mx_internal static function initProtoChainRoots() : void
      {
         impl.initProtoChainRoots();
      }
      
      public static function get selectors() : Array
      {
         return impl.selectors;
      }
      
      public static function getStyleDeclaration(param1:String) : CSSStyleDeclaration
      {
         return impl.getStyleDeclaration(param1);
      }
      
      public static function setStyleDeclaration(param1:String, param2:CSSStyleDeclaration, param3:Boolean) : void
      {
         impl.setStyleDeclaration(param1,param2,param3);
      }
      
      public static function clearStyleDeclaration(param1:String, param2:Boolean) : void
      {
         impl.clearStyleDeclaration(param1,param2);
      }
      
      mx_internal static function styleDeclarationsChanged() : void
      {
         impl.styleDeclarationsChanged();
      }
      
      public static function registerInheritingStyle(param1:String) : void
      {
         impl.registerInheritingStyle(param1);
      }
      
      public static function isInheritingStyle(param1:String) : Boolean
      {
         return impl.isInheritingStyle(param1);
      }
      
      public static function isInheritingTextFormatStyle(param1:String) : Boolean
      {
         return impl.isInheritingTextFormatStyle(param1);
      }
      
      public static function registerSizeInvalidatingStyle(param1:String) : void
      {
         impl.registerSizeInvalidatingStyle(param1);
      }
      
      public static function isSizeInvalidatingStyle(param1:String) : Boolean
      {
         return impl.isSizeInvalidatingStyle(param1);
      }
      
      public static function registerParentSizeInvalidatingStyle(param1:String) : void
      {
         impl.registerParentSizeInvalidatingStyle(param1);
      }
      
      public static function isParentSizeInvalidatingStyle(param1:String) : Boolean
      {
         return impl.isParentSizeInvalidatingStyle(param1);
      }
      
      public static function registerParentDisplayListInvalidatingStyle(param1:String) : void
      {
         impl.registerParentDisplayListInvalidatingStyle(param1);
      }
      
      public static function isParentDisplayListInvalidatingStyle(param1:String) : Boolean
      {
         return impl.isParentDisplayListInvalidatingStyle(param1);
      }
      
      public static function registerColorName(param1:String, param2:uint) : void
      {
         impl.registerColorName(param1,param2);
      }
      
      public static function isColorName(param1:String) : Boolean
      {
         return impl.isColorName(param1);
      }
      
      public static function getColorName(param1:Object) : uint
      {
         return impl.getColorName(param1);
      }
      
      public static function getColorNames(param1:Array) : void
      {
         impl.getColorNames(param1);
      }
      
      public static function isValidStyleValue(param1:*) : Boolean
      {
         return impl.isValidStyleValue(param1);
      }
      
      public static function loadStyleDeclarations(param1:String, param2:Boolean = true, param3:Boolean = false, param4:ApplicationDomain = null, param5:SecurityDomain = null) : IEventDispatcher
      {
         return impl.loadStyleDeclarations2(param1,param2,param4,param5);
      }
      
      public static function unloadStyleDeclarations(param1:String, param2:Boolean = true) : void
      {
         impl.unloadStyleDeclarations(param1,param2);
      }
   }
}

