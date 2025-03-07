package
{
   import org.flixel.*;
   
   public class IntroDialogue extends FlxGroup
   {
      private static const IMG_WIDTH:int = 368;
      
      private static const IMG_HEIGHT:int = 64;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private var _msg:FlxText;
      
      private var _active:Boolean;
      
      private var _started:int;
      
      private var _fullMsg:String;
      
      private const LETTER_DELAY:Number = 0.067;
      
      private var _elapsed:Number = 0;
      
      private var _oldLetters:int;
      
      private var _voice:int;
      
      private var _speed:Number = 1;
      
      public function setAlpha(param1:Number) : void
      {
         _msg.alpha = param1;
      }
      
      override public function destroy() : void
      {
         _msg = null;
         super.destroy();
      }
      
      public function IntroDialogue() : void
      {
         _active = false;
         _msg = new FlxText(0,170,FlxG.width);
         _msg.font = Fonts.normal;
         _msg.size = 20;
         _msg.color = 16777215;
         _msg.shadow = 1;
         _msg.alignment = "left";
         _msg.scrollFactor.x = _msg.scrollFactor.y = 0;
         _msg.visible = false;
         add(_msg);
      }
      
      public function start(param1:String, param2:int = 1, param3:Number = 1.0) : void
      {
         _msg.alpha = 1;
         _msg.text = "";
         _fullMsg = param1;
         _active = true;
         _msg.visible = true;
         _oldLetters = 0;
         _voice = param2;
         _elapsed = 0;
         _speed = param3;
      }
      
      public function stop() : void
      {
         _active = false;
         _msg.visible = false;
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         _elapsed += FlxG.elapsed;
         super.update();
         if(_active)
         {
            _loc1_ = _elapsed / (LETTER_DELAY / _speed);
            if(_loc1_ != _oldLetters)
            {
               _loc2_ = _fullMsg.charAt(_loc1_).toLowerCase();
               if(_loc2_ >= "a" && _loc2_ <= "z")
               {
                  if(_voice > -1)
                  {
                     Sfx.playDialogueLetter(_voice);
                  }
               }
               _oldLetters = _loc1_;
            }
            _msg.text = _fullMsg.substr(0,_loc1_);
         }
      }
   }
}

