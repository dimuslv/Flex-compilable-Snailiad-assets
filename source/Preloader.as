package
{
   import com.newgrounds.*;
   import com.newgrounds.components.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class Preloader extends FlxNGPreloader
   {
      public static var bg:Bitmap;
      
      public static var fail:Boolean = false;
      
      private static var txt:TextField;
      
      private static var txt2:TextField;
	  
	  [Embed(source = 'data/art/LoadBg.png')] private const LoadBg:Class;
      
      public function Preloader() : void
      {
         bg = new LoadBg();
         bg.width = 800;
         bg.height = 480;
         addChild(bg);
         className = "main";
         super();
         API.addEventListener(APIEvent.HOST_BLOCKED,onHostBlocked);
         NewgroundsAPIId = "18670:nrJul9g0";
         NewgroundsAPIEncryptionKey = "82p7QsSoR4Vf8gXTPtxFuN5GwX6T4zFq";
         NewgroundsAPIShowAds = true;
         createMedalPopup(10,20);
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         API.loadNewgrounds();
      }
      
      private function onHostBlocked(param1:APIEvent) : void
      {
         fail = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
      }
      
      public function addText() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color = 0;
         _loc1_.size = 20;
         _loc1_.align = "center";
         _loc1_.bold = true;
         _loc1_.font = "system";
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = 16777215;
         _loc2_.size = 20;
         _loc2_.align = "center";
         _loc2_.bold = true;
         _loc2_.font = "system";
         txt = new TextField();
         txt.width = stage.stageWidth - 16;
         txt.height = stage.stageHeight - 16;
         txt.y = 8;
         txt.multiline = true;
         txt.wordWrap = true;
         txt.embedFonts = true;
         txt.defaultTextFormat = _loc1_;
         txt.text = "This game is currently exclusive to Newgrounds!\n" + "Click anywhere to go to the official site!\n";
         txt.visible = false;
         addChild(txt);
         txt2 = new TextField();
         txt2.width = stage.stageWidth - 16;
         txt2.height = stage.stageHeight - 16;
         txt2.x = -2;
         txt2.y = 6;
         txt2.multiline = true;
         txt2.wordWrap = true;
         txt2.embedFonts = true;
         txt2.defaultTextFormat = _loc2_;
         txt2.text = "This game is currently exclusive to Newgrounds!\n" + "Click anywhere to go to the official site!\n";
         txt2.visible = false;
         addChild(txt2);
      }
   }
}

