package
{
   import org.flixel.*;
   
   public class Ending extends FlxGroup
   {
      private static const ENDING_FADE_TIMEOUT:Number = 2;
      
      private static const CREDITS_DONE_TIME:Number = 7;
      
      private static const MODE_NONE:int = 0;
      
      private static const MODE_WAIT_START:int = 1;
      
      private static const MODE_DIALOGUE:int = 2;
      
      private static const MODE_WAIT_CREDITS:int = 3;
      
      private static const MODE_CREDITS:int = 4;
      
      private static const MODE_WAIT_PICTURE:int = 5;
      
      private static const MODE_PICTURE:int = 6;
      
      private static const MODE_END:int = 7;
      
      public var pictureLayer:FlxGroup;
      
      private var elapsed:Number = 0;
      
      private var endingFade:Boolean = false;
      
      private var endingFadeTimeout:Number = 0;
      
      public var bg:EndingStarBg;
      
      private var _creditsDoneTimer:Number = 0;
      
      private var _finalText:FlxText;
      
      private var _mode:int = 0;
      
      private var _modeElapsed:Number = 0;
      
      private var _modeInitialized:Boolean = false;
      
      private var _dialogueMode:Number = 0;
      
      private var _targetAlpha:Array;
      
      private var _moonSprite:Array;
      
      private var _dialogueLayer:EndingDialogue;
      
      private var _hasSunSnailAppeared:Boolean = false;
      
      private var _zzz:EndingZzz;
      
      private var _sunSnailSprite:EndingSunSnail;
      
      private var _credits:EndingCredits;
      
      private var _ending1SongPlaying:Boolean = false;
      
      override public function destroy() : void
      {
         bg = null;
         pictureLayer = null;
         _targetAlpha = null;
         _moonSprite = null;
         _dialogueLayer = null;
         _sunSnailSprite = null;
         _credits = null;
         _zzz = null;
         _finalText = null;
         super.destroy();
      }
      
      public function Ending() : void
      {
         FlxG.mouse.hide();
         FlxG.noPause = true;
         setMode(MODE_WAIT_START);
         _targetAlpha = new Array();
         _moonSprite = new Array();
         bg = new EndingStarBg();
         add(bg);
         _dialogueLayer = new EndingDialogue();
         add(_dialogueLayer);
         FlxG.fade.stop();
         FlxG.flash.start(4278190080,1.4);
         if(PlayState.player.getHelixFragments() == 30)
         {
            PlayState.hasGoodEnding = true;
            NgMedal.unlockHappyEnding();
            PlayState.player.saveNoCoords();
         }
         if(PlayState.player._slugMode)
         {
            NgMedal.unlockHomeless();
         }
      }
      
      public function setMode(param1:int) : void
      {
         _mode = param1;
         _modeElapsed = 0;
         _modeInitialized = false;
      }
      
      public function updateEndingWaitStart() : void
      {
         if(_modeElapsed > 0.8)
         {
            setMode(MODE_DIALOGUE);
         }
      }
      
      public function makeSunSnail() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _moonSprite[_loc1_].setTargetAlpha(0);
            _moonSprite[_loc1_].alpha = 0;
            _loc1_++;
         }
         FlxG.fade.stop();
         FlxG.flash.start(4294967295,1.4);
         bg.setTargetRgb(228,0,96);
         _sunSnailSprite = new EndingSunSnail(264,140);
         add(_sunSnailSprite);
      }
      
      public function updateEndingDialogue() : void
      {
         var _loc1_:int = 0;
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            FlxG.fade.stop();
            FlxG.flash.start(4278190080,1.4);
            bg.setRgb(0,0,0);
            if(PlayState.player.getHelixFragments() == 30)
            {
               bg.setTargetRgb(21,0,0);
            }
            else
            {
               bg.setTargetRgb(0,48,48);
            }
            bg.fadeIn();
            _dialogueMode = 0;
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               _moonSprite[_loc1_] = new EndingMoonSnail(FlxG.width / 2 + 30,FlxG.height / 2 + 10,_loc1_);
               add(_moonSprite[_loc1_]);
               _loc1_++;
            }
         }
         if(_modeElapsed > 0.9 && !_ending1SongPlaying)
         {
            Sfx.playEnding1();
            _ending1SongPlaying = true;
         }
         if(_modeElapsed < 5)
         {
            _moonSprite[0].setTargetAlpha(1);
         }
         else if(_modeElapsed < 10.5)
         {
            _moonSprite[0].setTargetAlpha(0);
            _moonSprite[1].setTargetAlpha(1);
         }
         else if(_modeElapsed < 16.5)
         {
            _moonSprite[1].setTargetAlpha(0);
            _moonSprite[2].setTargetAlpha(1);
         }
         else if(_modeElapsed < 23)
         {
            if(PlayState.player.getHelixFragments() == 30)
            {
               if(!_hasSunSnailAppeared)
               {
                  _hasSunSnailAppeared = true;
                  FlxG.fade.start(4294967295,0.6,makeSunSnail);
               }
            }
            else
            {
               _moonSprite[2].setTargetAlpha(0);
               _moonSprite[3].setTargetAlpha(1);
               if(_moonSprite[3].alpha == 1 && !_zzz)
               {
                  _zzz = new EndingZzz(277,155);
                  _zzz.scrollFactor.x = _zzz.scrollFactor.y = 0;
                  add(_zzz);
               }
            }
         }
         if(_modeElapsed > 0.6 && _dialogueMode <= 1)
         {
            if(_dialogueMode < 1)
            {
               _dialogueMode = 1;
               _dialogueLayer.start("     AND SO...\n");
            }
         }
         if(_modeElapsed > 6 && _dialogueMode <= 1)
         {
            _dialogueLayer.setAlpha(7 - _modeElapsed);
         }
         if(_modeElapsed > 7 && _dialogueMode <= 2)
         {
            if(_dialogueMode < 2)
            {
               _dialogueMode = 2;
               if(PlayState.player.getHelixFragments() == 30)
               {
                  _dialogueLayer.start("   MOON SNAIL ONCE AGAIN\n" + "     REGAINED HIS LIGHT\n");
               }
               else
               {
                  _dialogueLayer.start("   DEFEATED, MOON SNAIL\n" + "          LOST HIS POWERS\n");
               }
            }
         }
         if(_modeElapsed > 13 && _dialogueMode <= 2)
         {
            _dialogueLayer.setAlpha(14 - _modeElapsed);
         }
         if(_modeElapsed > 14 && _dialogueMode <= 3)
         {
            if(_dialogueMode < 3)
            {
               _dialogueMode = 3;
               if(PlayState.player.getHelixFragments() == 30)
               {
                  _dialogueLayer.start("     AND BECAME THE\n" + "  LEGENDARY SUN SNAIL\n");
               }
               else
               {
                  _dialogueLayer.start("BUT COULD HE EVER BECOME\n" + "      SUN SNAIL ONCE MORE?\n");
               }
            }
         }
         if(_modeElapsed > 25)
         {
            _dialogueLayer.setAlpha(26 - _modeElapsed);
         }
         if(FlxG.keys.justPressed("ESCAPE"))
         {
            Sfx.stopEnding1();
            _dialogueLayer.setAlpha(0);
            setMode(MODE_WAIT_CREDITS);
            _moonSprite[0].setTargetAlpha(0);
            _moonSprite[1].setTargetAlpha(0);
            _moonSprite[2].setTargetAlpha(0);
            _moonSprite[3].setTargetAlpha(0);
            return;
         }
         if(_modeElapsed > 26)
         {
            setMode(MODE_WAIT_CREDITS);
         }
      }
      
      public function updateEndingWaitCredits() : void
      {
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            FlxG.fade.start(4278190080,1.9);
         }
         if(_modeElapsed > 2)
         {
            setMode(MODE_CREDITS);
         }
      }
      
      public function updateEndingCredits() : void
      {
         var _loc1_:StarLayer = null;
         var _loc2_:int = 0;
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            Music.playEnding2();
            _loc1_ = new StarLayer();
            _loc1_.makeStars();
            add(_loc1_);
            if(_sunSnailSprite)
            {
               _sunSnailSprite.kill();
               remove(_sunSnailSprite);
            }
            bg.setAlpha(0);
            bg.setRgb(0,0,48);
            bg.setTargetRgb(0,0,48);
            FlxG.fade.stop();
            FlxG.flash.start(4278190080,1.4);
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               remove(_moonSprite[_loc2_]);
               _moonSprite[_loc2_] = null;
               _loc2_++;
            }
            if(_zzz)
            {
               remove(_zzz);
               _zzz = null;
            }
            _credits = new EndingCredits();
            add(_credits);
            _creditsDoneTimer = CREDITS_DONE_TIME;
         }
         if(FlxG.keys.justPressed("ESCAPE"))
         {
            _credits.scrollDone = true;
            _creditsDoneTimer = 0;
         }
         if(_credits.scrollDone)
         {
            _creditsDoneTimer -= FlxG.elapsed;
            if(_creditsDoneTimer < 0)
            {
               setMode(MODE_WAIT_PICTURE);
            }
         }
      }
      
      public function updateEndingWaitPicture() : void
      {
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            FlxG.fade.start(4278190080,1.9);
         }
         if(_modeElapsed > 2)
         {
            setMode(MODE_PICTURE);
         }
      }
      
      public function updateEndingPicture() : void
      {
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            if(_credits)
            {
               remove(_credits);
               _credits = null;
            }
            pictureLayer = new EndingGroup(PlayState.endingNum);
            add(pictureLayer);
            FlxG.fade.stop();
            FlxG.flash.start(4278190080,1.4);
         }
         if(_modeElapsed > 3 && !_finalText)
         {
            _finalText = new FlxText(-4,FlxG.height / 2 - 30,FlxG.width);
            _finalText.font = Fonts.normal;
            _finalText.size = 20;
            _finalText.color = 16777215;
            _finalText.shadow = 4278190081;
            _finalText.setShadowDistance(2);
            _finalText.outline = true;
            _finalText.outlineColor = 4278190080;
            _finalText.alignment = "center";
            _finalText.text = "CONGRATULATIONS!!\n\n" + "ITEMS COLLECTED: " + PlayState.player.getPercentComplete() + "%\n" + "CLEAR TIME: " + GameTimeDisplay.formatExact(PlayState.player.clearTime.value) + "\n";
            _finalText.scrollFactor.x = _finalText.scrollFactor.y = 0;
            _finalText.alpha = 0;
            add(_finalText);
            PauseLayer.hideMe = true;
         }
         if(_finalText)
         {
            var _loc1_:Number = _modeElapsed - 3;
            if(_loc1_ > 1)
            {
               _loc1_ = 1;
               if(Utility.justPressedAnyKey() || FlxG.mouse.justPressed())
               {
                  setMode(MODE_END);
               }
            }
            _finalText.alpha = _loc1_;
         }
      }
      
      public function updateEndingEnd() : void
      {
         if(!_modeInitialized)
         {
            PauseLayer.hideMe = false;
            _modeInitialized = true;
            endingFadeTimeout = ENDING_FADE_TIMEOUT;
            FlxG.fade.start(4278190080,ENDING_FADE_TIMEOUT);
            FlxG.music.fadeOut(ENDING_FADE_TIMEOUT);
         }
         endingFadeTimeout -= FlxG.elapsed;
         if(endingFadeTimeout < 0)
         {
            FlxG.noPause = false;
            PlayState.endEnding();
         }
      }
      
      override public function update() : void
      {
         elapsed += FlxG.elapsed;
         _modeElapsed += FlxG.elapsed;
         switch(_mode)
         {
            case MODE_NONE:
               setMode(MODE_WAIT_START);
               break;
            case MODE_WAIT_START:
               updateEndingWaitStart();
               break;
            case MODE_DIALOGUE:
               updateEndingDialogue();
               break;
            case MODE_WAIT_CREDITS:
               updateEndingWaitCredits();
               break;
            case MODE_CREDITS:
               updateEndingCredits();
               break;
            case MODE_WAIT_PICTURE:
               updateEndingWaitPicture();
               break;
            case MODE_PICTURE:
               updateEndingPicture();
               break;
            case MODE_END:
               updateEndingEnd();
			   break;
         }
         super.update();
      }
   }
}

