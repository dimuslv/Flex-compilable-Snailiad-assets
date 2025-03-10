package org.flixel
{
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import org.flixel.data.*;
   
   public class FlxG
   {
      protected static var _game:FlxGame;
      
      protected static var _pause:Boolean;
      
      public static var debug:Boolean;
      
      public static var showBounds:Boolean;
      
      public static var elapsed:Number;
      
      public static var maxElapsed:Number;
      
      public static var timeScale:Number;
      
      public static var width:uint;
      
      public static var height:uint;
      
      public static var mobile:Boolean;
      
      public static var levels:Array;
      
      public static var level:int;
      
      public static var scores:Array;
      
      public static var score:int;
      
      public static var saves:Array;
      
      public static var save:int;
      
      public static var mouse:FlxMouse;
      
      public static var keys:FlxKeyboard;
      
      public static var gamepads:Array;
      
      public static var music:FlxSound;
      
      public static var sounds:Array;
      
      protected static var _mute:Boolean;
      
      protected static var _volume:Number;
      
      public static var followTarget:FlxObject;
      
      public static var followLead:Point;
      
      public static var followLerp:Number;
      
      public static var followMin:Point;
      
      public static var followMax:Point;
      
      protected static var _scrollTarget:Point;
      
      public static var scroll:Point;
      
      public static var buffer:BitmapData;
      
      protected static var _cache:Object;
      
      protected static var _cacheReverse:Object;
      
      public static var kong:FlxKong;
      
      public static var panel:FlxPanel;
      
      public static var quake:FlxQuake;
      
      public static var flash:FlxFlash;
      
      public static var fade:FlxFade;
      
      public static var noPause:Boolean = false;
      
      public static var cheated:Boolean = false;
      
      public static var _curSongVolume:Number = 1;
      
      public static var consoleEnabled:Boolean = false;
      
      protected static var _musicVolume:Number = 1;
      
      public static var MinX:int = 0;
      
      public static var MinY:int = 0;
      
      public static var MaxX:int = 0;
      
      public static var MaxY:int = 0;
      
      public function FlxG()
      {
         super();
      }
      
      public static function log(param1:Object) : void
      {
         if(_game != null && _game._console != null)
         {
            _game._console.log(param1 == null ? "ERROR: null object" : param1.toString());
         }
      }
      
      public static function get pause() : Boolean
      {
         return _pause;
      }
      
      public static function set pause(param1:Boolean) : void
      {
         var _loc2_:Boolean = _pause;
         _pause = param1;
         if(_pause != _loc2_)
         {
            if(_pause)
            {
               _game.pauseGame();
               pauseSounds();
            }
            else
            {
               _game.unpauseGame();
               playSounds();
            }
         }
      }
      
      public static function get framerate() : uint
      {
         return _game._framerate;
      }
      
      public static function set framerate(param1:uint) : void
      {
         _game._framerate = param1;
         if(!_game._paused && _game.stage != null)
         {
            _game.stage.frameRate = param1;
         }
      }
      
      public static function get frameratePaused() : uint
      {
         return _game._frameratePaused;
      }
      
      public static function set frameratePaused(param1:uint) : void
      {
         _game._frameratePaused = param1;
         if(_game._paused && _game.stage != null)
         {
            _game.stage.frameRate = param1;
         }
      }
      
      public static function resetInput() : void
      {
         keys.reset();
         mouse.reset();
         var _loc1_:uint = 0;
         var _loc2_:uint = gamepads.length;
         while(_loc1_ < _loc2_)
         {
            gamepads[_loc1_++].reset();
         }
      }
      
      public static function playMusic(param1:Class, param2:Number = 1, param3:Number = 0) : void
      {
         if(music == null)
         {
            music = new FlxSound();
         }
         else if(music.active)
         {
            music.stop();
         }
         music.loadEmbedded(param1,true);
         _curSongVolume = param2;
         music.volume = _musicVolume * _curSongVolume;
         music.survive = true;
         if(param3)
         {
            music.fadeIn(param3);
         }
         music.play();
      }
      
      public static function play(param1:Class, param2:Number = 0.75, param3:Boolean = false) : FlxSound
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = sounds.length;
         while(_loc4_ < _loc5_)
         {
            if(!(sounds[_loc4_] as FlxSound).active)
            {
               break;
            }
            _loc4_++;
         }
         if(sounds[_loc4_] == null)
         {
            sounds[_loc4_] = new FlxSound();
         }
         var _loc6_:FlxSound = sounds[_loc4_];
         _loc6_.loadEmbedded(param1,param3);
         _loc6_.volume = param2;
         _loc6_.play();
         return _loc6_;
      }
      
      public static function stream(param1:String, param2:Number = 1, param3:Boolean = false) : FlxSound
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = sounds.length;
         while(_loc4_ < _loc5_)
         {
            if(!(sounds[_loc4_] as FlxSound).active)
            {
               break;
            }
            _loc4_++;
         }
         if(sounds[_loc4_] == null)
         {
            sounds[_loc4_] = new FlxSound();
         }
         var _loc6_:FlxSound = sounds[_loc4_];
         _loc6_.loadStream(param1,param3);
         _loc6_.volume = param2;
         _loc6_.play();
         return _loc6_;
      }
      
      public static function get mute() : Boolean
      {
         return _mute;
      }
      
      public static function set mute(param1:Boolean) : void
      {
         _mute = param1;
         changeSounds();
      }
      
      public static function getMuteValue() : uint
      {
         if(_mute)
         {
            return 0;
         }
         return 1;
      }
      
      public static function get volume() : Number
      {
         return _volume;
      }
      
      public static function get musicVolume() : Number
      {
         return _musicVolume;
      }
      
      public static function set volume(param1:Number) : void
      {
         _volume = param1;
         if(_volume < 0)
         {
            _volume = 0;
         }
         else if(_volume > 1)
         {
            _volume = 1;
         }
         changeSounds();
      }
      
      public static function set musicVolume(param1:Number) : void
      {
         _musicVolume = param1;
         if(_musicVolume < 0)
         {
            _musicVolume = 0;
         }
         else if(_musicVolume > 1)
         {
            _musicVolume = 1;
         }
         if(music != null)
         {
            music.volume = _musicVolume * _curSongVolume;
         }
         changeSounds();
      }
      
      internal static function destroySounds(param1:Boolean = false) : void
      {
         var _loc3_:FlxSound = null;
         if(sounds == null)
         {
            return;
         }
         if(music != null && (param1 || !music.survive))
         {
            music.destroy();
         }
         var _loc2_:uint = 0;
         var _loc4_:uint = sounds.length;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = sounds[_loc2_++] as FlxSound;
            if(_loc3_ != null && (param1 || !_loc3_.survive))
            {
               _loc3_.destroy();
            }
         }
      }
      
      protected static function changeSounds() : void
      {
         var _loc2_:FlxSound = null;
         if(music != null && music.active)
         {
            music.updateTransform();
         }
         var _loc1_:uint = 0;
         var _loc3_:uint = sounds.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = sounds[_loc1_++] as FlxSound;
            if(_loc2_ != null && _loc2_.active)
            {
               _loc2_.updateTransform();
            }
         }
      }
      
      internal static function updateSounds() : void
      {
         var _loc2_:FlxSound = null;
         if(music != null && music.active)
         {
            music.update();
         }
         var _loc1_:uint = 0;
         var _loc3_:uint = sounds.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = sounds[_loc1_++] as FlxSound;
            if(_loc2_ != null && _loc2_.active)
            {
               _loc2_.update();
            }
         }
      }
      
      protected static function pauseSounds() : void
      {
         var _loc2_:FlxSound = null;
         var _loc1_:uint = 0;
         var _loc3_:uint = sounds.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = sounds[_loc1_++] as FlxSound;
            if(_loc2_ != null && _loc2_.active)
            {
               _loc2_.pause();
            }
         }
      }
      
      protected static function playSounds() : void
      {
         var _loc2_:FlxSound = null;
         if(music != null && music.active)
         {
            music.play();
         }
         var _loc1_:uint = 0;
         var _loc3_:uint = sounds.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = sounds[_loc1_++] as FlxSound;
            if(_loc2_ != null && _loc2_.active)
            {
               _loc2_.play();
            }
         }
      }
      
      public static function checkBitmapCache(param1:String) : Boolean
      {
         return _cache[param1] != undefined && _cache[param1] != null;
      }
      
      public static function createBitmap(param1:uint, param2:uint, param3:uint, param4:Boolean = false, param5:String = null) : BitmapData
      {
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc6_:String = param5;
         if(_loc6_ == null)
         {
            _loc6_ = param1 + "x" + param2 + ":" + param3;
            if(param4 && _cache[_loc6_] != undefined && _cache[_loc6_] != null)
            {
               _loc7_ = 0;
               do
               {
                  _loc8_ = _loc6_ + _loc7_++;
               }
               while(_cache[_loc8_] != undefined && _cache[_loc8_] != null);
               
               _loc6_ = _loc8_;
            }
         }
         if(!checkBitmapCache(_loc6_))
         {
            _cache[_loc6_] = new BitmapData(param1,param2,true,param3);
         }
         return _cache[_loc6_];
      }
      
      public static function addBitmap(param1:Class, param2:Boolean = false, param3:Boolean = false, param4:String = null) : BitmapData
      {
         var _loc8_:BitmapData = null;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc11_:BitmapData = null;
         var _loc12_:Matrix = null;
         var _loc5_:Boolean = false;
         var _loc6_:String = param4;
         if(_loc6_ == null)
         {
            _loc6_ = String(param1);
            if(_loc6_ == "[class SixMap3_Imgplayer]")
            {
            }
            if(param3 && _cache[_loc6_] != undefined && _cache[_loc6_] != null)
            {
               _loc9_ = 0;
               do
               {
                  _loc10_ = _loc6_ + _loc9_++;
               }
               while(_cache[_loc10_] != undefined && _cache[_loc10_] != null);
               
               _loc6_ = _loc10_;
            }
         }
         var _loc7_:Boolean = false;
         if(!checkBitmapCache(_loc6_))
         {
            _cache[_loc6_] = new param1().bitmapData;
            if(param2)
            {
               _loc5_ = true;
            }
         }
         else
         {
            _loc7_ = true;
         }
         if(!_loc7_ || !param2)
         {
            _loc8_ = _cache[_loc6_];
         }
         if(_loc7_ && param2)
         {
            _loc5_ = true;
         }
         else if(!_loc5_ && param2 && _loc8_.width == new param1().bitmapData.width)
         {
            _loc5_ = true;
         }
         if(_loc5_)
         {
            if(!_loc7_)
            {
               _loc11_ = new BitmapData(_loc8_.width << 1,_loc8_.height,true,0);
               _loc11_.draw(_loc8_);
               _loc12_ = new Matrix();
               _loc12_.scale(-1,1);
               _loc12_.translate(_loc11_.width,0);
               _loc11_.draw(_loc8_,_loc12_);
               _loc8_ = _loc11_;
               _cacheReverse[_loc6_] = _loc11_;
            }
            else
            {
               _loc8_ = _cacheReverse[_loc6_];
            }
         }
         return _loc8_;
      }
      
      public static function follow(param1:FlxObject, param2:Number = 1, param3:Boolean = true) : void
      {
         followTarget = param1;
         followLerp = param2;
         _scrollTarget.x = (width >> 1) - followTarget.x - (followTarget.width >> 1);
         _scrollTarget.y = (height >> 1) - followTarget.y - (followTarget.height >> 1);
         if(param3)
         {
            scroll.x = _scrollTarget.x;
            scroll.y = _scrollTarget.y;
         }
         doFollow();
      }
      
      public static function followAdjust(param1:Number = 0, param2:Number = 0) : void
      {
         followLead = new Point(param1,param2);
      }
      
      public static function followBounds(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:Boolean = true) : void
      {
         followMin = new Point(-param1,-param2);
         followMax = new Point(-param3 + width,-param4 + height);
         if(followMax.x > followMin.x)
         {
            followMax.x = followMin.x;
         }
         if(followMax.y > followMin.y)
         {
            followMax.y = followMin.y;
         }
         if(param5)
         {
            FlxU.setWorldBounds(param1,param2,param3 - param1,param4 - param2);
         }
         FlxG.MinX = param1;
         FlxG.MaxX = param3;
         FlxG.MinY = param2;
         FlxG.MaxY = param4;
         doFollow();
      }
      
      public static function get stage() : Stage
      {
         if(_game._state != null && _game._state.parent != null)
         {
            return _game._state.parent.stage;
         }
         return null;
      }
      
      public static function get state() : FlxState
      {
         return _game._state;
      }
      
      public static function set state(param1:FlxState) : void
      {
         _game.switchState(param1);
      }
      
      public static function unfollow() : void
      {
         followTarget = null;
         followLead = null;
         followLerp = 1;
         followMin = null;
         followMax = null;
         if(scroll == null)
         {
            scroll = new Point();
         }
         else
         {
            scroll.x = scroll.y = 0;
         }
         if(_scrollTarget == null)
         {
            _scrollTarget = new Point();
         }
         else
         {
            _scrollTarget.x = _scrollTarget.y = 0;
         }
      }
      
      internal static function setGameData(param1:FlxGame, param2:uint, param3:uint, param4:uint) : void
      {
         _game = param1;
         _cache = new Object();
         _cacheReverse = new Object();
         width = param2;
         height = param3;
         _mute = false;
         _volume = 1;
         sounds = new Array();
         mouse = new FlxMouse();
         keys = new FlxKeyboard();
         gamepads = new Array(4);
         gamepads[0] = new FlxGamepad();
         gamepads[1] = new FlxGamepad();
         gamepads[2] = new FlxGamepad();
         gamepads[3] = new FlxGamepad();
         scroll = null;
         _scrollTarget = null;
         unfollow();
         FlxG.levels = new Array();
         FlxG.scores = new Array();
         level = 0;
         score = 0;
         kong = null;
         pause = false;
         timeScale = 1;
         framerate = 60;
         frameratePaused = 24;
         maxElapsed = 0.0333333;
         FlxG.elapsed = 0;
         showBounds = false;
         mobile = false;
         panel = new FlxPanel();
         quake = new FlxQuake(param4);
         flash = new FlxFlash();
         fade = new FlxFade();
         FlxU.setWorldBounds(0,0,FlxG.width,FlxG.height);
      }
      
      internal static function doFollow() : void
      {
         if(followTarget != null)
         {
            _scrollTarget.x = (width >> 1) - followTarget.x - (followTarget.width >> 1);
            _scrollTarget.y = (height >> 1) - followTarget.y - (followTarget.height >> 1);
            if(followLead != null && followTarget is FlxSprite)
            {
               _scrollTarget.x -= (followTarget as FlxSprite).velocity.x * followLead.x;
               _scrollTarget.y -= (followTarget as FlxSprite).velocity.y * followLead.y;
            }
            scroll.x += (_scrollTarget.x - scroll.x) * followLerp * FlxG.elapsed;
            scroll.y += (_scrollTarget.y - scroll.y) * followLerp * FlxG.elapsed;
            if(followMin != null)
            {
               if(scroll.x > followMin.x)
               {
                  scroll.x = followMin.x;
               }
               if(scroll.y > followMin.y)
               {
                  scroll.y = followMin.y;
               }
            }
            if(followMax != null)
            {
               if(scroll.x < followMax.x)
               {
                  scroll.x = followMax.x;
               }
               if(scroll.y < followMax.y)
               {
                  scroll.y = followMax.y;
               }
            }
         }
      }
      
      internal static function updateInput() : void
      {
         keys.update();
         mouse.update(state.mouseX,state.mouseY,scroll.x,scroll.y);
         var _loc1_:uint = 0;
         var _loc2_:uint = gamepads.length;
         while(_loc1_ < _loc2_)
         {
            gamepads[_loc1_++].update();
         }
      }
   }
}

