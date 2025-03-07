package
{
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
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
      
      public var hasEnding:Array = [false,false,false,false,false,false];
      
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
      
      public function MainMenu() : void
      {
         timeSinceLastMove = 0;
         miniGame = false;
         checkSaveVars();
         setupBackground();
         sponsorMoreGames = new SponsorMoreGames();
         add(sponsorMoreGames);
         jayIsGames = new JayIsGames();
         add(jayIsGames);
         setupCursors();
         if(clickedToPlay)
         {
            makeMainOptions();
         }
         else
         {
            makeClickToPlay();
         }
         if(loadGameOption >= 0)
         {
            setOption(loadGameOption,true);
         }
         if(returnToGameOption >= 0)
         {
            setOption(returnToGameOption,true);
         }
         loadGameOption = -1;
         returnToGameOption = -1;
         musicVolOption = -1;
         soundVolOption = -1;
         endingOption = -1;
         escToOptions = false;
         escToMain = false;
         makeEnterKeyGraphic();
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
            hasEnding[0] = true;
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
               hasEnding[1] = true;
            }
            bgColor = 4281335856;
         }
         if(_loc1_.xml.vars && _loc1_.isVarTrue("hasWonHardMode"))
         {
            hasInsaneMode = false;
            hasEnding[2] = true;
            bgColor = 4278202416;
         }
         if(bestNormalTime > 0 && bestNormalTime < FAST_ENDING_CUTOFF || bestHardTime > 0 && bestHardTime < FAST_ENDING_CUTOFF || bestInsaneTime > 0 && bestInsaneTime < FAST_ENDING_CUTOFF)
         {
            hasEnding[3] = true;
         }
         if(_loc1_.xml.vars && _loc1_.isVarTrue("hasWonInsaneMode"))
         {
            bgColor = 4278202416;
         }
         if(bestInsaneTime > 0)
         {
            hasEnding[4] = true;
         }
      }
      
      public function makeEnterKeyGraphic() : void
      {
         enterKeyLayer = new EnterKeyLayer();
         add(enterKeyLayer);
      }
      
      public function putEnterKeyGraphicOnTop() : void
      {
         remove(enterKeyLayer);
         add(enterKeyLayer);
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
         if(textGroup)
         {
            textGroup.kill();
         }
         textGroup = new FlxGroup();
         add(textGroup);
         putEnterKeyGraphicOnTop();
         optionText = new Array();
         optionTextY = new Array();
         optionTextWidth = new Array();
         actions = new Array();
         doFade = new Array();
         optionNum = 0;
      }
      
      public function addOption(param1:String, param2:Function, param3:Boolean = false, param4:int = 0) : int
      {
         var _loc5_:FlxText = new FlxText(0,20 * optionNum,FlxG.width);
         _loc5_.font = Fonts.normal;
         _loc5_.size = 20;
         _loc5_.color = 16777215;
         _loc5_.shadow = 1;
         _loc5_.alignment = "center";
         _loc5_.text = param1;
         _loc5_.scrollFactor.x = _loc5_.scrollFactor.y = 0;
         textGroup.add(_loc5_);
         if(param1 == "LOAD GAME")
         {
            loadGameOption = optionNum;
         }
         if(param1 == "RETURN TO GAME")
         {
            returnToGameOption = optionNum;
         }
         optionTextWidth[optionNum] = _loc5_.realWidth;
         optionText[optionNum] = _loc5_;
         optionText[optionNum].x = param4;
         actions[optionNum] = param2;
         doFade[optionNum] = param3;
         return optionNum++;
      }
      
      public function changeOption(param1:int, param2:String, param3:Function, param4:int = 0) : void
      {
         optionText[param1].text = param2;
         actions[param1] = param3;
         optionText[param1].x = param4;
         optionTextWidth[param1] = optionText[param1].realWidth;
         setOption(curOption);
      }
      
      public function setOption(param1:int, param2:Boolean = false) : void
      {
         timeSinceLastMove = 0;
         if(!param2)
         {
            optionText[curOption].color = 16777215;
         }
         curOption = param1;
         while(curOption < 0)
         {
            curOption += optionNum;
         }
         while(curOption >= optionNum)
         {
            curOption -= optionNum;
         }
         while(actions[curOption] == null)
         {
            curOption = (curOption + 1) % optionNum;
         }
         curOption = param1;
         cursorL.moveTo(FlxG.width / 2 - optionTextWidth[curOption] / 2 - cursorL.width - 4 + optionText[curOption].x,optionText[curOption].y,param2);
         cursorR.moveTo(FlxG.width / 2 + optionTextWidth[curOption] / 2 + 4 + optionText[curOption].x,optionText[curOption].y,param2);
      }
      
      public function moveOption(param1:int) : void
      {
         curOption += param1;
         while(curOption < 0)
         {
            curOption += optionNum;
         }
         while(curOption >= optionNum)
         {
            curOption -= optionNum;
         }
         if(param1 > 0)
         {
            while(curOption < optionNum && actions[curOption] == null)
            {
               ++curOption;
               if(curOption >= optionNum)
               {
                  curOption -= optionNum;
               }
            }
         }
         if(param1 < 0)
         {
            while(curOption >= 0 && actions[curOption] == null)
            {
               --curOption;
               if(curOption < 0)
               {
                  curOption += optionNum;
               }
            }
         }
         setOption(curOption);
      }
      
      public function setupBackground() : void
      {
         if(PlayState.startedGame)
         {
            bg = new FlxSprite();
            bg.y = 0;
            bg.x = 0;
            bg.createGraphic(FlxG.width,FlxG.height,4278190080);
            bg.scrollFactor.x = bg.scrollFactor.y = 0;
            targetAlpha = 0.65;
            add(bg);
            bg.alpha = 0.0;
            elapsed = 0;
            menuOfsY = 0;
            titleText = new TitleText();
            add(titleText);
            menuOfsY = 27;
         }
         else
         {
            FlxG.flash.start(4278190080,0.34);
            bg = new FlxSprite();
            bg.y = 0;
            bg.x = 0;
            targetAlpha = 1;
            bg.createGraphic(FlxG.width,FlxG.height,bgColor);
            bg.scrollFactor.x = bg.scrollFactor.y = 0;
            add(bg);
            starLayer = new StarLayer();
            starLayer.makeStars();
            add(starLayer);
            bg.alpha = 1;
            elapsed = 9;
            menuOfsY = 0;
            titleText = new TitleText(true);
            add(titleText);
            menuOfsY = 27;
            Music.playTitle();
            if(!clickedToPlay)
            {
               titleText.setYOffset(60,true);
            }
         }
      }
      
      public function eraseFade() : void
      {
         fading = true;
         FlxG.fade.start(4289658880,0.34,eraseFade2);
      }
      
      public function eraseFade2() : void
      {
         FlxG.fade.stop();
         red = new FlxSprite();
         red.y = 0;
         red.x = 0;
         red.createGraphic(FlxG.width,FlxG.height,4289658880);
         red.scrollFactor.x = red.scrollFactor.y = 0;
         add(red);
         fadeInterval = setInterval(eraseFade3,1000);
      }
      
      public function eraseFade3() : void
      {
         red.visible = false;
         FlxG.flash.start(4289658880,0.34);
         clearInterval(fadeInterval);
         eraseSaveData();
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
         if(bg)
         {
            remove(bg).destroy();
            bg = null;
         }
         if(starLayer)
         {
            remove(starLayer).destroy();
            starLayer = null;
         }
         if(red)
         {
            remove(red).destroy();
            red = null;
         }
         if(titleText)
         {
            remove(titleText).destroy();
            titleText = null;
         }
         if(cursorL)
         {
            remove(cursorL).destroy();
            cursorL = null;
         }
         if(cursorR)
         {
            remove(cursorR).destroy();
            cursorR = null;
         }
         checkSaveVars();
         setupBackground();
         sponsorMoreGames.kill();
         remove(sponsorMoreGames);
         sponsorMoreGames = new SponsorMoreGames();
         add(sponsorMoreGames);
         jayIsGames.kill();
         remove(jayIsGames);
         jayIsGames = new JayIsGames();
         add(jayIsGames);
         setupCursors();
         makeMainOptions();
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
         resetMenu();
      }
      
      public function centerMenu() : void
      {
         var _loc1_:int = FlxG.height / 2 - (20 * optionNum - 5) / 2 + menuOfsY;
         if(_loc1_ < menuOfsY)
         {
            _loc1_ = menuOfsY;
         }
         var _loc2_:int = 0;
         while(_loc2_ < optionNum)
         {
            optionTextY[_loc2_] = _loc1_ + 20 * _loc2_;
            optionText[_loc2_].y = optionTextY[_loc2_];
            _loc2_++;
         }
         setOption(curOption,true);
      }
      
      public function updateMenuScroll() : void
      {
         var _loc1_:int = optionNum - 9;
         if(_loc1_ <= 0 || optionNum < 8)
         {
            justScrolled = false;
            if(titleText)
            {
               titleText.visible = true;
            }
            return;
         }
         if(miniGame)
         {
            miniGame = false;
            miniGame_destroyBall();
         }
         if(titleText)
         {
            titleText.visible = false;
         }
         var _loc2_:int = optionTextY[_loc1_] - optionTextY[0];
         var _loc3_:Number = curOption / optionNum;
         if(lastWasMouse)
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
         var _loc6_:int = menuScrollY;
         menuScrollY = Utility.integrate(menuScrollY,_loc5_,3,FlxG.elapsed);
         if(menuScrollY < 0)
         {
            menuScrollY = 0;
         }
         justScrolled = _loc6_ != menuScrollY;
         var _loc7_:int = 0;
         while(_loc7_ < optionNum)
         {
            optionText[_loc7_].y = optionTextY[_loc7_] - menuScrollY;
            _loc7_++;
         }
         setOption(curOption,true);
      }
      
      public function setupCursors() : void
      {
         cursorL = new MainMenuCursor();
         cursorR = new MainMenuCursor();
         cursorR.facing = left;
         add(cursorL);
         add(cursorR);
      }
      
      public function doNothing() : void
      {
      }
      
      public function confirmEraseSave() : void
      {
         sponsorMoreGames.hide();
         jayIsGames.hide();
         clearMenu();
         escToMain = true;
         oldOptionsMenuOption = curOption;
         addOption("ARE YOU SURE??",null,false);
         addOption("",null,false);
         addOption("YES, ERASE EVERYTHING!",eraseFade,false);
         addOption("NO WAY, I LIKE MY GAME!",makeOptionsMenu,false);
         curOption = 2;
         centerMenu();
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
         addOption(param1 + param2,param3,false,_loc5_ / 2 - 20);
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
         changeOption(curOption,param1 + param2,param3,_loc5_ / 2 - 20);
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
               changeKeyOption("OPEN MINIMAP && ",Player.MAP_KEY,setKeyMap);
               break;
            case KEY_JUMP:
               changeKeyOption("JUMP         ",Player.JUMP_KEY,setKeyJump);
               break;
            case KEY_SHOOT:
               changeKeyOption("SHOOT        ",Player.SHOOT_KEY,setKeyShoot);
               break;
            case KEY_STRAFE:
               changeKeyOption("STRAFE       ",Player.STRAFE_KEY,setKeyStrafe);
               break;
            case KEY_UP:
               changeKeyOption("MOVE UP      ",Player.UP_KEY,setKeyUp);
               break;
            case KEY_LEFT:
               changeKeyOption("MOVE LEFT    ",Player.LEFT_KEY,setKeyLeft);
               break;
            case KEY_DOWN:
               changeKeyOption("MOVE DOWN    ",Player.DOWN_KEY,setKeyDown);
               break;
            case KEY_RIGHT:
               changeKeyOption("MOVE RIGHT  &&&& ",Player.RIGHT_KEY,setKeyRight);
               break;
            case KEY_ALT_JUMP:
               changeKeyOption("JUMP         ",Player.ALT_JUMP_KEY,setAltKeyJump);
               break;
            case KEY_ALT_SHOOT:
               changeKeyOption("SHOOT        ",Player.ALT_SHOOT_KEY,setAltKeyShoot);
               break;
            case KEY_ALT_STRAFE:
               changeKeyOption("STRAFE       ",Player.ALT_STRAFE_KEY,setAltKeyStrafe);
               break;
            case KEY_ALT_UP:
               changeKeyOption("MOVE UP      ",Player.ALT_UP_KEY,setAltKeyUp);
               break;
            case KEY_ALT_LEFT:
               changeKeyOption("MOVE LEFT    ",Player.ALT_LEFT_KEY,setAltKeyLeft);
               break;
            case KEY_ALT_DOWN:
               changeKeyOption("MOVE DOWN    ",Player.ALT_DOWN_KEY,setAltKeyDown);
               break;
            case KEY_ALT_RIGHT:
               changeKeyOption("MOVE RIGHT  &&&& ",Player.ALT_RIGHT_KEY,setAltKeyRight);
               break;
            case KEY_WEAP_1:
               changeKeyOption("WEAPON ONE   ",Player.WEAPON_1_KEY,setKeyWeap1);
               break;
            case KEY_WEAP_2:
               changeKeyOption("WEAPON TWO   ",Player.WEAPON_2_KEY,setKeyWeap2);
               break;
            case KEY_WEAP_3:
               changeKeyOption("WEAPON THREE ",Player.WEAPON_3_KEY,setKeyWeap3);
               break;
            case KEY_WEAP_NEXT:
               changeKeyOption("NEXT WEAPON  ",Player.WEAPON_NEXT_KEY,setKeyWeapNext);
               break;
            case KEY_WEAP_PREV:
               changeKeyOption("PREV WEAPON  ",Player.WEAPON_PREV_KEY,setKeyWeapPrev);
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
         setKey(KEY_MAP);
      }
      
      public function setKeyJump() : void
      {
         setKey(KEY_JUMP);
      }
      
      public function setKeyShoot() : void
      {
         setKey(KEY_SHOOT);
      }
      
      public function setKeyStrafe() : void
      {
         setKey(KEY_STRAFE);
      }
      
      public function setKeyUp() : void
      {
         setKey(KEY_UP);
      }
      
      public function setKeyLeft() : void
      {
         setKey(KEY_LEFT);
      }
      
      public function setKeyDown() : void
      {
         setKey(KEY_DOWN);
      }
      
      public function setKeyRight() : void
      {
         setKey(KEY_RIGHT);
      }
      
      public function setAltKeyJump() : void
      {
         setKey(KEY_ALT_JUMP);
      }
      
      public function setAltKeyShoot() : void
      {
         setKey(KEY_ALT_SHOOT);
      }
      
      public function setAltKeyStrafe() : void
      {
         setKey(KEY_ALT_STRAFE);
      }
      
      public function setAltKeyUp() : void
      {
         setKey(KEY_ALT_UP);
      }
      
      public function setAltKeyLeft() : void
      {
         setKey(KEY_ALT_LEFT);
      }
      
      public function setAltKeyDown() : void
      {
         setKey(KEY_ALT_DOWN);
      }
      
      public function setAltKeyRight() : void
      {
         setKey(KEY_ALT_RIGHT);
      }
      
      public function setKeyWeap1() : void
      {
         setKey(KEY_WEAP_1);
      }
      
      public function setKeyWeap2() : void
      {
         setKey(KEY_WEAP_2);
      }
      
      public function setKeyWeap3() : void
      {
         setKey(KEY_WEAP_3);
      }
      
      public function setKeyWeapNext() : void
      {
         setKey(KEY_WEAP_NEXT);
      }
      
      public function setKeyWeapPrev() : void
      {
         setKey(KEY_WEAP_PREV);
      }
      
      public function resetControls() : void
      {
         reallySetKey(KEY_MAP,Player.DEFAULT_MAP_KEY);
         reallySetKey(KEY_JUMP,Player.DEFAULT_JUMP_KEY);
         reallySetKey(KEY_SHOOT,Player.DEFAULT_SHOOT_KEY);
         reallySetKey(KEY_STRAFE,Player.DEFAULT_STRAFE_KEY);
         reallySetKey(KEY_UP,Player.DEFAULT_UP_KEY);
         reallySetKey(KEY_LEFT,Player.DEFAULT_LEFT_KEY);
         reallySetKey(KEY_DOWN,Player.DEFAULT_DOWN_KEY);
         reallySetKey(KEY_RIGHT,Player.DEFAULT_RIGHT_KEY);
         reallySetKey(KEY_ALT_JUMP,Player.DEFAULT_ALT_JUMP_KEY);
         reallySetKey(KEY_ALT_SHOOT,Player.DEFAULT_ALT_SHOOT_KEY);
         reallySetKey(KEY_ALT_STRAFE,Player.DEFAULT_ALT_STRAFE_KEY);
         reallySetKey(KEY_ALT_UP,Player.DEFAULT_ALT_UP_KEY);
         reallySetKey(KEY_ALT_LEFT,Player.DEFAULT_ALT_LEFT_KEY);
         reallySetKey(KEY_ALT_DOWN,Player.DEFAULT_ALT_DOWN_KEY);
         reallySetKey(KEY_ALT_RIGHT,Player.DEFAULT_ALT_RIGHT_KEY);
         reallySetKey(KEY_WEAP_1,Player.DEFAULT_WEAPON_1_KEY);
         reallySetKey(KEY_WEAP_2,Player.DEFAULT_WEAPON_2_KEY);
         reallySetKey(KEY_WEAP_3,Player.DEFAULT_WEAPON_3_KEY);
         reallySetKey(KEY_WEAP_NEXT,Player.DEFAULT_WEAPON_NEXT_KEY);
         reallySetKey(KEY_WEAP_PREV,Player.DEFAULT_WEAPON_PREV_KEY);
         curOption = oldOptionsMenuOption;
         controlMenu();
      }
      
      public function controlMenu() : void
      {
         clearMenu();
         oldOptionsMenuOption = curOption;
         escToOptions = true;
         sponsorMoreGames.hide();
         jayIsGames.hide();
         scrollingMenu = true;
         isWaitingForControls = false;
         var _loc1_:Number = 340;
         addOption("CUSTOM CONTROLS (SET 1)",null,false);
         addOption("",null,false);
         addKeyOption("JUMP         ",Player.JUMP_KEY,setKeyJump);
         addKeyOption("SHOOT        ",Player.SHOOT_KEY,setKeyShoot);
         addKeyOption("STRAFE       ",Player.STRAFE_KEY,setKeyStrafe);
         addKeyOption("MOVE UP      ",Player.UP_KEY,setKeyUp);
         addKeyOption("MOVE LEFT    ",Player.LEFT_KEY,setKeyLeft);
         addKeyOption("MOVE DOWN    ",Player.DOWN_KEY,setKeyDown);
         addKeyOption("MOVE RIGHT  &&&& ",Player.RIGHT_KEY,setKeyRight);
         addOption("",null,false);
         addOption("CUSTOM CONTROLS (SET 2)",null,false);
         addOption("",null,false);
         addKeyOption("JUMP         ",Player.ALT_JUMP_KEY,setAltKeyJump);
         addKeyOption("SHOOT        ",Player.ALT_SHOOT_KEY,setAltKeyShoot);
         addKeyOption("STRAFE       ",Player.ALT_STRAFE_KEY,setAltKeyStrafe);
         addKeyOption("MOVE UP      ",Player.ALT_UP_KEY,setAltKeyUp);
         addKeyOption("MOVE LEFT    ",Player.ALT_LEFT_KEY,setAltKeyLeft);
         addKeyOption("MOVE DOWN    ",Player.ALT_DOWN_KEY,setAltKeyDown);
         addKeyOption("MOVE RIGHT  &&&& ",Player.ALT_RIGHT_KEY,setAltKeyRight);
         addOption("",null,false);
         addOption("CUSTOM CONTROLS (OTHER)",null,false);
         addOption("",null,false);
         addKeyOption("WEAPON ONE   ",Player.WEAPON_1_KEY,setKeyWeap1);
         addKeyOption("WEAPON TWO   ",Player.WEAPON_2_KEY,setKeyWeap2);
         addKeyOption("WEAPON THREE ",Player.WEAPON_3_KEY,setKeyWeap3);
         addKeyOption("NEXT WEAPON  ",Player.WEAPON_NEXT_KEY,setKeyWeapNext);
         addKeyOption("PREV WEAPON  ",Player.WEAPON_PREV_KEY,setKeyWeapPrev);
         addOption("",null,false);
         addKeyOption("OPEN MINIMAP && ",Player.MAP_KEY,setKeyMap);
         addOption("",null,false);
         addOption("RESET CONTROLS TO DEFAULTS",resetControls,false);
         addOption("",null,false);
         addOption("BACK TO OPTIONS",makeOptionsMenu,false);
         curOption = 2;
         centerMenu();
      }
      
      public function confirmBossRush() : void
      {
         clearMenu();
         escToMain = true;
         oldMenuOption = curOption;
         sponsorMoreGames.hide();
         jayIsGames.hide();
         addOption("ARE YOU SURE?",null,false);
         addOption("BOSS RUSH IS REALLY HARD!!",null,false);
         addOption("",null,false);
         addOption("YES, I\'M READY!!",PlayState.startBossRush,true);
         addOption("NO, I\'M AFRAID:(",makeMainOptions,false);
         addOption("",null,false);
         addOption("",null,false);
         curOption = 3;
         centerMenu();
      }
      
      public function confirmNewGame() : void
      {
         clearMenu();
         escToMain = true;
         oldMenuOption = curOption;
         sponsorMoreGames.hide();
         jayIsGames.hide();
         addOption("REALLY START A NEW GAME?",null,false);
         addOption("",null,false);
         addOption("YES, I WANT TO START OVER!",selectNewGameMode,false);
         addOption("NO WAY, I LIKE MY GAME!",makeMainOptions,false);
         curOption = 2;
         centerMenu();
      }
      
      public function selectNewGameMode() : void
      {
         clearMenu();
         escToMain = true;
         sponsorMoreGames.hide();
         jayIsGames.hide();
         addOption("SELECT A DIFFICULTY:",null,false);
         addOption("",null,false);
         addOption("EASY",PlayState.startEasyNewGame,false);
         addOption("NORMAL",PlayState.startNewGame,false);
         if(TESTING_ALL_MODES_AVAILABLE || hasHardMode)
         {
            addOption("SLUG",justinSnailyAnim,false);
         }
         curOption = 3;
         centerMenu();
      }
      
      public function justinSnailyAnim() : void
      {
         justinSnaily = true;
         justinSnailyElapsed = 0;
         miniGame = false;
         cursorL.visible = false;
         cursorR.visible = false;
         clearMenu();
         addOption("ENTER PASSWORD:",null,false);
         addOption("",null,false);
         addOption("------",null,false);
         addOption("------",null,false);
         addOption("",null,false);
         addOption("",PlayState.startHardNewGame,false);
         centerMenu();
         curOption = 5;
      }
      
      public function selectNewGameModeSetOldOption() : void
      {
         isMenuMain = false;
         oldMenuOption = curOption;
         selectNewGameMode();
      }
      
      public function soundOptionsMenu(param1:int = 0, param2:Boolean = false) : void
      {
         clearMenu();
         escToOptions = true;
         if(!param2)
         {
            oldOptionsMenuOption = curOption;
         }
         sponsorMoreGames.hide();
         jayIsGames.hide();
         soundVolOption = addOption("VOLUME: " + int(FlxG.volume * 10 + 0.0001).toString(),doNothing,false);
         musicVolOption = addOption("MUSIC: " + (FlxG.musicVolume == 0 ? "OFF" : "ON"),toggleMusicVol,false);
         addOption("",null,false);
         addOption("BACK TO OPTIONS",makeOptionsMenu,false);
         curOption = param1;
         centerMenu();
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
         changeOption(curOption,"HIDE MINIMAP: " + (PlayState.hideMiniMap ? "HIDE" : "SHOW"),toggleHideMiniMap);
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
         changeOption(curOption,"HIDE BOTTOM KEYS: " + (PlayState.hideTab ? "HIDE" : "SHOW"),toggleHideTab);
      }
      
      public function displayOptionsMenu(param1:int = 0, param2:Boolean = false) : void
      {
         clearMenu();
         escToOptions = true;
         if(!param2)
         {
            oldOptionsMenuOption = curOption;
         }
         sponsorMoreGames.hide();
         jayIsGames.hide();
         addOption("HIDE MINIMAP: " + (PlayState.hideMiniMap ? "HIDE" : "SHOW"),toggleHideMiniMap,false);
         addOption("HIDE BOTTOM KEYS: " + (PlayState.hideTab ? "HIDE" : "SHOW"),toggleHideTab,false);
         addOption("",null,false);
         addOption("BACK TO OPTIONS",makeOptionsMenu,false);
         curOption = param1;
         centerMenu();
      }
      
      public function makeOptionsMenuPreserveOption() : void
      {
         oldMenuOption = curOption;
         makeOptionsMenu();
      }
      
      public function showCredits() : void
      {
         clearMenu();
         escToMain = true;
         oldMenuOption = curOption;
         sponsorMoreGames.hide();
         jayIsGames.hide();
         addOption("SNAILIAD - A SNAILY GAME",null,false);
         addOption("BY CRYSTAL JACOBS (AURIPLANE)",null,false);
         addOption("",null,false);
         addOption("SPONSORED BY NEWGROUNDS",null,false);
         addOption("",null,false);
         addOption("",null,false);
         addOption("NEXT PAGE",showCreditsPageTwo,false);
         curOption = 6;
         centerMenu();
      }
      
      public function showCreditsPageTwo() : void
      {
         clearMenu();
         escToMain = true;
         sponsorMoreGames.hide();
         jayIsGames.hide();
         addOption("SPECIAL THANKS TO",null,false);
         addOption("",null,false);
         addOption("ADAMATOMIC (FLIXEL)",null,false);
         addOption("NEWSTARSHIPSMELL (TESTING)",null,false);
         addOption("XDANOND (ADDITIONAL ART)",null,false);
         addOption("",null,false);
         addOption("BACK TO MAIN MENU",makeMainOptions,false);
         curOption = 6;
         centerMenu();
      }
      
      public function showHighScores() : void
      {
         clearMenu();
         escToMain = true;
         oldMenuOption = curOption;
         sponsorMoreGames.show();
         jayIsGames.hide();
         addOption("YOUR BEST CLEAR TIMES",null,false);
         addOption("",null,false);
         if(bestNormalTime > 0)
         {
            addOption("NORMAL MODE   " + GameTimeDisplay.formatExact(bestNormalTime),null,false);
         }
         if(bestInsaneTime > 0)
         {
            addOption("100% CLEAR    " + GameTimeDisplay.formatExact(bestInsaneTime),null,false);
         }
         if(bestHardTime > 0)
         {
            addOption("SLUG MODE     " + GameTimeDisplay.formatExact(bestHardTime),null,false);
         }
         if(bestBossRushTime > 0)
         {
            addOption("BOSS RUSH     " + GameTimeDisplay.formatExact(bestBossRushTime),null,false);
         }
         addOption("",null,false);
         addOption("BACK TO MAIN MENU",makeMainOptions,false);
         curOption = optionNum - 1;
         centerMenu();
      }
      
      public function showEnding(param1:int) : void
      {
         FlxG.mouse.hide();
         endingOption = curOption;
         clearMenu();
         endingShow = true;
         addOption("",showEndingsMenu,false);
         endingGroup = new EndingGroup(param1);
         add(endingGroup);
         miniGame_destroyBall();
         miniGame = false;
         curOption = 0;
      }
      
      public function showEnding1() : void
      {
         showEnding(1);
      }
      
      public function showEnding2() : void
      {
         showEnding(2);
      }
      
      public function showEnding3() : void
      {
         showEnding(3);
      }
      
      public function showEnding4() : void
      {
         showEnding(4);
      }
      
      public function showEnding5() : void
      {
         showEnding(5);
      }
      
      public function showEndingsMenu() : void
      {
         sponsorMoreGames.hide();
         jayIsGames.hide();
         FlxG.mouse.show();
         clearMenu();
         escToMain = true;
         if(!endingGroup && !endingShow)
         {
            oldMenuOption = curOption;
         }
         if(endingShow)
         {
            endingShow = false;
         }
         if(endingGroup)
         {
            remove(endingGroup);
            endingGroup.destroy();
            endingGroup = null;
         }
         var _loc1_:Array = ["REGULAR CLEAR","BOSS RUSH CLEAR","SLUG MODE CLEAR","CLEAR < 30 MIN","100% CLEAR"];
         if(hasEnding[0])
         {
            addOption(_loc1_[0],showEnding1,false);
         }
         if(hasEnding[1])
         {
            addOption(_loc1_[1],showEnding2,false);
         }
         if(hasEnding[4])
         {
            addOption(_loc1_[4],showEnding3,false);
         }
         if(hasEnding[3])
         {
            addOption(_loc1_[3],showEnding4,false);
         }
         if(hasEnding[2])
         {
            addOption(_loc1_[2],showEnding5,false);
         }
         addOption("",null,false);
         addOption("BACK TO MAIN MENU",makeMainOptions,false);
         if(endingOption != -1)
         {
            curOption = endingOption;
         }
         else
         {
            curOption = optionNum - 1;
         }
         endingOption = -1;
         centerMenu();
      }
      
      public function toggleShootingMode() : void
      {
         Player.firingMode ^= 1;
         changeOption(curOption,"SHOOTING: " + (Player.firingMode == Player.FIRING_MODE_NORMAL ? "NORMAL" : "TOGGLE"),toggleShootingMode);
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
         clearMenu();
         escToMain = true;
         musicVolOption = -1;
         soundVolOption = -1;
         sponsorMoreGames.hide();
         jayIsGames.hide();
         addOption("SOUND OPTIONS",soundOptionsMenu,false);
         addOption("DISPLAY OPTIONS",displayOptionsMenu,false);
         addOption("SET CONTROLS",controlMenu,false);
         addOption("SHOOTING: " + (Player.firingMode == Player.FIRING_MODE_NORMAL ? "NORMAL" : "TOGGLE"),toggleShootingMode,false);
         addOption("",null,false);
         addOption("ERASE SAVE DATA",confirmEraseSave);
         addOption("",null,false);
         addOption("BACK TO MAIN MENU",makeMainOptions,false);
         setOption(oldOptionsMenuOption,true);
         centerMenu();
      }
      
      public function confirmLoadGame() : void
      {
         clearMenu();
         escToMain = true;
         oldMenuOption = curOption;
         sponsorMoreGames.hide();
         jayIsGames.hide();
         addOption("OKAY, WHERE WOULD YOU",null,false);
         addOption("LIKE TO START FROM?",null,false);
         addOption("",null,false);
         addOption("START FROM SAVE POINT",PlayState.loadGame,true);
         addOption("START FROM SNAIL TOWN",PlayState.loadGameFromTown,true);
         curOption = 3;
         centerMenu();
      }
      
      public function makeMainOptions() : void
      {
         curOption = 0;
         sponsorMoreGames.show();
         jayIsGames.show();
         clearMenu();
         isMenuMain = true;
         scrollingMenu = false;
         isWaitingForControls = false;
         if(PlayState.startedGame && !erasedSave)
         {
            if(PlayState.bossRush)
            {
               addOption("EXIT BOSS RUSH",resetMenu,true);
            }
            addOption("RETURN TO GAME",PlayState.returnToGame,false);
            if(!PlayState.bossRush)
            {
               addOption("NEW GAME",confirmNewGame,false);
            }
            if(hasSave)
            {
               addOption("LOAD GAME",confirmLoadGame,false);
            }
         }
         else if(hasSave)
         {
            if(!PlayState.bossRush)
            {
               addOption("NEW GAME",confirmNewGame,false);
            }
            addOption("LOAD GAME",confirmLoadGame,false);
         }
         else if(!PlayState.bossRush)
         {
            addOption("NEW GAME",selectNewGameModeSetOldOption,false);
         }
         if(TESTING_ALL_MODES_AVAILABLE || hasBossRush)
         {
            if(PlayState.bossRush)
            {
               addOption("RESTART BOSS RUSH",PlayState.startBossRush,true);
            }
            else
            {
               addOption("BOSS RUSH",confirmBossRush,false);
            }
         }
         addOption("",null);
         addOption("OPTIONS",makeOptionsMenuPreserveOption,false);
         addOption("CREDITS",showCredits,false);
         if(hasScores && !erasedSave)
         {
            addOption("RECORDS",showHighScores,false);
         }
         if((hasEnding[0] || hasEnding[1] || hasEnding[2] || hasEnding[3] || hasEnding[4]) && !erasedSave)
         {
            addOption("GALLERY",showEndingsMenu,false);
         }
         curOption = oldMenuOption;
         centerMenu();
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
         soundOptionsMenu(curOption,true);
      }
      
      public function setVol(param1:Number) : void
      {
         FlxG.volume += param1 * 0.1;
         soundOptionsMenu(curOption,true);
      }
      
      public function miniGame_pickRandomTarget() : void
      {
         var _loc1_:int = 30;
         do
         {
            miniGame_targetNum = int(FlxU.random() * optionNum);
            if(--_loc1_ < 0)
            {
               miniGame_targetNum = curOption;
               break;
            }
         }
         while(actions[miniGame_targetNum] == null || miniGame_targetNum == curOption);
         
         if(miniGame_right)
         {
            miniGame_targetX = FlxG.width / 2 + optionTextWidth[miniGame_targetNum] / 2 + cursorR.width;
         }
         else
         {
            miniGame_targetX = FlxG.width / 2 - optionTextWidth[miniGame_targetNum] / 2 - cursorL.width;
         }
         miniGame_targetY = optionText[miniGame_targetNum].y + optionText[miniGame_targetNum].height / 2 - 1;
      }
      
      public function miniGame_destroyBall() : void
      {
         if(miniGame_ball)
         {
            remove(miniGame_ball);
            miniGame_ball.destroy();
            miniGame_ball = null;
         }
      }
      
      public function miniGame_makeNewBall() : void
      {
         miniGame_destroyBall();
         miniGame_ball = new MenuBall();
         miniGame_ball.x = miniGame_right ? FlxG.width - MINIGAME_BALL_START_DISTANCE : 0 + MINIGAME_BALL_START_DISTANCE;
         miniGame_ball.y = int(FlxU.random() * FlxG.height);
         add(miniGame_ball);
      }
      
      public function miniGame_getBallSpeed() : Number
      {
         return 100 + miniGame_skill;
      }
      
      public function miniGame_getBallBounces() : int
      {
         var _loc1_:Number = 2.2 + 0.01 * miniGame_skill;
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
         if(miniGame_ball.velocity.y == 0 || _loc1_)
         {
            _loc2_ = FlxU.random() > 0.5;
         }
         else
         {
            _loc2_ = miniGame_ball.velocity.y < 0;
         }
         var _loc3_:Number = miniGame_getBallSpeed();
         var _loc4_:int = miniGame_getBallBounces();
         var _loc5_:int = miniGame_right ? FlxG.width * 2 - miniGame_targetX : 0 - miniGame_targetX;
         var _loc6_:int = _loc4_ % 2 == 1 ? FlxG.height - miniGame_targetY : 0 + miniGame_targetY;
         if(_loc2_)
         {
            _loc6_ -= FlxG.height * _loc4_;
         }
         else
         {
            _loc6_ += FlxG.height * _loc4_;
         }
         var _loc7_:Number = Math.atan2(_loc6_ - miniGame_ball.y,_loc5_ - miniGame_ball.x);
         miniGame_ball.velocity.x = Math.cos(_loc7_) * _loc3_;
         miniGame_ball.velocity.y = Math.sin(_loc7_) * _loc3_;
      }
      
      public function miniGame_start() : void
      {
         miniGame_right = FlxU.random() > 0.5;
         miniGame_missed = false;
         miniGame_makeNewBall();
         miniGame_startRound();
      }
      
      public function miniGame_paddleBounce() : void
      {
         miniGame_ball.bounceX(MenuBall.BOUNCE_PADDLE);
         miniGame_pickRandomTarget();
         miniGame_aimBall();
         miniGame_skill += 10;
         if(miniGame_skill > 400)
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
         miniGame_pickRandomTarget();
         miniGame_aimBall();
      }
      
      public function miniGame_isBallInPaddle() : Boolean
      {
         return miniGame_ball.x > cursorL.x && miniGame_ball.x < cursorL.x + cursorR.width && miniGame_ball.y > cursorL.y - 1 && miniGame_ball.y < cursorL.y + cursorR.height + 1 || miniGame_ball.x > cursorR.x && miniGame_ball.x < cursorR.x + cursorR.width && miniGame_ball.y > cursorR.y - 1 && miniGame_ball.y < cursorR.y + cursorR.height + 1;
      }
      
      public function miniGame_updateRight() : void
      {
         if(miniGame_ball.velocity.x < 0 && !miniGame_missed)
         {
            if(miniGame_isBallInPaddle())
            {
               miniGame_paddleBounce();
            }
            else if(miniGame_ball.x < FlxG.width / 2)
            {
               miniGame_miss();
            }
         }
         else if(miniGame_missed && miniGame_ball.x < MINIGAME_BALL_START_DISTANCE)
         {
            miniGame_right = false;
            miniGame_startRound();
         }
      }
      
      public function miniGame_updateLeft() : void
      {
         if(miniGame_ball.velocity.x > 0 && !miniGame_missed)
         {
            if(miniGame_isBallInPaddle())
            {
               miniGame_paddleBounce();
            }
            else if(miniGame_ball.x > FlxG.width / 2)
            {
               miniGame_miss();
            }
         }
         else if(miniGame_missed && miniGame_ball.x > FlxG.width - MINIGAME_BALL_START_DISTANCE)
         {
            miniGame_right = true;
            miniGame_startRound();
         }
      }
      
      public function miniGame_update() : void
      {
         if(miniGame_right)
         {
            miniGame_updateRight();
         }
         else
         {
            miniGame_updateLeft();
         }
      }
      
      public function miniGame_checkStartStop() : void
      {
         var _loc1_:Boolean = true;
         if(isMenuMain || _loc1_)
         {
            timeSinceLastMove += FlxG.elapsed;
            if(timeSinceLastMove > MINIGAME_IDLE_TRIGGER_SECONDS && !miniGame)
            {
               miniGame = true;
               miniGame_start();
            }
         }
         else if(miniGame)
         {
            miniGame_destroyBall();
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
            if(justinSnailyElapsed > _loc1_[_loc3_])
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         if(FlxG.keys.justPressed("ESCAPE"))
         {
            _loc2_ = 13;
         }
         if(_loc2_ > justinSnailyLetters)
         {
            justinSnailyLetters = _loc2_;
            switch(_loc2_)
            {
               case 1:
                  Sfx.playMenuBeep1();
                  changeOption(2,"J-----",null);
                  changeOption(3,"------",null);
                  break;
               case 2:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JU----",null);
                  changeOption(3,"------",null);
                  break;
               case 3:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUS---",null);
                  changeOption(3,"------",null);
                  break;
               case 4:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUST--",null);
                  changeOption(3,"------",null);
                  break;
               case 5:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUSTI-",null);
                  changeOption(3,"------",null);
                  break;
               case 6:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUSTIN",null);
                  changeOption(3,"------",null);
                  break;
               case 7:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUSTIN",null);
                  changeOption(3,"S-----",null);
                  break;
               case 8:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUSTIN",null);
                  changeOption(3,"SN----",null);
                  break;
               case 9:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUSTIN",null);
                  changeOption(3,"SNA---",null);
                  break;
               case 10:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUSTIN",null);
                  changeOption(3,"SNAI--",null);
                  break;
               case 11:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUSTIN",null);
                  changeOption(3,"SNAIL-",null);
                  break;
               case 12:
                  Sfx.playMenuBeep1();
                  changeOption(2,"JUSTIN",null);
                  changeOption(3,"SNAILY",null);
                  break;
               case 13:
                  Sfx.playMenuBeep2();
                  changeOption(2,"JUSTIN",null);
                  changeOption(3,"SNAILY",null);
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
         colorNum += FlxG.elapsed * colorFps;
         if(clickedToPlay)
         {
            optionText[curOption].color = colors[int(colorNum) % colors.length];
         }
         if(justinSnaily)
         {
            updateJustinSnaily();
            super.update();
            return;
         }
         if(bg)
         {
            elapsed += FlxG.elapsed;
            bg.alpha = Utility.integrate(bg.alpha,targetAlpha,1,elapsed);
         }
         if(fading)
         {
            return;
         }
         if(!clickedToPlay)
         {
            cursorL.visible = false;
            cursorR.visible = false;
            if(Utility.justPressedAnyKey() || FlxG.mouse.justPressed())
            {
               remove(clickToPlayText);
               makeMainOptions();
               if(loadGameOption >= 0)
               {
                  setOption(loadGameOption,true);
               }
               if(returnToGameOption >= 0)
               {
                  setOption(returnToGameOption,true);
               }
               clickedToPlay = true;
               cursorL.visible = true;
               cursorR.visible = true;
               titleText.setYOffset(0);
            }
            super.update();
            return;
         }
         if(endingShow)
         {
            if(FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("ESCAPE"))
            {
               lastWasMouse = false;
               doOption(curOption);
            }
            else if(FlxG.mouse.justPressed())
            {
               lastWasMouse = true;
               doOption(curOption);
            }
            super.update();
            return;
         }
         if(isWaitingForControls)
         {
            enterKeyLayer.visible = true;
            if(FlxG.keys.justPressed("ESCAPE"))
            {
               isWaitingForControls = false;
            }
            else if(FlxG.keys.justPressed("A") || FlxG.keys.justPressed("B") || FlxG.keys.justPressed("C") || FlxG.keys.justPressed("D") || FlxG.keys.justPressed("E") || FlxG.keys.justPressed("F") || FlxG.keys.justPressed("G") || FlxG.keys.justPressed("H") || FlxG.keys.justPressed("I") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("L") || FlxG.keys.justPressed("M") || FlxG.keys.justPressed("N") || FlxG.keys.justPressed("O") || FlxG.keys.justPressed("P") || FlxG.keys.justPressed("Q") || FlxG.keys.justPressed("R") || FlxG.keys.justPressed("S") || FlxG.keys.justPressed("T") || FlxG.keys.justPressed("U") || FlxG.keys.justPressed("V") || FlxG.keys.justPressed("W") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("Y") || FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("QUOTE") || FlxG.keys.justPressed("ONE") || FlxG.keys.justPressed("TWO") || FlxG.keys.justPressed("THREE") || FlxG.keys.justPressed("FOUR") || FlxG.keys.justPressed("FIVE") || FlxG.keys.justPressed("SIX") || FlxG.keys.justPressed("SEVEN") || FlxG.keys.justPressed("EIGHT") || FlxG.keys.justPressed("NINE") || FlxG.keys.justPressed("ZERO") || FlxG.keys.justPressed("MINUS") || FlxG.keys.justPressed("PLUS") || FlxG.keys.justPressed("TAB") || FlxG.keys.justPressed("LBRACKET") || FlxG.keys.justPressed("RBRACKET") || FlxG.keys.justPressed("SEMICOLON") || FlxG.keys.justPressed("BACKSLASH") || FlxG.keys.justPressed("SLASH") || FlxG.keys.justPressed("COMMA") || FlxG.keys.justPressed("PERIOD") || FlxG.keys.justPressed("ALT") || FlxG.keys.justPressed("CONTROL") || FlxG.keys.justPressed("SHIFT") || FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("LEFT") || FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("RIGHT"))
            {
               reallySetKey(keyToSet,FlxG.keys.getLastKeys(1));
            }
            super.update();
            return;
         }
		 else
		 {
		    ;
		 }
         enterKeyLayer.visible = false;
         updateMenuScroll();
         miniGame_checkStartStop();
         if(miniGame)
         {
            miniGame_update();
         }
         if(FlxG.keys.justPressed("LEFT") && curOption == soundVolOption)
         {
            lastWasMouse = false;
            setVol(-1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.keys.justPressed("RIGHT") && curOption == soundVolOption)
         {
            lastWasMouse = false;
            setVol(1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.keys.justPressed("UP"))
         {
            lastWasMouse = false;
            moveOption(-1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.keys.justPressed("DOWN"))
         {
            lastWasMouse = false;
            moveOption(1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.mouse.wheel > 0)
         {
            lastWasMouse = false;
            moveOption(-1);
            Sfx.playMenuBeep1();
         }
         if(FlxG.mouse.wheel < 0)
         {
            lastWasMouse = false;
            moveOption(1);
            Sfx.playMenuBeep1();
         }
         if((FlxG.keys.justPressed("P") || FlxG.keys.justPressed("ESCAPE") && !escToMain && !escToOptions) && PlayState.startedGame)
         {
            lastWasMouse = false;
            PlayState.realState = PlayState.STATE_GAME;
            FlxG.flash.start(2130706432,0.34);
            return;
         }
         if(FlxG.keys.justPressed("ESCAPE") && escToMain)
         {
            lastWasMouse = false;
            makeMainOptions();
            Sfx.playMenuBeep2();
         }
         else if(FlxG.keys.justPressed("ESCAPE") && escToOptions)
         {
            lastWasMouse = false;
            makeOptionsMenu();
            Sfx.playMenuBeep2();
         }
         if(FlxG.mouse.justPressed())
         {
            lastWasMouse = true;
            _loc1_ = 0;
            while(_loc1_ < optionNum)
            {
               if(actions[_loc1_] == null)
			   {
			   }
			   else
               {
                  _loc2_ = FlxG.width / 2 - optionTextWidth[_loc1_] / 2 + optionText[_loc1_].x;
                  if(FlxG.mouse.screenX > _loc2_ && FlxG.mouse.screenX < _loc2_ + optionTextWidth[_loc1_] && FlxG.mouse.screenY > optionText[_loc1_].y && FlxG.mouse.screenY < optionText[_loc1_].y + optionText[_loc1_].height - 2)
                  {
                     doOption(_loc1_);
                     break;
                  }
               }
               _loc1_++;
            }
         }
         else if(FlxG.mouse.justMoved || lastWasMouse && justScrolled)
         {
            lastWasMouse = true;
            _loc1_ = 0;
            while(_loc1_ < optionNum)
            {
               if(actions[_loc1_] == null)
			   {
			   }
			   else
               {
                  if(_loc1_ == curOption)
				  {
				  }
				  else
                  {
                     _loc2_ = FlxG.width / 2 - optionTextWidth[_loc1_] / 2 + optionText[_loc1_].x;
                     if(FlxG.mouse.screenX > _loc2_ && FlxG.mouse.screenX < _loc2_ + optionTextWidth[_loc1_] && FlxG.mouse.screenY > optionText[_loc1_].y && FlxG.mouse.screenY < optionText[_loc1_].y + optionText[_loc1_].height - 2)
                     {
                        setOption(_loc1_);
                        Sfx.playMenuBeep1();
                        break;
                     }
                  }
               }
               _loc1_++;
            }
         }
         if(FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER") || curOption == musicVolOption && (FlxG.keys.justPressed("LEFT") || FlxG.keys.justPressed("RIGHT")))
         {
            doOption(curOption);
         }
         super.update();
      }
      
      public function doOption(param1:int) : void
      {
         if(doFade[param1])
         {
            Sfx.playMenuBeep2();
            fading = true;
            FlxG.fade.start(4278206591,0.34,onFade);
         }
         else
         {
            Sfx.playMenuBeep2();
            actions[param1]();
         }
      }
      
      private function onFade() : void
      {
         FlxG.fade.stop();
         actions[curOption]();
         fading = false;
         FlxG.flash.start(2130706432,0.34);
      }
   }
}

