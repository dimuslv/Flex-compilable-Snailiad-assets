package
{
   import flash.utils.*;
   import org.flixel.*;
   
   public class MainMenu extends FlxGroup
   {
      public static const TESTING_ALL_MODES_AVAILABLE:Boolean = false;
      
      public static var clickedToPlay:Boolean = false;
      
      public static const MINIGAME_IDLE_TRIGGER_SECONDS:Number = 30;
      
      public static const FAST_ENDING_CUTOFF:int = 60 * 30;
      
      private static const colors:Array = [16777215];
      
      private static const KEY_JUMP:int = 0;
      
      private static const KEY_SHOOT:int = 1;
      
      private static const KEY_STRAFE:int = 2;
      
      private static const KEY_UP:int = 3;
      
      private static const KEY_LEFT:int = 4;
      
      private static const KEY_DOWN:int = 5;
      
      private static const KEY_RIGHT:int = 6;
      
      private static const KEY_ALT_JUMP:int = 7;
      
      private static const KEY_ALT_SHOOT:int = 8;
      
      private static const KEY_ALT_STRAFE:int = 9;
      
      private static const KEY_ALT_UP:int = 10;
      
      private static const KEY_ALT_LEFT:int = 11;
      
      private static const KEY_ALT_DOWN:int = 12;
      
      private static const KEY_ALT_RIGHT:int = 13;
      
      private static const KEY_WEAP_1:int = 14;
      
      private static const KEY_WEAP_2:int = 15;
      
      private static const KEY_WEAP_3:int = 16;
      
      private static const KEY_WEAP_NEXT:int = 17;
      
      private static const KEY_WEAP_PREV:int = 18;
      
      private static const KEY_MAP:int = 19;
      
      public var scrollingMenu:Boolean = false;
      
      public var isWaitingForControls:Boolean = false;
      
      public var menuScrollY:Number = 0;
      
      public var justScrolled:Boolean = false;
      
      public var enterKeyLayer:EnterKeyLayer;
      
      public var keyToSet:int = 0;
      
      public var sponsorMoreGames:SponsorMoreGames;
      
      public var jayIsGames:JayIsGames;
      
      public var miniGame_right:Boolean = true;
      
      public var miniGame:Boolean = false;
      
      public var miniGame_targetNum:int = 0;
      
      public var miniGame_targetX:int = 0;
      
      public var miniGame_targetY:int = 0;
      
      public var miniGame_skill:int = 0;
      
      public var miniGame_missed:Boolean = false;
      
      public var miniGame_ball:MenuBall;
      
      public var MINIGAME_BALL_START_DISTANCE:int = 30;
      
      public var lastWasMouse:Boolean = false;
      
      public var targetAlpha:Number = 1;
      
      public var justinSnaily:Boolean = false;
      
      public var justinSnailyLetters:int = -1;
      
      public var justinSnailyElapsed:Number = 0;
      
      public var bgColor:uint;
      
      public var endingShow:Boolean = false;
      
      public var endingGroup:EndingGroup;
      
      public var bestNormalTime:Number = 0;
      
      public var bestHardTime:Number = 0;
      
      public var bestInsaneTime:Number = 0;
      
      public var bestBossRushTime:Number = 0;
      
      public var hasScores:Boolean = false;
      
      public var hasEnding:Array;
      
      public var isMenuMain:Boolean = false;
      
      public var textGroup:FlxGroup;
      
      public var optionText:Array;
      
      public var optionTextY:Array;
      
      public var optionTextWidth:Array;
      
      public var escToMain:Boolean = false;
      
      public var escToOptions:Boolean = false;
      
      public var actions:Array;
      
      public var doFade:Array;
      
      public var optionNum:int = 0;
      
      public var curOption:int = 0;
      
      public var menuOfsY:int = 0;
      
      public var cursorL:MainMenuCursor;
      
      public var cursorR:MainMenuCursor;
      
      public var bg:FlxSprite;
      
      public var red:FlxSprite;
      
      public var titleText:TitleText;
      
      public var hasSave:Boolean = false;
      
      public var erasedSave:Boolean = false;
      
      public var hasBossRush:Boolean = false;
      
      public var hasHardMode:Boolean = false;
      
      public var hasInsaneMode:Boolean = false;
      
      public var starLayer:StarLayer;
      
      public var elapsed:Number = 0;
      
      public var loadGameOption:int = -1;
      
      public var returnToGameOption:int = -1;
      
      public var musicVolOption:int = -1;
      
      public var soundVolOption:int = -1;
      
      public var endingOption:int = -1;
      
      public var timeSinceLastMove:Number = 0;
      
      public var clickToPlayText:FlxText;
      
      public var fading:Boolean = false;
      
      public var colorNum:Number = 0;
      
      public var colorFps:Number = 5;
      
      public var oldMenuOption:int = 0;
      
      public var oldOptionsMenuOption:int = 0;
      
      public var fadeInterval:uint = 0;
      
      public function MainMenu() : void
      {
         this.hasEnding = [false,false,false,false,false,false];
         super();
         this.timeSinceLastMove = 0;
         this.miniGame = false;
         this.checkSaveVars();
         this.setupBackground();
         this.sponsorMoreGames = new SponsorMoreGames();
         add(this.sponsorMoreGames);
         this.jayIsGames = new JayIsGames();
         add(this.jayIsGames);
         this.setupCursors();
         if(clickedToPlay)
         {
            this.makeMainOptions();
         }
         else
         {
            this.makeClickToPlay();
         }
         if(this.loadGameOption >= 0)
         {
            this.setOption(this.loadGameOption,true);
         }
         if(this.returnToGameOption >= 0)
         {
            this.setOption(this.returnToGameOption,true);
         }
         this.loadGameOption = -1;
         this.returnToGameOption = -1;
         this.musicVolOption = -1;
         this.soundVolOption = -1;
         this.endingOption = -1;
         this.escToOptions = false;
         this.escToMain = false;
         this.makeEnterKeyGraphic();
      }
      
      override public function destroy() : void
      {
         clickToPlayText = null;
         titleText = null;
         starLayer = null;
         bg = null;
         red = null;
         textGroup = null;
         cursorL = null;
         cursorR = null;
         miniGame_ball = null;
         enterKeyLayer = null;
         optionTextY = null;
         optionText = null;
         optionTextWidth = null;
         sponsorMoreGames = null;
         jayIsGames = null;
         super.destroy();
      }
      
      public function checkSaveVars() : void
      {
         var _loc1_:SaveData = null;
         _loc1_ = new SaveData();
         _loc1_.loadAll();
         bgColor = 4278194224;
         if(_loc1_.xml.vars && _loc1_.isVarSet("gameTime"))
         {
            hasSave = true;
         }
         if(_loc1_.xml.vars && _loc1_.xml.vars.bestMainTime > 0)
         {
            hasScores = true;
            bestNormalTime = _loc1_.xml.vars.bestMainTime;
         }
         if(_loc1_.xml.vars && _loc1_.xml.vars.bestHardTime > 0)
         {
            bestHardTime = _loc1_.xml.vars.bestHardTime;
         }
         if(_loc1_.xml.vars && _loc1_.xml.vars.bestInsaneTime > 0)
         {
            bestInsaneTime = _loc1_.xml.vars.bestInsaneTime;
         }
         if(_loc1_.xml.vars && _loc1_.xml.vars.bestBossRushTime > 0)
         {
            bestBossRushTime = _loc1_.xml.vars.bestBossRushTime;
         }
         if(_loc1_.xml.vars && _loc1_.isVarTrue("hasWonGame"))
         {
            hasBossRush = true;
            this.hasEnding[0] = true;
            bgColor = 4278202384;
         }
         if(_loc1_.xml.vars && _loc1_.isVarTrue("toggleFire"))
         {
            Player.firingMode = Player.FIRING_MODE_TOGGLE;
         }
         if(_loc1_.xml.vars && _loc1_.isVarTrue("hasWonBossRush"))
         {
            hasHardMode = true;
            if(_loc1_.xml.vars.bestBossRushTime > 0)
            {
               this.hasEnding[1] = true;
            }
            bgColor = 4281335856;
         }
         if(_loc1_.xml.vars && _loc1_.isVarTrue("hasWonHardMode"))
         {
            hasInsaneMode = false;
            this.hasEnding[2] = true;
            bgColor = 4278202416;
         }
         if(this.bestNormalTime > 0 && this.bestNormalTime < FAST_ENDING_CUTOFF || this.bestHardTime > 0 && this.bestHardTime < FAST_ENDING_CUTOFF || this.bestInsaneTime > 0 && this.bestInsaneTime < FAST_ENDING_CUTOFF)
         {
            this.hasEnding[3] = true;
         }
         if(_loc1_.xml.vars && _loc1_.isVarTrue("hasWonInsaneMode"))
         {
            bgColor = 4278202416;
         }
         if(this.bestInsaneTime > 0)
         {
            this.hasEnding[4] = true;
         }
      }
      
      public function makeEnterKeyGraphic() : void
      {
         enterKeyLayer = new EnterKeyLayer();
         add(this.enterKeyLayer);
      }
      
      public function putEnterKeyGraphicOnTop() : void
      {
         remove(this.enterKeyLayer);
         add(this.enterKeyLayer);
      }
      
      public function makeClickToPlay() : void
      {
         var _loc1_:FlxText = null;
         FlxG.mouse.show();
         _loc1_ = new FlxText(0,FlxG.height / 2,FlxG.width,"CLICK TO PLAY!");
         _loc1_.font = Fonts.normal;
         _loc1_.size = 20;
         _loc1_.color = 16777215;
         _loc1_.shadow = 1;
         _loc1_.alignment = "center";
         _loc1_.scrollFactor.x = _loc1_.scrollFactor.y = 0;
         add(_loc1_);
         clickToPlayText = _loc1_;
      }
      
      public function clearMenu() : void
      {
         menuScrollY = 0;
         isMenuMain = false;
         escToMain = false;
         escToOptions = false;
         if(this.textGroup)
         {
            this.textGroup.kill();
         }
         textGroup = new FlxGroup();
         add(this.textGroup);
         this.putEnterKeyGraphicOnTop();
         optionText = new Array();
         optionTextY = new Array();
         optionTextWidth = new Array();
         actions = new Array();
         doFade = new Array();
         optionNum = 0;
      }
      
      public function addOption(param1:String, param2:Function, param3:Boolean = false, param4:int = 0) : int
      {
         var _loc5_:FlxText = new FlxText(0,20 * this.optionNum,FlxG.width);
         _loc5_.font = Fonts.normal;
         _loc5_.size = 20;
         _loc5_.color = 16777215;
         _loc5_.shadow = 1;
         _loc5_.alignment = "center";
         _loc5_.text = param1;
         _loc5_.scrollFactor.x = _loc5_.scrollFactor.y = 0;
         this.textGroup.add(_loc5_);
         if(param1 == "LOAD GAME")
         {
            loadGameOption = this.optionNum;
         }
         if(param1 == "RETURN TO GAME")
         {
            returnToGameOption = this.optionNum;
         }
         this.optionTextWidth[this.optionNum] = _loc5_.realWidth;
         this.optionText[this.optionNum] = _loc5_;
         this.optionText[this.optionNum].x = param4;
         this.actions[this.optionNum] = param2;
         this.doFade[this.optionNum] = param3;
         return this.optionNum++;
      }
      
      public function changeOption(param1:int, param2:String, param3:Function, param4:int = 0) : void
      {
         this.optionText[param1].text = param2;
         this.actions[param1] = param3;
         this.optionText[param1].x = param4;
         this.optionTextWidth[param1] = this.optionText[param1].realWidth;
         this.setOption(this.curOption);
      }
      
      public function setOption(param1:int, param2:Boolean = false) : void
      {
         timeSinceLastMove = 0;
         if(!param2)
         {
            this.optionText[this.curOption].color = 16777215;
         }
         curOption = param1;
         while(this.curOption < 0)
         {
            curOption += this.optionNum;
         }
         while(this.curOption >= this.optionNum)
         {
            curOption -= this.optionNum;
         }
         while(this.actions[this.curOption] == null)
         {
            curOption = (this.curOption + 1) % this.optionNum;
         }
         curOption = param1;
         this.cursorL.moveTo(FlxG.width / 2 - this.optionTextWidth[this.curOption] / 2 - this.cursorL.width - 4 + this.optionText[this.curOption].x,this.optionText[this.curOption].y,param2);
         this.cursorR.moveTo(FlxG.width / 2 + this.optionTextWidth[this.curOption] / 2 + 4 + this.optionText[this.curOption].x,this.optionText[this.curOption].y,param2);
      }
      
      public function moveOption(param1:int) : void
      {
         curOption += param1;
         while(this.curOption < 0)
         {
            curOption += this.optionNum;
         }
         while(this.curOption >= this.optionNum)
         {
            curOption -= this.optionNum;
         }
         if(param1 > 0)
         {
            while(this.curOption < this.optionNum && this.actions[this.curOption] == null)
            {
               ++this.curOption;
               if(this.curOption >= this.optionNum)
               {
                  curOption -= this.optionNum;
               }
            }
         }
         if(param1 < 0)
         {
            while(this.curOption >= 0 && this.actions[this.curOption] == null)
            {
               --this.curOption;
               if(this.curOption < 0)
               {
                  curOption += this.optionNum;
               }
            }
         }
         this.setOption(this.curOption);
      }
      
      public function setupBackground() : void
      {
         if(PlayState.startedGame)
         {
            bg = new FlxSprite();
            this.bg.y = 0;
            this.bg.x = 0;
            this.bg.createGraphic(FlxG.width,FlxG.height,4278190080);
            this.bg.scrollFactor.x = this.bg.scrollFactor.y = 0;
            targetAlpha = 0.65;
            add(this.bg);
            this.bg.alpha = 0.0;
            elapsed = 0;
            menuOfsY = 0;
            titleText = new TitleText();
            add(this.titleText);
            menuOfsY = 27;
         }
         else
         {
            FlxG.flash.start(4278190080,0.34);
            bg = new FlxSprite();
            this.bg.y = 0;
            this.bg.x = 0;
            targetAlpha = 1;
            this.bg.createGraphic(FlxG.width,FlxG.height,this.bgColor);
            this.bg.scrollFactor.x = this.bg.scrollFactor.y = 0;
            add(this.bg);
            starLayer = new StarLayer();
            this.starLayer.makeStars();
            add(this.starLayer);
            this.bg.alpha = 1;
            elapsed = 9;
            menuOfsY = 0;
            titleText = new TitleText(true);
            add(this.titleText);
            menuOfsY = 27;
            Music.playTitle();
            if(!clickedToPlay)
            {
               this.titleText.setYOffset(60,true);
            }
         }
      }
      
      public function eraseFade() : void
      {
         fading = true;
         FlxG.fade.start(4289658880,0.34,this.eraseFade2);
      }
      
      public function eraseFade2() : void
      {
         FlxG.fade.stop();
         red = new FlxSprite();
         this.red.y = 0;
         this.red.x = 0;
         this.red.createGraphic(FlxG.width,FlxG.height,4289658880);
         this.red.scrollFactor.x = this.red.scrollFactor.y = 0;
         add(this.red);
         fadeInterval = setInterval(this.eraseFade3,1000);
      }
      
      public function eraseFade3() : void
      {
         this.red.visible = false;
         FlxG.flash.start(4289658880,0.34);
         clearInterval(this.fadeInterval);
         this.eraseSaveData();
      }
      
      public function resetMenu() : void
      {
         var _loc1_:SaveData = null;
         FlxG.flash.stop();
         FlxG.fade.stop();
         fading = false;
         bgColor = 4278194224;
         oldMenuOption = 0;
         PlayState.startedGame = false;
         PlayState.bossRush = false;
         if(this.bg)
         {
            remove(this.bg).destroy();
            bg = null;
         }
         if(this.starLayer)
         {
            remove(this.starLayer).destroy();
            starLayer = null;
         }
         if(this.red)
         {
            remove(this.red).destroy();
            red = null;
         }
         if(this.titleText)
         {
            remove(this.titleText).destroy();
            titleText = null;
         }
         if(this.cursorL)
         {
            remove(this.cursorL).destroy();
            cursorL = null;
         }
         if(this.cursorR)
         {
            remove(this.cursorR).destroy();
            cursorR = null;
         }
         this.checkSaveVars();
         this.setupBackground();
         this.sponsorMoreGames.kill();
         remove(this.sponsorMoreGames);
         sponsorMoreGames = new SponsorMoreGames();
         add(this.sponsorMoreGames);
         this.jayIsGames.kill();
         remove(this.jayIsGames);
         jayIsGames = new JayIsGames();
         add(this.jayIsGames);
         this.setupCursors();
         this.makeMainOptions();
      }
      
      public function eraseSaveData() : void
      {
         var _loc1_:SaveData = null;
         FlxG.flash.stop();
         FlxG.fade.stop();
         fading = false;
         _loc1_ = new SaveData();
         _loc1_.eraseAll();
         hasSave = false;
         hasBossRush = false;
         hasHardMode = false;
         hasInsaneMode = false;
         erasedSave = true;
         this.resetMenu();
      }
      
      public function centerMenu() : void
      {
         var _loc1_:int = FlxG.height / 2 - (20 * this.optionNum - 5) / 2 + this.menuOfsY;
         if(_loc1_ < this.menuOfsY)
         {
            _loc1_ = this.menuOfsY;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.optionNum)
         {
            this.optionTextY[_loc2_] = _loc1_ + 20 * _loc2_;
            this.optionText[_loc2_].y = this.optionTextY[_loc2_];
            _loc2_++;
         }
         this.setOption(this.curOption,true);
      }
      
      public function updateMenuScroll() : void
      {
         var _loc1_:int = this.optionNum - 9;
         if(_loc1_ <= 0 || this.optionNum < 8)
         {
            justScrolled = false;
            if(this.titleText)
            {
               this.titleText.visible = true;
            }
            return;
         }
         if(this.miniGame)
         {
            miniGame = false;
            this.miniGame_destroyBall();
         }
         if(this.titleText)
         {
            this.titleText.visible = false;
         }
         var _loc2_:int = this.optionTextY[_loc1_] - this.optionTextY[0];
         var _loc3_:Number = this.curOption / this.optionNum;
         if(this.lastWasMouse)
         {
            _loc3_ = FlxG.mouse.screenY / FlxG.height;
         }
         var _loc4_:Number = 0.4;
         _loc3_ = _loc3_ * (1 + _loc4_ * 2) - _loc4_;
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         if(_loc3_ < 0.0)
         {
            _loc3_ = 0.0;
         }
         var _loc5_:int = _loc2_ * _loc3_;
         var _loc6_:int = this.menuScrollY;
         menuScrollY = Utility.integrate(this.menuScrollY,_loc5_,3,FlxG.elapsed);
         if(this.menuScrollY < 0)
         {
            menuScrollY = 0;
         }
         justScrolled = _loc6_ != this.menuScrollY;
         var _loc7_:int = 0;
         while(_loc7_ < this.optionNum)
         {
            this.optionText[_loc7_].y = this.optionTextY[_loc7_] - this.menuScrollY;
            _loc7_++;
         }
         this.setOption(this.curOption,true);
      }
      
      public function setupCursors() : void
      {
         cursorL = new MainMenuCursor();
         cursorR = new MainMenuCursor();
         this.cursorR.facing = left;
         add(this.cursorL);
         add(this.cursorR);
      }
      
      public function doNothing() : void
      {
      }
      
      public function confirmEraseSave() : void
      {
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.clearMenu();
         escToMain = true;
         oldOptionsMenuOption = this.curOption;
         this.addOption("ARE YOU SURE??",null,false);
         this.addOption("",null,false);
         this.addOption("YES, ERASE EVERYTHING!",this.eraseFade,false);
         this.addOption("NO WAY, I LIKE MY GAME!",this.makeOptionsMenu,false);
         curOption = 2;
         this.centerMenu();
      }
      
      public function addKeyOption(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:FlxText = new FlxText(0,0,FlxG.width);
         _loc4_.font = Fonts.normal;
         _loc4_.size = 20;
         _loc4_.color = 16777215;
         _loc4_.shadow = 1;
         _loc4_.text = param2;
         var _loc5_:int = _loc4_.realWidth;
         _loc4_ = null;
         this.addOption(param1 + param2,param3,false,_loc5_ / 2 - 20);
      }
      
      public function changeKeyOption(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:FlxText = new FlxText(0,0,FlxG.width);
         _loc4_.font = Fonts.normal;
         _loc4_.size = 20;
         _loc4_.color = 16777215;
         _loc4_.shadow = 1;
         _loc4_.text = param2;
         var _loc5_:int = _loc4_.realWidth;
         _loc4_ = null;
         this.changeOption(this.curOption,param1 + param2,param3,_loc5_ / 2 - 20);
      }
      
      public function reallySetKey(param1:int, param2:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:SaveData = null;
         var _loc5_:XMLList = null;
         switch(param1)
         {
            case KEY_MAP:
               _loc3_ = "mapKey";
               Player.MAP_KEY = param2;
               break;
            case KEY_JUMP:
               _loc3_ = "jumpKey";
               Player.JUMP_KEY = param2;
               break;
            case KEY_SHOOT:
               _loc3_ = "shootKey";
               Player.SHOOT_KEY = param2;
               break;
            case KEY_STRAFE:
               _loc3_ = "strafeKey";
               Player.STRAFE_KEY = param2;
               break;
            case KEY_UP:
               _loc3_ = "upKey";
               Player.UP_KEY = param2;
               break;
            case KEY_LEFT:
               _loc3_ = "leftKey";
               Player.LEFT_KEY = param2;
               break;
            case KEY_DOWN:
               _loc3_ = "downKey";
               Player.DOWN_KEY = param2;
               break;
            case KEY_RIGHT:
               _loc3_ = "rightKey";
               Player.RIGHT_KEY = param2;
               break;
            case KEY_ALT_JUMP:
               _loc3_ = "jumpAltKey";
               Player.ALT_JUMP_KEY = param2;
               break;
            case KEY_ALT_SHOOT:
               _loc3_ = "shootAltKey";
               Player.ALT_SHOOT_KEY = param2;
               break;
            case KEY_ALT_STRAFE:
               _loc3_ = "strafeAltKey";
               Player.ALT_STRAFE_KEY = param2;
               break;
            case KEY_ALT_UP:
               _loc3_ = "upAltKey";
               Player.ALT_UP_KEY = param2;
               break;
            case KEY_ALT_LEFT:
               _loc3_ = "leftAltKey";
               Player.ALT_LEFT_KEY = param2;
               break;
            case KEY_ALT_DOWN:
               _loc3_ = "downAltKey";
               Player.ALT_DOWN_KEY = param2;
               break;
            case KEY_ALT_RIGHT:
               _loc3_ = "rightAltKey";
               Player.ALT_RIGHT_KEY = param2;
               break;
            case KEY_WEAP_1:
               _loc3_ = "weap1Key";
               Player.WEAPON_1_KEY = param2;
               break;
            case KEY_WEAP_2:
               _loc3_ = "weap2Key";
               Player.WEAPON_2_KEY = param2;
               break;
            case KEY_WEAP_3:
               _loc3_ = "weap3Key";
               Player.WEAPON_3_KEY = param2;
               break;
            case KEY_WEAP_NEXT:
               _loc3_ = "weapNextKey";
               Player.WEAPON_NEXT_KEY = param2;
               break;
            case KEY_WEAP_PREV:
               _loc3_ = "weapPrevKey";
               Player.WEAPON_PREV_KEY = param2;
			   break;
         }
         if(_loc3_)
         {
            _loc4_ = new SaveData();
            _loc4_.loadAll();
            if(_loc4_.isVarSet(_loc3_))
            {
               _loc5_ = _loc4_.xml.vars.child(_loc3_);
               if(_loc5_)
               {
                  delete _loc5_.parent().*[_loc5_.childIndex()];
               }
            }
            _loc4_.xml.vars.appendChild(<{_loc3_}>{param2}</{_loc3_}>);
            _loc4_.saveAll();
         }
         switch(param1)
         {
            case KEY_MAP:
               this.changeKeyOption("OPEN MINIMAP && ",Player.MAP_KEY,this.setKeyMap);
               break;
            case KEY_JUMP:
               this.changeKeyOption("JUMP         ",Player.JUMP_KEY,this.setKeyJump);
               break;
            case KEY_SHOOT:
               this.changeKeyOption("SHOOT        ",Player.SHOOT_KEY,this.setKeyShoot);
               break;
            case KEY_STRAFE:
               this.changeKeyOption("STRAFE       ",Player.STRAFE_KEY,this.setKeyStrafe);
               break;
            case KEY_UP:
               this.changeKeyOption("MOVE UP      ",Player.UP_KEY,this.setKeyUp);
               break;
            case KEY_LEFT:
               this.changeKeyOption("MOVE LEFT    ",Player.LEFT_KEY,this.setKeyLeft);
               break;
            case KEY_DOWN:
               this.changeKeyOption("MOVE DOWN    ",Player.DOWN_KEY,this.setKeyDown);
               break;
            case KEY_RIGHT:
               this.changeKeyOption("MOVE RIGHT  &&&& ",Player.RIGHT_KEY,this.setKeyRight);
               break;
            case KEY_ALT_JUMP:
               this.changeKeyOption("JUMP         ",Player.ALT_JUMP_KEY,this.setAltKeyJump);
               break;
            case KEY_ALT_SHOOT:
               this.changeKeyOption("SHOOT        ",Player.ALT_SHOOT_KEY,this.setAltKeyShoot);
               break;
            case KEY_ALT_STRAFE:
               this.changeKeyOption("STRAFE       ",Player.ALT_STRAFE_KEY,this.setAltKeyStrafe);
               break;
            case KEY_ALT_UP:
               this.changeKeyOption("MOVE UP      ",Player.ALT_UP_KEY,this.setAltKeyUp);
               break;
            case KEY_ALT_LEFT:
               this.changeKeyOption("MOVE LEFT    ",Player.ALT_LEFT_KEY,this.setAltKeyLeft);
               break;
            case KEY_ALT_DOWN:
               this.changeKeyOption("MOVE DOWN    ",Player.ALT_DOWN_KEY,this.setAltKeyDown);
               break;
            case KEY_ALT_RIGHT:
               this.changeKeyOption("MOVE RIGHT  &&&& ",Player.ALT_RIGHT_KEY,this.setAltKeyRight);
               break;
            case KEY_WEAP_1:
               this.changeKeyOption("WEAPON ONE   ",Player.WEAPON_1_KEY,this.setKeyWeap1);
               break;
            case KEY_WEAP_2:
               this.changeKeyOption("WEAPON TWO   ",Player.WEAPON_2_KEY,this.setKeyWeap2);
               break;
            case KEY_WEAP_3:
               this.changeKeyOption("WEAPON THREE ",Player.WEAPON_3_KEY,this.setKeyWeap3);
               break;
            case KEY_WEAP_NEXT:
               this.changeKeyOption("NEXT WEAPON  ",Player.WEAPON_NEXT_KEY,this.setKeyWeapNext);
               break;
            case KEY_WEAP_PREV:
               this.changeKeyOption("PREV WEAPON  ",Player.WEAPON_PREV_KEY,this.setKeyWeapPrev);
			   break;
         }
         if(PlayState.controlHelp)
         {
            PlayState.controlHelp.updateLetterGraphics();
         }
         isWaitingForControls = false;
      }
      
      public function setKey(param1:int) : void
      {
         keyToSet = param1;
         isWaitingForControls = true;
      }
      
      public function setKeyMap() : void
      {
         this.setKey(KEY_MAP);
      }
      
      public function setKeyJump() : void
      {
         this.setKey(KEY_JUMP);
      }
      
      public function setKeyShoot() : void
      {
         this.setKey(KEY_SHOOT);
      }
      
      public function setKeyStrafe() : void
      {
         this.setKey(KEY_STRAFE);
      }
      
      public function setKeyUp() : void
      {
         this.setKey(KEY_UP);
      }
      
      public function setKeyLeft() : void
      {
         this.setKey(KEY_LEFT);
      }
      
      public function setKeyDown() : void
      {
         this.setKey(KEY_DOWN);
      }
      
      public function setKeyRight() : void
      {
         this.setKey(KEY_RIGHT);
      }
      
      public function setAltKeyJump() : void
      {
         this.setKey(KEY_ALT_JUMP);
      }
      
      public function setAltKeyShoot() : void
      {
         this.setKey(KEY_ALT_SHOOT);
      }
      
      public function setAltKeyStrafe() : void
      {
         this.setKey(KEY_ALT_STRAFE);
      }
      
      public function setAltKeyUp() : void
      {
         this.setKey(KEY_ALT_UP);
      }
      
      public function setAltKeyLeft() : void
      {
         this.setKey(KEY_ALT_LEFT);
      }
      
      public function setAltKeyDown() : void
      {
         this.setKey(KEY_ALT_DOWN);
      }
      
      public function setAltKeyRight() : void
      {
         this.setKey(KEY_ALT_RIGHT);
      }
      
      public function setKeyWeap1() : void
      {
         this.setKey(KEY_WEAP_1);
      }
      
      public function setKeyWeap2() : void
      {
         this.setKey(KEY_WEAP_2);
      }
      
      public function setKeyWeap3() : void
      {
         this.setKey(KEY_WEAP_3);
      }
      
      public function setKeyWeapNext() : void
      {
         this.setKey(KEY_WEAP_NEXT);
      }
      
      public function setKeyWeapPrev() : void
      {
         this.setKey(KEY_WEAP_PREV);
      }
      
      public function resetControls() : void
      {
         this.reallySetKey(KEY_MAP,Player.DEFAULT_MAP_KEY);
         this.reallySetKey(KEY_JUMP,Player.DEFAULT_JUMP_KEY);
         this.reallySetKey(KEY_SHOOT,Player.DEFAULT_SHOOT_KEY);
         this.reallySetKey(KEY_STRAFE,Player.DEFAULT_STRAFE_KEY);
         this.reallySetKey(KEY_UP,Player.DEFAULT_UP_KEY);
         this.reallySetKey(KEY_LEFT,Player.DEFAULT_LEFT_KEY);
         this.reallySetKey(KEY_DOWN,Player.DEFAULT_DOWN_KEY);
         this.reallySetKey(KEY_RIGHT,Player.DEFAULT_RIGHT_KEY);
         this.reallySetKey(KEY_ALT_JUMP,Player.DEFAULT_ALT_JUMP_KEY);
         this.reallySetKey(KEY_ALT_SHOOT,Player.DEFAULT_ALT_SHOOT_KEY);
         this.reallySetKey(KEY_ALT_STRAFE,Player.DEFAULT_ALT_STRAFE_KEY);
         this.reallySetKey(KEY_ALT_UP,Player.DEFAULT_ALT_UP_KEY);
         this.reallySetKey(KEY_ALT_LEFT,Player.DEFAULT_ALT_LEFT_KEY);
         this.reallySetKey(KEY_ALT_DOWN,Player.DEFAULT_ALT_DOWN_KEY);
         this.reallySetKey(KEY_ALT_RIGHT,Player.DEFAULT_ALT_RIGHT_KEY);
         this.reallySetKey(KEY_WEAP_1,Player.DEFAULT_WEAPON_1_KEY);
         this.reallySetKey(KEY_WEAP_2,Player.DEFAULT_WEAPON_2_KEY);
         this.reallySetKey(KEY_WEAP_3,Player.DEFAULT_WEAPON_3_KEY);
         this.reallySetKey(KEY_WEAP_NEXT,Player.DEFAULT_WEAPON_NEXT_KEY);
         this.reallySetKey(KEY_WEAP_PREV,Player.DEFAULT_WEAPON_PREV_KEY);
         curOption = this.oldOptionsMenuOption;
         this.controlMenu();
      }
      
      public function controlMenu() : void
      {
         this.clearMenu();
         oldOptionsMenuOption = this.curOption;
         escToOptions = true;
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         scrollingMenu = true;
         isWaitingForControls = false;
         var _loc1_:Number = 340;
         this.addOption("CUSTOM CONTROLS (SET 1)",null,false);
         this.addOption("",null,false);
         this.addKeyOption("JUMP         ",Player.JUMP_KEY,this.setKeyJump);
         this.addKeyOption("SHOOT        ",Player.SHOOT_KEY,this.setKeyShoot);
         this.addKeyOption("STRAFE       ",Player.STRAFE_KEY,this.setKeyStrafe);
         this.addKeyOption("MOVE UP      ",Player.UP_KEY,this.setKeyUp);
         this.addKeyOption("MOVE LEFT    ",Player.LEFT_KEY,this.setKeyLeft);
         this.addKeyOption("MOVE DOWN    ",Player.DOWN_KEY,this.setKeyDown);
         this.addKeyOption("MOVE RIGHT  &&&& ",Player.RIGHT_KEY,this.setKeyRight);
         this.addOption("",null,false);
         this.addOption("CUSTOM CONTROLS (SET 2)",null,false);
         this.addOption("",null,false);
         this.addKeyOption("JUMP         ",Player.ALT_JUMP_KEY,this.setAltKeyJump);
         this.addKeyOption("SHOOT        ",Player.ALT_SHOOT_KEY,this.setAltKeyShoot);
         this.addKeyOption("STRAFE       ",Player.ALT_STRAFE_KEY,this.setAltKeyStrafe);
         this.addKeyOption("MOVE UP      ",Player.ALT_UP_KEY,this.setAltKeyUp);
         this.addKeyOption("MOVE LEFT    ",Player.ALT_LEFT_KEY,this.setAltKeyLeft);
         this.addKeyOption("MOVE DOWN    ",Player.ALT_DOWN_KEY,this.setAltKeyDown);
         this.addKeyOption("MOVE RIGHT  &&&& ",Player.ALT_RIGHT_KEY,this.setAltKeyRight);
         this.addOption("",null,false);
         this.addOption("CUSTOM CONTROLS (OTHER)",null,false);
         this.addOption("",null,false);
         this.addKeyOption("WEAPON ONE   ",Player.WEAPON_1_KEY,this.setKeyWeap1);
         this.addKeyOption("WEAPON TWO   ",Player.WEAPON_2_KEY,this.setKeyWeap2);
         this.addKeyOption("WEAPON THREE ",Player.WEAPON_3_KEY,this.setKeyWeap3);
         this.addKeyOption("NEXT WEAPON  ",Player.WEAPON_NEXT_KEY,this.setKeyWeapNext);
         this.addKeyOption("PREV WEAPON  ",Player.WEAPON_PREV_KEY,this.setKeyWeapPrev);
         this.addOption("",null,false);
         this.addKeyOption("OPEN MINIMAP && ",Player.MAP_KEY,this.setKeyMap);
         this.addOption("",null,false);
         this.addOption("RESET CONTROLS TO DEFAULTS",this.resetControls,false);
         this.addOption("",null,false);
         this.addOption("BACK TO OPTIONS",this.makeOptionsMenu,false);
         curOption = 2;
         this.centerMenu();
      }
      
      public function confirmBossRush() : void
      {
         this.clearMenu();
         escToMain = true;
         oldMenuOption = this.curOption;
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.addOption("ARE YOU SURE?",null,false);
         this.addOption("BOSS RUSH IS REALLY HARD!!",null,false);
         this.addOption("",null,false);
         this.addOption("YES, I\'M READY!!",PlayState.startBossRush,true);
         this.addOption("NO, I\'M AFRAID:(",this.makeMainOptions,false);
         this.addOption("",null,false);
         this.addOption("",null,false);
         curOption = 3;
         this.centerMenu();
      }
      
      public function confirmNewGame() : void
      {
         this.clearMenu();
         escToMain = true;
         oldMenuOption = this.curOption;
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.addOption("REALLY START A NEW GAME?",null,false);
         this.addOption("",null,false);
         this.addOption("YES, I WANT TO START OVER!",this.selectNewGameMode,false);
         this.addOption("NO WAY, I LIKE MY GAME!",this.makeMainOptions,false);
         curOption = 2;
         this.centerMenu();
      }
      
      public function selectNewGameMode() : void
      {
         this.clearMenu();
         escToMain = true;
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.addOption("SELECT A DIFFICULTY:",null,false);
         this.addOption("",null,false);
         this.addOption("EASY",PlayState.startEasyNewGame,false);
         this.addOption("NORMAL",PlayState.startNewGame,false);
         if(TESTING_ALL_MODES_AVAILABLE || this.hasHardMode)
         {
            this.addOption("SLUG",this.justinSnailyAnim,false);
         }
         curOption = 3;
         this.centerMenu();
      }
      
      public function justinSnailyAnim() : void
      {
         justinSnaily = true;
         justinSnailyElapsed = 0;
         miniGame = false;
         this.cursorL.visible = false;
         this.cursorR.visible = false;
         this.clearMenu();
         this.addOption("ENTER PASSWORD:",null,false);
         this.addOption("",null,false);
         this.addOption("------",null,false);
         this.addOption("------",null,false);
         this.addOption("",null,false);
         this.addOption("",PlayState.startHardNewGame,false);
         this.centerMenu();
         curOption = 5;
      }
      
      public function selectNewGameModeSetOldOption() : void
      {
         isMenuMain = false;
         oldMenuOption = this.curOption;
         this.selectNewGameMode();
      }
      
      public function soundOptionsMenu(param1:int = 0, param2:Boolean = false) : void
      {
         this.clearMenu();
         escToOptions = true;
         if(!param2)
         {
            oldOptionsMenuOption = this.curOption;
         }
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         soundVolOption = this.addOption("VOLUME: " + int(FlxG.volume * 10 + 0.0001).toString(),this.doNothing,false);
         musicVolOption = this.addOption("MUSIC: " + (FlxG.musicVolume == 0 ? "OFF" : "ON"),this.toggleMusicVol,false);
         this.addOption("",null,false);
         this.addOption("BACK TO OPTIONS",this.makeOptionsMenu,false);
         curOption = param1;
         this.centerMenu();
      }
      
      public function toggleHideMiniMap() : void
      {
         PlayState.hideMiniMap = !PlayState.hideMiniMap;
         if(PlayState.miniMap)
         {
            PlayState.miniMap.setMapLittle();
         }
         var _loc1_:SaveData = new SaveData();
         _loc1_.loadAll();
         if(_loc1_.isVarSet("hideMiniMap"))
         {
            var _loc2_:XMLList = _loc1_.xml.vars.child("hideMiniMap");
            if(_loc2_)
            {
               delete _loc2_.parent().*[_loc2_.childIndex()];
            }
         }
         _loc1_.xml.vars.appendChild(<hideMiniMap>{PlayState.hideMiniMap}</hideMiniMap>);
         _loc1_.saveAll();
         this.changeOption(this.curOption,"HIDE MINIMAP: " + (PlayState.hideMiniMap ? "HIDE" : "SHOW"),this.toggleHideMiniMap);
      }
      
      public function toggleHideTab() : void
      {
         PlayState.hideTab = !PlayState.hideTab;
         if(PlayState.miniMap && PlayState.miniMap.subscreen)
         {
            PlayState.miniMap.subscreen.hide();
         }
         var _loc1_:SaveData = new SaveData();
         _loc1_.loadAll();
         if(_loc1_.isVarSet("hideTab"))
         {
            var _loc2_:XMLList = _loc1_.xml.vars.child("hideTab");
            if(_loc2_)
            {
               delete _loc2_.parent().*[_loc2_.childIndex()];
            }
         }
         _loc1_.xml.vars.appendChild(<hideTab>{PlayState.hideTab}</hideTab>);
         _loc1_.saveAll();
         this.changeOption(this.curOption,"HIDE BOTTOM KEYS: " + (PlayState.hideTab ? "HIDE" : "SHOW"),this.toggleHideTab);
      }
      
      public function displayOptionsMenu(param1:int = 0, param2:Boolean = false) : void
      {
         this.clearMenu();
         escToOptions = true;
         if(!param2)
         {
            oldOptionsMenuOption = this.curOption;
         }
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.addOption("HIDE MINIMAP: " + (PlayState.hideMiniMap ? "HIDE" : "SHOW"),this.toggleHideMiniMap,false);
         this.addOption("HIDE BOTTOM KEYS: " + (PlayState.hideTab ? "HIDE" : "SHOW"),this.toggleHideTab,false);
         this.addOption("",null,false);
         this.addOption("BACK TO OPTIONS",this.makeOptionsMenu,false);
         curOption = param1;
         this.centerMenu();
      }
      
      public function makeOptionsMenuPreserveOption() : void
      {
         oldMenuOption = this.curOption;
         this.makeOptionsMenu();
      }
      
      public function showCredits() : void
      {
         this.clearMenu();
         escToMain = true;
         oldMenuOption = this.curOption;
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.addOption("SNAILIAD - A SNAILY GAME",null,false);
         this.addOption("BY CRYSTAL JACOBS (AURIPLANE)",null,false);
         this.addOption("",null,false);
         this.addOption("SPONSORED BY NEWGROUNDS",null,false);
         this.addOption("",null,false);
         this.addOption("",null,false);
         this.addOption("NEXT PAGE",this.showCreditsPageTwo,false);
         curOption = 6;
         this.centerMenu();
      }
      
      public function showCreditsPageTwo() : void
      {
         this.clearMenu();
         escToMain = true;
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.addOption("SPECIAL THANKS TO",null,false);
         this.addOption("",null,false);
         this.addOption("ADAMATOMIC (FLIXEL)",null,false);
         this.addOption("NEWSTARSHIPSMELL (TESTING)",null,false);
         this.addOption("XDANOND (ADDITIONAL ART)",null,false);
         this.addOption("",null,false);
         this.addOption("BACK TO MAIN MENU",this.makeMainOptions,false);
         curOption = 6;
         this.centerMenu();
      }
      
      public function showHighScores() : void
      {
         this.clearMenu();
         escToMain = true;
         oldMenuOption = this.curOption;
         this.sponsorMoreGames.show();
         this.jayIsGames.hide();
         this.addOption("YOUR BEST CLEAR TIMES",null,false);
         this.addOption("",null,false);
         if(this.bestNormalTime > 0)
         {
            this.addOption("NORMAL MODE   " + GameTimeDisplay.formatExact(this.bestNormalTime),null,false);
         }
         if(this.bestInsaneTime > 0)
         {
            this.addOption("100% CLEAR    " + GameTimeDisplay.formatExact(this.bestInsaneTime),null,false);
         }
         if(this.bestHardTime > 0)
         {
            this.addOption("SLUG MODE     " + GameTimeDisplay.formatExact(this.bestHardTime),null,false);
         }
         if(this.bestBossRushTime > 0)
         {
            this.addOption("BOSS RUSH     " + GameTimeDisplay.formatExact(this.bestBossRushTime),null,false);
         }
         this.addOption("",null,false);
         this.addOption("BACK TO MAIN MENU",this.makeMainOptions,false);
         curOption = this.optionNum - 1;
         this.centerMenu();
      }
      
      public function showEnding(param1:int) : void
      {
         FlxG.mouse.hide();
         endingOption = this.curOption;
         this.clearMenu();
         endingShow = true;
         this.addOption("",this.showEndingsMenu,false);
         endingGroup = new EndingGroup(param1);
         add(this.endingGroup);
         this.miniGame_destroyBall();
         miniGame = false;
         curOption = 0;
      }
      
      public function showEnding1() : void
      {
         this.showEnding(1);
      }
      
      public function showEnding2() : void
      {
         this.showEnding(2);
      }
      
      public function showEnding3() : void
      {
         this.showEnding(3);
      }
      
      public function showEnding4() : void
      {
         this.showEnding(4);
      }
      
      public function showEnding5() : void
      {
         this.showEnding(5);
      }
      
      public function showEndingsMenu() : void
      {
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         FlxG.mouse.show();
         this.clearMenu();
         escToMain = true;
         if(!this.endingGroup && !this.endingShow)
         {
            oldMenuOption = this.curOption;
         }
         if(this.endingShow)
         {
            endingShow = false;
         }
         if(this.endingGroup)
         {
            remove(this.endingGroup);
            this.endingGroup.destroy();
            endingGroup = null;
         }
         var _loc1_:Array = ["REGULAR CLEAR","BOSS RUSH CLEAR","SLUG MODE CLEAR","CLEAR < 30 MIN","100% CLEAR"];
         if(this.hasEnding[0])
         {
            this.addOption(_loc1_[0],this.showEnding1,false);
         }
         if(this.hasEnding[1])
         {
            this.addOption(_loc1_[1],this.showEnding2,false);
         }
         if(this.hasEnding[4])
         {
            this.addOption(_loc1_[4],this.showEnding3,false);
         }
         if(this.hasEnding[3])
         {
            this.addOption(_loc1_[3],this.showEnding4,false);
         }
         if(this.hasEnding[2])
         {
            this.addOption(_loc1_[2],this.showEnding5,false);
         }
         this.addOption("",null,false);
         this.addOption("BACK TO MAIN MENU",this.makeMainOptions,false);
         if(this.endingOption != -1)
         {
            curOption = this.endingOption;
         }
         else
         {
            curOption = this.optionNum - 1;
         }
         endingOption = -1;
         this.centerMenu();
      }
      
      public function toggleShootingMode() : void
      {
         Player.firingMode ^= 1;
         this.changeOption(this.curOption,"SHOOTING: " + (Player.firingMode == Player.FIRING_MODE_NORMAL ? "NORMAL" : "TOGGLE"),this.toggleShootingMode);
         var _loc1_:String = "toggleFire";
         var _loc2_:SaveData = new SaveData();
         _loc2_.loadAll();
         if(_loc2_.isVarSet(_loc1_))
         {
            var _loc3_:XMLList = _loc2_.xml.vars.child(_loc1_);
            if(_loc3_)
            {
               delete _loc3_.parent().*[_loc3_.childIndex()];
            }
         }
         if(Player.firingMode == Player.FIRING_MODE_TOGGLE)
         {
            _loc2_.xml.vars.appendChild(<{_loc1_}>true</{_loc1_}>);
         }
         _loc2_.saveAll();
      }
      
      public function makeOptionsMenu() : void
      {
         this.clearMenu();
         escToMain = true;
         musicVolOption = -1;
         soundVolOption = -1;
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.addOption("SOUND OPTIONS",this.soundOptionsMenu,false);
         this.addOption("DISPLAY OPTIONS",this.displayOptionsMenu,false);
         this.addOption("SET CONTROLS",this.controlMenu,false);
         this.addOption("SHOOTING: " + (Player.firingMode == Player.FIRING_MODE_NORMAL ? "NORMAL" : "TOGGLE"),this.toggleShootingMode,false);
         this.addOption("",null,false);
         this.addOption("ERASE SAVE DATA",this.confirmEraseSave);
         this.addOption("",null,false);
         this.addOption("BACK TO MAIN MENU",this.makeMainOptions,false);
         this.setOption(this.oldOptionsMenuOption,true);
         this.centerMenu();
      }
      
      public function confirmLoadGame() : void
      {
         this.clearMenu();
         escToMain = true;
         oldMenuOption = this.curOption;
         this.sponsorMoreGames.hide();
         this.jayIsGames.hide();
         this.addOption("OKAY, WHERE WOULD YOU",null,false);
         this.addOption("LIKE TO START FROM?",null,false);
         this.addOption("",null,false);
         this.addOption("START FROM SAVE POINT",PlayState.loadGame,true);
         this.addOption("START FROM SNAIL TOWN",PlayState.loadGameFromTown,true);
         curOption = 3;
         this.centerMenu();
      }
      
      public function makeMainOptions() : void
      {
         curOption = 0;
         this.sponsorMoreGames.show();
         this.jayIsGames.show();
         this.clearMenu();
         isMenuMain = true;
         scrollingMenu = false;
         isWaitingForControls = false;
         if(PlayState.startedGame && !this.erasedSave)
         {
            if(PlayState.bossRush)
            {
               this.addOption("EXIT BOSS RUSH",this.resetMenu,true);
            }
            this.addOption("RETURN TO GAME",PlayState.returnToGame,false);
            if(!PlayState.bossRush)
            {
               this.addOption("NEW GAME",this.confirmNewGame,false);
            }
            if(this.hasSave)
            {
               this.addOption("LOAD GAME",this.confirmLoadGame,false);
            }
         }
         else if(this.hasSave)
         {
            if(!PlayState.bossRush)
            {
               this.addOption("NEW GAME",this.confirmNewGame,false);
            }
            this.addOption("LOAD GAME",this.confirmLoadGame,false);
         }
         else if(!PlayState.bossRush)
         {
            this.addOption("NEW GAME",this.selectNewGameModeSetOldOption,false);
         }
         if(TESTING_ALL_MODES_AVAILABLE || this.hasBossRush)
         {
            if(PlayState.bossRush)
            {
               this.addOption("RESTART BOSS RUSH",PlayState.startBossRush,true);
            }
            else
            {
               this.addOption("BOSS RUSH",this.confirmBossRush,false);
            }
         }
         this.addOption("",null);
         this.addOption("OPTIONS",this.makeOptionsMenuPreserveOption,false);
         this.addOption("CREDITS",this.showCredits,false);
         if(this.hasScores && !this.erasedSave)
         {
            this.addOption("RECORDS",this.showHighScores,false);
         }
         if((this.hasEnding[0] || this.hasEnding[1] || this.hasEnding[2] || this.hasEnding[3] || this.hasEnding[4]) && !this.erasedSave)
         {
            this.addOption("GALLERY",this.showEndingsMenu,false);
         }
         curOption = this.oldMenuOption;
         this.centerMenu();
         musicVolOption = -1;
         soundVolOption = -1;
      }
      
      public function toggleMusicVol() : void
      {
         if(FlxG.musicVolume == 0)
         {
            FlxG.musicVolume = 1;
         }
         else
         {
            FlxG.musicVolume = 0;
         }
         this.soundOptionsMenu(this.curOption,true);
      }
      
      public function setVol(param1:Number) : void
      {
         FlxG.volume += param1 * 0.1;
         this.soundOptionsMenu(this.curOption,true);
      }
      
      public function miniGame_pickRandomTarget() : void
      {
         var _loc1_:int = 30;
         do
         {
            miniGame_targetNum = int(FlxU.random() * this.optionNum);
            if(--_loc1_ < 0)
            {
               miniGame_targetNum = this.curOption;
               break;
            }
         }
         while(this.actions[this.miniGame_targetNum] == null || this.miniGame_targetNum == this.curOption);
         
         if(this.miniGame_right)
         {
            miniGame_targetX = FlxG.width / 2 + this.optionTextWidth[this.miniGame_targetNum] / 2 + this.cursorR.width;
         }
         else
         {
            miniGame_targetX = FlxG.width / 2 - this.optionTextWidth[this.miniGame_targetNum] / 2 - this.cursorL.width;
         }
         miniGame_targetY = this.optionText[this.miniGame_targetNum].y + this.optionText[this.miniGame_targetNum].height / 2 - 1;
      }
      
      public function miniGame_destroyBall() : void
      {
         if(this.miniGame_ball)
         {
            remove(this.miniGame_ball);
            this.miniGame_ball.destroy();
            miniGame_ball = null;
         }
      }
      
      public function miniGame_makeNewBall() : void
      {
         this.miniGame_destroyBall();
         miniGame_ball = new MenuBall();
         this.miniGame_ball.x = this.miniGame_right ? FlxG.width - this.MINIGAME_BALL_START_DISTANCE : 0 + this.MINIGAME_BALL_START_DISTANCE;
         this.miniGame_ball.y = int(FlxU.random() * FlxG.height);
         add(this.miniGame_ball);
      }
      
      public function miniGame_getBallSpeed() : Number
      {
         return 100 + this.miniGame_skill;
      }
      
      public function miniGame_getBallBounces() : int
      {
         var _loc1_:Number = 2.2 + 0.01 * this.miniGame_skill;
         var _loc2_:int = int(FlxU.random() * _loc1_);
         if(_loc2_ > 2)
         {
            _loc2_ = 2;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function miniGame_aimBall() : void
      {
         var _loc1_:Boolean = true;
		 var _loc2_:Boolean;
         if(this.miniGame_ball.velocity.y == 0 || _loc1_)
         {
            _loc2_ = FlxU.random() > 0.5;
         }
         else
         {
            _loc2_ = this.miniGame_ball.velocity.y < 0;
         }
         var _loc3_:Number = this.miniGame_getBallSpeed();
         var _loc4_:int = this.miniGame_getBallBounces();
         var _loc5_:int = this.miniGame_right ? FlxG.width * 2 - this.miniGame_targetX : 0 - this.miniGame_targetX;
         var _loc6_:int = _loc4_ % 2 == 1 ? FlxG.height - this.miniGame_targetY : 0 + this.miniGame_targetY;
         if(_loc2_)
         {
            _loc6_ -= FlxG.height * _loc4_;
         }
         else
         {
            _loc6_ += FlxG.height * _loc4_;
         }
         var _loc7_:Number = Math.atan2(_loc6_ - this.miniGame_ball.y,_loc5_ - this.miniGame_ball.x);
         this.miniGame_ball.velocity.x = Math.cos(_loc7_) * _loc3_;
         this.miniGame_ball.velocity.y = Math.sin(_loc7_) * _loc3_;
      }
      
      public function miniGame_start() : void
      {
         miniGame_right = FlxU.random() > 0.5;
         miniGame_missed = false;
         this.miniGame_makeNewBall();
         this.miniGame_startRound();
      }
      
      public function miniGame_paddleBounce() : void
      {
         this.miniGame_ball.bounceX(MenuBall.BOUNCE_PADDLE);
         this.miniGame_pickRandomTarget();
         this.miniGame_aimBall();
         miniGame_skill += 10;
         if(this.miniGame_skill > 400)
         {
            miniGame_skill = 400;
         }
      }
      
      public function miniGame_miss() : void
      {
         miniGame_missed = true;
         miniGame_skill = 0;
      }
      
      public function miniGame_startRound() : void
      {
         miniGame_missed = false;
         this.miniGame_pickRandomTarget();
         this.miniGame_aimBall();
      }
      
      public function miniGame_isBallInPaddle() : Boolean
      {
         return this.miniGame_ball.x > this.cursorL.x && this.miniGame_ball.x < this.cursorL.x + this.cursorR.width && this.miniGame_ball.y > this.cursorL.y - 1 && this.miniGame_ball.y < this.cursorL.y + this.cursorR.height + 1 || this.miniGame_ball.x > this.cursorR.x && this.miniGame_ball.x < this.cursorR.x + this.cursorR.width && this.miniGame_ball.y > this.cursorR.y - 1 && this.miniGame_ball.y < this.cursorR.y + this.cursorR.height + 1;
      }
      
      public function miniGame_updateRight() : void
      {
         if(this.miniGame_ball.velocity.x < 0 && !this.miniGame_missed)
         {
            if(this.miniGame_isBallInPaddle())
            {
               this.miniGame_paddleBounce();
            }
            else if(this.miniGame_ball.x < FlxG.width / 2)
            {
               this.miniGame_miss();
            }
         }
         else if(this.miniGame_missed && this.miniGame_ball.x < this.MINIGAME_BALL_START_DISTANCE)
         {
            miniGame_right = false;
            this.miniGame_startRound();
         }
      }
      
      public function miniGame_updateLeft() : void
      {
         if(this.miniGame_ball.velocity.x > 0 && !this.miniGame_missed)
         {
            if(this.miniGame_isBallInPaddle())
            {
               this.miniGame_paddleBounce();
            }
            else if(this.miniGame_ball.x > FlxG.width / 2)
            {
               this.miniGame_miss();
            }
         }
         else if(this.miniGame_missed && this.miniGame_ball.x > FlxG.width - this.MINIGAME_BALL_START_DISTANCE)
         {
            miniGame_right = true;
            this.miniGame_startRound();
         }
      }
      
      public function miniGame_update() : void
      {
         if(this.miniGame_right)
         {
            this.miniGame_updateRight();
         }
         else
         {
            this.miniGame_updateLeft();
         }
      }
      
      public function miniGame_checkStartStop() : void
      {
         var _loc1_:Boolean = true;
         if(this.isMenuMain || _loc1_)
         {
            timeSinceLastMove += FlxG.elapsed;
            if(this.timeSinceLastMove > MINIGAME_IDLE_TRIGGER_SECONDS && !this.miniGame)
            {
               miniGame = true;
               this.miniGame_start();
            }
         }
         else if(this.miniGame)
         {
            this.miniGame_destroyBall();
            miniGame = false;
         }
      }
      
      public function updateJustinSnaily() : void
      {
         justinSnailyElapsed += FlxG.elapsed;
         var _loc1_:Array = [0,2.0022,2.26774,2.44484,2.60571,2.71435,2.85117,3.65991,3.80471,4.02601,4.15476,4.36403,4.55724,5.6];
         var _loc2_:int;
		 var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(this.justinSnailyElapsed > _loc1_[_loc3_])
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         if(FlxG.keys.justPressed("ESCAPE"))
         {
            _loc2_ = 13;
         }
         if(_loc2_ > this.justinSnailyLetters)
         {
            justinSnailyLetters = _loc2_;
            switch(_loc2_)
            {
               case 1:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"J-----",null);
                  this.changeOption(3,"------",null);
                  break;
               case 2:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JU----",null);
                  this.changeOption(3,"------",null);
                  break;
               case 3:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUS---",null);
                  this.changeOption(3,"------",null);
                  break;
               case 4:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUST--",null);
                  this.changeOption(3,"------",null);
                  break;
               case 5:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUSTI-",null);
                  this.changeOption(3,"------",null);
                  break;
               case 6:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUSTIN",null);
                  this.changeOption(3,"------",null);
                  break;
               case 7:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUSTIN",null);
                  this.changeOption(3,"S-----",null);
                  break;
               case 8:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUSTIN",null);
                  this.changeOption(3,"SN----",null);
                  break;
               case 9:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUSTIN",null);
                  this.changeOption(3,"SNA---",null);
                  break;
               case 10:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUSTIN",null);
                  this.changeOption(3,"SNAI--",null);
                  break;
               case 11:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUSTIN",null);
                  this.changeOption(3,"SNAIL-",null);
                  break;
               case 12:
                  Sfx.playMenuBeep1();
                  this.changeOption(2,"JUSTIN",null);
                  this.changeOption(3,"SNAILY",null);
                  break;
               case 13:
                  Sfx.playMenuBeep2();
                  this.changeOption(2,"JUSTIN",null);
                  this.changeOption(3,"SNAILY",null);
                  PlayState.startHardNewGame();
				  break;
            }
         }
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(PlayState.realState != PlayState.STATE_MENU)
         {
            super.update();
            return;
         }
         colorNum += FlxG.elapsed * this.colorFps;
         if(clickedToPlay)
         {
            this.optionText[this.curOption].color = colors[int(this.colorNum) % colors.length];
         }
         if(this.justinSnaily)
         {
            this.updateJustinSnaily();
            super.update();
            return;
         }
         if(this.bg)
         {
            elapsed += FlxG.elapsed;
            this.bg.alpha = Utility.integrate(this.bg.alpha,this.targetAlpha,1,this.elapsed);
         }
         if(this.fading)
         {
            return;
         }
         if(!clickedToPlay)
         {
            this.cursorL.visible = false;
            this.cursorR.visible = false;
            if(Utility.justPressedAnyKey() || FlxG.mouse.justPressed())
            {
               remove(this.clickToPlayText);
               this.makeMainOptions();
               if(this.loadGameOption >= 0)
               {
                  this.setOption(this.loadGameOption,true);
               }
               if(this.returnToGameOption >= 0)
               {
                  this.setOption(this.returnToGameOption,true);
               }
               clickedToPlay = true;
               this.cursorL.visible = true;
               this.cursorR.visible = true;
               this.titleText.setYOffset(0);
            }
            super.update();
            return;
         }
         if(this.endingShow)
         {
            if(FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("ESCAPE"))
            {
               lastWasMouse = false;
               this.doOption(this.curOption);
            }
            else if(FlxG.mouse.justPressed())
            {
               lastWasMouse = true;
               this.doOption(this.curOption);
            }
            super.update();
            return;
         }
         if(this.isWaitingForControls)
         {
            this.enterKeyLayer.visible = true;
            if(FlxG.keys.justPressed("ESCAPE"))
            {
               isWaitingForControls = false;
            }
            else if(FlxG.keys.justPressed("A") || FlxG.keys.justPressed("B") || FlxG.keys.justPressed("C") || FlxG.keys.justPressed("D") || FlxG.keys.justPressed("E") || FlxG.keys.justPressed("F") || FlxG.keys.justPressed("G") || FlxG.keys.justPressed("H") || FlxG.keys.justPressed("I") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("L") || FlxG.keys.justPressed("M") || FlxG.keys.justPressed("N") || FlxG.keys.justPressed("O") || FlxG.keys.justPressed("P") || FlxG.keys.justPressed("Q") || FlxG.keys.justPressed("R") || FlxG.keys.justPressed("S") || FlxG.keys.justPressed("T") || FlxG.keys.justPressed("U") || FlxG.keys.justPressed("V") || FlxG.keys.justPressed("W") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("Y") || FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("QUOTE") || FlxG.keys.justPressed("ONE") || FlxG.keys.justPressed("TWO") || FlxG.keys.justPressed("THREE") || FlxG.keys.justPressed("FOUR") || FlxG.keys.justPressed("FIVE") || FlxG.keys.justPressed("SIX") || FlxG.keys.justPressed("SEVEN") || FlxG.keys.justPressed("EIGHT") || FlxG.keys.justPressed("NINE") || FlxG.keys.justPressed("ZERO") || FlxG.keys.justPressed("MINUS") || FlxG.keys.justPressed("PLUS") || FlxG.keys.justPressed("TAB") || FlxG.keys.justPressed("LBRACKET") || FlxG.keys.justPressed("RBRACKET") || FlxG.keys.justPressed("SEMICOLON") || FlxG.keys.justPressed("BACKSLASH") || FlxG.keys.justPressed("SLASH") || FlxG.keys.justPressed("COMMA") || FlxG.keys.justPressed("PERIOD") || FlxG.keys.justPressed("ALT") || FlxG.keys.justPressed("CONTROL") || FlxG.keys.justPressed("SHIFT") || FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("LEFT") || FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("RIGHT"))
            {
               this.reallySetKey(this.keyToSet,FlxG.keys.getLastKeys(1));
            }
            super.update();
            return;
         }
		 else
		 {
		    ;
		 }
         this.enterKeyLayer.visible = false;
         this.updateMenuScroll();
         this.miniGame_checkStartStop();
         if(this.miniGame)
         {
            this.miniGame_update();
         }
         if(FlxG.keys.justPressed("LEFT") && this.curOption == this.soundVolOption)
         {
            lastWasMouse = false;
            this.setVol(-1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.keys.justPressed("RIGHT") && this.curOption == this.soundVolOption)
         {
            lastWasMouse = false;
            this.setVol(1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.keys.justPressed("UP"))
         {
            lastWasMouse = false;
            this.moveOption(-1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.keys.justPressed("DOWN"))
         {
            lastWasMouse = false;
            this.moveOption(1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.mouse.wheel > 0)
         {
            lastWasMouse = false;
            this.moveOption(-1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.mouse.wheel < 0)
         {
            lastWasMouse = false;
            this.moveOption(1);
            Sfx.playMenuBeep1();
         }
         if((FlxG.keys.justPressed("P") || FlxG.keys.justPressed("ESCAPE") && !this.escToMain && !this.escToOptions) && PlayState.startedGame)
         {
            lastWasMouse = false;
            PlayState.realState = PlayState.STATE_GAME;
            FlxG.flash.start(2130706432,0.34);
            return;
         }
         if(FlxG.keys.justPressed("ESCAPE") && this.escToMain)
         {
            lastWasMouse = false;
            this.makeMainOptions();
            Sfx.playMenuBeep2();
         }
         else if(FlxG.keys.justPressed("ESCAPE") && this.escToOptions)
         {
            lastWasMouse = false;
            this.makeOptionsMenu();
            Sfx.playMenuBeep2();
         }
         if(FlxG.mouse.justPressed())
         {
            lastWasMouse = true;
            _loc1_ = 0;
            while(_loc1_ < this.optionNum)
            {
               if(this.actions[_loc1_] == null)
			   {
			   }
			   else
               {
                  _loc2_ = FlxG.width / 2 - this.optionTextWidth[_loc1_] / 2 + this.optionText[_loc1_].x;
                  if(FlxG.mouse.screenX > _loc2_ && FlxG.mouse.screenX < _loc2_ + this.optionTextWidth[_loc1_] && FlxG.mouse.screenY > this.optionText[_loc1_].y && FlxG.mouse.screenY < this.optionText[_loc1_].y + this.optionText[_loc1_].height - 2)
                  {
                     this.doOption(_loc1_);
                     break;
                  }
               }
               _loc1_++;
            }
         }
         else if(FlxG.mouse.justMoved || this.lastWasMouse && this.justScrolled)
         {
            lastWasMouse = true;
            _loc1_ = 0;
            while(_loc1_ < this.optionNum)
            {
               if(this.actions[_loc1_] == null)
			   {
			   }
			   else
               {
                  if(_loc1_ == this.curOption)
				  {
				  }
				  else
                  {
                     _loc2_ = FlxG.width / 2 - this.optionTextWidth[_loc1_] / 2 + this.optionText[_loc1_].x;
                     if(FlxG.mouse.screenX > _loc2_ && FlxG.mouse.screenX < _loc2_ + this.optionTextWidth[_loc1_] && FlxG.mouse.screenY > this.optionText[_loc1_].y && FlxG.mouse.screenY < this.optionText[_loc1_].y + this.optionText[_loc1_].height - 2)
                     {
                        this.setOption(_loc1_);
                        Sfx.playMenuBeep1();
                        break;
                     }
                  }
               }
               _loc1_++;
            }
         }
         if(FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER") || this.curOption == this.musicVolOption && (FlxG.keys.justPressed("LEFT") || FlxG.keys.justPressed("RIGHT")))
         {
            this.doOption(this.curOption);
         }
         super.update();
      }
      
      public function doOption(param1:int) : void
      {
         if(this.doFade[param1])
         {
            Sfx.playMenuBeep2();
            fading = true;
            FlxG.fade.start(4278206591,0.34,this.onFade);
         }
         else
         {
            Sfx.playMenuBeep2();
            this.actions[param1]();
         }
      }
      
      private function onFade() : void
      {
         FlxG.fade.stop();
         this.actions[this.curOption]();
         fading = false;
         FlxG.flash.start(2130706432,0.34);
      }
   }
}

