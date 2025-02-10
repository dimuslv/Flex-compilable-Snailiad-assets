package NewgroundsAPI_fla
{
   import com.newgrounds.API;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   [Embed]
   public dynamic class NewgroundsAPIAsset_FlashAd_Container_23 extends MovieClip
   {
      public var adMask:MovieClip;
      
      public var ngLinkButton:SimpleButton;
      
      public function NewgroundsAPIAsset_FlashAd_Container_23()
      {
         super();
         addFrameScript(0,this.frame1,10,this.frame11);
      }
      
      public function onNGLinkClicked(param1:MouseEvent) : void
      {
         API.loadNewgrounds();
      }
      
      internal function frame1() : *
      {
         this.ngLinkButton.addEventListener(MouseEvent.CLICK,this.onNGLinkClicked);
      }
      
      internal function frame11() : *
      {
         gotoAndPlay(1);
      }
   }
}

