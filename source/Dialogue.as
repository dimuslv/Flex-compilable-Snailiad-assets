package
{
   import org.flixel.*;
   
   public class Dialogue extends FlxGroup
   {
      private static const IMG_WIDTH:int = 368;
      
      private static const IMG_HEIGHT:int = 64;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private var _msg:FlxText;
      
      private var _active:Boolean;
      
      private var _started:int;
      
      private var _fullMsg:String;
      
      private const LETTER_DELAY:Number = 0.027;
      
      private var _elapsed:Number = 0;
      
      private var _bg:FlxSprite;
      
      private var _oldLetters:int;
      
      private var _voice:int;
      
      private var _speed:Number = 1;
      
      public var _diaNum:int = 0;
      
      override public function destroy() : void
      {
         _bg = null;
         _msg = null;
         super.destroy();
      }
      
      public function Dialogue() : void
      {
         _active = false;
         _msg = new FlxText(20,20,FlxG.width);
         _msg.font = Fonts.normal;
         _msg.size = 20;
         _msg.color = 16777215;
         _msg.shadow = 1;
         _msg.alignment = "left";
         _msg.scrollFactor.x = _msg.scrollFactor.y = 0;
         _msg.visible = false;
         _bg = new FlxSprite(16,20);
         _bg.loadGraphic(Art.Dialogue,true,true,IMG_WIDTH,IMG_HEIGHT);
         _bg.visible = false;
         _bg.addAnimation("normal",[0,1,2,3],60,false);
         _bg.addAnimation("alt",[4,5,6,7],60,false);
         _bg.exists = true;
         _bg.solid = false;
         _bg.scrollFactor.x = _bg.scrollFactor.y = 0;
         add(_bg);
         add(_msg);
      }
      
      public function start(param1:String, param2:int, param3:Boolean = false, param4:Number = 1.0, param5:int = 0) : void
      {
         if(_active)
         {
            return;
         }
         _diaNum = param5;
         _bg.play(param3 ? "alt" : "normal");
         _msg.text = "";
         _fullMsg = param1;
         _active = true;
         moveWindow(true);
         _msg.visible = true;
         _bg.visible = true;
         _oldLetters = 0;
         _voice = param2;
         _elapsed = 0;
         _speed = param4;
      }
      
      public function moveWindow(param1:Boolean) : void
      {
         var _loc2_:int;
		 if(PlayState.player.y - PlayState.worldMap.minY < 90)
         {
            _loc2_ = 160;
         }
         else
         {
            _loc2_ = 20;
         }
         if(param1)
         {
            _bg.y = _loc2_;
         }
         else
         {
            _bg.y = (_bg.y * 9 + _loc2_) / 10;
         }
         _msg.y = _bg.y;
      }
      
      public function stop(param1:int = -1) : void
      {
         if(param1 != _diaNum && param1 != -1)
         {
            return;
         }
         _active = false;
         _msg.visible = false;
         _bg.visible = false;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _elapsed += FlxG.elapsed;
         super.update();
         if(_active)
         {
            moveWindow(false);
            var _loc1_:int = _elapsed / (LETTER_DELAY / _speed);
            if(_loc1_ != _oldLetters)
            {
               var _loc2_:String = _fullMsg.charAt(_loc1_).toLowerCase();
               if(_loc2_ >= "a" && _loc2_ <= "z")
               {
                  Sfx.playDialogueLetter(_voice);
               }
               _oldLetters = _loc1_;
            }
            _msg.text = _fullMsg.substr(0,_loc1_);
         }
      }
   }
}

