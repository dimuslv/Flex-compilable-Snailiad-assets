package
{
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import com.newgrounds.components.FlxNGPreloader;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class Preloader extends FlxNGPreloader
   {
      public static var bg:Bitmap;
      
      private static var txt:TextField;
      
      private static var txt2:TextField;
      
      public static var fail:Boolean = false;
      
      private var LoadBg:*;
      
      public function Preloader()
      {
         this.LoadBg = Preloader_LoadBg;
         bg = new this.LoadBg();
         bg.width = 800;
         bg.height = 480;
         addChild(bg);
         className = "main";
         super();
         API.addEventListener(APIEvent.HOST_BLOCKED,this.onHostBlocked);
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
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      public function addText() : void
      {
         var _loc2_:TextFormat = null;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color = 0;
         _loc1_.size = 20;
         _loc1_.align = "center";
         _loc1_.bold = true;
         _loc1_.font = "system";
         _loc2_ = new TextFormat();
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

