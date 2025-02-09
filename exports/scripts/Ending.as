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
      
      public function Ending()
      {
         super();
         FlxG.mouse.hide();
         FlxG.noPause = true;
         this.setMode(MODE_WAIT_START);
         this._targetAlpha = new Array();
         this._moonSprite = new Array();
         this.bg = new EndingStarBg();
         add(this.bg);
         this._dialogueLayer = new EndingDialogue();
         add(this._dialogueLayer);
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
      
      override public function destroy() : void
      {
         this.bg = null;
         this.pictureLayer = null;
         this._targetAlpha = null;
         this._moonSprite = null;
         this._dialogueLayer = null;
         this._sunSnailSprite = null;
         this._credits = null;
         this._zzz = null;
         this._finalText = null;
         super.destroy();
      }
      
      public function setMode(param1:int) : void
      {
         this._mode = param1;
         this._modeElapsed = 0;
         this._modeInitialized = false;
      }
      
      public function updateEndingWaitStart() : void
      {
         if(this._modeElapsed > 0.8)
         {
            this.setMode(MODE_DIALOGUE);
         }
      }
      
      public function makeSunSnail() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this._moonSprite[_loc1_].setTargetAlpha(0);
            this._moonSprite[_loc1_].alpha = 0;
            _loc1_++;
         }
         FlxG.fade.stop();
         FlxG.flash.start(4294967295,1.4);
         this.bg.setTargetRgb(228,0,96);
         this._sunSnailSprite = new EndingSunSnail(264,140);
         add(this._sunSnailSprite);
      }
      
      public function updateEndingDialogue() : void
      {
         var _loc1_:int = 0;
         if(!this._modeInitialized)
         {
            this._modeInitialized = true;
            FlxG.fade.stop();
            FlxG.flash.start(4278190080,1.4);
            this.bg.setRgb(0,0,0);
            if(PlayState.player.getHelixFragments() == 30)
            {
               this.bg.setTargetRgb(21,0,0);
            }
            else
            {
               this.bg.setTargetRgb(0,48,48);
            }
            this.bg.fadeIn();
            this._dialogueMode = 0;
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               this._moonSprite[_loc1_] = new EndingMoonSnail(FlxG.width / 2 + 30,FlxG.height / 2 + 10,_loc1_);
               add(this._moonSprite[_loc1_]);
               _loc1_++;
            }
         }
         if(this._modeElapsed > 0.9 && !this._ending1SongPlaying)
         {
            Sfx.playEnding1();
            this._ending1SongPlaying = true;
         }
         if(this._modeElapsed < 5)
         {
            this._moonSprite[0].setTargetAlpha(1);
         }
         else if(this._modeElapsed < 10.5)
         {
            this._moonSprite[0].setTargetAlpha(0);
            this._moonSprite[1].setTargetAlpha(1);
         }
         else if(this._modeElapsed < 16.5)
         {
            this._moonSprite[1].setTargetAlpha(0);
            this._moonSprite[2].setTargetAlpha(1);
         }
         else if(this._modeElapsed < 23)
         {
            if(PlayState.player.getHelixFragments() == 30)
            {
               if(!this._hasSunSnailAppeared)
               {
                  this._hasSunSnailAppeared = true;
                  FlxG.fade.start(4294967295,0.6,this.makeSunSnail);
               }
            }
            else
            {
               this._moonSprite[2].setTargetAlpha(0);
               this._moonSprite[3].setTargetAlpha(1);
               if(this._moonSprite[3].alpha == 1 && !this._zzz)
               {
                  this._zzz = new EndingZzz(277,155);
                  this._zzz.scrollFactor.x = this._zzz.scrollFactor.y = 0;
                  add(this._zzz);
               }
            }
         }
         if(this._modeElapsed > 0.6 && this._dialogueMode <= 1)
         {
            if(this._dialogueMode < 1)
            {
               this._dialogueMode = 1;
               this._dialogueLayer.start("     AND SO...\n");
            }
         }
         if(this._modeElapsed > 6 && this._dialogueMode <= 1)
         {
            this._dialogueLayer.setAlpha(7 - this._modeElapsed);
         }
         if(this._modeElapsed > 7 && this._dialogueMode <= 2)
         {
            if(this._dialogueMode < 2)
            {
               this._dialogueMode = 2;
               if(PlayState.player.getHelixFragments() == 30)
               {
                  this._dialogueLayer.start("   MOON SNAIL ONCE AGAIN\n" + "     REGAINED HIS LIGHT\n");
               }
               else
               {
                  this._dialogueLayer.start("   DEFEATED, MOON SNAIL\n" + "          LOST HIS POWERS\n");
               }
            }
         }
         if(this._modeElapsed > 13 && this._dialogueMode <= 2)
         {
            this._dialogueLayer.setAlpha(14 - this._modeElapsed);
         }
         if(this._modeElapsed > 14 && this._dialogueMode <= 3)
         {
            if(this._dialogueMode < 3)
            {
               this._dialogueMode = 3;
               if(PlayState.player.getHelixFragments() == 30)
               {
                  this._dialogueLayer.start("     AND BECAME THE\n" + "  LEGENDARY SUN SNAIL\n");
               }
               else
               {
                  this._dialogueLayer.start("BUT COULD HE EVER BECOME\n" + "      SUN SNAIL ONCE MORE?\n");
               }
            }
         }
         if(this._modeElapsed > 25)
         {
            this._dialogueLayer.setAlpha(26 - this._modeElapsed);
         }
         if(FlxG.keys.justPressed("ESCAPE"))
         {
            Sfx.stopEnding1();
            this._dialogueLayer.setAlpha(0);
            this.setMode(MODE_WAIT_CREDITS);
            this._moonSprite[0].setTargetAlpha(0);
            this._moonSprite[1].setTargetAlpha(0);
            this._moonSprite[2].setTargetAlpha(0);
            this._moonSprite[3].setTargetAlpha(0);
            return;
         }
         if(this._modeElapsed > 26)
         {
            this.setMode(MODE_WAIT_CREDITS);
         }
      }
      
      public function updateEndingWaitCredits() : void
      {
         if(!this._modeInitialized)
         {
            this._modeInitialized = true;
            FlxG.fade.start(4278190080,1.9);
         }
         if(this._modeElapsed > 2)
         {
            this.setMode(MODE_CREDITS);
         }
      }
      
      public function updateEndingCredits() : void
      {
         var _loc1_:StarLayer = null;
         var _loc2_:int = 0;
         if(!this._modeInitialized)
         {
            this._modeInitialized = true;
            Music.playEnding2();
            _loc1_ = new StarLayer();
            _loc1_.makeStars();
            add(_loc1_);
            if(this._sunSnailSprite)
            {
               this._sunSnailSprite.kill();
               remove(this._sunSnailSprite);
            }
            this.bg.setAlpha(0);
            this.bg.setRgb(0,0,48);
            this.bg.setTargetRgb(0,0,48);
            FlxG.fade.stop();
            FlxG.flash.start(4278190080,1.4);
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               remove(this._moonSprite[_loc2_]);
               this._moonSprite[_loc2_] = null;
               _loc2_++;
            }
            if(this._zzz)
            {
               remove(this._zzz);
               this._zzz = null;
            }
            this._credits = new EndingCredits();
            add(this._credits);
            this._creditsDoneTimer = CREDITS_DONE_TIME;
         }
         if(FlxG.keys.justPressed("ESCAPE"))
         {
            this._credits.scrollDone = true;
            this._creditsDoneTimer = 0;
         }
         if(this._credits.scrollDone)
         {
            this._creditsDoneTimer -= FlxG.elapsed;
            if(this._creditsDoneTimer < 0)
            {
               this.setMode(MODE_WAIT_PICTURE);
            }
         }
      }
      
      public function updateEndingWaitPicture() : void
      {
         if(!this._modeInitialized)
         {
            this._modeInitialized = true;
            FlxG.fade.start(4278190080,1.9);
         }
         if(this._modeElapsed > 2)
         {
            this.setMode(MODE_PICTURE);
         }
      }
      
      public function updateEndingPicture() : void
      {
         var _loc1_:Number = NaN;
         if(!this._modeInitialized)
         {
            this._modeInitialized = true;
            if(this._credits)
            {
               remove(this._credits);
               this._credits = null;
            }
            this.pictureLayer = new EndingGroup(PlayState.endingNum);
            add(this.pictureLayer);
            FlxG.fade.stop();
            FlxG.flash.start(4278190080,1.4);
         }
         if(this._modeElapsed > 3 && !this._finalText)
         {
            this._finalText = new FlxText(-4,FlxG.height / 2 - 30,FlxG.width);
            this._finalText.font = Fonts.normal;
            this._finalText.size = 20;
            this._finalText.color = 16777215;
            this._finalText.shadow = 4278190081;
            this._finalText.setShadowDistance(2);
            this._finalText.outline = true;
            this._finalText.outlineColor = 4278190080;
            this._finalText.alignment = "center";
            this._finalText.text = "CONGRATULATIONS!!\n\n" + "ITEMS COLLECTED: " + PlayState.player.getPercentComplete() + "%\n" + "CLEAR TIME: " + GameTimeDisplay.formatExact(PlayState.player.clearTime.value) + "\n";
            this._finalText.scrollFactor.x = this._finalText.scrollFactor.y = 0;
            this._finalText.alpha = 0;
            add(this._finalText);
            PauseLayer.hideMe = true;
         }
         if(this._finalText)
         {
            _loc1_ = this._modeElapsed - 3;
            if(_loc1_ > 1)
            {
               _loc1_ = 1;
               if(Utility.justPressedAnyKey() || FlxG.mouse.justPressed())
               {
                  this.setMode(MODE_END);
               }
            }
            this._finalText.alpha = _loc1_;
         }
      }
      
      public function updateEndingEnd() : void
      {
         if(!this._modeInitialized)
         {
            PauseLayer.hideMe = false;
            this._modeInitialized = true;
            this.endingFadeTimeout = ENDING_FADE_TIMEOUT;
            FlxG.fade.start(4278190080,ENDING_FADE_TIMEOUT);
            FlxG.music.fadeOut(ENDING_FADE_TIMEOUT);
         }
         this.endingFadeTimeout -= FlxG.elapsed;
         if(this.endingFadeTimeout < 0)
         {
            FlxG.noPause = false;
            PlayState.endEnding();
         }
      }
      
      override public function update() : void
      {
         this.elapsed += FlxG.elapsed;
         this._modeElapsed += FlxG.elapsed;
         switch(this._mode)
         {
            case MODE_NONE:
               this.setMode(MODE_WAIT_START);
               break;
            case MODE_WAIT_START:
               this.updateEndingWaitStart();
               break;
            case MODE_DIALOGUE:
               this.updateEndingDialogue();
               break;
            case MODE_WAIT_CREDITS:
               this.updateEndingWaitCredits();
               break;
            case MODE_CREDITS:
               this.updateEndingCredits();
               break;
            case MODE_WAIT_PICTURE:
               this.updateEndingWaitPicture();
               break;
            case MODE_PICTURE:
               this.updateEndingPicture();
               break;
            case MODE_END:
               this.updateEndingEnd();
         }
         super.update();
      }
   }
}

