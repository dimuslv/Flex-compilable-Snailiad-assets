package
{
   import org.flixel.*;
   import com.newgrounds.API;
   import flash.events.ContextMenuEvent;
   import flash.net.*;
   import flash.ui.*;
   
   [Frame(factoryClass="Preloader")]
   [SWF(width="800", height="480", backgroundColor="#000000")]
   
   public class main extends FlxGame
   {
      private static const myPageUrl:String = "http://auriplane.newgrounds.com/";
      
      public function createContextMenu() : void
      {
         var myContextMenu:ContextMenu = new ContextMenu();
         myContextMenu.hideBuiltInItems();
         var menuCopyright:ContextMenuItem = new ContextMenuItem("Copyright 2011 Crystal Jacobs");
         var menuEmail:ContextMenuItem = new ContextMenuItem("Email: crystal@panix.com");
         var menuUrl:ContextMenuItem = new ContextMenuItem(myPageUrl);
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
      
      public function main() : void
      {
         if(!Preloader.fail)
         {
            var _loc1_:uint = 400;
            var _loc2_:uint = 240;
            var _loc3_:uint = 2;
            super(_loc1_,_loc2_,PlayState,_loc3_);
            pause = new PauseLayer();
            FlxState.bgColor = 4278190080;
            FlxG.framerate = 120;
            FlxG.showBounds = false;
            useDefaultHotKeys = false;
         }
         this.createContextMenu();
      }
   }
}

