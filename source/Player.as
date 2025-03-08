package
{
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import org.flixel.*;
   
   public class Player extends FlxSprite
   {
      public static const BOSSRUSH_STARTX:int = 500;
      
      public static const BOSSRUSH_STARTY:int = 135;
      
      public static const MAX_HELIX_FRAGMENTS:int = 30;
      
      public static const MAX_HEART_CONTAINERS:int = 14;
      
      public static const GRAV_DOWN:int = 0;
      
      public static const GRAV_RIGHT:int = 1;
      
      public static const GRAV_UP:int = 2;
      
      public static const GRAV_LEFT:int = 3;
      
      public static const DIR_DOWN:int = 0;
      
      public static const DIR_RIGHT:int = 1;
      
      public static const DIR_UP:int = 2;
      
      public static const DIR_LEFT:int = 3;
      
      public static const FACE_FLOOR_RIGHT:int = 0;
      
      public static const FACE_FLOOR_LEFT:int = 1;
      
      public static const FACE_CEIL_LEFT:int = 2;
      
      public static const FACE_CEIL_RIGHT:int = 3;
      
      public static const FACE_RWALL_UP:int = 4;
      
      public static const FACE_RWALL_DOWN:int = 5;
      
      public static const FACE_LWALL_UP:int = 6;
      
      public static const FACE_LWALL_DOWN:int = 7;
      
      public static const DIR_NAME:Array = ["floor right","floor left","ceil left","ceil right","rwall up","rwall down","lwall up","lwall down"];
      
      private static const DEATHFADE_DELAY:int = 1000;
      
      private static const TELEPORT_DELAY:int = 40;
      
      private static const REVIVE_DELAY:int = 2000;
      
      private static const SPRITE_WIDTH:int = 32;
      
      private static const SPRITE_HEIGHT:int = 32;
      
      private static const REGULAR_JUMP:int = 428;
      
      private static const HIGH_JUMP:int = 920;
      
      public static const WEAPON_NONE:int = -1;
      
      public static const WEAPON_PEA_SHOOTER:int = 0;
      
      public static const WEAPON_PEA_BOOMERANG:int = 1;
      
      public static const WEAPON_PEA_RAINBOW_WAVE:int = 2;
      
      public static const SNAILTYPE_NORMAL:int = 1;
      
      public static const SNAILTYPE_ICE:int = 2;
      
      public static const SNAILTYPE_GRAVITY:int = 3;
      
      public static const SNAILTYPE_METAL:int = 4;
      
      public static const STARTING_MAX_HEARTS:int = 3;
      
      public static var ALT_WEAPON_1_KEY:String = "";
      
      public static var ALT_WEAPON_2_KEY:String = "";
      
      public static var ALT_WEAPON_3_KEY:String = "";
      
      public static var ALT_WEAPON_NEXT_KEY:String = "";
      
      public static var ALT_WEAPON_PREV_KEY:String = "";
      
      public static const DEFAULT_WEAPON_1_KEY:String = "ONE";
      
      public static const DEFAULT_WEAPON_2_KEY:String = "TWO";
      
      public static const DEFAULT_WEAPON_3_KEY:String = "THREE";
      
      public static const DEFAULT_WEAPON_NEXT_KEY:String = "PLUS";
      
      public static const DEFAULT_WEAPON_PREV_KEY:String = "MINUS";
      
      public static const DEFAULT_MAP_KEY:String = "M";
      
      public static const DEFAULT_JUMP_KEY:String = "Z";
      
      public static const DEFAULT_SHOOT_KEY:String = "X";
      
      public static const DEFAULT_STRAFE_KEY:String = "C";
      
      public static const DEFAULT_ALT_JUMP_KEY:String = "K";
      
      public static const DEFAULT_ALT_SHOOT_KEY:String = "J";
      
      public static const DEFAULT_ALT_STRAFE_KEY:String = "H";
      
      public static const DEFAULT_UP_KEY:String = "UP";
      
      public static const DEFAULT_LEFT_KEY:String = "LEFT";
      
      public static const DEFAULT_DOWN_KEY:String = "DOWN";
      
      public static const DEFAULT_RIGHT_KEY:String = "RIGHT";
      
      public static const DEFAULT_ALT_UP_KEY:String = "W";
      
      public static const DEFAULT_ALT_LEFT_KEY:String = "A";
      
      public static const DEFAULT_ALT_DOWN_KEY:String = "S";
      
      public static const DEFAULT_ALT_RIGHT_KEY:String = "D";
      
      public static var WEAPON_1_KEY:String = DEFAULT_WEAPON_1_KEY;
      
      public static var WEAPON_2_KEY:String = DEFAULT_WEAPON_2_KEY;
      
      public static var WEAPON_3_KEY:String = DEFAULT_WEAPON_3_KEY;
      
      public static var WEAPON_NEXT_KEY:String = DEFAULT_WEAPON_NEXT_KEY;
      
      public static var WEAPON_PREV_KEY:String = DEFAULT_WEAPON_PREV_KEY;
      
      public static var MAP_KEY:String = DEFAULT_MAP_KEY;
      
      public static var JUMP_KEY:String = DEFAULT_JUMP_KEY;
      
      public static var SHOOT_KEY:String = DEFAULT_SHOOT_KEY;
      
      public static var STRAFE_KEY:String = DEFAULT_STRAFE_KEY;
      
      public static var ALT_JUMP_KEY:String = DEFAULT_ALT_JUMP_KEY;
      
      public static var ALT_SHOOT_KEY:String = DEFAULT_ALT_SHOOT_KEY;
      
      public static var ALT_STRAFE_KEY:String = DEFAULT_ALT_STRAFE_KEY;
      
      public static var UP_KEY:String = DEFAULT_UP_KEY;
      
      public static var LEFT_KEY:String = DEFAULT_LEFT_KEY;
      
      public static var DOWN_KEY:String = DEFAULT_DOWN_KEY;
      
      public static var RIGHT_KEY:String = DEFAULT_RIGHT_KEY;
      
      public static var ALT_UP_KEY:String = DEFAULT_ALT_UP_KEY;
      
      public static var ALT_LEFT_KEY:String = DEFAULT_ALT_LEFT_KEY;
      
      public static var ALT_DOWN_KEY:String = DEFAULT_ALT_DOWN_KEY;
      
      public static var ALT_RIGHT_KEY:String = DEFAULT_ALT_RIGHT_KEY;
      
      private static const SLEEP_TIMEOUT:Number = 30;
      
      public static var fireToggle:Boolean = false;
      
      public static const FIRING_MODE_NORMAL:int = 0;
      
      public static const FIRING_MODE_TOGGLE:int = 1;
      
      public static var firingMode:int = FIRING_MODE_NORMAL;
      
      private var _cuteLittleSnails:Boolean = false;
      
      public var _invincible:Boolean = false;
      
      public var _superattack:Boolean = false;
      
      public var noCollide:Boolean = false;
      
      public var hasSetHpBar:Boolean = false;
      
      public var saveOnNextFrame:Boolean = false;
      
      public var _slugMode:Boolean = false;
      
      public var _justHitSteps:Boolean = false;
      
      private var WEAPON_TIMEOUTS:Array = [0.085,0.3,0.17];
      
      private var WEAPON_SPEED:Array = [370,330,60];
      
      public var pressedRightSinceJump:Boolean = false;
      
      public var pressedLeftSinceJump:Boolean = false;
      
      public var cheatsEnabled:Boolean = false;
      
      public var _easyMode:Boolean = false;
      
      public var _hardMode:Boolean = false;
      
      public var _insaneMode:Boolean = false;
      
      public var gameTime:ShadowNumber;
      
      public var clearTime:ShadowNumber;
      
      private var _jumpPower:CipherInt;
      
      public var _gravityDir:uint = 0;
      
      private var _desiredGravity:uint = 0;
      
      private var _faceDir:int = 0;
      
      public var _runSpeed:CipherInt;
      
      private var _maxSpeed:CipherInt;
      
      private var _gravity:CipherInt;
      
      private var _hidingInShell:Boolean = false;
      
      public var _jumping:Boolean = false;
      
      private var _fallFrames:int = 0;
      
      private var _hideOfsX:int = 0;
      
      private var _hideOfsY:int = 0;
      
      private var _hasWeapon:Array = [false,false,false];
      
      private var _hasColdFoot:CheckBool;
      
      private var _hasGravityJump:CheckBool;
      
      private var _hasDevastator:CheckBool;
      
      private var _hasHighJump:CheckBool;
      
      private var _hasGravityShock:CheckBool;
      
      private var _hasShellShield:CheckBool;
      
      private var _hasArmor:CheckBool;
      
      private var _hasTurbo:CheckBool;
      
      private var _justHitHeadOrWall:Boolean = false;
      
      private var _paralyzed:Boolean = false;
      
      private var _snailType:CipherInt;
      
      private var _snailTypePrefix:String = "snail1_";
      
      private var _bulletGroups:PlayerBulletGroups;
      
      private var _currentWeapon:CipherInt;
      
      private var _turboMultiplier:ShadowNumber;
      
      public var _weaponTimeout:ShadowNumber;
      
      private var _curHp:CipherInt;
      
      public var _maxHp:CipherInt;
      
      public var deathFadeInterval:uint;
      
      public var teleportInterval:uint;
      
      public var reviveInterval:uint;
      
      private var _helixFragments:CipherInt;
      
      private var _mostRecentDir:int = 0;
      
      private var _mostRecentUpDown:int = 0;
      
      private var _mostRecentLeftRight:int = 1;
      
      public var hasSeenIsis:Boolean = false;
      
      public var hasSeenHelp:Boolean = false;
      
      public var hasWonGame:Boolean = false;
      
      public var hasWonHardMode:Boolean = false;
      
      public var hasWonInsaneMode:Boolean = false;
      
      public var hasWonBossRush:Boolean = false;
      
      public var hasFullClear:Boolean = false;
      
      public var bestMainTime:ShadowNumber;
      
      public var bestHardTime:ShadowNumber;
      
      public var bestInsaneTime:ShadowNumber;
      
      public var bestBossRushTime:ShadowNumber;
      
      private var _sleepTimeout:Number;
      
      public function hpPerHeart() : int
      {
         if(_easyMode)
         {
            return 8;
         }
         if(_hardMode)
         {
            return 2;
         }
         return 4;
      }
      
      override public function destroy() : void
      {
         clearInterval(deathFadeInterval);
         clearInterval(reviveInterval);
         _bulletGroups = null;
         _curHp = null;
         _gravity = null;
         _hasArmor = null;
         _hasColdFoot = null;
         _hasDevastator = null;
         _hasGravityJump = null;
         _hasGravityShock = null;
         _hasHighJump = null;
         _hasShellShield = null;
         _hasTurbo = null;
         _hasWeapon = null;
         _helixFragments = null;
         _jumpPower = null;
         _maxHp = null;
         _maxSpeed = null;
         _runSpeed = null;
         _snailType = null;
         _turboMultiplier = null;
         _weaponTimeout = null;
         bestBossRushTime = null;
         bestMainTime = null;
         bestHardTime = null;
         bestInsaneTime = null;
         gameTime = null;
         clearTime = null;
         super.destroy();
      }
      
      public function Player(param1:PlayerBulletGroups) : void
      {
         _easyMode = false;
         _hardMode = false;
         _insaneMode = false;
         _curHp = new CipherInt(STARTING_MAX_HEARTS * hpPerHeart());
         _maxHp = new CipherInt(STARTING_MAX_HEARTS * hpPerHeart());
         _currentWeapon = new CipherInt(WEAPON_NONE);
         _gravity = new CipherInt(1200);
         _hasArmor = new CheckBool(false);
         _hasColdFoot = new CheckBool(false);
         _hasDevastator = new CheckBool(false);
         _hasGravityJump = new CheckBool(false);
         _hasGravityShock = new CheckBool(false);
         _hasHighJump = new CheckBool(false);
         _hasShellShield = new CheckBool(false);
         _hasTurbo = new CheckBool(false);
         _helixFragments = new CipherInt(0);
         _jumpPower = new CipherInt(REGULAR_JUMP);
         _maxSpeed = new CipherInt(500);
         _runSpeed = new CipherInt(260);
         _snailType = new CipherInt(SNAILTYPE_NORMAL);
         _turboMultiplier = new ShadowNumber(1);
         _weaponTimeout = new ShadowNumber(0);
         bestBossRushTime = new ShadowNumber(0);
         bestMainTime = new ShadowNumber(0);
         bestHardTime = new ShadowNumber(0);
         bestInsaneTime = new ShadowNumber(0);
         gameTime = new ShadowNumber(0);
         clearTime = new ShadowNumber(0);
         _sleepTimeout = SLEEP_TIMEOUT;
         _bulletGroups = param1;
         _paralyzed = false;
         hasSetHpBar = false;
         maxVelocity.x = _maxSpeed.value;
         maxVelocity.y = _maxSpeed.value;
         setMaxHp(STARTING_MAX_HEARTS * hpPerHeart());
         setCurHp(STARTING_MAX_HEARTS * hpPerHeart());
         var _loc2_:SaveData = PlayState.saveData;
         var _loc3_:XMLList = _loc2_.xml.vars;
         if(PlayState.bossRush)
         {
            setEasyMode(false);
            setHardMode(false);
            setInsaneMode(false);
            setHasTurbo(false);
            setHighJump(false);
            setHasDevastator(false);
            setHasGravityShock(false);
            setHasShellShield(false);
            switchToWeapon(-1);
            setHelixFragments(0);
            setSnailType(SNAILTYPE_NORMAL);
            gameTime.value = 0;
            x = BOSSRUSH_STARTX * 16;
            y = BOSSRUSH_STARTY * 16;
         }
         else
         {
            setEasyMode(false);
            setHardMode(false);
            setInsaneMode(false);
            if(!_loc2_.isVarSet("savex"))
            {
               _loc3_.savex = PlayState.config.getPlayerStartX() * 16;
            }
            if(!_loc2_.isVarSet("savey"))
            {
               _loc3_.savey = PlayState.config.getPlayerStartY() * 16;
            }
            if(!_loc2_.isVarSet("gameTime"))
            {
               _loc3_.gameTime = 0.0;
            }
            if(!_loc2_.isVarSet("easyMode"))
            {
               _loc3_.easyMode = false;
            }
            if(!_loc2_.isVarSet("hardMode"))
            {
               _loc3_.hardMode = false;
            }
            if(!_loc2_.isVarSet("insaneMode"))
            {
               _loc3_.insaneMode = false;
            }
            if(!_loc2_.isVarSet("hasDevastator"))
            {
               _loc3_.hasDevastator = false;
            }
            if(!_loc2_.isVarSet("hasGravityShock"))
            {
               _loc3_.hasGravityShock = false;
            }
            if(!_loc2_.isVarSet("hasShellShield"))
            {
               _loc3_.hasShellShield = false;
            }
            if(!_loc2_.isVarSet("hasTurbo"))
            {
               _loc3_.hasTurbo = false;
            }
            if(!_loc2_.isVarSet("toggleFire"))
            {
               _loc3_.toggleFire = false;
            }
            if(!_loc2_.isVarSet("hasHighJump"))
            {
               _loc3_.hasHighJump = false;
            }
            if(!_loc2_.isVarSet("hasWeaponZero"))
            {
               _loc3_.hasWeaponZero = false;
            }
            if(!_loc2_.isVarSet("hasWeaponOne"))
            {
               _loc3_.hasWeaponOne = false;
            }
            if(!_loc2_.isVarSet("hasWeaponTwo"))
            {
               _loc3_.hasWeaponTwo = false;
            }
            if(!_loc2_.isVarSet("helixFragments"))
            {
               _loc3_.helixFragments = 0;
            }
            if(!_loc2_.isVarSet("lastWeapon"))
            {
               _loc3_.lastWeapon = -1;
            }
            if(!_loc2_.isVarSet("snailType"))
            {
               _loc3_.snailType = SNAILTYPE_NORMAL;
            }
            if(!_loc2_.isVarSet("hideTab"))
            {
               _loc3_.hideTab = false;
            }
            if(!_loc2_.isVarSet("hideMiniMap"))
            {
               _loc3_.hideMiniMap = false;
            }
            if(!_loc2_.isVarSet("hasGoodEnding"))
            {
               _loc3_.hasGoodEnding = false;
            }
            if(!_loc2_.isVarSet("mapKey"))
            {
               _loc3_.mapKey = DEFAULT_MAP_KEY;
            }
            if(!_loc2_.isVarSet("jumpKey"))
            {
               _loc3_.jumpKey = DEFAULT_JUMP_KEY;
            }
            if(!_loc2_.isVarSet("shootKey"))
            {
               _loc3_.shootKey = DEFAULT_SHOOT_KEY;
            }
            if(!_loc2_.isVarSet("strafeKey"))
            {
               _loc3_.strafeKey = DEFAULT_STRAFE_KEY;
            }
            if(!_loc2_.isVarSet("upKey"))
            {
               _loc3_.upKey = DEFAULT_UP_KEY;
            }
            if(!_loc2_.isVarSet("leftKey"))
            {
               _loc3_.leftKey = DEFAULT_LEFT_KEY;
            }
            if(!_loc2_.isVarSet("downKey"))
            {
               _loc3_.downKey = DEFAULT_DOWN_KEY;
            }
            if(!_loc2_.isVarSet("rightKey"))
            {
               _loc3_.rightKey = DEFAULT_RIGHT_KEY;
            }
            if(!_loc2_.isVarSet("jumpAltKey"))
            {
               _loc3_.jumpAltKey = DEFAULT_ALT_JUMP_KEY;
            }
            if(!_loc2_.isVarSet("shootAltKey"))
            {
               _loc3_.shootAltKey = DEFAULT_ALT_SHOOT_KEY;
            }
            if(!_loc2_.isVarSet("strafeAltKey"))
            {
               _loc3_.strafeAltKey = DEFAULT_ALT_STRAFE_KEY;
            }
            if(!_loc2_.isVarSet("upAltKey"))
            {
               _loc3_.upAltKey = DEFAULT_ALT_UP_KEY;
            }
            if(!_loc2_.isVarSet("leftAltKey"))
            {
               _loc3_.leftAltKey = DEFAULT_ALT_LEFT_KEY;
            }
            if(!_loc2_.isVarSet("downAltKey"))
            {
               _loc3_.downAltKey = DEFAULT_ALT_DOWN_KEY;
            }
            if(!_loc2_.isVarSet("rightAltKey"))
            {
               _loc3_.rightAltKey = DEFAULT_ALT_RIGHT_KEY;
            }
            if(!_loc2_.isVarSet("weap1Key"))
            {
               _loc3_.weap1Key = DEFAULT_WEAPON_1_KEY;
            }
            if(!_loc2_.isVarSet("weap2Key"))
            {
               _loc3_.weap2Key = DEFAULT_WEAPON_2_KEY;
            }
            if(!_loc2_.isVarSet("weap3Key"))
            {
               _loc3_.weap3Key = DEFAULT_WEAPON_3_KEY;
            }
            if(!_loc2_.isVarSet("weapNextKey"))
            {
               _loc3_.weapNextKey = DEFAULT_WEAPON_NEXT_KEY;
            }
            if(!_loc2_.isVarSet("weapPrevKey"))
            {
               _loc3_.weapPrevKey = DEFAULT_WEAPON_PREV_KEY;
            }
            hasWonGame = _loc2_.isVarTrue("hasWonGame");
            hasWonHardMode = _loc2_.isVarTrue("hasWonHardMode");
            hasWonInsaneMode = _loc2_.isVarTrue("hasWonInsaneMode");
            hasFullClear = _loc2_.isVarTrue("hasFullClear");
            hasWonBossRush = _loc2_.isVarTrue("hasWonBossRush");
            PlayState.hideTab = _loc2_.isVarTrue("hideTab");
            PlayState.hideMiniMap = _loc2_.isVarTrue("hideMiniMap");
            PlayState.hasGoodEnding = _loc2_.isVarTrue("hasGoodEnding");
            setEasyMode(_loc2_.isVarTrue("easyMode"));
            setHardMode(_loc2_.isVarTrue("hardMode"));
            setInsaneMode(_loc2_.isVarTrue("insaneMode"));
            _slugMode = _hardMode && !_insaneMode;
            if(_slugMode)
            {
               WEAPON_TIMEOUTS[0] = 0.046;
               WEAPON_TIMEOUTS[1] = 0.23;
               WEAPON_TIMEOUTS[2] = 0.13;
            }
            if(!_loc2_.isVarSet("maxHp"))
            {
               _loc3_.maxHp = STARTING_MAX_HEARTS * hpPerHeart();
            }
            setMaxHp(_loc3_.maxHp);
            setCurHp(999999999);
            bestMainTime.value = _loc3_.bestMainTime;
            bestHardTime.value = _loc3_.bestHardTime;
            bestBossRushTime.value = _loc3_.bestBossRushTime;
            bestInsaneTime.value = _loc3_.bestInsaneTime;
            gameTime.value = _loc3_.gameTime;
            setHasWeapon(0,_loc2_.isVarTrue("hasWeaponZero"));
            setHasWeapon(1,_loc2_.isVarTrue("hasWeaponOne"));
            setHasWeapon(2,_loc2_.isVarTrue("hasWeaponTwo"));
            setHasTurbo(_loc2_.isVarTrue("hasTurbo"));
            if(_loc2_.isVarTrue("toggleFire"))
            {
               firingMode = FIRING_MODE_TOGGLE;
            }
            else
            {
               firingMode = FIRING_MODE_NORMAL;
            }
            setHighJump(_loc2_.isVarTrue("hasHighJump"));
            setHasDevastator(_loc2_.isVarTrue("hasDevastator"));
            setHasGravityShock(_loc2_.isVarTrue("hasGravityShock"));
            setHasShellShield(_loc2_.isVarTrue("hasShellShield"));
            switchToWeapon(_loc3_.lastWeapon);
            setHelixFragments(_loc3_.helixFragments);
            setSnailType(_loc3_.snailType);
            hasSeenIsis = _loc2_.isVarTrue("hasSeenIsis");
            hasSeenHelp = _loc2_.isVarTrue("hasSeenHelp");
            PlayState.bossesKilled[1] = _loc2_.isVarTrue("bossesKilledOne");
            PlayState.bossesKilled[2] = _loc2_.isVarTrue("bossesKilledTwo");
            PlayState.bossesKilled[3] = _loc2_.isVarTrue("bossesKilledThree");
            PlayState.bossesKilled[4] = _loc2_.isVarTrue("bossesKilledFour");
            if(bestMainTime.value > 0 || bestHardTime.value > 0)
            {
               NgMedal.unlockFirstOfFour();
               NgMedal.unlockStinkyToe();
               NgMedal.unlockGravityBattle();
               NgMedal.unlockVictory();
            }
            if(bestHardTime.value > 0)
            {
               NgMedal.unlockHomeless();
            }
            if(bestInsaneTime.value > 0)
            {
               NgMedal.unlockHappyEnding();
            }
            if(bestBossRushTime.value > 0)
            {
               NgMedal.unlockTheGauntlet();
            }
            if(hasSeenIsis)
            {
               NgMedal.unlockPilgrim();
            }
            if(PlayState.bossesKilled[1] && !_easyMode)
            {
               NgMedal.unlockFirstOfFour();
            }
            if(PlayState.bossesKilled[2] && !_easyMode)
            {
               NgMedal.unlockStinkyToe();
            }
            if(PlayState.bossesKilled[3] && !_easyMode)
            {
               NgMedal.unlockGravityBattle();
            }
            if(PlayState.bossesKilled[4] && !_easyMode)
            {
               NgMedal.unlockVictory();
            }
            MAP_KEY = _loc3_.mapKey;
            JUMP_KEY = _loc3_.jumpKey;
            SHOOT_KEY = _loc3_.shootKey;
            STRAFE_KEY = _loc3_.strafeKey;
            UP_KEY = _loc3_.upKey;
            LEFT_KEY = _loc3_.leftKey;
            DOWN_KEY = _loc3_.downKey;
            RIGHT_KEY = _loc3_.rightKey;
            ALT_JUMP_KEY = _loc3_.jumpAltKey;
            ALT_SHOOT_KEY = _loc3_.shootAltKey;
            ALT_STRAFE_KEY = _loc3_.strafeAltKey;
            ALT_UP_KEY = _loc3_.upAltKey;
            ALT_LEFT_KEY = _loc3_.leftAltKey;
            ALT_DOWN_KEY = _loc3_.downAltKey;
            ALT_RIGHT_KEY = _loc3_.rightAltKey;
            WEAPON_1_KEY = _loc3_.weap1Key;
            WEAPON_2_KEY = _loc3_.weap2Key;
            WEAPON_3_KEY = _loc3_.weap3Key;
            WEAPON_NEXT_KEY = _loc3_.weapNextKey;
            WEAPON_PREV_KEY = _loc3_.weapPrevKey;
            x = _loc3_.savex;
            y = _loc3_.savey;
            if(PlayState.startFromTown)
            {
               x = PlayState.config.getPlayerStartX() * 16;
               y = PlayState.config.getPlayerStartY() * 16;
            }
            if(!PlayState.startFromTown)
            {
               saveOnNextFrame = true;
            }
         }
         setGravityDir(GRAV_DOWN);
         _slugMode = _hardMode;
         loadGraphic(Art.SnailySnail,true,true,SPRITE_WIDTH,SPRITE_HEIGHT);
         for (var i:int = 0; i < 4; i++)
         {
            var _loc5_:int = i * 20;
            if(_slugMode)
            {
               _loc5_ += 4 * 20;
            }
            addAnimation("snail" + (i + 1).toString() + "_floor_right_move",[0 + _loc5_,1 + _loc5_],3,true);
            addAnimation("snail" + (i + 1).toString() + "_floor_right_hide",[3 + _loc5_],9,false);
            addAnimation("snail" + (i + 1).toString() + "_rwall_up_move",[4 + _loc5_,5 + _loc5_],3,true);
            addAnimation("snail" + (i + 1).toString() + "_rwall_up_hide",[7 + _loc5_],9,false);
            addAnimation("snail" + (i + 1).toString() + "_rwall_down_move",[8 + _loc5_,9 + _loc5_],3,true);
            addAnimation("snail" + (i + 1).toString() + "_rwall_down_hide",[11 + _loc5_],9,false);
            addAnimation("snail" + (i + 1).toString() + "_ceil_right_move",[12 + _loc5_,13 + _loc5_],3,true);
            addAnimation("snail" + (i + 1).toString() + "_ceil_right_hide",[15 + _loc5_],9,false);
            addAnimation("snail" + (i + 1).toString() + "_death",[16 + _loc5_,17 + _loc5_,18 + _loc5_,19 + _loc5_],30,true);
         }
         setFaceDir(FACE_FLOOR_RIGHT,true);
         playAnim("floor_right_move");
      }
      
      public function checkInput_handleMenu() : void
      {
         if((FlxG.keys.justPressed("P") || FlxG.keys.justPressed("ESCAPE")) && !dead && !PlayState.isBossRushComplete && !PlayState.isGameComplete && !_paralyzed)
         {
            if(PlayState.realState == PlayState.STATE_SUBSCREEN)
            {
               PlayState.miniMap.toggleMapSize();
            }
            PlayState.realState = PlayState.STATE_MENU;
         }
      }
      
      public function checkInput_handleHelp() : void
      {
         if(FlxG.keys.justPressed("F1") && !cheatsEnabled)
         {
            PlayState.controlHelp.toggle();
         }
      }
      
      public function checkInput_handleSkyFishCheat() : void
      {
         if(PlayState.bossRush || PlayState.area != 0)
         {
            return;
         }
         if(FlxG.keys.getLastKeys(6) == "SKYFIS" && (PlayState.bossesKilled[1] || PlayState.bossesKilled[2] || PlayState.bossesKilled[3] || PlayState.bossesKilled[4]))
         {
            Sfx.playSlugMode();
            PlayState.bossesKilled[1] = false;
            PlayState.bossesKilled[2] = false;
            PlayState.bossesKilled[3] = false;
            PlayState.bossesKilled[4] = false;
            saveNoCoords();
            PlayState.hud.areaName.setArea("- SKYFISH FLIES AGAIN -");
         }
      }
      
      public function checkInput_handleSlugCheat() : void
      {
         if(!PlayState.bossRush || PlayState.bossRushTimer.started || _slugMode)
         {
            return;
         }
         if(FlxG.keys.getLastKeys(4) == "SLUG")
         {
            Sfx.playSlugMode();
            hideInShell(false);
            _maxHp.value /= hpPerHeart();
            _slugMode = true;
            _hardMode = true;
            _maxHp.value *= hpPerHeart();
            setMaxHp(getMaxHp());
            setCurHp(999999999);
            WEAPON_TIMEOUTS[0] = 0.046;
            WEAPON_TIMEOUTS[1] = 0.23;
            WEAPON_TIMEOUTS[2] = 0.13;
            _animations = new Array();
            for (var i:int = 0; i < 4; i++)
            {
               var _loc2_:int = i * 20;
               if(_slugMode)
               {
                  _loc2_ += 4 * 20;
               }
               addAnimation("snail" + (i + 1).toString() + "_floor_right_move",[0 + _loc2_,1 + _loc2_],3,true);
               addAnimation("snail" + (i + 1).toString() + "_floor_right_hide",[3 + _loc2_],9,false);
               addAnimation("snail" + (i + 1).toString() + "_rwall_up_move",[4 + _loc2_,5 + _loc2_],3,true);
               addAnimation("snail" + (i + 1).toString() + "_rwall_up_hide",[7 + _loc2_],9,false);
               addAnimation("snail" + (i + 1).toString() + "_rwall_down_move",[8 + _loc2_,9 + _loc2_],3,true);
               addAnimation("snail" + (i + 1).toString() + "_rwall_down_hide",[11 + _loc2_],9,false);
               addAnimation("snail" + (i + 1).toString() + "_ceil_right_move",[12 + _loc2_,13 + _loc2_],3,true);
               addAnimation("snail" + (i + 1).toString() + "_ceil_right_hide",[15 + _loc2_],9,false);
               addAnimation("snail" + (i + 1).toString() + "_death",[16 + _loc2_,17 + _loc2_,18 + _loc2_,19 + _loc2_],30,true);
            }
            playAnim("death");
            setSnailType(_snailType.value);
            PlayState.hud.areaName.setArea("- OMEGA SLUG ENGAGE -");
         }
      }
      
      public function checkInput_hideInShell() : void
      {
         if(_slugMode)
         {
            return;
         }
         if(firingMode == FIRING_MODE_NORMAL && pressedShoot())
         {
            return;
         }
         if(firingMode == FIRING_MODE_TOGGLE && pressedStrafe())
         {
            return;
         }
         if(flickering() || dead)
         {
            return;
         }
         if(_gravityDir == GRAV_DOWN && justPressedDown() || _gravityDir == GRAV_UP && justPressedUp())
         {
            if(!pressedLeft() && !pressedRight() || _hidingInShell)
            {
               hideInShell(!_hidingInShell);
            }
         }
         if(_gravityDir == GRAV_LEFT && justPressedLeft() || _gravityDir == GRAV_RIGHT && justPressedRight())
         {
            if(!pressedUp() && !pressedDown() || _hidingInShell)
            {
               hideInShell(!_hidingInShell);
            }
         }
      }
      
      public function checkInput_shoot() : void
      {
         if(firingMode == FIRING_MODE_TOGGLE)
         {
            if(justPressedShoot() && hasAnyWeapon())
            {
               fireToggle = !fireToggle;
            }
         }
         else
         {
            fireToggle = pressedShoot();
         }
         if(fireToggle && !_hidingInShell)
         {
            shootCurrentWeapon();
         }
         if(justPressedShoot() && _hidingInShell && hasAnyWeapon())
         {
            hideInShell(false);
            shootCurrentWeapon();
         }
      }
      
      public function checkInput_switchWeapons() : void
      {
         if(FlxG.keys.justPressed(WEAPON_1_KEY))
         {
            switchToWeapon(0);
         }
         if(FlxG.keys.justPressed(WEAPON_2_KEY))
         {
            switchToWeapon(1);
         }
         if(FlxG.keys.justPressed(WEAPON_3_KEY))
         {
            switchToWeapon(2);
         }
         if(FlxG.keys.justPressed(WEAPON_NEXT_KEY))
         {
            switchToNextWeapon();
         }
         if(FlxG.keys.justPressed(WEAPON_PREV_KEY))
         {
            switchToPrevWeapon();
         }
      }
      
      public function checkInput_performGravityJump() : void
      {
         if(_hasGravityJump.value && justPressedJump() && _jumping)
         {
            performGravityJump();
         }
      }
      
      private function checkInput_move() : void
      {
         if(noCollide)
         {
            noCollide = false;
            acceleration.y = 1200;
         }
         if(justPressedUp())
         {
            _mostRecentDir = DIR_UP;
            _mostRecentUpDown = DIR_UP;
         }
         if(justPressedDown())
         {
            _mostRecentDir = DIR_DOWN;
            _mostRecentUpDown = DIR_DOWN;
         }
         if(justPressedLeft())
         {
            _mostRecentDir = DIR_LEFT;
            _mostRecentLeftRight = DIR_LEFT;
         }
         if(justPressedRight())
         {
            _mostRecentDir = DIR_RIGHT;
            _mostRecentLeftRight = DIR_RIGHT;
         }
         var _loc1_:Boolean = _hidingInShell && !_jumping;
         switch(_gravityDir)
         {
            case GRAV_UP:
               acceleration.x = 0;
               if(pressedLeft() && !pressedStrafe())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  facing = LEFT;
                  if((PlayState.worldMap.solidAt(x - 1,y + 3) || PlayState.worldMap.solidAt(x - 1,y + height - 4)) && !(pressedUp() || pressedDown()))
                  {
                     velocity.x = 0;
                  }
                  else
                  {
                     velocity.x = -_runSpeed.value;
                  }
                  setFaceDir(FACE_CEIL_LEFT);
               }
               else if(pressedRight() && !pressedStrafe())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  facing = RIGHT;
                  if((PlayState.worldMap.solidAt(x + width,y + 3) || PlayState.worldMap.solidAt(x + width,y + height - 4)) && !(pressedUp() || pressedDown()))
                  {
                     velocity.x = 0;
                  }
                  else
                  {
                     velocity.x = _runSpeed.value;
                  }
                  setFaceDir(FACE_CEIL_RIGHT);
               }
               break;
            case GRAV_DOWN:
               acceleration.x = 0;
               if(pressedLeft() && !pressedStrafe())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  facing = LEFT;
                  if((PlayState.worldMap.solidAt(x - 1,y + 3) || PlayState.worldMap.solidAt(x - 1,y + height - 4)) && !(pressedUp() || pressedDown()))
                  {
                     velocity.x = 0;
                  }
                  else
                  {
                     velocity.x = -_runSpeed.value;
                  }
                  setFaceDir(FACE_FLOOR_LEFT);
               }
               else if(pressedRight() && !pressedStrafe())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  facing = RIGHT;
                  if((PlayState.worldMap.solidAt(x + width,y + 3) || PlayState.worldMap.solidAt(x + width,y + height - 4)) && !(pressedUp() || pressedDown()))
                  {
                     velocity.x = 0;
                  }
                  else
                  {
                     velocity.x = _runSpeed.value;
                  }
                  setFaceDir(FACE_FLOOR_RIGHT);
               }
               break;
            case GRAV_LEFT:
               acceleration.y = 0;
               if(pressedUp() && !pressedStrafe())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  velocity.y = -_runSpeed.value;
                  facing = LEFT;
                  setFaceDir(FACE_LWALL_UP);
               }
               else if(pressedDown() && !pressedStrafe())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  velocity.y = _runSpeed.value;
                  facing = LEFT;
                  setFaceDir(FACE_LWALL_DOWN);
               }
               break;
            case GRAV_RIGHT:
               acceleration.y = 0;
               if(pressedUp() && !pressedStrafe())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  velocity.y = -_runSpeed.value;
                  facing = RIGHT;
                  setFaceDir(FACE_RWALL_UP);
               }
               else if(pressedDown() && !pressedStrafe())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  velocity.y = _runSpeed.value;
                  facing = RIGHT;
                  setFaceDir(FACE_RWALL_DOWN);
               }
			   break;
         }
      }
      
      public function checkInput_map() : void
      {
         if((FlxG.keys.justPressed("TAB") || FlxG.keys.justPressed(MAP_KEY)) && !_paralyzed && !dead && !PlayState.isBossRushComplete && !PlayState.isGameComplete)
         {
            PlayState.miniMap.toggleMapSize();
         }
      }
      
      public function checkInput_jump() : void
      {
         if(justPressedJump())
         {
            if(_hidingInShell)
            {
               hideInShell(false);
            }
            if(!_jumping)
            {
               doJump();
            }
         }
         if(_jumping && !pressedJump())
         {
            switch(_gravityDir)
            {
               case GRAV_UP:
                  if(velocity.y > 0)
                  {
                     velocity.y = Utility.integrate(velocity.y,0,4,FlxG.elapsed);
                  }
                  break;
               case GRAV_DOWN:
                  if(velocity.y < 0)
                  {
                     velocity.y = Utility.integrate(velocity.y,0,4,FlxG.elapsed);
                  }
                  break;
               case GRAV_LEFT:
                  if(velocity.x > 0)
                  {
                     velocity.x = Utility.integrate(velocity.x,0,4,FlxG.elapsed);
                  }
                  break;
               case GRAV_RIGHT:
                  if(velocity.x < 0)
                  {
                     velocity.x = Utility.integrate(velocity.x,0,4,FlxG.elapsed);
                  }
				  break;
            }
         }
      }
      
      override public function update() : void
      {
         if(saveOnNextFrame)
         {
            setHelixFragments(_helixFragments.value);
            setSaveCoords(x,y,true);
            saveOnNextFrame = false;
            hasSetHpBar = false;
            setCurHp(9999);
         }
         if(hasSetHpBar == false)
         {
            hasSetHpBar = true;
            setCurHp(9999);
            setMaxHp(_maxHp.value);
         }
         if(facing > 10)
         {
            facing = RIGHT;
         }
         if(PlayState.realState == PlayState.STATE_GAME || PlayState.realState == PlayState.STATE_SUBSCREEN)
         {
            checkInput_map();
            checkInput_handleMenu();
            checkInput_switchWeapons();
         }
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         gameTime.value += FlxG.elapsed;
         _weaponTimeout.value -= FlxG.elapsed;
         if(justPressedLeft())
         {
            pressedLeftSinceJump = true;
         }
         else if(justPressedRight())
         {
            pressedRightSinceJump = true;
         }
         else if(justPressedJump())
         {
            pressedLeftSinceJump = false;
            pressedRightSinceJump = false;
         }
         if(!dead)
         {
            fixGravity();
         }
         if(!dead && !_paralyzed)
         {
            checkInput_handleHelp();
            checkInput_handleSkyFishCheat();
            checkInput_handleSlugCheat();
            checkInput_hideInShell();
            checkInput_shoot();
            checkInput_performGravityJump();
            checkInput_move();
            checkInput_jump();
         }
         if(pressedUp() || pressedDown() || pressedLeft() || pressedRight() || pressedShoot() || pressedStrafe() || pressedJump() || flickering())
         {
            _sleepTimeout = SLEEP_TIMEOUT;
         }
         _sleepTimeout -= FlxG.elapsed;
         if(_sleepTimeout <= 0 && !PlayState.zzz.visible && !_slugMode)
         {
            hideInShell(true);
            PlayState.zzz.visible = true;
            _sleepTimeout = SLEEP_TIMEOUT;
         }
         if(!dead)
         {
            PlayState.worldMap.checkFakeBounds(x,y);
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
         if(_invincible || noCollide || _paralyzed)
         {
            return;
         }
         _sleepTimeout = SLEEP_TIMEOUT;
         if(_hidingInShell)
         {
            hideInShell(false);
            if(_hasShellShield.value)
            {
               flicker(1);
               Sfx.playEnemyPingOffArmor();
               return;
            }
         }
         if(flickering() || dead)
         {
            return;
         }
         if(_hasArmor.value)
         {
            param1 /= 2;
            if(param1 < 1)
            {
               Sfx.playEnemyPingOffArmor();
               return;
            }
         }
         setCurHp(_curHp.value - param1);
         if(dead)
         {
            Sfx.playDeath();
            playAnim("death");
            velocity.x = facing == LEFT ? 110 : -110;
            velocity.y = -300;
            acceleration.x = 0;
            acceleration.y = _gravity.value;
            drag.x = 0;
            drag.y = 0;
            dead = true;
            solid = false;
         }
         else
         {
            Sfx.playHurt();
            flicker(1);
         }
      }
      
      public function heal(param1:int) : void
      {
         setCurHp(_curHp.value + param1);
      }
      
      override public function kill() : void
      {
         if(dead)
         {
            return;
         }
         _sleepTimeout = SLEEP_TIMEOUT;
         dead = true;
         solid = false;
         if(PlayState.bossRush)
         {
            PlayState.bossesKilled[1] = false;
            PlayState.bossesKilled[2] = false;
            PlayState.bossesKilled[3] = false;
            PlayState.bossesKilled[4] = false;
            PlayState.bossRushTimer.going = false;
            PlayState.bossRushTimer.started = false;
            PlayState.bossRushTimer.now.value = 0;
         }
         if(!_invincible)
         {
            Utility.stackTrace("setting timer for kill()");
            deathFadeInterval = setInterval(deathFade,DEATHFADE_DELAY);
            reviveInterval = setInterval(revive,REVIVE_DELAY);
            setFaceDir(FACE_FLOOR_RIGHT,true);
         }
      }
      
      public function deathFade() : void
      {
         FlxG.fade.start(4278206591,0.44);
         clearInterval(deathFadeInterval);
      }
      
      public function revive() : void
      {
         clearInterval(reviveInterval);
         setFaceDir(FACE_FLOOR_RIGHT,true);
         facing = right;
         _faceDir = FACE_FLOOR_RIGHT;
         _mostRecentDir = DIR_RIGHT;
         _mostRecentUpDown = DIR_DOWN;
         _mostRecentLeftRight = DIR_RIGHT;
         teleportTo(32,32);
         teleportInterval = setInterval(realTeleport,TELEPORT_DELAY);
         if(PlayState.bossRush)
         {
            Music.playBoss1();
            PlayState.bossesKilled[1] = false;
            PlayState.bossesKilled[2] = false;
            PlayState.bossesKilled[3] = false;
            PlayState.bossesKilled[4] = false;
            PlayState.bossRushTimer.going = false;
            PlayState.bossRushTimer.started = false;
            PlayState.bossRushTimer.now.value = 0;
         }
      }
      
      override public function hitLeft(param1:FlxObject, param2:Number) : void
      {
         _justHitHeadOrWall = true;
         if(findNotSolidHeight() < 8)
         {
            return;
         }
         if(_paralyzed)
         {
            return;
         }
         if(pressedLeft() && (!flickering() || _hasGravityJump.value))
         {
            switch(_gravityDir)
            {
               case GRAV_UP:
                  if(pressedDown())
                  {
                     setGravityDir(GRAV_LEFT);
                     setFaceDir(FACE_LWALL_DOWN,true);
                     moveSnailCheckBounds(0,2);
                  }
                  break;
               case GRAV_DOWN:
                  if(pressedUp() || _jumping && pressedDown())
                  {
                     if(!_hasGravityJump.value && _jumping && _fallFrames < 8)
                     {
                        return;
                     }
                     setGravityDir(GRAV_LEFT);
                     setFaceDir(FACE_LWALL_UP,true);
                  }
				  break;
            }
         }
         super.hitLeft(param1,param2);
      }
      
      override public function hitRight(param1:FlxObject, param2:Number) : void
      {
         _justHitHeadOrWall = true;
         super.hitRight(param1,param2);
         if(_paralyzed)
         {
            return;
         }
         if(findNotSolidHeight() < 8)
         {
            return;
         }
         if(pressedRight() && (!flickering() || _hasGravityJump.value))
         {
            switch(_gravityDir)
            {
               case GRAV_UP:
                  if(pressedDown())
                  {
                     setGravityDir(GRAV_RIGHT);
                     setFaceDir(FACE_RWALL_DOWN,true);
                     moveSnailCheckBounds(11,2);
                  }
                  break;
               case GRAV_DOWN:
                  if(pressedUp() || _jumping && pressedDown())
                  {
                     if(!_hasGravityJump.value && _jumping && _fallFrames < 8)
                     {
                        return;
                     }
                     setGravityDir(GRAV_RIGHT);
                     setFaceDir(FACE_RWALL_UP,true);
                     y -= 11;
                     x += 11;
                     moveSnailCheckFullBounds(0,11);
                  }
				  break;
            }
         }
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         _justHitHeadOrWall = false;
         super.hitBottom(param1,param2);
         if(findNotSolidWidth() < 8)
         {
            return;
         }
         if(_paralyzed)
         {
            return;
         }
         if(_faceDir == FACE_LWALL_DOWN || _faceDir == FACE_RWALL_DOWN)
         {
            switch(_gravityDir)
            {
               case GRAV_LEFT:
                  if(pressedLeft() || pressedRight() || !hasGravityJump())
                  {
                     setGravityDir(GRAV_DOWN);
                     setFaceDir(FACE_FLOOR_RIGHT,true);
                     facing = RIGHT;
                     moveSnailCheckBounds(2,11);
                  }
                  break;
               case GRAV_RIGHT:
                  if(pressedLeft() || pressedRight() || !hasGravityJump())
                  {
                     setGravityDir(GRAV_DOWN);
                     setFaceDir(FACE_FLOOR_LEFT,true);
                     moveSnailCheckBounds(0,11);
                     facing = LEFT;
                  }
				  break;
            }
         }
         if(_faceDir == FACE_CEIL_RIGHT || _faceDir == FACE_CEIL_LEFT)
         {
            if(pressedDown())
            {
               setGravityDir(GRAV_DOWN);
               setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT,true);
            }
         }
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         _justHitHeadOrWall = true;
         super.hitTop(param1,param2);
         if(findNotSolidWidth() < 8)
         {
            return;
         }
         if(_paralyzed)
         {
            return;
         }
         if(_faceDir == FACE_LWALL_UP || _faceDir == FACE_RWALL_UP)
         {
            if(!pressedJump())
            {
               switch(_gravityDir)
               {
                  case GRAV_LEFT:
                     if(pressedRight())
                     {
                        setGravityDir(GRAV_UP);
                        setFaceDir(FACE_CEIL_RIGHT,true);
                        facing = RIGHT;
                     }
                     break;
                  case GRAV_RIGHT:
                     if(pressedLeft())
                     {
                        setGravityDir(GRAV_UP);
                        moveSnailCheckBounds(-11,0);
                        setFaceDir(FACE_CEIL_LEFT,true);
                        facing = LEFT;
                     }
					 break;
               }
            }
         }
         if(_faceDir == FACE_FLOOR_RIGHT || _faceDir == FACE_FLOOR_LEFT)
         {
            if(pressedUp())
            {
               setGravityDir(GRAV_UP);
               setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT,true);
            }
         }
      }
      
      public function hasAnyWeapon() : Boolean
      {
         return _hasWeapon[0] || _hasWeapon[1] || _hasWeapon[2];
      }
      
      public function hasAnyTwoWeapons() : Boolean
      {
         return _hasWeapon[0] && (_hasWeapon[1] || _hasWeapon[2]) || _hasWeapon[1] && _hasWeapon[2];
      }
      
      public function getHasWeapon(param1:int) : Boolean
      {
         return _hasWeapon[param1];
      }
      
      public function setHasWeapon(param1:int, param2:Boolean) : void
      {
         _hasWeapon[param1] = param2;
      }
      
      public function switchToWeapon(param1:int) : void
      {
         if(_hasWeapon[param1] || param1 == WEAPON_NONE)
         {
            _currentWeapon.value = param1;
         }
      }
      
      public function getCurrentWeapon() : int
      {
         return _currentWeapon.value;
      }
      
      private function switchToNextWeapon() : void
      {
         if(!(_hasWeapon[0] || _hasWeapon[1] || _hasWeapon[2]))
         {
            return;
         }
         var _loc1_:int = _currentWeapon.value;
         do
         {
            _loc1_++;
            _loc1_ %= 3;
         }
         while(!_hasWeapon[_loc1_]);
         
         switchToWeapon(_loc1_);
      }
      
      private function switchToPrevWeapon() : void
      {
         if(!(_hasWeapon[0] || _hasWeapon[1] || _hasWeapon[2]))
         {
            return;
         }
         var _loc1_:int = _currentWeapon.value;
         do
         {
            _loc1_--;
            _loc1_ += 3;
            _loc1_ %= 3;
         }
         while(!_hasWeapon[_loc1_]);
         
         switchToWeapon(_loc1_);
      }
      
      public function hasTurbo() : Boolean
      {
         return _hasTurbo.value;
      }
      
      private function setHasTurbo(param1:Boolean) : void
      {
         _hasTurbo.value = param1;
         _turboMultiplier.value = _hasTurbo.value ? 0.5 : 1;
      }
      
      public function shootCurrentWeapon() : void
      {
         while(_currentWeapon.value > WEAPON_NONE && !_hasWeapon[_currentWeapon.value])
         {
            --_currentWeapon.value;
         }
         if(_currentWeapon.value == WEAPON_NONE)
         {
            return;
         }
         if(_weaponTimeout.value > 0)
         {
            return;
         }
         var _loc1_:PlayerBullet = _bulletGroups.getBullet(_currentWeapon.value,_hasDevastator.value);
         if(_loc1_)
         {
            var _loc2_:int = -1;
			var _loc3_:Array;
            var _loc4_:Boolean = false;
            if(_jumping || _hasDevastator.value || _loc4_)
            {
               _loc3_ = [1,1,1,1,1,1,1,1];
            }
            else if(_currentWeapon.value == WEAPON_PEA_SHOOTER)
            {
               switch(_gravityDir)
               {
                  case GRAV_LEFT:
                     _loc3_ = [1,1,1,0,0,0,1,1];
                     break;
                  case GRAV_RIGHT:
                     _loc3_ = [0,0,1,1,1,1,1,0];
                     break;
                  case GRAV_UP:
                     _loc3_ = [1,0,0,0,1,1,1,1];
                     break;
                  case GRAV_DOWN:
                     _loc3_ = [1,1,1,1,1,0,0,0];
					 break;
               }
            }
            else
            {
               _loc3_ = [1,1,1,1,1,1,1,1];
            }
            if(pressedUp() && pressedLeft() && _loc3_[3])
            {
               _loc2_ = 3;
            }
            else if(pressedUp() && pressedRight() && _loc3_[1])
            {
               _loc2_ = 1;
            }
            else if(pressedDown() && pressedLeft() && _loc3_[5])
            {
               _loc2_ = 5;
            }
            else if(pressedDown() && pressedRight() && _loc3_[7])
            {
               _loc2_ = 7;
            }
            else if(pressedUp() && _loc3_[2])
            {
               _loc2_ = 2;
            }
            else if(pressedDown() && _loc3_[6])
            {
               _loc2_ = 6;
            }
            else if(pressedLeft() && _loc3_[4])
            {
               _loc2_ = 4;
            }
            else if(pressedRight() && _loc3_[0])
            {
               _loc2_ = 0;
            }
            if(_loc2_ == -1)
            {
               switch(_faceDir)
               {
                  case FACE_FLOOR_LEFT:
                     _loc2_ = 4;
                     break;
                  case FACE_CEIL_LEFT:
                     _loc2_ = 4;
                     break;
                  case FACE_FLOOR_RIGHT:
                     _loc2_ = 0;
                     break;
                  case FACE_CEIL_RIGHT:
                     _loc2_ = 0;
                     break;
                  case FACE_RWALL_UP:
                     _loc2_ = 2;
                     break;
                  case FACE_LWALL_UP:
                     _loc2_ = 2;
                     break;
                  case FACE_RWALL_DOWN:
                     _loc2_ = 6;
                     break;
                  case FACE_LWALL_DOWN:
                     _loc2_ = 6;
					 break;
               }
            }
            var _loc5_:Array = [0,40,90,140,180,-140,-90,-40];
            var _loc6_:int = _loc5_[_loc2_];
            var _loc7_:int = WEAPON_SPEED[_currentWeapon.value] / _turboMultiplier.value;
            var _loc8_:int = Math.cos(_loc6_ * Math.PI / 180) * _loc7_;
            var _loc9_:int = -Math.sin(_loc6_ * Math.PI / 180) * _loc7_;
            _loc1_.shoot(x + width / 2,y + height / 2,_loc8_,_loc9_);
            _weaponTimeout.value = WEAPON_TIMEOUTS[_currentWeapon.value] * _turboMultiplier.value;
         }
      }
      
      public function performGravityJump() : void
      {
         if(FlxG.keys.pressed("SHIFT") && cheatsEnabled)
         {
            return;
         }
         switch(_gravityDir)
         {
            case GRAV_DOWN:
               if((!pressedLeft() && !pressedRight() || _mostRecentDir == DIR_UP) && pressedUp())
               {
                  if(findNotSolidWidth() < 8)
                  {
                     return;
                  }
                  setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                  _desiredGravity = GRAV_UP;
               }
               else if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_RIGHT) && pressedRight())
               {
                  if(findNotSolidHeight() < 8)
                  {
                     return;
                  }
                  setFaceDir(FACE_RWALL_UP);
                  _desiredGravity = GRAV_RIGHT;
               }
               else if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_LEFT) && pressedLeft())
               {
                  if(findNotSolidHeight() < 8)
                  {
                     return;
                  }
                  setFaceDir(FACE_LWALL_UP);
                  _desiredGravity = GRAV_LEFT;
               }
               break;
            case GRAV_UP:
               if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_RIGHT) && pressedRight())
               {
                  if(findNotSolidHeight() < 8)
                  {
                     return;
                  }
                  setFaceDir(FACE_RWALL_DOWN);
                  _desiredGravity = GRAV_RIGHT;
               }
               else if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_LEFT) && pressedLeft())
               {
                  if(findNotSolidHeight() < 8)
                  {
                     return;
                  }
                  setFaceDir(FACE_LWALL_DOWN);
                  _desiredGravity = GRAV_LEFT;
               }
               else if(pressedDown())
               {
                  if(findNotSolidWidth() < 8)
                  {
                     return;
                  }
                  setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                  _desiredGravity = GRAV_DOWN;
               }
               break;
            case GRAV_RIGHT:
               if((!pressedLeft() && !pressedRight() || _mostRecentDir == DIR_UP) && pressedUp())
               {
                  if(findNotSolidWidth() < 8)
                  {
                     return;
                  }
                  setFaceDir(FACE_CEIL_RIGHT);
                  _desiredGravity = GRAV_UP;
               }
               else if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_RIGHT) && pressedRight())
			   {
			   }
			   else
               {
                  if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_LEFT) && pressedLeft())
                  {
                     if(findNotSolidHeight() < 8)
                     {
                        return;
                     }
                     setFaceDir(_faceDir == FACE_RWALL_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                     _desiredGravity = GRAV_LEFT;
                  }
                  else if((!pressedLeft() && !pressedRight() || _mostRecentDir == DIR_DOWN) && pressedDown())
                  {
                     if(findNotSolidWidth() < 8)
                     {
                        return;
                     }
                     setFaceDir(FACE_FLOOR_RIGHT);
                     _desiredGravity = GRAV_DOWN;
                  }
               }
               break;
            case GRAV_LEFT:
               if((!pressedLeft() && !pressedRight() || _mostRecentDir == DIR_UP) && pressedUp())
               {
                  if(findNotSolidWidth() < 8)
                  {
                     return;
                  }
                  setFaceDir(FACE_CEIL_LEFT);
                  _desiredGravity = GRAV_UP;
               }
               else if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_LEFT) && pressedLeft())
			   {
			   }
			   else
               {
                  if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_RIGHT) && pressedRight())
                  {
                     if(findNotSolidHeight() < 8)
                     {
                        return;
                     }
                     setFaceDir(_faceDir == FACE_LWALL_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
                     _desiredGravity = GRAV_RIGHT;
                  }
                  else if((!pressedLeft() && !pressedRight() || _mostRecentDir == DIR_DOWN) && pressedDown())
                  {
                     if(findNotSolidWidth() < 8)
                     {
                        return;
                     }
                     setFaceDir(FACE_FLOOR_LEFT);
                     _desiredGravity = GRAV_DOWN;
                  }
               }
			   break;
         }
         _desiredGravity = GRAV_DOWN;
      }
      
      public function changeSnailSizeCheckBounds(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:int = param1 - param3;
         var _loc6_:int = param2 - param4;
         x = int(x);
         y = int(y);
         if(_loc5_ > 0 && _loc6_ > 0)
         {
            x -= _loc5_;
            y -= _loc6_;
            moveSnailCheckBounds(_loc5_,_loc6_);
         }
         else if(_loc5_ > 0)
         {
            x -= _loc5_;
            moveSnailCheckBounds(_loc5_,0);
         }
         else if(_loc6_ > 0)
         {
            y -= _loc6_;
            moveSnailCheckBounds(0,_loc6_);
         }
      }
      
      public function findNotSolidHeight() : int
      {
         var _loc1_:int = PlayState.worldMap.findFirstNotSolidTop(x,y,width,0,-8);
         var _loc2_:int = PlayState.worldMap.findFirstNotSolidBottom(x,y + height,width,0,8);
         return _loc2_ - _loc1_;
      }
      
      public function findNotSolidWidth() : int
      {
         var _loc1_:int = PlayState.worldMap.findFirstNotSolidLeft(x,y,0,height,-8);
         var _loc2_:int = PlayState.worldMap.findFirstNotSolidRight(x + width,y,0,height,8);
         return _loc2_ - _loc1_;
      }
      
      public function moveSnailCheckFullBounds(param1:int, param2:int) : void
      {
         var _loc3_:int = param2;
         if(param2 < 0)
         {
            param2 = PlayState.worldMap.findFirstFullNotSolidTop(x,y,width,height,param2);
         }
         else if(param2 > 0)
         {
            param2 = PlayState.worldMap.findFirstFullNotSolidBottom(x,y,width,height,param2);
         }
         y += param2;
         if(param1 < 0)
         {
            param1 = PlayState.worldMap.findFirstFullNotSolidLeft(x,y,width,height,param1);
         }
         else if(param1 > 0)
         {
            param1 = PlayState.worldMap.findFirstFullNotSolidRight(x,y,width,height,param1);
         }
         x += param1;
         param2 = _loc3_ - param2;
         if(param2 < 0)
         {
            param2 = PlayState.worldMap.findFirstFullNotSolidTop(x,y,width,height,param2);
         }
         else if(param2 > 0)
         {
            param2 = PlayState.worldMap.findFirstFullNotSolidBottom(x,y,width,height,param2);
         }
         y += param2;
      }
      
      public function moveSnailCheckBounds(param1:int, param2:int) : void
      {
         var _loc3_:int = param2;
         if(param2 < 0)
         {
            param2 = PlayState.worldMap.findFirstNotSolidTop(x,y,width,height,param2);
         }
         else if(param2 > 0)
         {
            param2 = PlayState.worldMap.findFirstNotSolidBottom(x,y,width,height,param2);
         }
         y += param2;
         if(param1 < 0)
         {
            param1 = PlayState.worldMap.findFirstNotSolidLeft(x,y,width,height,param1);
         }
         else if(param1 > 0)
         {
            param1 = PlayState.worldMap.findFirstNotSolidRight(x,y,width,height,param1);
         }
         x += param1;
         param2 = _loc3_ - param2;
         if(param2 < 0)
         {
            param2 = PlayState.worldMap.findFirstNotSolidTop(x,y,width,height,param2);
         }
         else if(param2 > 0)
         {
            param2 = PlayState.worldMap.findFirstNotSolidBottom(x,y,width,height,param2);
         }
         y += param2;
      }
      
      private function fixGravity() : void
      {
         if(_justHitSteps)
         {
            _justHitSteps = false;
            return;
         }
         switch(_gravityDir)
         {
            case GRAV_UP:
               _jumping = velocity.y != 0;
               if(_jumping)
               {
                  ++_fallFrames;
               }
               else
               {
                  _fallFrames = 0;
               }
               if(!_hasGravityJump.value && _fallFrames >= 1 || flickering() && !_hasGravityJump.value)
               {
                  setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
               }
               else if(_hasGravityJump.value && _fallFrames == 1 && pressedUp() && pressedRight())
               {
                  setFaceDir(FACE_LWALL_UP);
                  moveSnailCheckBounds(0,-1);
               }
               else if(_hasGravityJump.value && _fallFrames == 1 && pressedUp() && pressedLeft())
               {
                  setFaceDir(FACE_RWALL_UP);
                  moveSnailCheckBounds(12,-1);
               }
               else if(_hasGravityJump.value && !pressedJump() && _fallFrames == 1 && !pressedUp())
               {
                  _desiredGravity = GRAV_UP;
                  switch(_desiredGravity)
                  {
                     case GRAV_DOWN:
                        setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                        break;
                     case GRAV_UP:
                        setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                        break;
                     case GRAV_LEFT:
                        setFaceDir(_mostRecentUpDown == DIR_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                        break;
                     case GRAV_RIGHT:
                        setFaceDir(_mostRecentUpDown == DIR_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
						break;
                  }
               }
               break;
            case GRAV_DOWN:
               if(_fallFrames == 1 && pressedDown() && !_justHitHeadOrWall && !flickering() && velocity.y > 0)
               {
                  if(facing == RIGHT && pressedRight())
                  {
                     setFaceDir(FACE_LWALL_DOWN,false,true);
                     velocity.x = -_runSpeed.value;
                     moveSnailCheckBounds(0,-11);
                  }
                  else if(facing == LEFT && pressedLeft())
                  {
                     setFaceDir(FACE_RWALL_DOWN,false,true);
                     velocity.x = _runSpeed.value;
                     moveSnailCheckBounds(15,-11);
                  }
                  break;
               }
               _jumping = velocity.y != 0;
               if(_jumping)
               {
                  ++_fallFrames;
               }
               else
               {
                  _fallFrames = 0;
               }
               if(_fallFrames == 1 || flickering())
               {
                  if(facing == RIGHT)
                  {
                     setFaceDir(FACE_FLOOR_RIGHT);
                  }
                  else
                  {
                     setFaceDir(FACE_FLOOR_LEFT);
                  }
               }
               break;
            case GRAV_LEFT:
               _jumping = velocity.x != 0;
               if(_jumping)
               {
                  ++_fallFrames;
               }
               else
               {
                  _fallFrames = 0;
               }
               if(!_hasGravityJump.value && _fallFrames >= 1 || flickering() && !_hasGravityJump.value)
               {
                  setFaceDir(FACE_FLOOR_LEFT);
                  moveSnailCheckBounds(0,13);
               }
               else if(_hasGravityJump.value && _fallFrames == 1 && pressedUp() && pressedLeft())
               {
                  setFaceDir(FACE_FLOOR_LEFT);
                  moveSnailCheckBounds(0,13);
               }
               else if(_hasGravityJump.value && _fallFrames == 1 && pressedDown() && pressedLeft())
               {
                  setFaceDir(FACE_CEIL_LEFT);
                  moveSnailCheckBounds(0,1);
               }
               else if(_hasGravityJump.value && !pressedJump() && _fallFrames == 1 && !pressedLeft())
               {
                  _desiredGravity = GRAV_LEFT;
                  switch(_desiredGravity)
                  {
                     case GRAV_DOWN:
                        setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                        break;
                     case GRAV_UP:
                        setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                        break;
                     case GRAV_LEFT:
                        setFaceDir(_mostRecentUpDown == DIR_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                        break;
                     case GRAV_RIGHT:
                        setFaceDir(_mostRecentUpDown == DIR_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
						break;
                  }
               }
               break;
            case GRAV_RIGHT:
               _jumping = velocity.x != 0;
               if(_jumping)
               {
                  ++_fallFrames;
               }
               else
               {
                  _fallFrames = 0;
               }
               if(!_hasGravityJump.value && _fallFrames >= 1 || flickering() && !_hasGravityJump.value)
               {
                  setFaceDir(FACE_FLOOR_RIGHT);
                  moveSnailCheckBounds(-6,13);
               }
               else if(_hasGravityJump.value && _fallFrames == 1 && pressedUp() && pressedRight())
               {
                  setFaceDir(FACE_FLOOR_RIGHT);
                  moveSnailCheckBounds(-6,13);
               }
               else if(_hasGravityJump.value && _fallFrames == 1 && pressedDown() && pressedRight())
               {
                  setFaceDir(FACE_CEIL_RIGHT);
                  moveSnailCheckBounds(-6,1);
               }
               else if(_hasGravityJump.value && !pressedJump() && _fallFrames == 1 && !pressedRight())
               {
                  _desiredGravity = GRAV_RIGHT;
                  switch(_desiredGravity)
                  {
                     case GRAV_DOWN:
                        setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                        break;
                     case GRAV_UP:
                        setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                        break;
                     case GRAV_LEFT:
                        setFaceDir(_mostRecentUpDown == DIR_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                        break;
                     case GRAV_RIGHT:
                        setFaceDir(_mostRecentUpDown == DIR_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
						break;
                  }
               }
			   break;
         }
      }
      
      public function doJump() : void
      {
         if(_jumping)
         {
            return;
         }
         hideInShell(false);
         if(_hasGravityJump.value)
         {
            if(doGravityJump())
            {
               Sfx.playJump1();
            }
         }
         else if(doRegularJump())
         {
            Sfx.playJump1();
         }
      }
      
      private function doGravityJump() : Boolean
      {
         switch(_gravityDir)
         {
            case GRAV_UP:
               if(findNotSolidHeight() >= 8)
               {
                  y += 1;
                  velocity.y = _jumpPower.value;
                  return true;
               }
               break;
            case GRAV_DOWN:
               if(findNotSolidHeight() >= 8)
               {
                  y -= 1;
                  velocity.y = -_jumpPower.value;
                  return true;
               }
               break;
            case GRAV_LEFT:
               if(findNotSolidWidth() >= 8)
               {
                  x -= 1;
                  velocity.x = _jumpPower.value;
                  return true;
               }
               break;
            case GRAV_RIGHT:
               if(findNotSolidWidth() >= 8)
               {
                  x += 1;
                  velocity.x = -_jumpPower.value;
                  return true;
               }
               break;
         }
         return false;
      }
      
      private function doRegularJump() : Boolean
      {
         switch(_gravityDir)
         {
            case GRAV_UP:
               if(findNotSolidHeight() >= 8)
               {
                  y += 1;
                  velocity.y = 0;
                  setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                  return true;
               }
               break;
            case GRAV_DOWN:
               if(findNotSolidHeight() >= 8)
               {
                  y -= 1;
                  velocity.y = -_jumpPower.value;
                  return true;
               }
               break;
            case GRAV_LEFT:
               if(findNotSolidWidth() >= 8 && !(pressedLeft() && (pressedUp() || pressedDown())))
               {
                  velocity.y = 0;
                  velocity.x = 100;
                  setFaceDir(FACE_FLOOR_LEFT);
                  return true;
               }
               break;
            case GRAV_RIGHT:
               if(findNotSolidWidth() >= 8 && !(pressedRight() && (pressedUp() || pressedDown())))
               {
                  velocity.y = 0;
                  velocity.x = -100;
                  x -= 11;
                  setFaceDir(FACE_FLOOR_RIGHT);
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function setHighJump(param1:Boolean) : void
      {
         _hasHighJump.value = param1;
         _jumpPower.value = _hasHighJump.value ? HIGH_JUMP : REGULAR_JUMP;
      }
      
      public function isIcy() : Boolean
      {
         return _hasColdFoot.value;
      }
      
      public function setSnailType(param1:int) : void
      {
         _snailType.value = param1;
         _snailTypePrefix = "snail" + param1.toString() + "_";
         _hasColdFoot.value = param1 >= SNAILTYPE_ICE;
         _hasGravityJump.value = param1 >= SNAILTYPE_GRAVITY;
         _hasArmor.value = param1 >= SNAILTYPE_METAL;
         if(_hasArmor.value)
         {
            _runSpeed.value = _slugMode ? 480 : 330;
            _maxSpeed.value = 550;
            _gravity.value = _slugMode ? 900 : 1200;
         }
         else if(_hasGravityJump.value)
         {
            _runSpeed.value = _slugMode ? 370 : 260;
            _maxSpeed.value = 500;
            _gravity.value = _slugMode ? 900 : 1200;
         }
         else if(_hasColdFoot.value)
         {
            _runSpeed.value = _slugMode ? 370 : 260;
            _maxSpeed.value = 500;
            _gravity.value = _slugMode ? 900 : 1200;
         }
         else
         {
            _runSpeed.value = _slugMode ? 370 : 260;
            _maxSpeed.value = 500;
            _gravity.value = _slugMode ? 900 : 1200;
         }
         setFaceDir(_faceDir,true);
      }
      
      public function playAnim(param1:String) : void
      {
         play(_snailTypePrefix + param1);
      }
      
      public function setGravityDir(param1:int) : void
      {
         _gravityDir = param1;
         switch(_gravityDir)
         {
            case GRAV_DOWN:
               acceleration.x = 0;
               acceleration.y = _gravity.value;
               drag.x = _runSpeed.value * 200;
               drag.y = 0;
               break;
            case GRAV_RIGHT:
               acceleration.x = _gravity.value;
               acceleration.y = 0;
               drag.y = _runSpeed.value * 200;
               drag.x = 0;
               break;
            case GRAV_UP:
               acceleration.x = 0;
               acceleration.y = -_gravity.value;
               drag.x = _runSpeed.value * 200;
               drag.y = 0;
               break;
            case GRAV_LEFT:
               acceleration.x = -_gravity.value;
               acceleration.y = 0;
               drag.y = _runSpeed.value * 200;
               drag.x = 0;
			   break;
         }
      }
      
      public function hideInShell(param1:Boolean) : void
      {
         if(!_hidingInShell && param1)
         {
            Sfx.playShell();
         }
         _hidingInShell = param1;
         PlayState.zzz.visible = false;
         setFaceDir(_faceDir,true);
      }
      
      public function realTeleport() : void
      {
         var _loc1_:XMLList = null;
         setCurHp(PlayState.player._maxHp.value);
         dead = false;
         solid = true;
         if(PlayState.bossRush)
         {
            setCurHp(99999);
            x = BOSSRUSH_STARTX * 16;
            y = BOSSRUSH_STARTY * 16;
         }
         else
         {
            _loc1_ = PlayState.saveData.xml.vars;
            teleportTo(_loc1_.savex,_loc1_.savey);
         }
         clearInterval(teleportInterval);
         FlxG.fade.stop();
         FlxG.flash.start(2130706432,0.34);
      }
      
      public function teleportTo(param1:int, param2:int) : void
      {
         setFaceDir(FACE_FLOOR_RIGHT,true);
         x = param1;
         y = param2;
         velocity.x = 0;
         velocity.y = 0;
         drag.x = _runSpeed.value * 200;
         drag.y = 0;
         PlayState.worldMap.checkRoomBounds(this);
      }
      
      public function setFaceDirHiding(param1:int) : void
      {
         switch(_faceDir)
         {
            case FACE_FLOOR_LEFT:
               offset.x = 0 + 13;
               width = 32 - 13 - 7;
               offset.y = 16 + 3;
               height = 16 - 3;
               setGravityDir(GRAV_DOWN);
               playAnim("floor_right_hide");
               _hideOfsX = 9;
               x += _hideOfsX;
               _hideOfsY = 0;
               y += _hideOfsY;
               break;
            case FACE_FLOOR_RIGHT:
               offset.x = 0 + 7;
               width = 32 - 7 - 13;
               offset.y = 16 + 3;
               height = 16 - 3;
               setGravityDir(GRAV_DOWN);
               _hideOfsX = 3;
               x += _hideOfsX;
               _hideOfsY = 0;
               y += _hideOfsY;
               playAnim("floor_right_hide");
               break;
            case FACE_CEIL_LEFT:
               offset.x = 0 + 13;
               width = 32 - 13 - 7;
               offset.y = 0 + 0;
               height = 16 - 6;
               setGravityDir(GRAV_UP);
               playAnim("ceil_right_hide");
               _hideOfsX = 9;
               x += _hideOfsX;
               break;
            case FACE_CEIL_RIGHT:
               offset.x = 0 + 7;
               width = 32 - 7 - 13;
               offset.y = 0 + 0;
               height = 16 - 6;
               setGravityDir(GRAV_UP);
               playAnim("ceil_right_hide");
               _hideOfsX = 3;
               x += _hideOfsX;
               break;
            case FACE_RWALL_UP:
               offset.y = 0 + 13;
               height = 32 - 13 - 7;
               offset.x = 16 + 6;
               width = 16 - 6;
               setGravityDir(GRAV_RIGHT);
               playAnim("rwall_up_hide");
               facing = RIGHT;
               _hideOfsY = 9;
               y += _hideOfsY;
               _hideOfsX = 3;
               x += _hideOfsX;
               break;
            case FACE_RWALL_DOWN:
               offset.y = 0 + 7;
               height = 32 - 7 - 13;
               offset.x = 16 + 6;
               width = 16 - 6;
               setGravityDir(GRAV_RIGHT);
               playAnim("rwall_down_hide");
               facing = RIGHT;
               _hideOfsY = 3;
               y += _hideOfsY;
               _hideOfsX = 3;
               x += _hideOfsX;
               break;
            case FACE_LWALL_UP:
               offset.y = 0 + 13;
               height = 32 - 13 - 7;
               offset.x = 0 + 0;
               width = 16 - 6;
               setGravityDir(GRAV_LEFT);
               playAnim("rwall_up_hide");
               facing = LEFT;
               _hideOfsY = 9;
               y += _hideOfsY;
               break;
            case FACE_LWALL_DOWN:
               offset.y = 0 + 7;
               height = 32 - 7 - 13;
               offset.x = 0 + 0;
               width = 16 - 6;
               setGravityDir(GRAV_LEFT);
               playAnim("rwall_down_hide");
               facing = LEFT;
               _hideOfsY = 3;
               y += _hideOfsY;
			   break;
         }
      }
      
      public function setFaceDirNotHiding(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = offset.x;
         var _loc4_:int = offset.y;
         var _loc5_:int = width;
         var _loc6_:int = height;
         switch(_faceDir)
         {
            case FACE_FLOOR_LEFT:
            case FACE_FLOOR_RIGHT:
               offset.x = 0 + 4;
               width = 32 - 4 - 4;
               offset.y = 16 + 3;
               height = 16 - 3;
               changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               setGravityDir(GRAV_DOWN);
               playAnim("floor_right_move");
               break;
            case FACE_CEIL_LEFT:
            case FACE_CEIL_RIGHT:
               offset.x = 0 + 4;
               width = 32 - 4 - 4;
               offset.y = 0 + 0;
               height = 16 - 3;
               changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               setGravityDir(GRAV_UP);
               playAnim("ceil_right_move");
               break;
            case FACE_RWALL_UP:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 16 + 3;
               width = 16 - 3;
               if(!param2)
               {
                  changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               }
               setGravityDir(GRAV_RIGHT);
               playAnim("rwall_up_move");
               facing = RIGHT;
               break;
            case FACE_RWALL_DOWN:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 16 + 3;
               width = 16 - 3;
               if(!param2)
               {
                  changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               }
               setGravityDir(GRAV_RIGHT);
               playAnim("rwall_down_move");
               facing = RIGHT;
               break;
            case FACE_LWALL_UP:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 0 + 0;
               width = 16 - 3;
               if(!param2)
               {
                  changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               }
               setGravityDir(GRAV_LEFT);
               playAnim("rwall_up_move");
               facing = LEFT;
               break;
            case FACE_LWALL_DOWN:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 0 + 0;
               width = 16 - 3;
               if(!param2)
               {
                  changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               }
               setGravityDir(GRAV_LEFT);
               playAnim("rwall_down_move");
               facing = LEFT;
			   break;
         }
      }
      
      public function setFaceDir(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         if(_faceDir == param1 && !param2)
         {
            return;
         }
         _faceDir = param1;
         moveSnailCheckBounds(-_hideOfsX,-_hideOfsY);
         _hideOfsX = 0;
         _hideOfsY = 0;
         if(_hidingInShell)
         {
            setFaceDirHiding(_faceDir);
         }
         else
         {
            setFaceDirNotHiding(_faceDir,param3);
         }
      }
      
      public function setCurHp(param1:int) : void
      {
         _curHp.value = param1;
         if(_curHp.value > _maxHp.value)
         {
            _curHp.value = _maxHp.value;
         }
         PlayState.hud.heartHud.setCurHp(_curHp.value,this);
         if(_curHp.value <= 0)
         {
            kill();
         }
      }
      
      public function getCurHp() : int
      {
         return _curHp.value;
      }
      
      public function getMaxHp() : int
      {
         return _maxHp.value;
      }
      
      public function setMaxHp(param1:int) : void
      {
         _maxHp.value = param1;
         if(_maxHp.value > hpPerHeart() * MAX_HEART_CONTAINERS)
         {
            _maxHp.value = hpPerHeart() * MAX_HEART_CONTAINERS;
         }
         setCurHp(_maxHp.value);
         PlayState.hud.heartHud.setMaxHp(_maxHp.value,this);
         PlayState.hud.heartHud.setCurHp(_maxHp.value,this);
      }
      
      public function addHeartContainer() : void
      {
         setMaxHp(_maxHp.value + hpPerHeart());
      }
      
      public function justPressedShoot() : Boolean
      {
         if(firingMode == FIRING_MODE_NORMAL)
         {
            return FlxG.keys.justPressed(SHOOT_KEY) || FlxG.keys.justPressed(ALT_SHOOT_KEY) || FlxG.keys.justPressed(STRAFE_KEY) || FlxG.keys.justPressed(ALT_STRAFE_KEY);
         }
         return FlxG.keys.justPressed(SHOOT_KEY) || FlxG.keys.justPressed(ALT_SHOOT_KEY);
      }
      
      public function pressedStrafe() : Boolean
      {
         return FlxG.keys.pressed(STRAFE_KEY) || FlxG.keys.pressed(ALT_STRAFE_KEY);
      }
      
      public function pressedShoot() : Boolean
      {
         if(firingMode == FIRING_MODE_NORMAL)
         {
            return FlxG.keys.pressed(SHOOT_KEY) || FlxG.keys.pressed(ALT_SHOOT_KEY) || FlxG.keys.pressed(STRAFE_KEY) || FlxG.keys.pressed(ALT_STRAFE_KEY);
         }
         return FlxG.keys.pressed(SHOOT_KEY) || FlxG.keys.pressed(ALT_SHOOT_KEY);
      }
      
      public function justPressedJump() : Boolean
      {
         return FlxG.keys.justPressed(JUMP_KEY) || FlxG.keys.justPressed(ALT_JUMP_KEY);
      }
      
      public function pressedJump() : Boolean
      {
         return FlxG.keys.pressed(JUMP_KEY) || FlxG.keys.pressed(ALT_JUMP_KEY);
      }
      
      public function justPressedUp() : Boolean
      {
         return FlxG.keys.justPressed(UP_KEY) || FlxG.keys.justPressed(ALT_UP_KEY);
      }
      
      public function justPressedDown() : Boolean
      {
         return FlxG.keys.justPressed(DOWN_KEY) || FlxG.keys.justPressed(ALT_DOWN_KEY);
      }
      
      public function justPressedLeft() : Boolean
      {
         return FlxG.keys.justPressed(LEFT_KEY) || FlxG.keys.justPressed(ALT_LEFT_KEY);
      }
      
      public function justPressedRight() : Boolean
      {
         return FlxG.keys.justPressed(RIGHT_KEY) || FlxG.keys.justPressed(ALT_RIGHT_KEY);
      }
      
      public function pressedUp() : Boolean
      {
         return FlxG.keys.pressed(UP_KEY) || FlxG.keys.pressed(ALT_UP_KEY);
      }
      
      public function pressedDown() : Boolean
      {
         return FlxG.keys.pressed(DOWN_KEY) || FlxG.keys.pressed(ALT_DOWN_KEY);
      }
      
      public function pressedLeft() : Boolean
      {
         return FlxG.keys.pressed(LEFT_KEY) || FlxG.keys.pressed(ALT_LEFT_KEY);
      }
      
      public function pressedRight() : Boolean
      {
         return FlxG.keys.pressed(RIGHT_KEY) || FlxG.keys.pressed(ALT_RIGHT_KEY);
      }
      
      public function saveGame() : void
      {
         var _loc1_:XMLList = PlayState.saveData.xml.vars;
         var _loc2_:int = _loc1_.savex;
         var _loc3_:int = _loc1_.savey;
         setSaveCoords(_loc2_,_loc3_,true);
      }
      
      public function saveNoCoords() : void
      {
         if(PlayState.bossRush)
         {
            return;
         }
         var _loc1_:int = PlayState.config.getPlayerStartX() * 16;
         var _loc2_:int = PlayState.config.getPlayerStartY() * 16;
         var _loc3_:SaveData = PlayState.saveData;
         if(_loc3_.isVarSet("savex"))
         {
            _loc1_ = _loc3_.xml.vars.savex;
         }
         if(_loc3_.isVarSet("savey"))
         {
            _loc2_ = _loc3_.xml.vars.savey;
         }
         setSaveCoords(_loc1_,_loc2_,true);
      }
      
      public function setSaveCoords(param1:int, param2:int, param3:Boolean = false) : void
      {
         if(dead || !active)
         {
            return;
         }
         if(!param3)
         {
            PlayState.savingText.setSaving();
         }
         var _loc4_:XML = new XML(<vars/>);
         _loc4_.appendChild(<savex>{param1}</savex>);
         _loc4_.appendChild(<savey>{param2}</savey>);
         _loc4_.appendChild(<lastWeapon>{_currentWeapon.value}</lastWeapon>);
         if(firingMode)
         {
            _loc4_.appendChild(<toggleFire>true</toggleFire>);
         }
         if(_hasTurbo.value)
         {
            _loc4_.appendChild(<hasTurbo>true</hasTurbo>);
         }
         if(_hasHighJump.value)
         {
            _loc4_.appendChild(<hasHighJump>true</hasHighJump>);
         }
         if(_hasDevastator.value)
         {
            _loc4_.appendChild(<hasDevastator>true</hasDevastator>);
         }
         if(_hasGravityShock.value)
         {
            _loc4_.appendChild(<hasGravityShock>true</hasGravityShock>);
         }
         if(_hasShellShield.value)
         {
            _loc4_.appendChild(<hasShellShield>true</hasShellShield>);
         }
         if(PlayState.hasGoodEnding)
         {
            _loc4_.appendChild(<hasGoodEnding>true</hasGoodEnding>);
         }
         if(PlayState.hideMiniMap)
         {
            _loc4_.appendChild(<hideMiniMap>true</hideMiniMap>);
         }
         if(PlayState.hideTab)
         {
            _loc4_.appendChild(<hideTab>true</hideTab>);
         }
         _loc4_.appendChild(<snailType>{_snailType.value}</snailType>);
         _loc4_.appendChild(<maxHp>{_maxHp.value}</maxHp>);
         if(PlayState.bossesKilled[1])
         {
            _loc4_.appendChild(<bossesKilledOne>true</bossesKilledOne>);
         }
         if(PlayState.bossesKilled[2])
         {
            _loc4_.appendChild(<bossesKilledTwo>true</bossesKilledTwo>);
         }
         if(PlayState.bossesKilled[3])
         {
            _loc4_.appendChild(<bossesKilledThree>true</bossesKilledThree>);
         }
         if(PlayState.bossesKilled[4])
         {
            _loc4_.appendChild(<bossesKilledFour>true</bossesKilledFour>);
         }
         if(_easyMode)
         {
            _loc4_.appendChild(<easyMode>true</easyMode>);
         }
         if(_hardMode)
         {
            _loc4_.appendChild(<hardMode>true</hardMode>);
         }
         if(_insaneMode)
         {
            _loc4_.appendChild(<insaneMode>true</insaneMode>);
         }
         if(_hasWeapon[0])
         {
            _loc4_.appendChild(<hasWeaponZero>true</hasWeaponZero>);
         }
         if(_hasWeapon[1])
         {
            _loc4_.appendChild(<hasWeaponOne>true</hasWeaponOne>);
         }
         if(_hasWeapon[2])
         {
            _loc4_.appendChild(<hasWeaponTwo>true</hasWeaponTwo>);
         }
         _loc4_.appendChild(<gameTime>{gameTime.value}</gameTime>);
         _loc4_.appendChild(<helixFragments>{_helixFragments.value}</helixFragments>);
         if(hasSeenIsis)
         {
            _loc4_.appendChild(<hasSeenIsis>{hasSeenIsis}</hasSeenIsis>);
         }
         if(hasSeenHelp)
         {
            _loc4_.appendChild(<hasSeenHelp>{hasSeenHelp}</hasSeenHelp>);
         }
         _loc4_.appendChild(<hasWonGame>{hasWonGame}</hasWonGame>);
         _loc4_.appendChild(<hasWonHardMode>{hasWonHardMode}</hasWonHardMode>);
         _loc4_.appendChild(<hasWonInsaneMode>{hasWonInsaneMode}</hasWonInsaneMode>);
         _loc4_.appendChild(<hasFullClear>{hasFullClear}</hasFullClear>);
         _loc4_.appendChild(<hasWonBossRush>{hasWonBossRush}</hasWonBossRush>);
         _loc4_.appendChild(<bestBossRushTime>{bestBossRushTime.value}</bestBossRushTime>);
         _loc4_.appendChild(<bestMainTime>{bestMainTime.value}</bestMainTime>);
         _loc4_.appendChild(<bestHardTime>{bestHardTime.value}</bestHardTime>);
         _loc4_.appendChild(<bestInsaneTime>{bestInsaneTime.value}</bestInsaneTime>);
         _loc4_.appendChild(<mapKey>{MAP_KEY}</mapKey>);
         _loc4_.appendChild(<jumpKey>{JUMP_KEY}</jumpKey>);
         _loc4_.appendChild(<shootKey>{SHOOT_KEY}</shootKey>);
         _loc4_.appendChild(<strafeKey>{STRAFE_KEY}</strafeKey>);
         _loc4_.appendChild(<upKey>{UP_KEY}</upKey>);
         _loc4_.appendChild(<downKey>{DOWN_KEY}</downKey>);
         _loc4_.appendChild(<leftKey>{LEFT_KEY}</leftKey>);
         _loc4_.appendChild(<rightKey>{RIGHT_KEY}</rightKey>);
         _loc4_.appendChild(<jumpAltKey>{ALT_JUMP_KEY}</jumpAltKey>);
         _loc4_.appendChild(<shootAltKey>{ALT_SHOOT_KEY}</shootAltKey>);
         _loc4_.appendChild(<strafeAltKey>{ALT_STRAFE_KEY}</strafeAltKey>);
         _loc4_.appendChild(<upAltKey>{ALT_UP_KEY}</upAltKey>);
         _loc4_.appendChild(<downAltKey>{ALT_DOWN_KEY}</downAltKey>);
         _loc4_.appendChild(<leftAltKey>{ALT_LEFT_KEY}</leftAltKey>);
         _loc4_.appendChild(<rightAltKey>{ALT_RIGHT_KEY}</rightAltKey>);
         _loc4_.appendChild(<weap1Key>{WEAPON_1_KEY}</weap1Key>);
         _loc4_.appendChild(<weap2Key>{WEAPON_2_KEY}</weap2Key>);
         _loc4_.appendChild(<weap3Key>{WEAPON_3_KEY}</weap3Key>);
         _loc4_.appendChild(<weapNextKey>{WEAPON_NEXT_KEY}</weapNextKey>);
         _loc4_.appendChild(<weapPrevKey>{WEAPON_PREV_KEY}</weapPrevKey>);
         delete PlayState.saveData.xml.vars;
         PlayState.saveData.xml.vars = _loc4_;
         PlayState.uniqueBlocks.saveAll();
         PlayState.miniMap.saveAll();
         PlayState.saveData.saveAll();
         if(!param3)
         {
            PlayState.savingText.setSaved();
         }
      }
      
      public function addWeapon(param1:int) : void
      {
         var _loc2_:Boolean = !hasAnyWeapon() && !PlayState.bossRush && !_hardMode;
         _hasWeapon[param1] = true;
         if(_currentWeapon.value < param1)
         {
            switchToWeapon(param1);
         }
         if(_loc2_)
         {
            PlayState.controlHelp.updateLetterGraphics();
            PlayState.controlHelp.show(true);
         }
      }
      
      public function hasWeapon(param1:int) : Boolean
      {
         return _hasWeapon[param1];
      }
      
      public function getHasDevastator() : Boolean
      {
         return _hasDevastator.value;
      }
      
      public function hasArmor() : Boolean
      {
         return _hasArmor.value;
      }
      
      public function hasGravityJump() : Boolean
      {
         return _hasGravityJump.value;
      }
      
      public function hasHighJump() : Boolean
      {
         return _hasHighJump.value;
      }
      
      public function addTurbo() : void
      {
         setHasTurbo(true);
      }
      
      public function addDevastator() : void
      {
         setHasDevastator(true);
      }
      
      public function addGravityJump() : void
      {
         if(!hasArmor())
         {
            setSnailType(SNAILTYPE_GRAVITY);
         }
      }
      
      public function addColdFoot() : void
      {
         if(!hasGravityJump() && !hasArmor())
         {
            setSnailType(SNAILTYPE_ICE);
         }
      }
      
      public function addHighJump() : void
      {
         setHighJump(true);
      }
      
      public function setHasDevastator(param1:Boolean) : void
      {
         _hasDevastator.value = param1;
      }
      
      public function setHelixFragments(param1:int) : void
      {
         _helixFragments.value = param1;
         if(_helixFragments.value > MAX_HELIX_FRAGMENTS)
         {
            _helixFragments.value = MAX_HELIX_FRAGMENTS;
         }
         if(PlayState.miniMap)
         {
            if(_helixFragments.value == 0)
            {
               PlayState.miniMap.subscreen.helixSprite.visible = false;
               PlayState.miniMap.subscreen.helixText.visible = false;
               PlayState.miniMap.subscreen.helixText.text = "x " + _helixFragments.value.toString();
            }
            else
            {
               PlayState.miniMap.subscreen.helixSprite.visible = true;
               PlayState.miniMap.subscreen.helixText.visible = true;
               PlayState.miniMap.subscreen.helixText.text = "x " + _helixFragments.value.toString();
            }
         }
      }
      
      public function getHelixFragments() : int
      {
         return _helixFragments.value;
      }
      
      public function getHasShellShield() : Boolean
      {
         return _hasShellShield.value;
      }
      
      public function setHasShellShield(param1:Boolean) : void
      {
         if(_slugMode)
         {
            return;
         }
         _hasShellShield.value = param1;
      }
      
      public function addShellShield() : void
      {
         if(!_slugMode)
         {
            setHasShellShield(true);
         }
      }
      
      public function setEasyMode(param1:Boolean) : void
      {
         _easyMode = param1;
      }
      
      public function setHardMode(param1:Boolean) : void
      {
         _hardMode = param1;
      }
      
      public function setInsaneMode(param1:Boolean) : void
      {
         _insaneMode = param1;
      }
      
      public function hasGravityShock() : Boolean
      {
         return _hasGravityShock.value;
      }
      
      public function setHasGravityShock(param1:Boolean) : void
      {
      }
      
      public function addGravityShock() : void
      {
      }
      
      public function addHelixFragment() : void
      {
         setHelixFragments(_helixFragments.value + 1);
      }
      
      public function getPercentComplete() : int
      {
         var _loc1_:int = (_hasWeapon[0] ? 1 : 0) + (_hasWeapon[1] ? 1 : 0) + (_hasWeapon[2] ? 1 : 0) + (_hasDevastator.value ? 1 : 0) + (_hasTurbo.value ? 1 : 0) + (_hasHighJump.value ? 1 : 0) + _maxHp.value / hpPerHeart() - STARTING_MAX_HEARTS + (_hasColdFoot.value ? 1 : 0) + (_hasGravityJump.value ? 1 : 0) + (_hasArmor.value ? 1 : 0) + (_hasShellShield.value ? 1 : 0) + _helixFragments.value;
         return _loc1_ * 100 / (_slugMode ? 50 : 51);
      }
      
      public function isParalyzed() : Boolean
      {
         return _paralyzed;
      }
      
      public function paralyze(param1:Boolean) : void
      {
         _paralyzed = param1;
      }
      
      public function addArmor() : void
      {
         setSnailType(SNAILTYPE_METAL);
         _hasArmor.value = true;
      }
   }
}

