package mx.styles
{
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mx.core.Singleton;
   import mx.core.mx_internal;
   import mx.managers.ISystemManager;
   import mx.managers.SystemManagerGlobals;
   import mx.utils.ObjectUtil;
   
   use namespace mx_internal;
   
   public class CSSStyleDeclaration extends EventDispatcher
   {
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static const NOT_A_COLOR:uint = 4294967295;
      
      private static const FILTERMAP_PROP:String = "__reserved__filterMap";
      
      private var clones:Dictionary;
      
      mx_internal var selectorRefCount:int = 0;
      
      mx_internal var effects:Array;
      
      private var styleManager:IStyleManager2;
      
      private var _defaultFactory:Function;
      
      private var _factory:Function;
      
      private var _overrides:Object;
      
      private var _selector:CSSSelector;
      
      private var _selectorString:String;
      
      public function CSSStyleDeclaration(param1:Object = null, param2:IStyleManager2 = null, param3:Boolean = true)
      {
         this.clones = new Dictionary(true);
         super();
         if(!param2)
         {
            param2 = Singleton.getInstance("mx.styles::IStyleManager2") as IStyleManager2;
         }
         this.styleManager = param2;
         if(param1)
         {
            if(param1 is CSSSelector)
            {
               this.selector = param1 as CSSSelector;
            }
            else
            {
               this.mx_internal::selectorString = param1.toString();
            }
            if(param3)
            {
               param2.setStyleDeclaration(this.mx_internal::selectorString,this,false);
            }
         }
      }
      
      public function get defaultFactory() : Function
      {
         return this._defaultFactory;
      }
      
      public function set defaultFactory(param1:Function) : void
      {
         this._defaultFactory = param1;
      }
      
      public function get factory() : Function
      {
         return this._factory;
      }
      
      public function set factory(param1:Function) : void
      {
         this._factory = param1;
      }
      
      public function get overrides() : Object
      {
         return this._overrides;
      }
      
      public function set overrides(param1:Object) : void
      {
         this._overrides = param1;
      }
      
      public function get selector() : CSSSelector
      {
         return this._selector;
      }
      
      public function set selector(param1:CSSSelector) : void
      {
         this._selector = param1;
         this._selectorString = null;
      }
      
      mx_internal function get selectorString() : String
      {
         if(this._selectorString == null && this._selector != null)
         {
            this._selectorString = this._selector.toString();
         }
         return this._selectorString;
      }
      
      mx_internal function set selectorString(param1:String) : void
      {
         var _loc2_:CSSCondition = null;
         if(param1.charAt(0) == ".")
         {
            _loc2_ = new CSSCondition(CSSConditionKind.CLASS,param1.substr(1));
            this._selector = new CSSSelector("",[_loc2_]);
         }
         else
         {
            this._selector = new CSSSelector(param1);
         }
         this._selectorString = param1;
      }
      
      public function get specificity() : int
      {
         return !!this._selector ? this._selector.specificity : 0;
      }
      
      public function get subject() : String
      {
         if(this._selector != null)
         {
            if(this._selector.subject == "" && Boolean(this._selector.conditions))
            {
               return "*";
            }
            return this._selector.subject;
         }
         return null;
      }
      
      mx_internal function getPseudoCondition() : String
      {
         return this.selector != null ? this.selector.mx_internal::getPseudoCondition() : null;
      }
      
      mx_internal function isAdvanced() : Boolean
      {
         var _loc1_:CSSCondition = null;
         if(this.selector != null)
         {
            if(this.selector.ancestor)
            {
               return true;
            }
            if(this.selector.conditions)
            {
               if(this.subject != "*" && this.subject != "global")
               {
                  return true;
               }
               for each(_loc1_ in this.selector.conditions)
               {
                  if(_loc1_.kind != CSSConditionKind.CLASS)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function matchesStyleClient(param1:IAdvancedStyleClient) : Boolean
      {
         return this.selector != null ? this.selector.matchesStyleClient(param1) : false;
      }
      
      mx_internal function equals(param1:CSSStyleDeclaration) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 == null)
         {
            return false;
         }
         if(ObjectUtil.compare(this.overrides,param1.overrides) != 0)
         {
            return false;
         }
         if(this.factory == null && param1.factory != null || this.factory != null && param1.factory == null)
         {
            return false;
         }
         if(this.factory != null)
         {
            if(ObjectUtil.compare(new this.factory(),new param1.factory()) != 0)
            {
               return false;
            }
         }
         if(this.defaultFactory == null && param1.defaultFactory != null || this.defaultFactory != null && param1.defaultFactory == null)
         {
            return false;
         }
         if(this.defaultFactory != null)
         {
            if(ObjectUtil.compare(new this.defaultFactory(),new param1.defaultFactory()) != 0)
            {
               return false;
            }
         }
         if(ObjectUtil.compare(this.mx_internal::effects,param1.mx_internal::effects))
         {
            return false;
         }
         return true;
      }
      
      public function getStyle(param1:String) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(this.overrides)
         {
            if(param1 in this.overrides && this.overrides[param1] === undefined)
            {
               return undefined;
            }
            _loc3_ = this.overrides[param1];
            if(_loc3_ !== undefined)
            {
               return _loc3_;
            }
         }
         if(this.factory != null)
         {
            this.factory.prototype = {};
            _loc2_ = new this.factory();
            _loc3_ = _loc2_[param1];
            if(_loc3_ !== undefined)
            {
               return _loc3_;
            }
         }
         if(this.defaultFactory != null)
         {
            this.defaultFactory.prototype = {};
            _loc2_ = new this.defaultFactory();
            _loc3_ = _loc2_[param1];
            if(_loc3_ !== undefined)
            {
               return _loc3_;
            }
         }
         return undefined;
      }
      
      public function setStyle(param1:String, param2:*) : void
      {
         var _loc7_:int = 0;
         var _loc8_:ISystemManager = null;
         var _loc9_:Object = null;
         var _loc3_:Object = this.getStyle(param1);
         var _loc4_:Boolean = false;
         if(this.mx_internal::selectorRefCount > 0 && this.factory == null && this.defaultFactory == null && !this.overrides && _loc3_ !== param2)
         {
            _loc4_ = true;
         }
         if(param2 !== undefined)
         {
            this.mx_internal::setLocalStyle(param1,param2);
         }
         else
         {
            if(param2 == _loc3_)
            {
               return;
            }
            this.mx_internal::setLocalStyle(param1,param2);
         }
         var _loc5_:Array = SystemManagerGlobals.topLevelSystemManagers;
         var _loc6_:int = int(_loc5_.length);
         if(_loc4_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc8_ = _loc5_[_loc7_];
               _loc9_ = _loc8_.getImplementation("mx.managers::ISystemManagerChildManager");
               _loc9_.regenerateStyleCache(true);
               _loc7_++;
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc5_[_loc7_];
            _loc9_ = _loc8_.getImplementation("mx.managers::ISystemManagerChildManager");
            _loc9_.notifyStyleChangeInChildren(param1,true);
            _loc7_++;
         }
      }
      
      mx_internal function setLocalStyle(param1:String, param2:*) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc3_:Object = this.getStyle(param1);
         if(param2 === undefined)
         {
            this.clearStyleAttr(param1);
            return;
         }
         if(param2 is String)
         {
            if(!this.styleManager)
            {
               this.styleManager = Singleton.getInstance("mx.styles::IStyleManager2") as IStyleManager2;
            }
            _loc5_ = Number(this.styleManager.getColorName(param2));
            if(_loc5_ != NOT_A_COLOR)
            {
               param2 = _loc5_;
            }
         }
         if(this.defaultFactory != null)
         {
            _loc4_ = new this.defaultFactory();
            if(_loc4_[param1] !== param2)
            {
               if(!this.overrides)
               {
                  this.overrides = {};
               }
               this.overrides[param1] = param2;
            }
            else if(this.overrides)
            {
               delete this.overrides[param1];
            }
         }
         if(this.factory != null)
         {
            _loc4_ = new this.factory();
            if(_loc4_[param1] !== param2)
            {
               if(!this.overrides)
               {
                  this.overrides = {};
               }
               this.overrides[param1] = param2;
            }
            else if(this.overrides)
            {
               delete this.overrides[param1];
            }
         }
         if(this.defaultFactory == null && this.factory == null)
         {
            if(!this.overrides)
            {
               this.overrides = {};
            }
            this.overrides[param1] = param2;
         }
         this.mx_internal::updateClones(param1,param2);
      }
      
      public function clearStyle(param1:String) : void
      {
         this.setStyle(param1,undefined);
      }
      
      mx_internal function createProtoChainRoot() : Object
      {
         var _loc1_:Object = {};
         if(this.defaultFactory != null)
         {
            this.defaultFactory.prototype = _loc1_;
            _loc1_ = new this.defaultFactory();
         }
         if(this.factory != null)
         {
            this.factory.prototype = _loc1_;
            _loc1_ = new this.factory();
         }
         this.clones[_loc1_] = 1;
         return _loc1_;
      }
      
      mx_internal function addStyleToProtoChain(param1:Object, param2:DisplayObject, param3:Object = null) : Object
      {
         var objectFactory:Object;
         var parentStyle:CSSStyleDeclaration = null;
         var p:String = null;
         var emptyObjectFactory:Function = null;
         var filteredChain:Object = null;
         var filterObjectFactory:Function = null;
         var i:String = null;
         var chain:Object = param1;
         var target:DisplayObject = param2;
         var filterMap:Object = param3;
         var nodeAddedToChain:Boolean = false;
         var originalChain:Object = chain;
         if(filterMap)
         {
            chain = {};
         }
         if(this.styleManager.parent)
         {
            parentStyle = this.styleManager.parent.getStyleDeclaration(this.mx_internal::selectorString);
            if(parentStyle)
            {
               chain = parentStyle.mx_internal::addStyleToProtoChain(chain,target,filterMap);
            }
         }
         if(this.defaultFactory != null)
         {
            this.defaultFactory.prototype = chain;
            chain = new this.defaultFactory();
            nodeAddedToChain = true;
         }
         objectFactory = null;
         if(this.factory != null)
         {
            objectFactory = new this.factory();
            this.factory.prototype = chain;
            chain = new this.factory();
            nodeAddedToChain = true;
         }
         if(this.overrides)
         {
            if(this.defaultFactory == null && this.factory == null)
            {
               emptyObjectFactory = function():void
               {
               };
               emptyObjectFactory.prototype = chain;
               chain = new emptyObjectFactory();
               nodeAddedToChain = true;
            }
            for(p in this.overrides)
            {
               if(this.overrides[p] === undefined)
               {
                  delete chain[p];
               }
               else
               {
                  chain[p] = this.overrides[p];
               }
            }
         }
         if(filterMap)
         {
            if(nodeAddedToChain)
            {
               filteredChain = {};
               filterObjectFactory = function():void
               {
               };
               filterObjectFactory.prototype = originalChain;
               filteredChain = new filterObjectFactory();
               for(i in chain)
               {
                  if(filterMap[i] != null)
                  {
                     filteredChain[filterMap[i]] = chain[i];
                  }
               }
               chain = filteredChain;
               chain[FILTERMAP_PROP] = filterMap;
            }
            else
            {
               chain = originalChain;
            }
         }
         if(nodeAddedToChain)
         {
            this.clones[chain] = 1;
         }
         return chain;
      }
      
      mx_internal function clearOverride(param1:String) : void
      {
         if(Boolean(this.overrides) && this.overrides[param1] !== undefined)
         {
            delete this.overrides[param1];
         }
      }
      
      private function clearStyleAttr(param1:String) : void
      {
         var _loc2_:* = undefined;
         if(!this.overrides)
         {
            this.overrides = {};
         }
         this.overrides[param1] = undefined;
         for(_loc2_ in this.clones)
         {
            delete _loc2_[param1];
         }
      }
      
      mx_internal function updateClones(param1:String, param2:*) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         for(_loc3_ in this.clones)
         {
            _loc4_ = _loc3_[FILTERMAP_PROP];
            if(_loc4_)
            {
               if(_loc4_[param1] != null)
               {
                  _loc3_[_loc4_[param1]] = param2;
               }
            }
            else
            {
               _loc3_[param1] = param2;
            }
         }
      }
   }
}

