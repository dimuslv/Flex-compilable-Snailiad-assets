package com.newgrounds.components
{
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class FlxNGPreloader extends MovieClip
   {
      public var NewgroundsAPIId:String;
      
      public var NewgroundsAPIEncryptionKey:String;
      
      public var NewgroundsAPIShowAds:Boolean = true;
      
      public var autoPlay:Boolean = false;
      
      public var className:String;
      
      protected var _initialized:Boolean;
      
      protected var _preloader:Sprite;
      
      protected var _ad:FlashAd;
      
      protected var _adContainer:Sprite;
      
      protected var _loadBarMask:Shape;
      
      protected var _loadBar:Bitmap;
      
      public function FlxNGPreloader()
      {
         this._preloader = new Sprite();
         this._adContainer = new Sprite();
         this._loadBarMask = new Shape();
         super();
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      protected function create() : void
      {
         if(!this.NewgroundsAPIId)
         {
            trace("[NewgroundsAPI] :: No API ID set! Please set NewgroundsAPIId in your preloader.");
            return;
         }
         if(this.NewgroundsAPIShowAds)
         {
            API.addEventListener(APIEvent.ADS_APPROVED,this.adsApprovedHandler,false,0,true);
            this._adContainer.graphics.beginFill(0);
            this._adContainer.graphics.moveTo(-4,-4);
            this._adContainer.graphics.lineTo(304,-4);
            this._adContainer.graphics.lineTo(304,254);
            this._adContainer.graphics.lineTo(-4,254);
            this._adContainer.graphics.lineTo(-4,-4);
            this._adContainer.graphics.endFill();
            this._adContainer.scaleX = Math.min(1,stage.stageWidth / 325);
            this._adContainer.scaleY = this._adContainer.scaleX;
         }
         this._preloader.addChild(this._adContainer);
         this._adContainer.visible = false;
         var _loc1_:Bitmap = new Bitmap(new FlxLoaderFrame(0,0));
         _loc1_.y = 260;
         this._preloader.addChild(_loc1_);
         this._loadBarMask.graphics.beginFill(0);
         this._loadBarMask.graphics.lineTo(304,0);
         this._loadBarMask.graphics.lineTo(304,70);
         this._loadBarMask.graphics.lineTo(0,70);
         this._loadBarMask.graphics.lineTo(0,0);
         this._loadBarMask.graphics.endFill();
         this._loadBarMask.scaleX = 0;
         this._loadBarMask.y = _loc1_.y;
         this._preloader.addChild(this._loadBarMask);
         this._loadBar = new Bitmap(new FlxLoaderBar(0,0));
         this._loadBar.y = _loc1_.y;
         this._preloader.addChild(this._loadBar);
         this._loadBar.mask = this._loadBarMask;
         addChild(this._preloader);
         this._preloader.x = (stage.stageWidth - this._preloader.width) / 2;
         this._preloader.y = (stage.stageHeight - this._preloader.height) / 2;
         API.connect(loaderInfo,this.NewgroundsAPIId,this.NewgroundsAPIEncryptionKey);
         this._initialized = true;
      }
      
      protected function createMedalPopup(param1:Number, param2:Number) : void
      {
         var _loc3_:MedalPopup = new MedalPopup();
         _loc3_.x = param1;
         _loc3_.y = param2;
         addChild(_loc3_);
      }
      
      protected function enterFrameHandler(param1:Event) : void
      {
         var _loc3_:Sprite = null;
         if(!this._initialized)
         {
            if(stage)
            {
               this.create();
            }
            return;
         }
         var _loc2_:Number = loaderInfo.bytesLoaded / loaderInfo.bytesTotal;
         this._loadBarMask.scaleX = uint(_loc2_ * 200) / 200;
         if(_loc2_ >= 1)
         {
            removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            if(this.autoPlay)
            {
               this.startGame();
            }
            else
            {
               _loc3_ = new Sprite();
               _loc3_.addChild(new Bitmap(new FlxLoaderPlay(0,0)));
               _loc3_.x = this._loadBarMask.x;
               _loc3_.y = this._loadBarMask.y;
               _loc3_.buttonMode = true;
               this._loadBar.visible = false;
               _loc3_.addEventListener(MouseEvent.CLICK,this.playButtonClickHandler);
               this._preloader.addChild(_loc3_);
            }
         }
      }
      
      protected function startGame() : void
      {
         var _loc2_:Object = null;
         nextFrame();
         var _loc1_:Class = Class(getDefinitionByName(this.className));
         if(_loc1_)
         {
            _loc2_ = new _loc1_();
            addChild(_loc2_ as DisplayObject);
         }
         removeChild(this._preloader);
         if(this._ad)
         {
            this._ad.removeAd();
         }
         this._ad = null;
         this._adContainer = null;
         this._loadBarMask = null;
         this._preloader = null;
      }
      
      private function adsApprovedHandler(param1:APIEvent) : void
      {
         API.removeEventListener(APIEvent.ADS_APPROVED,this.adsApprovedHandler);
         if(this._adContainer)
         {
            this._ad = new FlashAd(false);
            this._adContainer.addChild(this._ad);
            this._preloader.addChild(this._adContainer);
            this._adContainer.visible = true;
         }
      }
      
      private function playButtonClickHandler(param1:MouseEvent) : void
      {
         this.startGame();
      }
   }
}

