package
{
   import com.newgrounds.API;
   import flash.events.ContextMenuEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import org.flixel.FlxG;
   import org.flixel.FlxGame;
   import org.flixel.FlxState;
   
   public class main extends FlxGame
   {
      private static const myPageUrl:String = "http://auriplane.newgrounds.com/";
      
      public function main()
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(!Preloader.fail)
         {
            _loc1_ = 400;
            _loc2_ = 240;
            _loc3_ = 2;
            super(_loc1_,_loc2_,PlayState,_loc3_);
            pause = new PauseLayer();
            FlxState.bgColor = 4278190080;
            FlxG.framerate = 120;
            FlxG.showBounds = false;
            useDefaultHotKeys = false;
         }
         this.createContextMenu();
      }
      
      public function createContextMenu() : void
      {
         var menuCopyright:ContextMenuItem = null;
         var menuEmail:ContextMenuItem = null;
         var menuUrl:ContextMenuItem = null;
         var myContextMenu:ContextMenu = new ContextMenu();
         myContextMenu.hideBuiltInItems();
         menuCopyright = new ContextMenuItem("Copyright 2011 Crystal Jacobs");
         menuEmail = new ContextMenuItem("Email: crystal@panix.com");
         menuUrl = new ContextMenuItem(myPageUrl);
         if(API.isNewgrounds())
         {
            menuUrl = new ContextMenuItem(myPageUrl);
            menuUrl.enabled = false;
         }
         else
         {
            menuUrl.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,function(param1:ContextMenuEvent):void
            {
               navigateToURL(new URLRequest(myPageUrl),"_self");
            });
            menuUrl.enabled = true;
         }
         menuEmail.enabled = false;
         menuCopyright.enabled = false;
         myContextMenu.customItems.push(menuCopyright,menuEmail,menuUrl);
         contextMenu = myContextMenu;
      }
   }
}

