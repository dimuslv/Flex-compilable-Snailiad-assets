package spark.layouts.supportClasses
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mx.core.ILayoutElement;
   import mx.core.UIComponentGlobals;
   import mx.core.mx_internal;
   import mx.events.DragEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.ILayoutManagerClient;
   import mx.utils.OnDemandEventDispatcher;
   import spark.components.supportClasses.GroupBase;
   import spark.components.supportClasses.OverlayDepth;
   import spark.core.NavigationUnit;
   
   use namespace mx_internal;
   
   public class LayoutBase extends OnDemandEventDispatcher
   {
      private var _target:GroupBase;
      
      private var _useVirtualLayout:Boolean = false;
      
      private var _horizontalScrollPosition:Number = 0;
      
      private var _verticalScrollPosition:Number = 0;
      
      private var _clipAndEnableScrolling:Boolean = false;
      
      private var _typicalLayoutElement:ILayoutElement = null;
      
      private var _dropIndicator:DisplayObject;
      
      private var _dragScrollTimer:Timer;
      
      private var _dragScrollDelta:Point;
      
      private var _dragScrollEvent:DragEvent;
      
      mx_internal var dragScrollRegionSizeHorizontal:Number = 20;
      
      mx_internal var dragScrollRegionSizeVertical:Number = 20;
      
      mx_internal var dragScrollSpeed:Number = 5;
      
      mx_internal var dragScrollInitialDelay:int = 250;
      
      mx_internal var dragScrollInterval:int = 32;
      
      mx_internal var dragScrollHidesIndicator:Boolean = false;
      
      public function LayoutBase()
      {
         super();
      }
      
      public function get target() : GroupBase
      {
         return this._target;
      }
      
      public function set target(param1:GroupBase) : void
      {
         if(this._target == param1)
         {
            return;
         }
         this.clearVirtualLayoutCache();
         this._target = param1;
      }
      
      public function get useVirtualLayout() : Boolean
      {
         return this._useVirtualLayout;
      }
      
      public function set useVirtualLayout(param1:Boolean) : void
      {
         if(this._useVirtualLayout == param1)
         {
            return;
         }
         dispatchEvent(new Event("useVirtualLayoutChanged"));
         if(this._useVirtualLayout && !param1)
         {
            this.clearVirtualLayoutCache();
         }
         this._useVirtualLayout = param1;
         if(this.target)
         {
            this.target.invalidateDisplayList();
         }
      }
      
      public function clearVirtualLayoutCache() : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get horizontalScrollPosition() : Number
      {
         return this._horizontalScrollPosition;
      }
      
      private function set _754184102horizontalScrollPosition(param1:Number) : void
      {
         if(param1 == this._horizontalScrollPosition)
         {
            return;
         }
         this._horizontalScrollPosition = param1;
         this.scrollPositionChanged();
      }
      
      [Bindable(event="propertyChange")]
      public function get verticalScrollPosition() : Number
      {
         return this._verticalScrollPosition;
      }
      
      private function set _1010846676verticalScrollPosition(param1:Number) : void
      {
         if(param1 == this._verticalScrollPosition)
         {
            return;
         }
         this._verticalScrollPosition = param1;
         this.scrollPositionChanged();
      }
      
      public function get clipAndEnableScrolling() : Boolean
      {
         return this._clipAndEnableScrolling;
      }
      
      public function set clipAndEnableScrolling(param1:Boolean) : void
      {
         if(param1 == this._clipAndEnableScrolling)
         {
            return;
         }
         this._clipAndEnableScrolling = param1;
         var _loc2_:GroupBase = this.target;
         if(_loc2_)
         {
            this.updateScrollRect(_loc2_.width,_loc2_.height);
         }
      }
      
      public function get typicalLayoutElement() : ILayoutElement
      {
         if(!this._typicalLayoutElement && this.target && this.target.numElements > 0)
         {
            this._typicalLayoutElement = this.target.getElementAt(0);
         }
         return this._typicalLayoutElement;
      }
      
      public function set typicalLayoutElement(param1:ILayoutElement) : void
      {
         if(this._typicalLayoutElement == param1)
         {
            return;
         }
         this._typicalLayoutElement = param1;
         var _loc2_:GroupBase = this.target;
         if(_loc2_)
         {
            _loc2_.invalidateSize();
         }
      }
      
      public function get dropIndicator() : DisplayObject
      {
         return this._dropIndicator;
      }
      
      public function set dropIndicator(param1:DisplayObject) : void
      {
         if(this._dropIndicator)
         {
            this.target.overlay.removeDisplayObject(this._dropIndicator);
         }
         this._dropIndicator = param1;
         if(this._dropIndicator)
         {
            this._dropIndicator.visible = false;
            this.target.overlay.addDisplayObject(this._dropIndicator,OverlayDepth.DROP_INDICATOR);
            if(this._dropIndicator is ILayoutManagerClient)
            {
               UIComponentGlobals.mx_internal::layoutManager.validateClient(ILayoutManagerClient(this._dropIndicator),true);
            }
            if(this._dropIndicator is ILayoutElement)
            {
               ILayoutElement(this._dropIndicator).includeInLayout = false;
            }
         }
      }
      
      public function measure() : void
      {
      }
      
      public function updateDisplayList(param1:Number, param2:Number) : void
      {
      }
      
      public function elementAdded(param1:int) : void
      {
      }
      
      public function elementRemoved(param1:int) : void
      {
      }
      
      protected function scrollPositionChanged() : void
      {
         var _loc1_:GroupBase = this.target;
         if(!_loc1_)
         {
            return;
         }
         this.updateScrollRect(_loc1_.width,_loc1_.height);
      }
      
      public function updateScrollRect(param1:Number, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:GroupBase = this.target;
         if(!_loc3_)
         {
            return;
         }
         if(this.clipAndEnableScrolling)
         {
            _loc4_ = this.horizontalScrollPosition;
            _loc5_ = this.verticalScrollPosition;
            _loc3_.scrollRect = new Rectangle(_loc4_,_loc5_,param1,param2);
         }
         else
         {
            _loc3_.scrollRect = null;
         }
      }
      
      public function getNavigationDestinationIndex(param1:int, param2:uint, param3:Boolean) : int
      {
         if(!this.target || this.target.numElements < 1)
         {
            return -1;
         }
         switch(param2)
         {
            case NavigationUnit.HOME:
               return 0;
            case NavigationUnit.END:
               return this.target.numElements - 1;
            default:
               return -1;
         }
      }
      
      protected function getScrollRect() : Rectangle
      {
         var _loc1_:GroupBase = this.target;
         if(!_loc1_ || !_loc1_.clipAndEnableScrolling)
         {
            return null;
         }
         var _loc2_:Number = _loc1_.verticalScrollPosition;
         var _loc3_:Number = _loc1_.horizontalScrollPosition;
         return new Rectangle(_loc3_,_loc2_,_loc1_.width,_loc1_.height);
      }
      
      public function getElementBounds(param1:int) : Rectangle
      {
         var _loc2_:GroupBase = this.target;
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:int = _loc2_.numElements;
         if(param1 < 0 || param1 >= _loc3_)
         {
            return null;
         }
         var _loc4_:ILayoutElement = _loc2_.getElementAt(param1);
         if(!_loc4_ || !_loc4_.includeInLayout)
         {
            return null;
         }
         var _loc5_:Number = _loc4_.getLayoutBoundsX();
         var _loc6_:Number = _loc4_.getLayoutBoundsY();
         var _loc7_:Number = _loc4_.getLayoutBoundsWidth();
         var _loc8_:Number = _loc4_.getLayoutBoundsHeight();
         return new Rectangle(_loc5_,_loc6_,_loc7_,_loc8_);
      }
      
      protected function getElementBoundsLeftOfScrollRect(param1:Rectangle) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.left = param1.left - 1;
         _loc2_.right = param1.left;
         return _loc2_;
      }
      
      protected function getElementBoundsRightOfScrollRect(param1:Rectangle) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.left = param1.right;
         _loc2_.right = param1.right + 1;
         return _loc2_;
      }
      
      protected function getElementBoundsAboveScrollRect(param1:Rectangle) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.top = param1.top - 1;
         _loc2_.bottom = param1.top;
         return _loc2_;
      }
      
      protected function getElementBoundsBelowScrollRect(param1:Rectangle) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.top = param1.bottom;
         _loc2_.bottom = param1.bottom + 1;
         return _loc2_;
      }
      
      public function getHorizontalScrollPositionDelta(param1:uint) : Number
      {
         var _loc6_:Rectangle = null;
         var _loc2_:GroupBase = this.target;
         if(!_loc2_)
         {
            return 0;
         }
         var _loc3_:Rectangle = this.getScrollRect();
         if(!_loc3_)
         {
            return 0;
         }
         if(_loc3_.x == 0 && _loc3_.width >= _loc2_.contentWidth)
         {
            return 0;
         }
         var _loc4_:Number = _loc2_.contentWidth - _loc3_.right;
         var _loc5_:Number = -_loc3_.left;
         switch(param1)
         {
            case NavigationUnit.LEFT:
            case NavigationUnit.PAGE_LEFT:
               _loc6_ = this.getElementBoundsLeftOfScrollRect(_loc3_);
               break;
            case NavigationUnit.RIGHT:
            case NavigationUnit.PAGE_RIGHT:
               _loc6_ = this.getElementBoundsRightOfScrollRect(_loc3_);
               break;
            case NavigationUnit.HOME:
               return _loc5_;
            case NavigationUnit.END:
               return _loc4_;
            default:
               return 0;
         }
         if(!_loc6_)
         {
            return 0;
         }
         var _loc7_:Number = 0;
         switch(param1)
         {
            case NavigationUnit.LEFT:
               _loc7_ = Math.max(_loc6_.left - _loc3_.left,-_loc3_.width);
               break;
            case NavigationUnit.RIGHT:
               _loc7_ = Math.min(_loc6_.right - _loc3_.right,_loc3_.width);
               break;
            case NavigationUnit.PAGE_LEFT:
               _loc7_ = _loc6_.right - _loc3_.right;
               if(_loc7_ >= 0)
               {
                  _loc7_ = Math.max(_loc6_.left - _loc3_.left,-_loc3_.width);
               }
               break;
            case NavigationUnit.PAGE_RIGHT:
               _loc7_ = _loc6_.left - _loc3_.left;
               if(_loc7_ <= 0)
               {
                  _loc7_ = Math.min(_loc6_.right - _loc3_.right,_loc3_.width);
               }
         }
         return Math.min(_loc4_,Math.max(_loc5_,_loc7_));
      }
      
      public function getVerticalScrollPositionDelta(param1:uint) : Number
      {
         var _loc6_:Rectangle = null;
         var _loc2_:GroupBase = this.target;
         if(!_loc2_)
         {
            return 0;
         }
         var _loc3_:Rectangle = this.getScrollRect();
         if(!_loc3_)
         {
            return 0;
         }
         if(_loc3_.y == 0 && _loc3_.height >= _loc2_.contentHeight)
         {
            return 0;
         }
         var _loc4_:Number = _loc2_.contentHeight - _loc3_.bottom;
         var _loc5_:Number = -_loc3_.top;
         switch(param1)
         {
            case NavigationUnit.UP:
            case NavigationUnit.PAGE_UP:
               _loc6_ = this.getElementBoundsAboveScrollRect(_loc3_);
               break;
            case NavigationUnit.DOWN:
            case NavigationUnit.PAGE_DOWN:
               _loc6_ = this.getElementBoundsBelowScrollRect(_loc3_);
               break;
            case NavigationUnit.HOME:
               return _loc5_;
            case NavigationUnit.END:
               return _loc4_;
            default:
               return 0;
         }
         if(!_loc6_)
         {
            return 0;
         }
         var _loc7_:Number = 0;
         switch(param1)
         {
            case NavigationUnit.UP:
               _loc7_ = Math.max(_loc6_.top - _loc3_.top,-_loc3_.height);
               break;
            case NavigationUnit.DOWN:
               _loc7_ = Math.min(_loc6_.bottom - _loc3_.bottom,_loc3_.height);
               break;
            case NavigationUnit.PAGE_UP:
               _loc7_ = _loc6_.bottom - _loc3_.bottom;
               if(_loc7_ >= 0)
               {
                  _loc7_ = Math.max(_loc6_.top - _loc3_.top,-_loc3_.height);
               }
               break;
            case NavigationUnit.PAGE_DOWN:
               _loc7_ = _loc6_.top - _loc3_.top;
               if(_loc7_ <= 0)
               {
                  _loc7_ = Math.min(_loc6_.bottom - _loc3_.bottom,_loc3_.height);
               }
         }
         return Math.min(_loc4_,Math.max(_loc5_,_loc7_));
      }
      
      public function getScrollPositionDeltaToElement(param1:int) : Point
      {
         return this.mx_internal::getScrollPositionDeltaToElementHelper(param1);
      }
      
      mx_internal function getScrollPositionDeltaToElementHelper(param1:int, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN, param5:Number = NaN) : Point
      {
         var _loc6_:Rectangle = this.getElementBounds(param1);
         if(!_loc6_)
         {
            return null;
         }
         var _loc7_:Rectangle = this.getScrollRect();
         if(!_loc7_ || !this.target.clipAndEnableScrolling)
         {
            return null;
         }
         if(isNaN(param2) && isNaN(param3) && isNaN(param4) && isNaN(param5) && (_loc7_.containsRect(_loc6_) || _loc6_.containsRect(_loc7_)))
         {
            return null;
         }
         var _loc8_:Number = _loc6_.left - _loc7_.left;
         var _loc9_:Number = _loc6_.right - _loc7_.right;
         var _loc10_:Number = _loc6_.top - _loc7_.top;
         var _loc11_:Number = _loc6_.bottom - _loc7_.bottom;
         var _loc12_:Number = Math.abs(_loc8_) < Math.abs(_loc9_) ? _loc8_ : _loc9_;
         var _loc13_:Number = Math.abs(_loc10_) < Math.abs(_loc11_) ? _loc10_ : _loc11_;
         if(!isNaN(param2))
         {
            _loc13_ = _loc10_ + param2;
         }
         else if(!isNaN(param3))
         {
            _loc13_ = _loc11_ - param3;
         }
         if(!isNaN(param4))
         {
            _loc12_ = _loc8_ + param4;
         }
         else if(!isNaN(param5))
         {
            _loc12_ = _loc9_ - param5;
         }
         if(_loc6_.left >= _loc7_.left && _loc6_.right <= _loc7_.right)
         {
            _loc12_ = 0;
         }
         else if(_loc6_.bottom <= _loc7_.bottom && _loc6_.top >= _loc7_.top)
         {
            _loc13_ = 0;
         }
         if(_loc6_.left <= _loc7_.left && _loc6_.right >= _loc7_.right)
         {
            _loc12_ = 0;
         }
         else if(_loc6_.bottom >= _loc7_.bottom && _loc6_.top <= _loc7_.top)
         {
            _loc13_ = 0;
         }
         return new Point(_loc12_,_loc13_);
      }
      
      public function calculateDropLocation(param1:DragEvent) : DropLocation
      {
         var _loc2_:Point = this.globalToLocal(param1.stageX,param1.stageY);
         var _loc3_:int = this.calculateDropIndex(_loc2_.x,_loc2_.y);
         if(_loc3_ == -1)
         {
            return null;
         }
         var _loc4_:DropLocation = new DropLocation();
         _loc4_.dragEvent = param1;
         _loc4_.dropPoint = _loc2_;
         _loc4_.dropIndex = _loc3_;
         return _loc4_;
      }
      
      public function showDropIndicator(param1:DropLocation) : void
      {
         var _loc4_:ILayoutElement = null;
         if(!this._dropIndicator)
         {
            return;
         }
         this._dropIndicator.visible = false;
         var _loc2_:int = 0;
         if(this._dragScrollTimer)
         {
            _loc2_ = this._dragScrollTimer.currentCount * this._dragScrollTimer.delay;
         }
         this._dragScrollDelta = this.calculateDragScrollDelta(param1,_loc2_);
         if(this._dragScrollDelta)
         {
            this._dragScrollEvent = param1.dragEvent;
            if(!this.dragScrollingInProgress())
            {
               this.startDragScrolling();
               return;
            }
            if(this.mx_internal::dragScrollHidesIndicator)
            {
               return;
            }
         }
         else
         {
            this.stopDragScrolling();
         }
         var _loc3_:Rectangle = this.calculateDropIndicatorBounds(param1);
         if(!_loc3_)
         {
            return;
         }
         if(this._dropIndicator is ILayoutElement)
         {
            _loc4_ = ILayoutElement(this._dropIndicator);
            _loc4_.setLayoutBoundsSize(_loc3_.width,_loc3_.height);
            _loc4_.setLayoutBoundsPosition(_loc3_.x,_loc3_.y);
         }
         else
         {
            this._dropIndicator.width = _loc3_.width;
            this._dropIndicator.height = _loc3_.height;
            this._dropIndicator.x = _loc3_.x;
            this._dropIndicator.y = _loc3_.y;
         }
         this._dropIndicator.visible = true;
      }
      
      public function hideDropIndicator() : void
      {
         this.stopDragScrolling();
         if(this._dropIndicator)
         {
            this._dropIndicator.visible = false;
         }
      }
      
      protected function calculateDropIndex(param1:Number, param2:Number) : int
      {
         return this.target.numElements;
      }
      
      protected function calculateDropIndicatorBounds(param1:DropLocation) : Rectangle
      {
         return null;
      }
      
      protected function calculateDragScrollDelta(param1:DropLocation, param2:Number) : Point
      {
         var _loc3_:GroupBase = this.target;
         if(_loc3_.numElements == 0)
         {
            return null;
         }
         var _loc4_:Rectangle = this.getScrollRect();
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:Number = param1.dropPoint.x;
         var _loc6_:Number = param1.dropPoint.y;
         var _loc7_:Number = Math.min(this.mx_internal::dragScrollRegionSizeHorizontal,_loc3_.width / 2);
         var _loc8_:Number = Math.min(this.mx_internal::dragScrollRegionSizeVertical,_loc3_.height / 2);
         if(_loc4_.left + _loc7_ < _loc5_ && _loc5_ < _loc4_.right - _loc7_ && _loc4_.top + _loc8_ < _loc6_ && _loc6_ < _loc4_.bottom - _loc8_)
         {
            return null;
         }
         if(param2 < this.mx_internal::dragScrollInitialDelay)
         {
            return new Point();
         }
         param2 -= this.mx_internal::dragScrollInitialDelay;
         var _loc9_:Number = Math.min(param2,2000) / 2000;
         _loc9_ = _loc9_ * 3;
         _loc9_ = _loc9_ + 1;
         _loc9_ *= _loc9_ * this.mx_internal::dragScrollSpeed * this.mx_internal::dragScrollInterval / 50;
         var _loc10_:Number = -_loc4_.left;
         var _loc11_:Number = -_loc4_.top;
         var _loc12_:Number = this.target.contentHeight - _loc4_.bottom;
         var _loc13_:Number = this.target.contentWidth - _loc4_.right;
         var _loc14_:Number = 0;
         var _loc15_:Number = 0;
         if(_loc10_ != 0 && _loc5_ - _loc4_.left < _loc7_)
         {
            _loc14_ = 1 - (_loc5_ - _loc4_.left) / _loc7_;
            _loc14_ *= _loc14_ * _loc9_;
            _loc14_ = -Math.round(_loc14_) - 1;
         }
         else if(_loc13_ != 0 && _loc4_.right - _loc5_ < _loc7_)
         {
            _loc14_ = 1 - (_loc4_.right - _loc5_) / _loc7_;
            _loc14_ *= _loc14_ * _loc9_;
            _loc14_ = Math.round(_loc14_) + 1;
         }
         if(_loc11_ != 0 && _loc6_ - _loc4_.top < _loc8_)
         {
            _loc15_ = 1 - (_loc6_ - _loc4_.top) / _loc8_;
            _loc15_ *= _loc15_ * _loc9_;
            _loc15_ = -Math.round(_loc15_) - 1;
         }
         else if(_loc12_ != 0 && _loc4_.bottom - _loc6_ < _loc8_)
         {
            _loc15_ = 1 - (_loc4_.bottom - _loc6_) / _loc8_;
            _loc15_ *= _loc15_ * _loc9_;
            _loc15_ = Math.round(_loc15_) + 1;
         }
         _loc14_ = Math.max(_loc10_,Math.min(_loc13_,_loc14_));
         _loc15_ = Math.max(_loc11_,Math.min(_loc12_,_loc15_));
         if(_loc14_ == 0 && _loc15_ == 0)
         {
            return null;
         }
         return new Point(_loc14_,_loc15_);
      }
      
      private function dragScrollingInProgress() : Boolean
      {
         return this._dragScrollTimer != null;
      }
      
      private function startDragScrolling() : void
      {
         if(this._dragScrollTimer)
         {
            return;
         }
         this._dragScrollTimer = new Timer(this.mx_internal::dragScrollInterval);
         this._dragScrollTimer.addEventListener(TimerEvent.TIMER,this.dragScroll);
         this._dragScrollTimer.start();
         this.dragScroll(null);
      }
      
      private function dragScroll(param1:TimerEvent) : void
      {
         this.horizontalScrollPosition += this._dragScrollDelta.x;
         this.verticalScrollPosition += this._dragScrollDelta.y;
         this.target.validateNow();
         var _loc2_:DragEvent = new DragEvent(DragEvent.DRAG_OVER,this._dragScrollEvent.bubbles,this._dragScrollEvent.cancelable,this._dragScrollEvent.dragInitiator,this._dragScrollEvent.dragSource,this._dragScrollEvent.action,this._dragScrollEvent.ctrlKey,this._dragScrollEvent.altKey,this._dragScrollEvent.shiftKey);
         _loc2_.draggedItem = this._dragScrollEvent.draggedItem;
         _loc2_.localX = this._dragScrollEvent.localX;
         _loc2_.localY = this._dragScrollEvent.localY;
         _loc2_.relatedObject = this._dragScrollEvent.relatedObject;
         this._dragScrollEvent.target.dispatchEvent(_loc2_);
      }
      
      private function stopDragScrolling() : void
      {
         if(this._dragScrollTimer)
         {
            this._dragScrollTimer.stop();
            this._dragScrollTimer.removeEventListener(TimerEvent.TIMER,this.dragScroll);
            this._dragScrollTimer = null;
         }
         this._dragScrollEvent = null;
         this._dragScrollDelta = null;
      }
      
      private function globalToLocal(param1:Number, param2:Number) : Point
      {
         var _loc3_:GroupBase = this.target;
         var _loc4_:DisplayObject = _loc3_.parent;
         var _loc5_:Point = _loc4_.globalToLocal(new Point(param1,param2));
         _loc5_.x -= _loc3_.x;
         _loc5_.y -= _loc3_.y;
         var _loc6_:Rectangle = this.getScrollRect();
         if(_loc6_)
         {
            _loc5_.x += _loc6_.x;
            _loc5_.y += _loc6_.y;
         }
         return _loc5_;
      }
      
      public function set verticalScrollPosition(param1:Number) : void
      {
         var _loc2_:Object = this.verticalScrollPosition;
         if(_loc2_ !== param1)
         {
            this._1010846676verticalScrollPosition = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"verticalScrollPosition",_loc2_,param1));
            }
         }
      }
      
      public function set horizontalScrollPosition(param1:Number) : void
      {
         var _loc2_:Object = this.horizontalScrollPosition;
         if(_loc2_ !== param1)
         {
            this._754184102horizontalScrollPosition = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"horizontalScrollPosition",_loc2_,param1));
            }
         }
      }
   }
}

