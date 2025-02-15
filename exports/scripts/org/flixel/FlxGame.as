package org.flixel
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.*;
   import flash.geom.Point;
   import flash.text.AntiAliasType;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import org.flixel.data.FlxConsole;
   import org.flixel.data.FlxPause;
   
   public class FlxGame extends Sprite
   {
      protected var junk:String = "FlxGame_junk";
      
      protected var SndBeep:Class;
      
      protected var SndFlixel:Class;
      
      public var useDefaultHotKeys:Boolean;
      
      public var pause:FlxGroup;
      
      internal var _iState:Class;
      
      internal var _created:Boolean;
      
      internal var _state:FlxState;
      
      internal var _screen:Sprite;
      
      internal var _buffer:Bitmap;
      
      internal var _zoom:uint;
      
      internal var _gameXOffset:int;
      
      internal var _gameYOffset:int;
      
      internal var _frame:Class;
      
      internal var _zeroPoint:Point;
      
      internal var _elapsed:Number;
      
      internal var _total:uint;
      
      internal var _paused:Boolean;
      
      internal var _framerate:uint;
      
      internal var _frameratePaused:uint;
      
      internal var _soundTray:Sprite;
      
      internal var _soundTrayTimer:Number;
      
      internal var _soundTrayBars:Array;
      
      internal var _console:FlxConsole;
      
      public function FlxGame(param1:uint, param2:uint, param3:Class, param4:uint = 2)
      {
         this.SndBeep = FlxGame_SndBeep;
         this.SndFlixel = FlxGame_SndFlixel;
         super();
         Mouse.hide();
         this._zoom = param4;
         FlxState.bgColor = 4278190080;
         FlxG.setGameData(this,param1,param2,param4);
         this._elapsed = 0;
         this._total = 0;
         this.pause = new FlxPause();
         this._state = null;
         this._iState = param3;
         this._zeroPoint = new Point();
         this.useDefaultHotKeys = true;
         this._frame = null;
         this._gameXOffset = 0;
         this._gameYOffset = 0;
         this._paused = false;
         this._created = false;
         addEventListener(Event.ENTER_FRAME,this.create);
      }
      
      protected function addFrame(param1:Class, param2:uint, param3:uint) : FlxGame
      {
         this._frame = param1;
         this._gameXOffset = param2;
         this._gameYOffset = param3;
         return this;
      }
      
      public function showSoundTray(param1:Boolean = false) : void
      {
         if(!param1)
         {
            FlxG.play(this.SndBeep);
         }
         this._soundTrayTimer = 1;
         this._soundTray.y = this._gameYOffset * this._zoom;
         this._soundTray.visible = true;
         var _loc2_:uint = Math.round(FlxG.volume * 10);
         if(FlxG.mute)
         {
            _loc2_ = 0;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this._soundTrayBars.length)
         {
            if(_loc3_ < _loc2_)
            {
               this._soundTrayBars[_loc3_].alpha = 1;
            }
            else
            {
               this._soundTrayBars[_loc3_].alpha = 0.5;
            }
            _loc3_++;
         }
      }
      
      public function switchState(param1:FlxState) : void
      {
         FlxG.panel.hide();
         FlxG.unfollow();
         FlxG.resetInput();
         FlxG.destroySounds();
         FlxG.flash.stop();
         FlxG.fade.stop();
         FlxG.quake.stop();
         this._screen.x = 0;
         this._screen.y = 0;
         this._screen.addChild(param1);
         if(this._state != null)
         {
            this._state.destroy();
            this._screen.swapChildren(param1,this._state);
            this._screen.removeChild(this._state);
         }
         this._state = param1;
         this._state.scaleX = this._state.scaleY = this._zoom;
         this._state.create();
      }
      
      protected function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         if(param1.keyCode == 192 || param1.keyCode == 220)
         {
            this._console.toggle();
            return;
         }
         if(!FlxG.mobile && this.useDefaultHotKeys)
         {
            _loc4_ = int(param1.keyCode);
            _loc5_ = String.fromCharCode(param1.charCode);
            switch(_loc4_)
            {
               case 48:
               case 96:
                  FlxG.mute = !FlxG.mute;
                  this.showSoundTray();
                  return;
               case 109:
               case 189:
                  FlxG.mute = false;
                  FlxG.volume -= 0.1;
                  this.showSoundTray();
                  return;
               case 107:
               case 187:
                  FlxG.mute = false;
                  FlxG.volume += 0.1;
                  this.showSoundTray();
                  return;
               case 80:
                  FlxG.pause = !FlxG.pause;
            }
         }
         FlxG.keys.handleKeyUp(param1);
         var _loc2_:uint = 0;
         var _loc3_:uint = FlxG.gamepads.length;
         while(_loc2_ < _loc3_)
         {
            FlxG.gamepads[_loc2_++].handleKeyUp(param1);
         }
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         FlxG.keys.handleKeyDown(param1);
         var _loc2_:uint = 0;
         var _loc3_:uint = FlxG.gamepads.length;
         while(_loc2_ < _loc3_)
         {
            FlxG.gamepads[_loc2_++].handleKeyDown(param1);
         }
      }
      
      protected function onFocus(param1:Event = null) : void
      {
         if(FlxG.pause)
         {
            FlxG.pause = false;
         }
      }
      
      protected function onFocusLost(param1:Event = null) : void
      {
         FlxG.pause = true;
      }
      
      internal function unpauseGame() : void
      {
         if(!FlxG.panel.visible)
         {
            Mouse.hide();
         }
         FlxG.resetInput();
         this._paused = false;
         stage.frameRate = this._framerate;
      }
      
      internal function pauseGame() : void
      {
         if(x != 0 || y != 0)
         {
            x = 0;
            y = 0;
         }
         Mouse.show();
         this._paused = true;
         stage.frameRate = this._frameratePaused;
      }
      
      protected function update(param1:Event) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:FlxSave = null;
         var _loc2_:uint = uint(getTimer());
         var _loc5_:uint = uint(_loc2_ - this._total);
         this._elapsed = _loc5_ / 1000;
         this._console.mtrTotal.add(_loc5_);
         this._total = _loc2_;
         FlxG.elapsed = this._elapsed;
         if(FlxG.elapsed > FlxG.maxElapsed)
         {
            FlxG.elapsed = FlxG.maxElapsed;
         }
         FlxG.elapsed *= FlxG.timeScale;
         if(this._soundTray != null)
         {
            if(this._soundTrayTimer > 0)
            {
               this._soundTrayTimer -= this._elapsed;
            }
            else if(this._soundTray.y > -this._soundTray.height)
            {
               this._soundTray.y -= this._elapsed * FlxG.height * 2;
               if(this._soundTray.y <= -this._soundTray.height)
               {
                  this._soundTray.visible = false;
                  _loc4_ = new FlxSave();
                  if(_loc4_.bind("flixel"))
                  {
                     if(_loc4_.data.sound == null)
                     {
                        _loc4_.data.sound = new Object();
                     }
                     _loc4_.data.mute = FlxG.mute;
                     _loc4_.data.volume = FlxG.volume;
                     _loc4_.forceSave();
                  }
               }
            }
         }
         FlxG.panel.update();
         if(this._console.visible)
         {
            this._console.update();
         }
         FlxG.updateInput();
         FlxG.updateSounds();
         if(this._paused)
         {
            this.pause.update();
         }
         else
         {
            FlxG.doFollow();
            this._state.update();
            if(FlxG.flash.exists)
            {
               FlxG.flash.update();
            }
            if(FlxG.fade.exists)
            {
               FlxG.fade.update();
            }
            FlxG.quake.update();
            this._screen.x = FlxG.quake.x;
            this._screen.y = FlxG.quake.y;
         }
         var _loc6_:uint = uint(getTimer());
         this._console.mtrUpdate.add(_loc6_ - _loc2_);
         FlxG.buffer.lock();
         this._state.preProcess();
         this._state.render();
         if(FlxG.flash.exists)
         {
            FlxG.flash.render();
         }
         if(FlxG.fade.exists)
         {
            FlxG.fade.render();
         }
         if(FlxG.panel.visible)
         {
            FlxG.panel.render();
         }
         if(FlxG.mouse.cursor != null)
         {
            if(FlxG.mouse.cursor.active)
            {
               FlxG.mouse.cursor.update();
            }
            if(FlxG.mouse.cursor.visible)
            {
               FlxG.mouse.cursor.render();
            }
         }
         this._state.postProcess();
         if(this._paused)
         {
            this.pause.render();
         }
         FlxG.buffer.unlock();
         this._console.mtrRender.add(getTimer() - _loc6_);
         FlxG.mouse.wheel = 0;
      }
      
      internal function create(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:FlxSave = null;
         var _loc8_:TextField = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Bitmap = null;
         if(root == null)
         {
            return;
         }
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.frameRate = this._framerate;
         this._screen = new Sprite();
         addChild(this._screen);
         var _loc5_:Bitmap = new Bitmap(new BitmapData(FlxG.width,FlxG.height,true,FlxState.bgColor));
         _loc5_.x = this._gameXOffset;
         _loc5_.y = this._gameYOffset;
         _loc5_.scaleX = _loc5_.scaleY = this._zoom;
         this._screen.addChild(_loc5_);
         FlxG.buffer = _loc5_.bitmapData;
         this._console = new FlxConsole(this._gameXOffset,this._gameYOffset,this._zoom);
         if(!FlxG.mobile)
         {
            addChild(this._console);
         }
         var _loc6_:* = FlxG.LIBRARY_NAME + " v" + FlxG.LIBRARY_MAJOR_VERSION + "." + FlxG.LIBRARY_MINOR_VERSION;
         if(FlxG.debug)
         {
            _loc6_ += " [debug]";
         }
         else
         {
            _loc6_ += " [release]";
         }
         var _loc7_:* = "";
         _loc2_ = 0;
         _loc3_ = uint(_loc6_.length + 32);
         while(_loc2_ < _loc3_)
         {
            _loc7_ += "-";
            _loc2_++;
         }
         FlxG.log(_loc6_);
         FlxG.log(_loc7_);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,FlxG.mouse.handleMouseDown);
         stage.addEventListener(MouseEvent.MOUSE_UP,FlxG.mouse.handleMouseUp);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         if(!FlxG.mobile)
         {
            stage.addEventListener(MouseEvent.MOUSE_OUT,FlxG.mouse.handleMouseOut);
            stage.addEventListener(MouseEvent.MOUSE_OVER,FlxG.mouse.handleMouseOver);
            stage.addEventListener(MouseEvent.MOUSE_WHEEL,FlxG.mouse.handleMouseWheel);
            stage.addEventListener(Event.DEACTIVATE,this.onFocusLost);
            stage.addEventListener(Event.ACTIVATE,this.onFocus);
            this._soundTray = new Sprite();
            this._soundTray.visible = false;
            this._soundTray.scaleX = 2;
            this._soundTray.scaleY = 2;
            _loc5_ = new Bitmap(new BitmapData(80,30,true,2130706432));
            this._soundTray.x = (this._gameXOffset + FlxG.width / 2) * this._zoom - _loc5_.width / 2 * this._soundTray.scaleX;
            this._soundTray.addChild(_loc5_);
            _loc8_ = new TextField();
            _loc8_.width = _loc5_.width;
            _loc8_.height = _loc5_.height;
            _loc8_.multiline = true;
            _loc8_.wordWrap = true;
            _loc8_.selectable = false;
            _loc8_.embedFonts = true;
            _loc8_.antiAliasType = AntiAliasType.NORMAL;
            _loc8_.gridFitType = GridFitType.PIXEL;
            _loc8_.defaultTextFormat = new TextFormat("system",8,16777215,null,null,null,null,null,"center");
            this._soundTray.addChild(_loc8_);
            _loc8_.text = "VOLUME";
            _loc8_.y = 16;
            _loc9_ = 10;
            _loc10_ = 14;
            this._soundTrayBars = new Array();
            _loc2_ = 0;
            while(_loc2_ < 10)
            {
               _loc5_ = new Bitmap(new BitmapData(4,++_loc2_,false,16777215));
               _loc5_.x = _loc9_;
               _loc5_.y = _loc10_;
               this._soundTrayBars.push(this._soundTray.addChild(_loc5_));
               _loc9_ += 6;
               _loc10_--;
            }
            addChild(this._soundTray);
            _loc4_ = new FlxSave();
            if(_loc4_.bind("flixel") && _loc4_.data.sound != null)
            {
               if(_loc4_.data.volume != null)
               {
                  FlxG.volume = _loc4_.data.volume;
               }
               if(_loc4_.data.mute != null)
               {
                  FlxG.mute = _loc4_.data.mute;
               }
               this.showSoundTray(true);
            }
         }
         if(this._frame != null)
         {
            _loc11_ = new this._frame();
            _loc11_.scaleX = this._zoom;
            _loc11_.scaleY = this._zoom;
            addChild(_loc11_);
         }
         this.switchState(new this._iState());
         FlxState.screen.unsafeBind(FlxG.buffer);
         removeEventListener(Event.ENTER_FRAME,this.create);
         addEventListener(Event.ENTER_FRAME,this.update);
      }
   }
}

