package
{
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   import org.flixel.FlxText;
   
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
      
      public function Dialogue()
      {
         super();
         this._active = false;
         this._msg = new FlxText(20,20,FlxG.width);
         this._msg.font = Fonts.normal;
         this._msg.size = 20;
         this._msg.color = 16777215;
         this._msg.shadow = 1;
         this._msg.alignment = "left";
         this._msg.scrollFactor.x = this._msg.scrollFactor.y = 0;
         this._msg.visible = false;
         this._bg = new FlxSprite(16,20);
         this._bg.loadGraphic(Art.Dialogue,true,true,IMG_WIDTH,IMG_HEIGHT);
         this._bg.visible = false;
         this._bg.addAnimation("normal",[0,1,2,3],60,false);
         this._bg.addAnimation("alt",[4,5,6,7],60,false);
         this._bg.exists = true;
         this._bg.solid = false;
         this._bg.scrollFactor.x = this._bg.scrollFactor.y = 0;
         add(this._bg);
         add(this._msg);
      }
      
      override public function destroy() : void
      {
         this._bg = null;
         this._msg = null;
         super.destroy();
      }
      
      public function start(param1:String, param2:int, param3:Boolean = false, param4:Number = 1, param5:int = 0) : void
      {
         if(this._active)
         {
            return;
         }
         this._diaNum = param5;
         this._bg.play(param3 ? "alt" : "normal");
         this._msg.text = "";
         this._fullMsg = param1;
         this._active = true;
         this.moveWindow(true);
         this._msg.visible = true;
         this._bg.visible = true;
         this._oldLetters = 0;
         this._voice = param2;
         this._elapsed = 0;
         this._speed = param4;
      }
      
      public function moveWindow(param1:Boolean) : void
      {
         var _loc2_:int = 0;
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
            this._bg.y = _loc2_;
         }
         else
         {
            this._bg.y = (this._bg.y * 9 + _loc2_) / 10;
         }
         this._msg.y = this._bg.y;
      }
      
      public function stop(param1:int = -1) : void
      {
         if(param1 != this._diaNum && param1 != -1)
         {
            return;
         }
         this._active = false;
         this._msg.visible = false;
         this._bg.visible = false;
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this._elapsed += FlxG.elapsed;
         super.update();
         if(this._active)
         {
            this.moveWindow(false);
            _loc1_ = this._elapsed / (this.LETTER_DELAY / this._speed);
            if(_loc1_ != this._oldLetters)
            {
               _loc2_ = this._fullMsg.charAt(_loc1_).toLowerCase();
               if(_loc2_ >= "a" && _loc2_ <= "z")
               {
                  Sfx.playDialogueLetter(this._voice);
               }
               this._oldLetters = _loc1_;
            }
            this._msg.text = this._fullMsg.substr(0,_loc1_);
         }
      }
   }
}

