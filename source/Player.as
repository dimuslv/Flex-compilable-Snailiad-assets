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
      
      private var WEAPON_TIMEOUTS:Array;
      
      private var WEAPON_SPEED:Array;
      
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
      
      private var _hasWeapon:Array;
      
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
      
      public function Player(param1:PlayerBulletGroups)
      {
         var _loc5_:int = 0;
         this.WEAPON_TIMEOUTS = [0.085,0.3,0.17];
         this.WEAPON_SPEED = [370,330,60];
         this._hasWeapon = [false,false,false];
         super();
         this._easyMode = false;
         this._hardMode = false;
         this._insaneMode = false;
         this._curHp = new CipherInt(STARTING_MAX_HEARTS * this.hpPerHeart());
         this._maxHp = new CipherInt(STARTING_MAX_HEARTS * this.hpPerHeart());
         this._currentWeapon = new CipherInt(WEAPON_NONE);
         this._gravity = new CipherInt(1200);
         this._hasArmor = new CheckBool(false);
         this._hasColdFoot = new CheckBool(false);
         this._hasDevastator = new CheckBool(false);
         this._hasGravityJump = new CheckBool(false);
         this._hasGravityShock = new CheckBool(false);
         this._hasHighJump = new CheckBool(false);
         this._hasShellShield = new CheckBool(false);
         this._hasTurbo = new CheckBool(false);
         this._helixFragments = new CipherInt(0);
         this._jumpPower = new CipherInt(REGULAR_JUMP);
         this._maxSpeed = new CipherInt(500);
         this._runSpeed = new CipherInt(260);
         this._snailType = new CipherInt(SNAILTYPE_NORMAL);
         this._turboMultiplier = new ShadowNumber(1);
         this._weaponTimeout = new ShadowNumber(0);
         this.bestBossRushTime = new ShadowNumber(0);
         this.bestMainTime = new ShadowNumber(0);
         this.bestHardTime = new ShadowNumber(0);
         this.bestInsaneTime = new ShadowNumber(0);
         this.gameTime = new ShadowNumber(0);
         this.clearTime = new ShadowNumber(0);
         this._sleepTimeout = SLEEP_TIMEOUT;
         this._bulletGroups = param1;
         this._paralyzed = false;
         this.hasSetHpBar = false;
         maxVelocity.x = this._maxSpeed.value;
         maxVelocity.y = this._maxSpeed.value;
         this.setMaxHp(STARTING_MAX_HEARTS * this.hpPerHeart());
         this.setCurHp(STARTING_MAX_HEARTS * this.hpPerHeart());
         var _loc2_:SaveData = PlayState.saveData;
         var _loc3_:XMLList = _loc2_.xml.vars;
         if(PlayState.bossRush)
         {
            this.setEasyMode(false);
            this.setHardMode(false);
            this.setInsaneMode(false);
            this.setHasTurbo(false);
            this.setHighJump(false);
            this.setHasDevastator(false);
            this.setHasGravityShock(false);
            this.setHasShellShield(false);
            this.switchToWeapon(-1);
            this.setHelixFragments(0);
            this.setSnailType(SNAILTYPE_NORMAL);
            this.gameTime.value = 0;
            x = BOSSRUSH_STARTX * 16;
            y = BOSSRUSH_STARTY * 16;
         }
         else
         {
            this.setEasyMode(false);
            this.setHardMode(false);
            this.setInsaneMode(false);
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
               _loc3_.gameTime = 0;
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
            this.hasWonGame = _loc2_.isVarTrue("hasWonGame");
            this.hasWonHardMode = _loc2_.isVarTrue("hasWonHardMode");
            this.hasWonInsaneMode = _loc2_.isVarTrue("hasWonInsaneMode");
            this.hasFullClear = _loc2_.isVarTrue("hasFullClear");
            this.hasWonBossRush = _loc2_.isVarTrue("hasWonBossRush");
            PlayState.hideTab = _loc2_.isVarTrue("hideTab");
            PlayState.hideMiniMap = _loc2_.isVarTrue("hideMiniMap");
            PlayState.hasGoodEnding = _loc2_.isVarTrue("hasGoodEnding");
            this.setEasyMode(_loc2_.isVarTrue("easyMode"));
            this.setHardMode(_loc2_.isVarTrue("hardMode"));
            this.setInsaneMode(_loc2_.isVarTrue("insaneMode"));
            this._slugMode = this._hardMode && !this._insaneMode;
            if(this._slugMode)
            {
               this.WEAPON_TIMEOUTS[0] = 0.046;
               this.WEAPON_TIMEOUTS[1] = 0.23;
               this.WEAPON_TIMEOUTS[2] = 0.13;
            }
            if(!_loc2_.isVarSet("maxHp"))
            {
               _loc3_.maxHp = STARTING_MAX_HEARTS * this.hpPerHeart();
            }
            this.setMaxHp(_loc3_.maxHp);
            this.setCurHp(999999999);
            this.bestMainTime.value = _loc3_.bestMainTime;
            this.bestHardTime.value = _loc3_.bestHardTime;
            this.bestBossRushTime.value = _loc3_.bestBossRushTime;
            this.bestInsaneTime.value = _loc3_.bestInsaneTime;
            this.gameTime.value = _loc3_.gameTime;
            this.setHasWeapon(0,_loc2_.isVarTrue("hasWeaponZero"));
            this.setHasWeapon(1,_loc2_.isVarTrue("hasWeaponOne"));
            this.setHasWeapon(2,_loc2_.isVarTrue("hasWeaponTwo"));
            this.setHasTurbo(_loc2_.isVarTrue("hasTurbo"));
            if(_loc2_.isVarTrue("toggleFire"))
            {
               firingMode = FIRING_MODE_TOGGLE;
            }
            else
            {
               firingMode = FIRING_MODE_NORMAL;
            }
            this.setHighJump(_loc2_.isVarTrue("hasHighJump"));
            this.setHasDevastator(_loc2_.isVarTrue("hasDevastator"));
            this.setHasGravityShock(_loc2_.isVarTrue("hasGravityShock"));
            this.setHasShellShield(_loc2_.isVarTrue("hasShellShield"));
            this.switchToWeapon(_loc3_.lastWeapon);
            this.setHelixFragments(_loc3_.helixFragments);
            this.setSnailType(_loc3_.snailType);
            this.hasSeenIsis = _loc2_.isVarTrue("hasSeenIsis");
            this.hasSeenHelp = _loc2_.isVarTrue("hasSeenHelp");
            PlayState.bossesKilled[1] = _loc2_.isVarTrue("bossesKilledOne");
            PlayState.bossesKilled[2] = _loc2_.isVarTrue("bossesKilledTwo");
            PlayState.bossesKilled[3] = _loc2_.isVarTrue("bossesKilledThree");
            PlayState.bossesKilled[4] = _loc2_.isVarTrue("bossesKilledFour");
            if(this.bestMainTime.value > 0 || this.bestHardTime.value > 0)
            {
               NgMedal.unlockFirstOfFour();
               NgMedal.unlockStinkyToe();
               NgMedal.unlockGravityBattle();
               NgMedal.unlockVictory();
            }
            if(this.bestHardTime.value > 0)
            {
               NgMedal.unlockHomeless();
            }
            if(this.bestInsaneTime.value > 0)
            {
               NgMedal.unlockHappyEnding();
            }
            if(this.bestBossRushTime.value > 0)
            {
               NgMedal.unlockTheGauntlet();
            }
            if(this.hasSeenIsis)
            {
               NgMedal.unlockPilgrim();
            }
            if(Boolean(PlayState.bossesKilled[1]) && !this._easyMode)
            {
               NgMedal.unlockFirstOfFour();
            }
            if(Boolean(PlayState.bossesKilled[2]) && !this._easyMode)
            {
               NgMedal.unlockStinkyToe();
            }
            if(Boolean(PlayState.bossesKilled[3]) && !this._easyMode)
            {
               NgMedal.unlockGravityBattle();
            }
            if(Boolean(PlayState.bossesKilled[4]) && !this._easyMode)
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
               this.saveOnNextFrame = true;
            }
         }
         this.setGravityDir(GRAV_DOWN);
         this._slugMode = this._hardMode;
         loadGraphic(Art.SnailySnail,true,true,SPRITE_WIDTH,SPRITE_HEIGHT);
         var _loc4_:int = 0;
         while(_loc4_ < 4)
         {
            _loc5_ = _loc4_ * 20;
            if(this._slugMode)
            {
               _loc5_ += 4 * 20;
            }
            addAnimation("snail" + (_loc4_ + 1).toString() + "_floor_right_move",[0 + _loc5_,1 + _loc5_],3,true);
            addAnimation("snail" + (_loc4_ + 1).toString() + "_floor_right_hide",[3 + _loc5_],9,false);
            addAnimation("snail" + (_loc4_ + 1).toString() + "_rwall_up_move",[4 + _loc5_,5 + _loc5_],3,true);
            addAnimation("snail" + (_loc4_ + 1).toString() + "_rwall_up_hide",[7 + _loc5_],9,false);
            addAnimation("snail" + (_loc4_ + 1).toString() + "_rwall_down_move",[8 + _loc5_,9 + _loc5_],3,true);
            addAnimation("snail" + (_loc4_ + 1).toString() + "_rwall_down_hide",[11 + _loc5_],9,false);
            addAnimation("snail" + (_loc4_ + 1).toString() + "_ceil_right_move",[12 + _loc5_,13 + _loc5_],3,true);
            addAnimation("snail" + (_loc4_ + 1).toString() + "_ceil_right_hide",[15 + _loc5_],9,false);
            addAnimation("snail" + (_loc4_ + 1).toString() + "_death",[16 + _loc5_,17 + _loc5_,18 + _loc5_,19 + _loc5_],30,true);
            _loc4_++;
         }
         this.setFaceDir(FACE_FLOOR_RIGHT,true);
         this.playAnim("floor_right_move");
      }
      
      public function hpPerHeart() : int
      {
         if(this._easyMode)
         {
            return 8;
         }
         if(this._hardMode)
         {
            return 2;
         }
         return 4;
      }
      
      override public function destroy() : void
      {
         clearInterval(this.deathFadeInterval);
         clearInterval(this.reviveInterval);
         this._bulletGroups = null;
         this._curHp = null;
         this._gravity = null;
         this._hasArmor = null;
         this._hasColdFoot = null;
         this._hasDevastator = null;
         this._hasGravityJump = null;
         this._hasGravityShock = null;
         this._hasHighJump = null;
         this._hasShellShield = null;
         this._hasTurbo = null;
         this._hasWeapon = null;
         this._helixFragments = null;
         this._jumpPower = null;
         this._maxHp = null;
         this._maxSpeed = null;
         this._runSpeed = null;
         this._snailType = null;
         this._turboMultiplier = null;
         this._weaponTimeout = null;
         this.bestBossRushTime = null;
         this.bestMainTime = null;
         this.bestHardTime = null;
         this.bestInsaneTime = null;
         this.gameTime = null;
         this.clearTime = null;
         super.destroy();
      }
      
      public function checkInput_handleMenu() : void
      {
         if((FlxG.keys.justPressed("P") || FlxG.keys.justPressed("ESCAPE")) && !dead && !PlayState.isBossRushComplete && !PlayState.isGameComplete && !this._paralyzed)
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
         if(FlxG.keys.justPressed("F1") && !this.cheatsEnabled)
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
         if(FlxG.keys.getLastKeys(6) == "SKYFIS" && (Boolean(PlayState.bossesKilled[1]) || Boolean(PlayState.bossesKilled[2]) || Boolean(PlayState.bossesKilled[3]) || Boolean(PlayState.bossesKilled[4])))
         {
            Sfx.playSlugMode();
            PlayState.bossesKilled[1] = false;
            PlayState.bossesKilled[2] = false;
            PlayState.bossesKilled[3] = false;
            PlayState.bossesKilled[4] = false;
            this.saveNoCoords();
            PlayState.hud.areaName.setArea("- SKYFISH FLIES AGAIN -");
         }
      }
      
      public function checkInput_handleSlugCheat() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!PlayState.bossRush || PlayState.bossRushTimer.started || this._slugMode)
         {
            return;
         }
         if(FlxG.keys.getLastKeys(4) == "SLUG")
         {
            Sfx.playSlugMode();
            this.hideInShell(false);
            this._maxHp.value /= this.hpPerHeart();
            this._slugMode = true;
            this._hardMode = true;
            this._maxHp.value *= this.hpPerHeart();
            this.setMaxHp(this.getMaxHp());
            this.setCurHp(999999999);
            this.WEAPON_TIMEOUTS[0] = 0.046;
            this.WEAPON_TIMEOUTS[1] = 0.23;
            this.WEAPON_TIMEOUTS[2] = 0.13;
            _animations = new Array();
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               _loc2_ = _loc1_ * 20;
               if(this._slugMode)
               {
                  _loc2_ += 4 * 20;
               }
               addAnimation("snail" + (_loc1_ + 1).toString() + "_floor_right_move",[0 + _loc2_,1 + _loc2_],3,true);
               addAnimation("snail" + (_loc1_ + 1).toString() + "_floor_right_hide",[3 + _loc2_],9,false);
               addAnimation("snail" + (_loc1_ + 1).toString() + "_rwall_up_move",[4 + _loc2_,5 + _loc2_],3,true);
               addAnimation("snail" + (_loc1_ + 1).toString() + "_rwall_up_hide",[7 + _loc2_],9,false);
               addAnimation("snail" + (_loc1_ + 1).toString() + "_rwall_down_move",[8 + _loc2_,9 + _loc2_],3,true);
               addAnimation("snail" + (_loc1_ + 1).toString() + "_rwall_down_hide",[11 + _loc2_],9,false);
               addAnimation("snail" + (_loc1_ + 1).toString() + "_ceil_right_move",[12 + _loc2_,13 + _loc2_],3,true);
               addAnimation("snail" + (_loc1_ + 1).toString() + "_ceil_right_hide",[15 + _loc2_],9,false);
               addAnimation("snail" + (_loc1_ + 1).toString() + "_death",[16 + _loc2_,17 + _loc2_,18 + _loc2_,19 + _loc2_],30,true);
               _loc1_++;
            }
            this.playAnim("death");
            this.setSnailType(this._snailType.value);
            PlayState.hud.areaName.setArea("- OMEGA SLUG ENGAGE -");
         }
      }
      
      public function checkInput_hideInShell() : void
      {
         if(this._slugMode)
         {
            return;
         }
         if(firingMode == FIRING_MODE_NORMAL && this.pressedShoot())
         {
            return;
         }
         if(firingMode == FIRING_MODE_TOGGLE && this.pressedStrafe())
         {
            return;
         }
         if(flickering() || dead)
         {
            return;
         }
         if(this._gravityDir == GRAV_DOWN && this.justPressedDown() || this._gravityDir == GRAV_UP && this.justPressedUp())
         {
            if(!this.pressedLeft() && !this.pressedRight() || this._hidingInShell)
            {
               this.hideInShell(!this._hidingInShell);
            }
         }
         if(this._gravityDir == GRAV_LEFT && this.justPressedLeft() || this._gravityDir == GRAV_RIGHT && this.justPressedRight())
         {
            if(!this.pressedUp() && !this.pressedDown() || this._hidingInShell)
            {
               this.hideInShell(!this._hidingInShell);
            }
         }
      }
      
      public function checkInput_shoot() : void
      {
         if(firingMode == FIRING_MODE_TOGGLE)
         {
            if(this.justPressedShoot() && this.hasAnyWeapon())
            {
               fireToggle = !fireToggle;
            }
         }
         else
         {
            fireToggle = this.pressedShoot();
         }
         if(fireToggle && !this._hidingInShell)
         {
            this.shootCurrentWeapon();
         }
         if(this.justPressedShoot() && this._hidingInShell && this.hasAnyWeapon())
         {
            this.hideInShell(false);
            this.shootCurrentWeapon();
         }
      }
      
      public function checkInput_switchWeapons() : void
      {
         if(FlxG.keys.justPressed(WEAPON_1_KEY))
         {
            this.switchToWeapon(0);
         }
         if(FlxG.keys.justPressed(WEAPON_2_KEY))
         {
            this.switchToWeapon(1);
         }
         if(FlxG.keys.justPressed(WEAPON_3_KEY))
         {
            this.switchToWeapon(2);
         }
         if(FlxG.keys.justPressed(WEAPON_NEXT_KEY))
         {
            this.switchToNextWeapon();
         }
         if(FlxG.keys.justPressed(WEAPON_PREV_KEY))
         {
            this.switchToPrevWeapon();
         }
      }
      
      public function checkInput_performGravityJump() : void
      {
         if(this._hasGravityJump.value && this.justPressedJump() && this._jumping)
         {
            this.performGravityJump();
         }
      }
      
      private function checkInput_move() : void
      {
         if(this.noCollide)
         {
            this.noCollide = false;
            acceleration.y = 1200;
         }
         if(this.justPressedUp())
         {
            this._mostRecentDir = DIR_UP;
            this._mostRecentUpDown = DIR_UP;
         }
         if(this.justPressedDown())
         {
            this._mostRecentDir = DIR_DOWN;
            this._mostRecentUpDown = DIR_DOWN;
         }
         if(this.justPressedLeft())
         {
            this._mostRecentDir = DIR_LEFT;
            this._mostRecentLeftRight = DIR_LEFT;
         }
         if(this.justPressedRight())
         {
            this._mostRecentDir = DIR_RIGHT;
            this._mostRecentLeftRight = DIR_RIGHT;
         }
         var _loc1_:Boolean = this._hidingInShell && !this._jumping;
         switch(this._gravityDir)
         {
            case GRAV_UP:
               acceleration.x = 0;
               if(this.pressedLeft() && !this.pressedStrafe())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  facing = LEFT;
                  if((PlayState.worldMap.solidAt(x - 1,y + 3) || PlayState.worldMap.solidAt(x - 1,y + height - 4)) && !(this.pressedUp() || this.pressedDown()))
                  {
                     velocity.x = 0;
                  }
                  else
                  {
                     velocity.x = -this._runSpeed.value;
                  }
                  this.setFaceDir(FACE_CEIL_LEFT);
               }
               else if(this.pressedRight() && !this.pressedStrafe())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  facing = RIGHT;
                  if((PlayState.worldMap.solidAt(x + width,y + 3) || PlayState.worldMap.solidAt(x + width,y + height - 4)) && !(this.pressedUp() || this.pressedDown()))
                  {
                     velocity.x = 0;
                  }
                  else
                  {
                     velocity.x = this._runSpeed.value;
                  }
                  this.setFaceDir(FACE_CEIL_RIGHT);
               }
               break;
            case GRAV_DOWN:
               acceleration.x = 0;
               if(this.pressedLeft() && !this.pressedStrafe())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  facing = LEFT;
                  if((PlayState.worldMap.solidAt(x - 1,y + 3) || PlayState.worldMap.solidAt(x - 1,y + height - 4)) && !(this.pressedUp() || this.pressedDown()))
                  {
                     velocity.x = 0;
                  }
                  else
                  {
                     velocity.x = -this._runSpeed.value;
                  }
                  this.setFaceDir(FACE_FLOOR_LEFT);
               }
               else if(this.pressedRight() && !this.pressedStrafe())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  facing = RIGHT;
                  if((PlayState.worldMap.solidAt(x + width,y + 3) || PlayState.worldMap.solidAt(x + width,y + height - 4)) && !(this.pressedUp() || this.pressedDown()))
                  {
                     velocity.x = 0;
                  }
                  else
                  {
                     velocity.x = this._runSpeed.value;
                  }
                  this.setFaceDir(FACE_FLOOR_RIGHT);
               }
               break;
            case GRAV_LEFT:
               acceleration.y = 0;
               if(this.pressedUp() && !this.pressedStrafe())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  velocity.y = -this._runSpeed.value;
                  facing = LEFT;
                  this.setFaceDir(FACE_LWALL_UP);
               }
               else if(this.pressedDown() && !this.pressedStrafe())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  velocity.y = this._runSpeed.value;
                  facing = LEFT;
                  this.setFaceDir(FACE_LWALL_DOWN);
               }
               break;
            case GRAV_RIGHT:
               acceleration.y = 0;
               if(this.pressedUp() && !this.pressedStrafe())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  velocity.y = -this._runSpeed.value;
                  facing = RIGHT;
                  this.setFaceDir(FACE_RWALL_UP);
               }
               else if(this.pressedDown() && !this.pressedStrafe())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  velocity.y = this._runSpeed.value;
                  facing = RIGHT;
                  this.setFaceDir(FACE_RWALL_DOWN);
               }
         }
      }
      
      public function checkInput_map() : void
      {
         if((FlxG.keys.justPressed("TAB") || FlxG.keys.justPressed(MAP_KEY)) && !this._paralyzed && !dead && !PlayState.isBossRushComplete && !PlayState.isGameComplete)
         {
            PlayState.miniMap.toggleMapSize();
         }
      }
      
      public function checkInput_jump() : void
      {
         if(this.justPressedJump())
         {
            if(this._hidingInShell)
            {
               this.hideInShell(false);
            }
            if(!this._jumping)
            {
               this.doJump();
            }
         }
         if(this._jumping && !this.pressedJump())
         {
            switch(this._gravityDir)
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
            }
         }
      }
      
      override public function update() : void
      {
         if(this.saveOnNextFrame)
         {
            this.setHelixFragments(this._helixFragments.value);
            this.setSaveCoords(x,y,true);
            this.saveOnNextFrame = false;
            this.hasSetHpBar = false;
            this.setCurHp(9999);
         }
         if(this.hasSetHpBar == false)
         {
            this.hasSetHpBar = true;
            this.setCurHp(9999);
            this.setMaxHp(this._maxHp.value);
         }
         if(facing > 10)
         {
            facing = RIGHT;
         }
         if(PlayState.realState == PlayState.STATE_GAME || PlayState.realState == PlayState.STATE_SUBSCREEN)
         {
            this.checkInput_map();
            this.checkInput_handleMenu();
            this.checkInput_switchWeapons();
         }
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this.gameTime.value += FlxG.elapsed;
         this._weaponTimeout.value -= FlxG.elapsed;
         if(this.justPressedLeft())
         {
            this.pressedLeftSinceJump = true;
         }
         else if(this.justPressedRight())
         {
            this.pressedRightSinceJump = true;
         }
         else if(this.justPressedJump())
         {
            this.pressedLeftSinceJump = false;
            this.pressedRightSinceJump = false;
         }
         if(!dead)
         {
            this.fixGravity();
         }
         if(!dead && !this._paralyzed)
         {
            this.checkInput_handleHelp();
            this.checkInput_handleSkyFishCheat();
            this.checkInput_handleSlugCheat();
            this.checkInput_hideInShell();
            this.checkInput_shoot();
            this.checkInput_performGravityJump();
            this.checkInput_move();
            this.checkInput_jump();
         }
         if(this.pressedUp() || this.pressedDown() || this.pressedLeft() || this.pressedRight() || this.pressedShoot() || this.pressedStrafe() || this.pressedJump() || flickering())
         {
            this._sleepTimeout = SLEEP_TIMEOUT;
         }
         this._sleepTimeout -= FlxG.elapsed;
         if(this._sleepTimeout <= 0 && !PlayState.zzz.visible && !this._slugMode)
         {
            this.hideInShell(true);
            PlayState.zzz.visible = true;
            this._sleepTimeout = SLEEP_TIMEOUT;
         }
         if(!dead)
         {
            PlayState.worldMap.checkFakeBounds(x,y);
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
         if(this._invincible || this.noCollide || this._paralyzed)
         {
            return;
         }
         this._sleepTimeout = SLEEP_TIMEOUT;
         if(this._hidingInShell)
         {
            this.hideInShell(false);
            if(this._hasShellShield.value)
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
         if(this._hasArmor.value)
         {
            param1 /= 2;
            if(param1 < 1)
            {
               Sfx.playEnemyPingOffArmor();
               return;
            }
         }
         this.setCurHp(this._curHp.value - param1);
         if(dead)
         {
            Sfx.playDeath();
            this.playAnim("death");
            velocity.x = facing == LEFT ? 110 : -110;
            velocity.y = -300;
            acceleration.x = 0;
            acceleration.y = this._gravity.value;
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
         this.setCurHp(this._curHp.value + param1);
      }
      
      override public function kill() : void
      {
         if(dead)
         {
            return;
         }
         this._sleepTimeout = SLEEP_TIMEOUT;
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
         if(!this._invincible)
         {
            Utility.stackTrace("setting timer for kill()");
            this.deathFadeInterval = setInterval(this.deathFade,DEATHFADE_DELAY);
            this.reviveInterval = setInterval(this.revive,REVIVE_DELAY);
            this.setFaceDir(FACE_FLOOR_RIGHT,true);
         }
      }
      
      public function deathFade() : void
      {
         FlxG.fade.start(4278206591,0.44);
         clearInterval(this.deathFadeInterval);
      }
      
      public function revive() : void
      {
         clearInterval(this.reviveInterval);
         this.setFaceDir(FACE_FLOOR_RIGHT,true);
         facing = right;
         this._faceDir = FACE_FLOOR_RIGHT;
         this._mostRecentDir = DIR_RIGHT;
         this._mostRecentUpDown = DIR_DOWN;
         this._mostRecentLeftRight = DIR_RIGHT;
         this.teleportTo(32,32);
         this.teleportInterval = setInterval(this.realTeleport,TELEPORT_DELAY);
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
         this._justHitHeadOrWall = true;
         if(this.findNotSolidHeight() < 8)
         {
            return;
         }
         if(this._paralyzed)
         {
            return;
         }
         if(this.pressedLeft() && (!flickering() || this._hasGravityJump.value))
         {
            switch(this._gravityDir)
            {
               case GRAV_UP:
                  if(this.pressedDown())
                  {
                     this.setGravityDir(GRAV_LEFT);
                     this.setFaceDir(FACE_LWALL_DOWN,true);
                     this.moveSnailCheckBounds(0,2);
                  }
                  break;
               case GRAV_DOWN:
                  if(this.pressedUp() || this._jumping && this.pressedDown())
                  {
                     if(!this._hasGravityJump.value && this._jumping && this._fallFrames < 8)
                     {
                        return;
                     }
                     this.setGravityDir(GRAV_LEFT);
                     this.setFaceDir(FACE_LWALL_UP,true);
                  }
            }
         }
         super.hitLeft(param1,param2);
      }
      
      override public function hitRight(param1:FlxObject, param2:Number) : void
      {
         this._justHitHeadOrWall = true;
         super.hitRight(param1,param2);
         if(this._paralyzed)
         {
            return;
         }
         if(this.findNotSolidHeight() < 8)
         {
            return;
         }
         if(this.pressedRight() && (!flickering() || this._hasGravityJump.value))
         {
            switch(this._gravityDir)
            {
               case GRAV_UP:
                  if(this.pressedDown())
                  {
                     this.setGravityDir(GRAV_RIGHT);
                     this.setFaceDir(FACE_RWALL_DOWN,true);
                     this.moveSnailCheckBounds(11,2);
                  }
                  break;
               case GRAV_DOWN:
                  if(this.pressedUp() || this._jumping && this.pressedDown())
                  {
                     if(!this._hasGravityJump.value && this._jumping && this._fallFrames < 8)
                     {
                        return;
                     }
                     this.setGravityDir(GRAV_RIGHT);
                     this.setFaceDir(FACE_RWALL_UP,true);
                     y -= 11;
                     x += 11;
                     this.moveSnailCheckFullBounds(0,11);
                  }
            }
         }
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         this._justHitHeadOrWall = false;
         super.hitBottom(param1,param2);
         if(this.findNotSolidWidth() < 8)
         {
            return;
         }
         if(this._paralyzed)
         {
            return;
         }
         if(this._faceDir == FACE_LWALL_DOWN || this._faceDir == FACE_RWALL_DOWN)
         {
            switch(this._gravityDir)
            {
               case GRAV_LEFT:
                  if(this.pressedLeft() || this.pressedRight() || !this.hasGravityJump())
                  {
                     this.setGravityDir(GRAV_DOWN);
                     this.setFaceDir(FACE_FLOOR_RIGHT,true);
                     facing = RIGHT;
                     this.moveSnailCheckBounds(2,11);
                  }
                  break;
               case GRAV_RIGHT:
                  if(this.pressedLeft() || this.pressedRight() || !this.hasGravityJump())
                  {
                     this.setGravityDir(GRAV_DOWN);
                     this.setFaceDir(FACE_FLOOR_LEFT,true);
                     this.moveSnailCheckBounds(0,11);
                     facing = LEFT;
                  }
            }
         }
         if(this._faceDir == FACE_CEIL_RIGHT || this._faceDir == FACE_CEIL_LEFT)
         {
            if(this.pressedDown())
            {
               this.setGravityDir(GRAV_DOWN);
               this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT,true);
            }
         }
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         this._justHitHeadOrWall = true;
         super.hitTop(param1,param2);
         if(this.findNotSolidWidth() < 8)
         {
            return;
         }
         if(this._paralyzed)
         {
            return;
         }
         if(this._faceDir == FACE_LWALL_UP || this._faceDir == FACE_RWALL_UP)
         {
            if(!this.pressedJump())
            {
               switch(this._gravityDir)
               {
                  case GRAV_LEFT:
                     if(this.pressedRight())
                     {
                        this.setGravityDir(GRAV_UP);
                        this.setFaceDir(FACE_CEIL_RIGHT,true);
                        facing = RIGHT;
                     }
                     break;
                  case GRAV_RIGHT:
                     if(this.pressedLeft())
                     {
                        this.setGravityDir(GRAV_UP);
                        this.moveSnailCheckBounds(-11,0);
                        this.setFaceDir(FACE_CEIL_LEFT,true);
                        facing = LEFT;
                     }
               }
            }
         }
         if(this._faceDir == FACE_FLOOR_RIGHT || this._faceDir == FACE_FLOOR_LEFT)
         {
            if(this.pressedUp())
            {
               this.setGravityDir(GRAV_UP);
               this.setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT,true);
            }
         }
      }
      
      public function hasAnyWeapon() : Boolean
      {
         return Boolean(this._hasWeapon[0]) || Boolean(this._hasWeapon[1]) || Boolean(this._hasWeapon[2]);
      }
      
      public function hasAnyTwoWeapons() : Boolean
      {
         return Boolean(this._hasWeapon[0]) && (Boolean(this._hasWeapon[1]) || Boolean(this._hasWeapon[2])) || Boolean(this._hasWeapon[1]) && Boolean(this._hasWeapon[2]);
      }
      
      public function getHasWeapon(param1:int) : Boolean
      {
         return this._hasWeapon[param1];
      }
      
      public function setHasWeapon(param1:int, param2:Boolean) : void
      {
         this._hasWeapon[param1] = param2;
      }
      
      public function switchToWeapon(param1:int) : void
      {
         if(Boolean(this._hasWeapon[param1]) || param1 == WEAPON_NONE)
         {
            this._currentWeapon.value = param1;
         }
      }
      
      public function getCurrentWeapon() : int
      {
         return this._currentWeapon.value;
      }
      
      private function switchToNextWeapon() : void
      {
         if(!(Boolean(this._hasWeapon[0]) || Boolean(this._hasWeapon[1]) || Boolean(this._hasWeapon[2])))
         {
            return;
         }
         var _loc1_:int = this._currentWeapon.value;
         do
         {
            _loc1_++;
            _loc1_ %= 3;
         }
         while(!this._hasWeapon[_loc1_]);
         
         this.switchToWeapon(_loc1_);
      }
      
      private function switchToPrevWeapon() : void
      {
         if(!(Boolean(this._hasWeapon[0]) || Boolean(this._hasWeapon[1]) || Boolean(this._hasWeapon[2])))
         {
            return;
         }
         var _loc1_:int = this._currentWeapon.value;
         do
         {
            _loc1_--;
            _loc1_ += 3;
            _loc1_ %= 3;
         }
         while(!this._hasWeapon[_loc1_]);
         
         this.switchToWeapon(_loc1_);
      }
      
      public function hasTurbo() : Boolean
      {
         return this._hasTurbo.value;
      }
      
      private function setHasTurbo(param1:Boolean) : void
      {
         this._hasTurbo.value = param1;
         this._turboMultiplier.value = this._hasTurbo.value ? 0.5 : 1;
      }
      
      public function shootCurrentWeapon() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         while(this._currentWeapon.value > WEAPON_NONE && !this._hasWeapon[this._currentWeapon.value])
         {
            --this._currentWeapon.value;
         }
         if(this._currentWeapon.value == WEAPON_NONE)
         {
            return;
         }
         if(this._weaponTimeout.value > 0)
         {
            return;
         }
         var _loc1_:PlayerBullet = this._bulletGroups.getBullet(this._currentWeapon.value,this._hasDevastator.value);
         if(_loc1_)
         {
            _loc2_ = -1;
            _loc4_ = false;
            if(this._jumping || this._hasDevastator.value || _loc4_)
            {
               _loc3_ = [1,1,1,1,1,1,1,1];
            }
            else if(this._currentWeapon.value == WEAPON_PEA_SHOOTER)
            {
               switch(this._gravityDir)
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
               }
            }
            else
            {
               _loc3_ = [1,1,1,1,1,1,1,1];
            }
            if(this.pressedUp() && this.pressedLeft() && Boolean(_loc3_[3]))
            {
               _loc2_ = 3;
            }
            else if(this.pressedUp() && this.pressedRight() && Boolean(_loc3_[1]))
            {
               _loc2_ = 1;
            }
            else if(this.pressedDown() && this.pressedLeft() && Boolean(_loc3_[5]))
            {
               _loc2_ = 5;
            }
            else if(this.pressedDown() && this.pressedRight() && Boolean(_loc3_[7]))
            {
               _loc2_ = 7;
            }
            else if(this.pressedUp() && Boolean(_loc3_[2]))
            {
               _loc2_ = 2;
            }
            else if(this.pressedDown() && Boolean(_loc3_[6]))
            {
               _loc2_ = 6;
            }
            else if(this.pressedLeft() && Boolean(_loc3_[4]))
            {
               _loc2_ = 4;
            }
            else if(this.pressedRight() && Boolean(_loc3_[0]))
            {
               _loc2_ = 0;
            }
            if(_loc2_ == -1)
            {
               switch(this._faceDir)
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
               }
            }
            _loc5_ = [0,40,90,140,180,-140,-90,-40];
            _loc6_ = int(_loc5_[_loc2_]);
            _loc7_ = this.WEAPON_SPEED[this._currentWeapon.value] / this._turboMultiplier.value;
            _loc8_ = Math.cos(_loc6_ * Math.PI / 180) * _loc7_;
            _loc9_ = -Math.sin(_loc6_ * Math.PI / 180) * _loc7_;
            _loc1_.shoot(x + width / 2,y + height / 2,_loc8_,_loc9_);
            this._weaponTimeout.value = this.WEAPON_TIMEOUTS[this._currentWeapon.value] * this._turboMultiplier.value;
         }
      }
      
      public function performGravityJump() : void
      {
         if(FlxG.keys.pressed("SHIFT") && this.cheatsEnabled)
         {
            return;
         }
         switch(this._gravityDir)
         {
            case GRAV_DOWN:
               if((!this.pressedLeft() && !this.pressedRight() || this._mostRecentDir == DIR_UP) && this.pressedUp())
               {
                  if(this.findNotSolidWidth() < 8)
                  {
                     return;
                  }
                  this.setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                  this._desiredGravity = GRAV_UP;
               }
               else if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_RIGHT) && this.pressedRight())
               {
                  if(this.findNotSolidHeight() < 8)
                  {
                     return;
                  }
                  this.setFaceDir(FACE_RWALL_UP);
                  this._desiredGravity = GRAV_RIGHT;
               }
               else if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_LEFT) && this.pressedLeft())
               {
                  if(this.findNotSolidHeight() < 8)
                  {
                     return;
                  }
                  this.setFaceDir(FACE_LWALL_UP);
                  this._desiredGravity = GRAV_LEFT;
               }
               break;
            case GRAV_UP:
               if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_RIGHT) && this.pressedRight())
               {
                  if(this.findNotSolidHeight() < 8)
                  {
                     return;
                  }
                  this.setFaceDir(FACE_RWALL_DOWN);
                  this._desiredGravity = GRAV_RIGHT;
               }
               else if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_LEFT) && this.pressedLeft())
               {
                  if(this.findNotSolidHeight() < 8)
                  {
                     return;
                  }
                  this.setFaceDir(FACE_LWALL_DOWN);
                  this._desiredGravity = GRAV_LEFT;
               }
               else if(this.pressedDown())
               {
                  if(this.findNotSolidWidth() < 8)
                  {
                     return;
                  }
                  this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                  this._desiredGravity = GRAV_DOWN;
               }
               break;
            case GRAV_RIGHT:
               if((!this.pressedLeft() && !this.pressedRight() || this._mostRecentDir == DIR_UP) && this.pressedUp())
               {
                  if(this.findNotSolidWidth() < 8)
                  {
                     return;
                  }
                  this.setFaceDir(FACE_CEIL_RIGHT);
                  this._desiredGravity = GRAV_UP;
               }
               else if(!((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_RIGHT) && this.pressedRight()))
               {
                  if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_LEFT) && this.pressedLeft())
                  {
                     if(this.findNotSolidHeight() < 8)
                     {
                        return;
                     }
                     this.setFaceDir(this._faceDir == FACE_RWALL_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                     this._desiredGravity = GRAV_LEFT;
                  }
                  else if((!this.pressedLeft() && !this.pressedRight() || this._mostRecentDir == DIR_DOWN) && this.pressedDown())
                  {
                     if(this.findNotSolidWidth() < 8)
                     {
                        return;
                     }
                     this.setFaceDir(FACE_FLOOR_RIGHT);
                     this._desiredGravity = GRAV_DOWN;
                  }
               }
               break;
            case GRAV_LEFT:
               if((!this.pressedLeft() && !this.pressedRight() || this._mostRecentDir == DIR_UP) && this.pressedUp())
               {
                  if(this.findNotSolidWidth() < 8)
                  {
                     return;
                  }
                  this.setFaceDir(FACE_CEIL_LEFT);
                  this._desiredGravity = GRAV_UP;
               }
               else if(!((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_LEFT) && this.pressedLeft()))
               {
                  if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_RIGHT) && this.pressedRight())
                  {
                     if(this.findNotSolidHeight() < 8)
                     {
                        return;
                     }
                     this.setFaceDir(this._faceDir == FACE_LWALL_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
                     this._desiredGravity = GRAV_RIGHT;
                  }
                  else if((!this.pressedLeft() && !this.pressedRight() || this._mostRecentDir == DIR_DOWN) && this.pressedDown())
                  {
                     if(this.findNotSolidWidth() < 8)
                     {
                        return;
                     }
                     this.setFaceDir(FACE_FLOOR_LEFT);
                     this._desiredGravity = GRAV_DOWN;
                  }
               }
         }
         this._desiredGravity = GRAV_DOWN;
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
            this.moveSnailCheckBounds(_loc5_,_loc6_);
         }
         else if(_loc5_ > 0)
         {
            x -= _loc5_;
            this.moveSnailCheckBounds(_loc5_,0);
         }
         else if(_loc6_ > 0)
         {
            y -= _loc6_;
            this.moveSnailCheckBounds(0,_loc6_);
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
         if(this._justHitSteps)
         {
            this._justHitSteps = false;
            return;
         }
         switch(this._gravityDir)
         {
            case GRAV_UP:
               this._jumping = velocity.y != 0;
               if(this._jumping)
               {
                  ++this._fallFrames;
               }
               else
               {
                  this._fallFrames = 0;
               }
               if(!this._hasGravityJump.value && this._fallFrames >= 1 || flickering() && !this._hasGravityJump.value)
               {
                  this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
               }
               else if(this._hasGravityJump.value && this._fallFrames == 1 && this.pressedUp() && this.pressedRight())
               {
                  this.setFaceDir(FACE_LWALL_UP);
                  this.moveSnailCheckBounds(0,-1);
               }
               else if(this._hasGravityJump.value && this._fallFrames == 1 && this.pressedUp() && this.pressedLeft())
               {
                  this.setFaceDir(FACE_RWALL_UP);
                  this.moveSnailCheckBounds(12,-1);
               }
               else if(this._hasGravityJump.value && !this.pressedJump() && this._fallFrames == 1 && !this.pressedUp())
               {
                  this._desiredGravity = GRAV_UP;
                  switch(this._desiredGravity)
                  {
                     case GRAV_DOWN:
                        this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                        break;
                     case GRAV_UP:
                        this.setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                        break;
                     case GRAV_LEFT:
                        this.setFaceDir(this._mostRecentUpDown == DIR_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                        break;
                     case GRAV_RIGHT:
                        this.setFaceDir(this._mostRecentUpDown == DIR_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
                  }
               }
               break;
            case GRAV_DOWN:
               if(this._fallFrames == 1 && this.pressedDown() && !this._justHitHeadOrWall && !flickering() && velocity.y > 0)
               {
                  if(facing == RIGHT && this.pressedRight())
                  {
                     this.setFaceDir(FACE_LWALL_DOWN,false,true);
                     velocity.x = -this._runSpeed.value;
                     this.moveSnailCheckBounds(0,-11);
                  }
                  else if(facing == LEFT && this.pressedLeft())
                  {
                     this.setFaceDir(FACE_RWALL_DOWN,false,true);
                     velocity.x = this._runSpeed.value;
                     this.moveSnailCheckBounds(15,-11);
                  }
                  break;
               }
               this._jumping = velocity.y != 0;
               if(this._jumping)
               {
                  ++this._fallFrames;
               }
               else
               {
                  this._fallFrames = 0;
               }
               if(this._fallFrames == 1 || flickering())
               {
                  if(facing == RIGHT)
                  {
                     this.setFaceDir(FACE_FLOOR_RIGHT);
                  }
                  else
                  {
                     this.setFaceDir(FACE_FLOOR_LEFT);
                  }
               }
               break;
            case GRAV_LEFT:
               this._jumping = velocity.x != 0;
               if(this._jumping)
               {
                  ++this._fallFrames;
               }
               else
               {
                  this._fallFrames = 0;
               }
               if(!this._hasGravityJump.value && this._fallFrames >= 1 || flickering() && !this._hasGravityJump.value)
               {
                  this.setFaceDir(FACE_FLOOR_LEFT);
                  this.moveSnailCheckBounds(0,13);
               }
               else if(this._hasGravityJump.value && this._fallFrames == 1 && this.pressedUp() && this.pressedLeft())
               {
                  this.setFaceDir(FACE_FLOOR_LEFT);
                  this.moveSnailCheckBounds(0,13);
               }
               else if(this._hasGravityJump.value && this._fallFrames == 1 && this.pressedDown() && this.pressedLeft())
               {
                  this.setFaceDir(FACE_CEIL_LEFT);
                  this.moveSnailCheckBounds(0,1);
               }
               else if(this._hasGravityJump.value && !this.pressedJump() && this._fallFrames == 1 && !this.pressedLeft())
               {
                  this._desiredGravity = GRAV_LEFT;
                  switch(this._desiredGravity)
                  {
                     case GRAV_DOWN:
                        this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                        break;
                     case GRAV_UP:
                        this.setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                        break;
                     case GRAV_LEFT:
                        this.setFaceDir(this._mostRecentUpDown == DIR_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                        break;
                     case GRAV_RIGHT:
                        this.setFaceDir(this._mostRecentUpDown == DIR_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
                  }
               }
               break;
            case GRAV_RIGHT:
               this._jumping = velocity.x != 0;
               if(this._jumping)
               {
                  ++this._fallFrames;
               }
               else
               {
                  this._fallFrames = 0;
               }
               if(!this._hasGravityJump.value && this._fallFrames >= 1 || flickering() && !this._hasGravityJump.value)
               {
                  this.setFaceDir(FACE_FLOOR_RIGHT);
                  this.moveSnailCheckBounds(-6,13);
               }
               else if(this._hasGravityJump.value && this._fallFrames == 1 && this.pressedUp() && this.pressedRight())
               {
                  this.setFaceDir(FACE_FLOOR_RIGHT);
                  this.moveSnailCheckBounds(-6,13);
               }
               else if(this._hasGravityJump.value && this._fallFrames == 1 && this.pressedDown() && this.pressedRight())
               {
                  this.setFaceDir(FACE_CEIL_RIGHT);
                  this.moveSnailCheckBounds(-6,1);
               }
               else if(this._hasGravityJump.value && !this.pressedJump() && this._fallFrames == 1 && !this.pressedRight())
               {
                  this._desiredGravity = GRAV_RIGHT;
                  switch(this._desiredGravity)
                  {
                     case GRAV_DOWN:
                        this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                        break;
                     case GRAV_UP:
                        this.setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                        break;
                     case GRAV_LEFT:
                        this.setFaceDir(this._mostRecentUpDown == DIR_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                        break;
                     case GRAV_RIGHT:
                        this.setFaceDir(this._mostRecentUpDown == DIR_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
                  }
               }
         }
      }
      
      public function doJump() : void
      {
         if(this._jumping)
         {
            return;
         }
         this.hideInShell(false);
         if(this._hasGravityJump.value)
         {
            if(this.doGravityJump())
            {
               Sfx.playJump1();
            }
         }
         else if(this.doRegularJump())
         {
            Sfx.playJump1();
         }
      }
      
      private function doGravityJump() : Boolean
      {
         switch(this._gravityDir)
         {
            case GRAV_UP:
               if(this.findNotSolidHeight() >= 8)
               {
                  y += 1;
                  velocity.y = this._jumpPower.value;
                  return true;
               }
               break;
            case GRAV_DOWN:
               if(this.findNotSolidHeight() >= 8)
               {
                  --y;
                  velocity.y = -this._jumpPower.value;
                  return true;
               }
               break;
            case GRAV_LEFT:
               if(this.findNotSolidWidth() >= 8)
               {
                  --x;
                  velocity.x = this._jumpPower.value;
                  return true;
               }
               break;
            case GRAV_RIGHT:
               if(this.findNotSolidWidth() >= 8)
               {
                  x += 1;
                  velocity.x = -this._jumpPower.value;
                  return true;
               }
               break;
         }
         return false;
      }
      
      private function doRegularJump() : Boolean
      {
         switch(this._gravityDir)
         {
            case GRAV_UP:
               if(this.findNotSolidHeight() >= 8)
               {
                  y += 1;
                  velocity.y = 0;
                  this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                  return true;
               }
               break;
            case GRAV_DOWN:
               if(this.findNotSolidHeight() >= 8)
               {
                  --y;
                  velocity.y = -this._jumpPower.value;
                  return true;
               }
               break;
            case GRAV_LEFT:
               if(this.findNotSolidWidth() >= 8 && !(this.pressedLeft() && (this.pressedUp() || this.pressedDown())))
               {
                  velocity.y = 0;
                  velocity.x = 100;
                  this.setFaceDir(FACE_FLOOR_LEFT);
                  return true;
               }
               break;
            case GRAV_RIGHT:
               if(this.findNotSolidWidth() >= 8 && !(this.pressedRight() && (this.pressedUp() || this.pressedDown())))
               {
                  velocity.y = 0;
                  velocity.x = -100;
                  x -= 11;
                  this.setFaceDir(FACE_FLOOR_RIGHT);
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function setHighJump(param1:Boolean) : void
      {
         this._hasHighJump.value = param1;
         this._jumpPower.value = this._hasHighJump.value ? HIGH_JUMP : REGULAR_JUMP;
      }
      
      public function isIcy() : Boolean
      {
         return this._hasColdFoot.value;
      }
      
      public function setSnailType(param1:int) : void
      {
         this._snailType.value = param1;
         this._snailTypePrefix = "snail" + param1.toString() + "_";
         this._hasColdFoot.value = param1 >= SNAILTYPE_ICE;
         this._hasGravityJump.value = param1 >= SNAILTYPE_GRAVITY;
         this._hasArmor.value = param1 >= SNAILTYPE_METAL;
         if(this._hasArmor.value)
         {
            this._runSpeed.value = this._slugMode ? 480 : 330;
            this._maxSpeed.value = 550;
            this._gravity.value = this._slugMode ? 900 : 1200;
         }
         else if(this._hasGravityJump.value)
         {
            this._runSpeed.value = this._slugMode ? 370 : 260;
            this._maxSpeed.value = 500;
            this._gravity.value = this._slugMode ? 900 : 1200;
         }
         else if(this._hasColdFoot.value)
         {
            this._runSpeed.value = this._slugMode ? 370 : 260;
            this._maxSpeed.value = 500;
            this._gravity.value = this._slugMode ? 900 : 1200;
         }
         else
         {
            this._runSpeed.value = this._slugMode ? 370 : 260;
            this._maxSpeed.value = 500;
            this._gravity.value = this._slugMode ? 900 : 1200;
         }
         this.setFaceDir(this._faceDir,true);
      }
      
      public function playAnim(param1:String) : void
      {
         play(this._snailTypePrefix + param1);
      }
      
      public function setGravityDir(param1:int) : void
      {
         this._gravityDir = param1;
         switch(this._gravityDir)
         {
            case GRAV_DOWN:
               acceleration.x = 0;
               acceleration.y = this._gravity.value;
               drag.x = this._runSpeed.value * 200;
               drag.y = 0;
               break;
            case GRAV_RIGHT:
               acceleration.x = this._gravity.value;
               acceleration.y = 0;
               drag.y = this._runSpeed.value * 200;
               drag.x = 0;
               break;
            case GRAV_UP:
               acceleration.x = 0;
               acceleration.y = -this._gravity.value;
               drag.x = this._runSpeed.value * 200;
               drag.y = 0;
               break;
            case GRAV_LEFT:
               acceleration.x = -this._gravity.value;
               acceleration.y = 0;
               drag.y = this._runSpeed.value * 200;
               drag.x = 0;
         }
      }
      
      public function hideInShell(param1:Boolean) : void
      {
         if(!this._hidingInShell && param1)
         {
            Sfx.playShell();
         }
         this._hidingInShell = param1;
         PlayState.zzz.visible = false;
         this.setFaceDir(this._faceDir,true);
      }
      
      public function realTeleport() : void
      {
         var _loc1_:XMLList = null;
         this.setCurHp(PlayState.player._maxHp.value);
         dead = false;
         solid = true;
         if(PlayState.bossRush)
         {
            this.setCurHp(99999);
            x = BOSSRUSH_STARTX * 16;
            y = BOSSRUSH_STARTY * 16;
         }
         else
         {
            _loc1_ = PlayState.saveData.xml.vars;
            this.teleportTo(_loc1_.savex,_loc1_.savey);
         }
         clearInterval(this.teleportInterval);
         FlxG.fade.stop();
         FlxG.flash.start(2130706432,0.34);
      }
      
      public function teleportTo(param1:int, param2:int) : void
      {
         this.setFaceDir(FACE_FLOOR_RIGHT,true);
         x = param1;
         y = param2;
         velocity.x = 0;
         velocity.y = 0;
         drag.x = this._runSpeed.value * 200;
         drag.y = 0;
         PlayState.worldMap.checkRoomBounds(this);
      }
      
      public function setFaceDirHiding(param1:int) : void
      {
         switch(this._faceDir)
         {
            case FACE_FLOOR_LEFT:
               offset.x = 0 + 13;
               width = 32 - 13 - 7;
               offset.y = 16 + 3;
               height = 16 - 3;
               this.setGravityDir(GRAV_DOWN);
               this.playAnim("floor_right_hide");
               this._hideOfsX = 9;
               x += this._hideOfsX;
               this._hideOfsY = 0;
               y += this._hideOfsY;
               break;
            case FACE_FLOOR_RIGHT:
               offset.x = 0 + 7;
               width = 32 - 7 - 13;
               offset.y = 16 + 3;
               height = 16 - 3;
               this.setGravityDir(GRAV_DOWN);
               this._hideOfsX = 3;
               x += this._hideOfsX;
               this._hideOfsY = 0;
               y += this._hideOfsY;
               this.playAnim("floor_right_hide");
               break;
            case FACE_CEIL_LEFT:
               offset.x = 0 + 13;
               width = 32 - 13 - 7;
               offset.y = 0 + 0;
               height = 16 - 6;
               this.setGravityDir(GRAV_UP);
               this.playAnim("ceil_right_hide");
               this._hideOfsX = 9;
               x += this._hideOfsX;
               break;
            case FACE_CEIL_RIGHT:
               offset.x = 0 + 7;
               width = 32 - 7 - 13;
               offset.y = 0 + 0;
               height = 16 - 6;
               this.setGravityDir(GRAV_UP);
               this.playAnim("ceil_right_hide");
               this._hideOfsX = 3;
               x += this._hideOfsX;
               break;
            case FACE_RWALL_UP:
               offset.y = 0 + 13;
               height = 32 - 13 - 7;
               offset.x = 16 + 6;
               width = 16 - 6;
               this.setGravityDir(GRAV_RIGHT);
               this.playAnim("rwall_up_hide");
               facing = RIGHT;
               this._hideOfsY = 9;
               y += this._hideOfsY;
               this._hideOfsX = 3;
               x += this._hideOfsX;
               break;
            case FACE_RWALL_DOWN:
               offset.y = 0 + 7;
               height = 32 - 7 - 13;
               offset.x = 16 + 6;
               width = 16 - 6;
               this.setGravityDir(GRAV_RIGHT);
               this.playAnim("rwall_down_hide");
               facing = RIGHT;
               this._hideOfsY = 3;
               y += this._hideOfsY;
               this._hideOfsX = 3;
               x += this._hideOfsX;
               break;
            case FACE_LWALL_UP:
               offset.y = 0 + 13;
               height = 32 - 13 - 7;
               offset.x = 0 + 0;
               width = 16 - 6;
               this.setGravityDir(GRAV_LEFT);
               this.playAnim("rwall_up_hide");
               facing = LEFT;
               this._hideOfsY = 9;
               y += this._hideOfsY;
               break;
            case FACE_LWALL_DOWN:
               offset.y = 0 + 7;
               height = 32 - 7 - 13;
               offset.x = 0 + 0;
               width = 16 - 6;
               this.setGravityDir(GRAV_LEFT);
               this.playAnim("rwall_down_hide");
               facing = LEFT;
               this._hideOfsY = 3;
               y += this._hideOfsY;
         }
      }
      
      public function setFaceDirNotHiding(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = offset.x;
         var _loc4_:int = offset.y;
         var _loc5_:int = width;
         var _loc6_:int = height;
         switch(this._faceDir)
         {
            case FACE_FLOOR_LEFT:
            case FACE_FLOOR_RIGHT:
               offset.x = 0 + 4;
               width = 32 - 4 - 4;
               offset.y = 16 + 3;
               height = 16 - 3;
               this.changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               this.setGravityDir(GRAV_DOWN);
               this.playAnim("floor_right_move");
               break;
            case FACE_CEIL_LEFT:
            case FACE_CEIL_RIGHT:
               offset.x = 0 + 4;
               width = 32 - 4 - 4;
               offset.y = 0 + 0;
               height = 16 - 3;
               this.changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               this.setGravityDir(GRAV_UP);
               this.playAnim("ceil_right_move");
               break;
            case FACE_RWALL_UP:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 16 + 3;
               width = 16 - 3;
               if(!param2)
               {
                  this.changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               }
               this.setGravityDir(GRAV_RIGHT);
               this.playAnim("rwall_up_move");
               facing = RIGHT;
               break;
            case FACE_RWALL_DOWN:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 16 + 3;
               width = 16 - 3;
               if(!param2)
               {
                  this.changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               }
               this.setGravityDir(GRAV_RIGHT);
               this.playAnim("rwall_down_move");
               facing = RIGHT;
               break;
            case FACE_LWALL_UP:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 0 + 0;
               width = 16 - 3;
               if(!param2)
               {
                  this.changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               }
               this.setGravityDir(GRAV_LEFT);
               this.playAnim("rwall_up_move");
               facing = LEFT;
               break;
            case FACE_LWALL_DOWN:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 0 + 0;
               width = 16 - 3;
               if(!param2)
               {
                  this.changeSnailSizeCheckBounds(width,height,_loc5_,_loc6_);
               }
               this.setGravityDir(GRAV_LEFT);
               this.playAnim("rwall_down_move");
               facing = LEFT;
         }
      }
      
      public function setFaceDir(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         if(this._faceDir == param1 && !param2)
         {
            return;
         }
         this._faceDir = param1;
         this.moveSnailCheckBounds(-this._hideOfsX,-this._hideOfsY);
         this._hideOfsX = 0;
         this._hideOfsY = 0;
         if(this._hidingInShell)
         {
            this.setFaceDirHiding(this._faceDir);
         }
         else
         {
            this.setFaceDirNotHiding(this._faceDir,param3);
         }
      }
      
      public function setCurHp(param1:int) : void
      {
         this._curHp.value = param1;
         if(this._curHp.value > this._maxHp.value)
         {
            this._curHp.value = this._maxHp.value;
         }
         PlayState.hud.heartHud.setCurHp(this._curHp.value,this);
         if(this._curHp.value <= 0)
         {
            this.kill();
         }
      }
      
      public function getCurHp() : int
      {
         return this._curHp.value;
      }
      
      public function getMaxHp() : int
      {
         return this._maxHp.value;
      }
      
      public function setMaxHp(param1:int) : void
      {
         this._maxHp.value = param1;
         if(this._maxHp.value > this.hpPerHeart() * MAX_HEART_CONTAINERS)
         {
            this._maxHp.value = this.hpPerHeart() * MAX_HEART_CONTAINERS;
         }
         this.setCurHp(this._maxHp.value);
         PlayState.hud.heartHud.setMaxHp(this._maxHp.value,this);
         PlayState.hud.heartHud.setCurHp(this._maxHp.value,this);
      }
      
      public function addHeartContainer() : void
      {
         this.setMaxHp(this._maxHp.value + this.hpPerHeart());
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
         var _loc2_:int = int(_loc1_.savex);
         var _loc3_:int = int(_loc1_.savey);
         this.setSaveCoords(_loc2_,_loc3_,true);
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
            _loc1_ = int(_loc3_.xml.vars.savex);
         }
         if(_loc3_.isVarSet("savey"))
         {
            _loc2_ = int(_loc3_.xml.vars.savey);
         }
         this.setSaveCoords(_loc1_,_loc2_,true);
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
         _loc4_.appendChild(<lastWeapon>{this._currentWeapon.value}</lastWeapon>);
         if(firingMode)
         {
            _loc4_.appendChild(<toggleFire>true</toggleFire>);
         }
         if(this._hasTurbo.value)
         {
            _loc4_.appendChild(<hasTurbo>true</hasTurbo>);
         }
         if(this._hasHighJump.value)
         {
            _loc4_.appendChild(<hasHighJump>true</hasHighJump>);
         }
         if(this._hasDevastator.value)
         {
            _loc4_.appendChild(<hasDevastator>true</hasDevastator>);
         }
         if(this._hasGravityShock.value)
         {
            _loc4_.appendChild(<hasGravityShock>true</hasGravityShock>);
         }
         if(this._hasShellShield.value)
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
         _loc4_.appendChild(<snailType>{this._snailType.value}</snailType>);
         _loc4_.appendChild(<maxHp>{this._maxHp.value}</maxHp>);
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
         if(this._easyMode)
         {
            _loc4_.appendChild(<easyMode>true</easyMode>);
         }
         if(this._hardMode)
         {
            _loc4_.appendChild(<hardMode>true</hardMode>);
         }
         if(this._insaneMode)
         {
            _loc4_.appendChild(<insaneMode>true</insaneMode>);
         }
         if(this._hasWeapon[0])
         {
            _loc4_.appendChild(<hasWeaponZero>true</hasWeaponZero>);
         }
         if(this._hasWeapon[1])
         {
            _loc4_.appendChild(<hasWeaponOne>true</hasWeaponOne>);
         }
         if(this._hasWeapon[2])
         {
            _loc4_.appendChild(<hasWeaponTwo>true</hasWeaponTwo>);
         }
         _loc4_.appendChild(<gameTime>{this.gameTime.value}</gameTime>);
         _loc4_.appendChild(<helixFragments>{this._helixFragments.value}</helixFragments>);
         if(this.hasSeenIsis)
         {
            _loc4_.appendChild(<hasSeenIsis>{this.hasSeenIsis}</hasSeenIsis>);
         }
         if(this.hasSeenHelp)
         {
            _loc4_.appendChild(<hasSeenHelp>{this.hasSeenHelp}</hasSeenHelp>);
         }
         _loc4_.appendChild(<hasWonGame>{this.hasWonGame}</hasWonGame>);
         _loc4_.appendChild(<hasWonHardMode>{this.hasWonHardMode}</hasWonHardMode>);
         _loc4_.appendChild(<hasWonInsaneMode>{this.hasWonInsaneMode}</hasWonInsaneMode>);
         _loc4_.appendChild(<hasFullClear>{this.hasFullClear}</hasFullClear>);
         _loc4_.appendChild(<hasWonBossRush>{this.hasWonBossRush}</hasWonBossRush>);
         _loc4_.appendChild(<bestBossRushTime>{this.bestBossRushTime.value}</bestBossRushTime>);
         _loc4_.appendChild(<bestMainTime>{this.bestMainTime.value}</bestMainTime>);
         _loc4_.appendChild(<bestHardTime>{this.bestHardTime.value}</bestHardTime>);
         _loc4_.appendChild(<bestInsaneTime>{this.bestInsaneTime.value}</bestInsaneTime>);
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
         var _loc2_:Boolean = !this.hasAnyWeapon() && !PlayState.bossRush && !this._hardMode;
         this._hasWeapon[param1] = true;
         if(this._currentWeapon.value < param1)
         {
            this.switchToWeapon(param1);
         }
         if(_loc2_)
         {
            PlayState.controlHelp.updateLetterGraphics();
            PlayState.controlHelp.show(true);
         }
      }
      
      public function hasWeapon(param1:int) : Boolean
      {
         return this._hasWeapon[param1];
      }
      
      public function getHasDevastator() : Boolean
      {
         return this._hasDevastator.value;
      }
      
      public function hasArmor() : Boolean
      {
         return this._hasArmor.value;
      }
      
      public function hasGravityJump() : Boolean
      {
         return this._hasGravityJump.value;
      }
      
      public function hasHighJump() : Boolean
      {
         return this._hasHighJump.value;
      }
      
      public function addTurbo() : void
      {
         this.setHasTurbo(true);
      }
      
      public function addDevastator() : void
      {
         this.setHasDevastator(true);
      }
      
      public function addGravityJump() : void
      {
         if(!this.hasArmor())
         {
            this.setSnailType(SNAILTYPE_GRAVITY);
         }
      }
      
      public function addColdFoot() : void
      {
         if(!this.hasGravityJump() && !this.hasArmor())
         {
            this.setSnailType(SNAILTYPE_ICE);
         }
      }
      
      public function addHighJump() : void
      {
         this.setHighJump(true);
      }
      
      public function setHasDevastator(param1:Boolean) : void
      {
         this._hasDevastator.value = param1;
      }
      
      public function setHelixFragments(param1:int) : void
      {
         this._helixFragments.value = param1;
         if(this._helixFragments.value > MAX_HELIX_FRAGMENTS)
         {
            this._helixFragments.value = MAX_HELIX_FRAGMENTS;
         }
         if(PlayState.miniMap)
         {
            if(this._helixFragments.value == 0)
            {
               PlayState.miniMap.subscreen.helixSprite.visible = false;
               PlayState.miniMap.subscreen.helixText.visible = false;
               PlayState.miniMap.subscreen.helixText.text = "x " + this._helixFragments.value.toString();
            }
            else
            {
               PlayState.miniMap.subscreen.helixSprite.visible = true;
               PlayState.miniMap.subscreen.helixText.visible = true;
               PlayState.miniMap.subscreen.helixText.text = "x " + this._helixFragments.value.toString();
            }
         }
      }
      
      public function getHelixFragments() : int
      {
         return this._helixFragments.value;
      }
      
      public function getHasShellShield() : Boolean
      {
         return this._hasShellShield.value;
      }
      
      public function setHasShellShield(param1:Boolean) : void
      {
         if(this._slugMode)
         {
            return;
         }
         this._hasShellShield.value = param1;
      }
      
      public function addShellShield() : void
      {
         if(!this._slugMode)
         {
            this.setHasShellShield(true);
         }
      }
      
      public function setEasyMode(param1:Boolean) : void
      {
         this._easyMode = param1;
      }
      
      public function setHardMode(param1:Boolean) : void
      {
         this._hardMode = param1;
      }
      
      public function setInsaneMode(param1:Boolean) : void
      {
         this._insaneMode = param1;
      }
      
      public function hasGravityShock() : Boolean
      {
         return this._hasGravityShock.value;
      }
      
      public function setHasGravityShock(param1:Boolean) : void
      {
      }
      
      public function addGravityShock() : void
      {
      }
      
      public function addHelixFragment() : void
      {
         this.setHelixFragments(this._helixFragments.value + 1);
      }
      
      public function getPercentComplete() : int
      {
         var _loc1_:int = (!!this._hasWeapon[0] ? 1 : 0) + (!!this._hasWeapon[1] ? 1 : 0) + (!!this._hasWeapon[2] ? 1 : 0) + (this._hasDevastator.value ? 1 : 0) + (this._hasTurbo.value ? 1 : 0) + (this._hasHighJump.value ? 1 : 0) + this._maxHp.value / this.hpPerHeart() - STARTING_MAX_HEARTS + (this._hasColdFoot.value ? 1 : 0) + (this._hasGravityJump.value ? 1 : 0) + (this._hasArmor.value ? 1 : 0) + (this._hasShellShield.value ? 1 : 0) + this._helixFragments.value;
         return _loc1_ * 100 / (this._slugMode ? 50 : 51);
      }
      
      public function isParalyzed() : Boolean
      {
         return this._paralyzed;
      }
      
      public function paralyze(param1:Boolean) : void
      {
         this._paralyzed = param1;
      }
      
      public function addArmor() : void
      {
         this.setSnailType(SNAILTYPE_METAL);
         this._hasArmor.value = true;
      }
   }
}

