package
{
   import org.flixel.*;
   
   public class Boss4Rush extends Boss
   {
      private static const MODE_INTRO:int = 0;
      
      private static const MODE_ATTACK:int = 1;
      
      private static const MODE_MOVE:int = 2;
      
      private static const MODE_TELEPORT:int = 3;
      
      private static const MODE_STRAFE:int = 4;
      
      private static const MODE_NAME:Array = ["INTRO","ATTACK","MOVE","TELEPORT","STRAFE"];
      
      private static const RING_TIMEOUT:Number = 1.7;
      
      private static const JUMP_LENGTH:Number = 0.3;
      
      private static const TELEPORT_TIME:Number = 0.95;
      
      private static const ATTACK_STOP_TIMEOUT:Number = 0.9;
      
      private static const ATTACK_START_TIMEOUT:Number = 0.45;
      
      private static const DECISION_TABLE:Array = [0.1640168826,0.3892556902,0.0336081053,0.2246864975,0.5434009453,0.4227320437,0.1017472328,0.2041907897,0.9950191347,0.3634705228,0.0779175897,0.384822732,0.3284047846,0.0951552057,0.1941055446,0.496359046,0.2428007567,0.8280672868,0.852732986,0.6928913176,0.2023843678,0.7280045905,0.4311591744,0.796788024,0.41191487,0.7108575032,0.1134556829,0.6883870615,0.8149317527,0.8392490375,0.3647662453,0.3487805783,0.7900575239,0.1670561498,0.9810836953,0.0097847681,0.2244645569,0.0842442402,0.3263779227,0.1481701068,0.6538572663,0.2544128409,0.1991950422,0.541057099,0.574700257,0.5926224371,0.310134571,0.6104650203,0.3545506087,0.2313309166,0.3070387696,0.0790505658,0.9804949607,0.7704714904,0.7152660213,0.8215058975,0.9426850446,0.7483973576,0.7602092802,0.881605898,0.5136580468,0.0190696615,0.28759162,0.1565554394,0.3664312259,0.2586407176,0.3185483313,0.9837348993,0.3330417452,0.2801789805,0.3288621592,0.0230039287,0.303914672,0.7212895333,0.6296904139,0.8659332532,0.1715852607,0.3900271956,0.2824020982,0.1624092775,0.7599701669,0.6952292831,0.2161165745,0.9005386635,0.3707154895,0.6392742953,0.452149187,0.5595775233,0.686286675,0.7266258821,0.6904605229,0.6808205255,0.6856147591,0.299675182,0.8012191872,0.804475971,0.1926201715,0.8868517061,0.8347136807,0.1512707539];
      
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      private static const REGULAR_JUMP:int = 428;
      
      private static const HIGH_JUMP:int = 920;
      
      public static const WEAPON_NONE:int = -1;
      
      public static const WEAPON_PEA_SHOOTER:int = 0;
      
      public static const WEAPON_BOOMERANG:int = 1;
      
      public static const WEAPON_SHADOW_WAVE:int = 2;
      
      public static const GRAV_NONE:int = -1;
      
      public static const GRAV_DOWN:int = 0;
      
      public static const GRAV_RIGHT:int = 1;
      
      public static const GRAV_UP:int = 2;
      
      public static const GRAV_LEFT:int = 3;
      
      public static const DIR_DOWN:int = 0;
      
      public static const DIR_RIGHT:int = 1;
      
      public static const DIR_UP:int = 2;
      
      public static const DIR_LEFT:int = 3;
      
      public static const FACE_FLOOR_LEFT:int = 0;
      
      public static const FACE_FLOOR_RIGHT:int = 1;
      
      public static const FACE_CEIL_LEFT:int = 2;
      
      public static const FACE_CEIL_RIGHT:int = 3;
      
      public static const FACE_RWALL_UP:int = 4;
      
      public static const FACE_RWALL_DOWN:int = 5;
      
      public static const FACE_LWALL_UP:int = 6;
      
      public static const FACE_LWALL_DOWN:int = 7;
      
      public static const dirName:Array = ["floor left","floor right","ceil left","ceil right","rwall up","rwall down","lwall up","lwall down"];
      
      public static const SNAILTYPE_METAL:int = 1;
      
      private static const WEAPON_TIMEOUTS:Array = [0.1,0.3,0.205];
      
      private static const WEAPON_SPEED:Array = [280,330,100];
      
      private var _ringTimeout:Number = 0;
      
      private var _releaseJumpTimeout:Number = 0;
      
      private var _gravJumpDir:int = -1;
      
      private var _attackMode:int = 0;
      
      private var _modeElapsed:Number = 0;
      
      private var _bossSpeed:Number = 1;
      
      private var _modeInitialized:Boolean = false;
      
      private var ACTION_TIMEOUT:Number = 0.7;
      
      private var SHADOW_BALL_RADIUS:Number = 80;
      
      private var SHADOW_BALL_NUM:int = 5;
      
      private var _actionTimeout:Number = 0;
      
      private var _shadowBall:Array;
      
      private var _moveStartX:Number = 0;
      
      private var _moveStartY:Number = 0;
      
      private var _moveEndX:Number = 0;
      
      private var _moveEndY:Number = 0;
      
      private var _teleStartX:Number = 0;
      
      private var _attackStartTimeout:Number = 0;
      
      private var _attackStopTimeout:Number = 0.9;
      
      private var _teleStartY:Number = 0;
      
      private var _teleEndX:Number = 0;
      
      private var _teleEndY:Number = 0;
      
      private var _originX:Number = 0;
      
      private var _originY:Number = 0;
      
      private var _targetGravity:int = -1;
      
      private var _attackPhase:int = 0;
      
      private var _lastAnim:String;
      
      private var _decisionTableIndex:int = 0;
      
      private var MAX_HP:int = 12500;
      
      private var _currentWeapon:int = 2;
      
      private var _nextMove:Number = 0;
      
      private var _runSpeed:uint = 300;
      
      private var _maxSpeed:uint = 500;
      
      private var _gravity:uint = 1200;
      
      private var _jumpPower:int = 428;
      
      private var _gravityDir:uint = 0;
      
      private var _desiredGravity:uint = 0;
      
      private var _faceDir:int = 1;
      
      private var _hidingInShell:Boolean = false;
      
      private var _jumping:Boolean = false;
      
      private var _fallFrames:int = 0;
      
      private var _hideOfsX:int = 0;
      
      private var _hideOfsY:int = 0;
      
      private var _hasWeapon:Array;
      
      private var _hasColdFoot:Boolean = true;
      
      private var _hasGravityJump:Boolean = true;
      
      private var _hasDevastator:Boolean = true;
      
      private var _hasHighJump:Boolean = true;
      
      private var _hasGravityShock:Boolean = true;
      
      private var _hasShellShield:Boolean = true;
      
      private var _hasRoll:Boolean = true;
      
      private var _hasArmor:Boolean = true;
      
      private var _justHitHeadOrWall:Boolean = false;
      
      private var _paralyzed:Boolean = false;
      
      public var elapsed:Number = 0;
      
      public var _isAttacking:Boolean = false;
      
      public var tappedUp:Boolean = false;
      
      public var tappedDown:Boolean = false;
      
      public var tappedRight:Boolean = false;
      
      public var tappedLeft:Boolean = false;
      
      public var tappedJump:Boolean = false;
      
      public var framesUp:int = -1;
      
      public var framesDown:int = -1;
      
      public var framesLeft:int = -1;
      
      public var framesRight:int = -1;
      
      public var framesJump:int = -1;
      
      private var _snailType:int = 1;
      
      private var _snailTypePrefix:String = "snail1_";
      
      private var _bulletGroups:Boss4BulletGroups;
      
      private var _turboMultiplier:Number = 0.5;
      
      private var _hasTurbo:Boolean = false;
      
      private var _weaponTimeout:Number = 0;
      
      private var _mostRecentDir:int = 0;
      
      private var _mostRecentUpDown:int = 0;
      
      private var _mostRecentLeftRight:int = 1;
      
      public function Boss4Rush(param1:int, param2:int)
      {
         this._hasWeapon = [true,true,true];
         if(PlayState.player._slugMode)
         {
            this._bossSpeed += 0.1;
         }
         super(param1,param2,this.MAX_HP,DEFENSE,OFFENSE);
         this._originX = param1;
         this._originY = param2;
         this._decisionTableIndex = PlayState.player.getMaxHp() + PlayState.player.getPercentComplete();
         this._decisionTableIndex %= DECISION_TABLE.length;
         loadGraphic(Art.Boss4Rush,true,true,IMG_WIDTH,IMG_HEIGHT);
         var _loc3_:int = 0;
         while(_loc3_ < 2)
         {
            addAnimation("snail" + (_loc3_ + 1).toString() + "_floor_right_move",[0 + _loc3_ * 20,1 + _loc3_ * 20],3,true);
            addAnimation("snail" + (_loc3_ + 1).toString() + "_floor_right_hide",[3 + _loc3_ * 20],9,false);
            addAnimation("snail" + (_loc3_ + 1).toString() + "_rwall_up_move",[4 + _loc3_ * 20,5 + _loc3_ * 20],3,true);
            addAnimation("snail" + (_loc3_ + 1).toString() + "_rwall_up_hide",[7 + _loc3_ * 20],9,false);
            addAnimation("snail" + (_loc3_ + 1).toString() + "_rwall_down_move",[8 + _loc3_ * 20,9 + _loc3_ * 20],3,true);
            addAnimation("snail" + (_loc3_ + 1).toString() + "_rwall_down_hide",[11 + _loc3_ * 20],9,false);
            addAnimation("snail" + (_loc3_ + 1).toString() + "_ceil_right_move",[12 + _loc3_ * 20,13 + _loc3_ * 20],3,true);
            addAnimation("snail" + (_loc3_ + 1).toString() + "_ceil_right_hide",[15 + _loc3_ * 20],9,false);
            addAnimation("snail" + (_loc3_ + 1).toString() + "_death",[16 + _loc3_ * 20,17 + _loc3_ * 20,18 + _loc3_ * 20,19 + _loc3_ * 20],30,true);
            _loc3_++;
         }
         this._runSpeed = 410;
         this._maxSpeed = 600;
         this._gravity = 1200;
         maxVelocity.x = this._maxSpeed;
         maxVelocity.y = this._maxSpeed;
         this._shadowBall = new Array();
         _loc3_ = 0;
         while(_loc3_ < this.SHADOW_BALL_NUM)
         {
            this._shadowBall[_loc3_] = new Boss4ShadowBall();
            PlayState.enemies.add(this._shadowBall[_loc3_]);
            _loc3_++;
         }
         this.setGravityDir(GRAV_DOWN);
         this.setFaceDir(FACE_FLOOR_RIGHT,true);
         this.playAnim("floor_right_move");
         this._bulletGroups = PlayState.boss4BulletGroups;
         PlayState.player.x -= 60;
         Music.playBoss1();
         PlayState.player.setFaceDir(Player.FACE_FLOOR_LEFT);
      }
      
      public function setMode(param1:int, param2:Boolean = false) : void
      {
         this._attackMode = param1;
         this._modeElapsed = 0;
         this._modeInitialized = false;
         this._isAttacking = false;
         this._actionTimeout = this.ACTION_TIMEOUT;
         var _loc3_:int = 0;
         while(_loc3_ < this._shadowBall.length)
         {
            this._shadowBall[_loc3_].visible = false;
            _loc3_++;
         }
         visible = true;
         solid = true;
         this.releaseUp();
         this.releaseDown();
         this.releaseLeft();
         this.releaseRight();
         this.releaseJump();
         this._attackStopTimeout = ATTACK_STOP_TIMEOUT;
         this._attackStartTimeout = ATTACK_START_TIMEOUT;
         if(param2)
         {
            this.checkFireRings();
         }
      }
      
      public function checkFireRings() : void
      {
         if(this._ringTimeout <= 0)
         {
            this._ringTimeout = RING_TIMEOUT;
            PlayState.enemiesNoCollide.add(new Boss4RingCenter(x,y));
         }
      }
      
      public function pickMoveTarget() : void
      {
         var _loc1_:int = 0;
         this._moveStartX = x;
         this._moveStartY = y;
         this._moveEndX = x;
         this._moveEndY = y;
         while(Utility.dist(this._moveEndX,this._moveEndY,x,y) < 60)
         {
            _loc1_ = this.getDecision() * 6;
            switch(_loc1_)
            {
               case 0:
                  this._moveEndX = this._originX + 16 * 1;
                  this._moveEndY = this._originY + 16 * 4;
                  this._targetGravity = GRAV_DOWN;
                  break;
               case 1:
                  this._moveEndX = this._originX + 16 * 14;
                  this._moveEndY = this._originY + 16 * 4;
                  this._targetGravity = GRAV_DOWN;
                  break;
               case 2:
                  this._moveEndX = this._originX + 16 * 1;
                  this._moveEndY = this._originY + 16 * -8;
                  this._targetGravity = GRAV_UP;
                  break;
               case 3:
                  this._moveEndX = this._originX + 16 * 14;
                  this._moveEndY = this._originY + 16 * -8;
                  this._targetGravity = GRAV_UP;
                  break;
               case 4:
                  this._moveEndX = this._originX + 16 * -3;
                  this._moveEndY = this._originY + 16 * -2;
                  this._targetGravity = GRAV_LEFT;
                  break;
               case 5:
                  this._moveEndX = this._originX + 16 * 18;
                  this._moveEndY = this._originY + 16 * -2;
                  this._targetGravity = GRAV_RIGHT;
                  break;
            }
         }
      }
      
      public function pickTeleTarget() : void
      {
         var _loc1_:int = 0;
         this._teleStartX = x;
         this._teleStartY = y;
         this._teleEndX = x;
         this._teleEndY = y;
         while(Utility.dist(this._teleEndX,this._teleEndY,x,y) < 60)
         {
            _loc1_ = this.getDecision() * 6;
            switch(_loc1_)
            {
               case 0:
                  this._teleEndX = this._originX + 16 * 1;
                  this._teleEndY = this._originY + 16 * 4;
                  this.setGravityDir(GRAV_DOWN);
                  this.setFaceDir(FACE_FLOOR_RIGHT);
                  break;
               case 1:
                  this._teleEndX = this._originX + 16 * 14;
                  this._teleEndY = this._originY + 16 * 4;
                  this.setGravityDir(GRAV_DOWN);
                  this.setFaceDir(FACE_FLOOR_LEFT);
                  break;
               case 2:
                  this._teleEndX = this._originX + 16 * 1;
                  this._teleEndY = this._originY + 16 * -8;
                  this.setGravityDir(GRAV_UP);
                  this.setFaceDir(FACE_CEIL_RIGHT);
                  break;
               case 3:
                  this._teleEndX = this._originX + 16 * 14;
                  this._teleEndY = this._originY + 16 * -8;
                  this.setGravityDir(GRAV_UP);
                  this.setFaceDir(FACE_CEIL_LEFT);
                  break;
               case 4:
                  this._teleEndX = this._originX + 16 * -3;
                  this._teleEndY = this._originY + 16 * -2;
                  this.setGravityDir(GRAV_LEFT);
                  this.setFaceDir(FACE_LWALL_UP);
                  break;
               case 5:
                  this._teleEndX = this._originX + 16 * 19;
                  this._teleEndY = this._originY + 16 * -2;
                  this.setGravityDir(GRAV_RIGHT);
                  this.setFaceDir(FACE_RWALL_UP);
                  break;
            }
         }
      }
      
      public function updateAiMove() : void
      {
         if(!this._modeInitialized)
         {
            this._modeInitialized = true;
            this.pickMoveTarget();
            this._currentWeapon = 1;
            this.releaseUp();
            this.releaseDown();
            this.releaseLeft();
            this.releaseRight();
         }
         if(this._attackPhase >= 1 || PlayState.player._slugMode)
         {
            this._isAttacking = true;
         }
         if((this._gravityDir == GRAV_DOWN || this._gravityDir == GRAV_UP) && Math.abs(this._moveEndX - x) > 10)
         {
            if(this._moveEndX > x)
            {
               this.pressRight();
            }
            else
            {
               this.pressLeft();
            }
         }
         else
         {
            this.releaseRight();
            this.releaseLeft();
         }
         if((this._gravityDir == GRAV_LEFT || this._gravityDir == GRAV_RIGHT) && Math.abs(this._moveEndY - y) > 10)
         {
            if(this._moveEndY > y)
            {
               this.pressDown();
            }
            else
            {
               this.pressUp();
            }
         }
         else
         {
            this.releaseDown();
            this.releaseUp();
         }
         if(!this._jumping)
         {
            if(this._gravityDir != this._targetGravity)
            {
               this.aiJump(this._targetGravity);
            }
            else
            {
               this.aiJump();
            }
         }
         this.checkFireRings();
         if(Utility.dist(this._moveEndX,this._moveEndY,x,y) < 40)
         {
            this.setMode(MODE_ATTACK);
         }
      }
      
      public function updateAiIntro() : void
      {
         if(this._modeElapsed > 0.3)
         {
            this.setMode(MODE_ATTACK);
         }
      }
      
      public function updateAiTeleport() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(!this._modeInitialized)
         {
            this._modeInitialized = true;
            this.pickTeleTarget();
            visible = false;
            solid = false;
            _loc4_ = 0;
            while(_loc4_ < this._shadowBall.length)
            {
               this._shadowBall[_loc4_].x = this._teleStartX;
               this._shadowBall[_loc4_].y = this._teleStartY;
               this._shadowBall[_loc4_].visible = true;
               _loc4_++;
            }
         }
         var _loc1_:Number = this.normalizedSigmoid(this._modeElapsed / TELEPORT_TIME);
         if(_loc1_ <= 0.5)
         {
            _loc2_ = this.SHADOW_BALL_RADIUS * this.normalizedSigmoid(this._modeElapsed / TELEPORT_TIME * 2);
         }
         else
         {
            _loc2_ = this.SHADOW_BALL_RADIUS * this.normalizedSigmoid((1 - this._modeElapsed / TELEPORT_TIME) * 2);
         }
         if(_loc1_ <= 0.5)
         {
            _loc3_ = Math.PI * 2 * this.normalizedSigmoid(this._modeElapsed / TELEPORT_TIME * 2);
         }
         else
         {
            _loc3_ = Math.PI * 2 * this.normalizedSigmoid((1 - this._modeElapsed / TELEPORT_TIME) * 2);
         }
         _loc4_ = 0;
         while(_loc4_ < this._shadowBall.length)
         {
            this._shadowBall[_loc4_].x = this._teleStartX * (1 - _loc1_) + this._teleEndX * _loc1_ + Math.cos(_loc3_ + Math.PI * 2 / this._shadowBall.length * _loc4_) * _loc2_;
            this._shadowBall[_loc4_].y = this._teleStartY * (1 - _loc1_) + this._teleEndY * _loc1_ - Math.sin(_loc3_ + Math.PI * 2 / this._shadowBall.length * _loc4_) * _loc2_;
            _loc4_++;
         }
         velocity.x = 0;
         velocity.y = 0;
         x = this._teleEndX;
         y = this._teleEndY;
         this.releaseJump();
         if(this._modeElapsed / TELEPORT_TIME >= 1)
         {
            this.setMode(MODE_ATTACK,true);
         }
      }
      
      public function facePlayer() : void
      {
         switch(this._gravityDir)
         {
            case GRAV_UP:
            case GRAV_DOWN:
               if(PlayState.player.x < x && facing == RIGHT)
               {
                  this.tapLeft();
               }
               else if(PlayState.player.x > x && facing == LEFT)
               {
                  this.tapRight();
               }
               break;
            case GRAV_LEFT:
               if(PlayState.player.y < y && this._faceDir == FACE_LWALL_DOWN)
               {
                  this.tapUp();
               }
               else if(PlayState.player.y > y && this._faceDir == FACE_LWALL_UP)
               {
                  this.tapDown();
               }
               break;
            case GRAV_RIGHT:
               if(PlayState.player.y < y && this._faceDir == FACE_RWALL_DOWN)
               {
                  this.tapUp();
               }
               else if(PlayState.player.y > y && this._faceDir == FACE_RWALL_UP)
               {
                  this.tapDown();
               }
         }
      }
      
      public function aiJump(param1:int = -1, param2:Number = 0.3) : void
      {
         if(this._releaseJumpTimeout > 0)
         {
            return;
         }
         this.pressJump();
         this._releaseJumpTimeout = param2;
         this._gravJumpDir = param1;
      }
      
      public function updateAiAttack() : void
      {
         this.facePlayer();
         if(!this._isAttacking)
         {
            this._attackStartTimeout -= FlxG.elapsed * this._bossSpeed;
            if(this._attackStartTimeout < 0)
            {
               this._attackStopTimeout = ATTACK_STOP_TIMEOUT;
               this._isAttacking = true;
            }
         }
         else
         {
            this._attackStopTimeout -= FlxG.elapsed * this._bossSpeed;
            if(this._attackStopTimeout < 0)
            {
               this._attackStartTimeout = ATTACK_START_TIMEOUT;
               this._isAttacking = false;
            }
         }
         this._currentWeapon = 2;
         if(this._actionTimeout <= 0)
         {
            this._actionTimeout = this.ACTION_TIMEOUT;
            if(this.getDecision() < 0.2)
            {
               switch(this._gravityDir)
               {
                  case GRAV_RIGHT:
                     this.aiJump(GRAV_LEFT);
                     break;
                  case GRAV_LEFT:
                     this.aiJump(GRAV_RIGHT);
                     break;
                  case GRAV_UP:
                     this.aiJump(GRAV_DOWN);
                     break;
                  case GRAV_DOWN:
                     this.aiJump(GRAV_UP);
               }
            }
            else if(this.getDecision() < 0.4)
            {
               this.aiJump();
            }
            else if(this.getDecision() < 0.4)
            {
               this.setMode(MODE_TELEPORT);
            }
            else
            {
               this.setMode(MODE_MOVE);
            }
         }
         if(Utility.dist(x + width / 2,y + width / 2,PlayState.player.x + PlayState.player.width / 2,PlayState.player.y + PlayState.player.height / 2) < 60)
         {
            this.setMode(MODE_TELEPORT);
         }
         else
         {
            switch(this._gravityDir)
            {
               case GRAV_RIGHT:
                  if(Math.abs(PlayState.player.y - y) < 50 || Math.abs(PlayState.player.x - x) > 200)
                  {
                     this.pressLeft();
                  }
                  else
                  {
                     this.releaseLeft();
                  }
                  break;
               case GRAV_LEFT:
                  if(Math.abs(PlayState.player.y - y) < 50 || Math.abs(PlayState.player.x - x) > 200)
                  {
                     this.pressRight();
                  }
                  else
                  {
                     this.releaseRight();
                  }
                  break;
               case GRAV_DOWN:
                  if(Math.abs(PlayState.player.x - x) < 50 || Math.abs(PlayState.player.y - y) > 200)
                  {
                     this.pressUp();
                  }
                  else
                  {
                     this.releaseUp();
                  }
                  break;
               case GRAV_UP:
                  if(Math.abs(PlayState.player.x - x) < 50 || Math.abs(PlayState.player.y - y) > 200)
                  {
                     this.pressDown();
                  }
                  else
                  {
                     this.releaseDown();
                  }
            }
         }
      }
      
      private function normalizedSigmoid(param1:Number) : Number
      {
         return 1 / (1 + Math.exp(-(param1 * 8 - 4)));
      }
      
      public function updateAi() : void
      {
         this._ringTimeout -= FlxG.elapsed * this._bossSpeed;
         if(this.tappedUp)
         {
            this.tappedUp = false;
            this.releaseUp();
         }
         if(this.tappedDown)
         {
            this.tappedDown = false;
            this.releaseDown();
         }
         if(this.tappedRight)
         {
            this.tappedRight = false;
            this.releaseRight();
         }
         if(this.tappedLeft)
         {
            this.tappedLeft = false;
            this.releaseLeft();
         }
         this._modeElapsed += FlxG.elapsed * this._bossSpeed;
         this._actionTimeout -= FlxG.elapsed * this._bossSpeed;
         switch(this._attackMode)
         {
            case MODE_INTRO:
               this.updateAiIntro();
               break;
            case MODE_MOVE:
               this.updateAiMove();
               break;
            case MODE_ATTACK:
               this.updateAiAttack();
               break;
            case MODE_TELEPORT:
               this.updateAiTeleport();
               break;
            case MODE_STRAFE:
         }
         this._releaseJumpTimeout -= FlxG.elapsed;
         if(this._releaseJumpTimeout <= 0 && this.pressedJump())
         {
            this.releaseJump();
            if(this._gravJumpDir != GRAV_NONE)
            {
               switch(this._gravJumpDir)
               {
                  case GRAV_RIGHT:
                     this.tapRight();
                     this.aiJump(GRAV_NONE,0.1);
                     break;
                  case GRAV_LEFT:
                     this.tapLeft();
                     this.aiJump(GRAV_NONE,0.1);
                     break;
                  case GRAV_UP:
                     this.tapUp();
                     this.aiJump(GRAV_NONE,0.1);
                     break;
                  case GRAV_DOWN:
                     this.tapDown();
                     this.aiJump(GRAV_NONE,0.1);
               }
            }
         }
      }
      
      public function getDecision() : Number
      {
         ++this._decisionTableIndex;
         this._decisionTableIndex %= DECISION_TABLE.length;
         return DECISION_TABLE[this._decisionTableIndex];
      }
      
      public function pressRight() : void
      {
         this.framesRight = 1;
         this.framesLeft = -1;
      }
      
      public function releaseRight() : void
      {
         this.framesRight = -1;
      }
      
      public function pressLeft() : void
      {
         this.framesLeft = 1;
         this.framesRight = -1;
      }
      
      public function releaseLeft() : void
      {
         this.framesLeft = -1;
      }
      
      public function pressDown() : void
      {
         this.framesDown = 1;
         this.framesUp = -1;
      }
      
      public function releaseDown() : void
      {
         this.framesDown = -1;
      }
      
      public function pressUp() : void
      {
         this.framesUp = 1;
         this.framesDown = -1;
      }
      
      public function releaseUp() : void
      {
         this.framesUp = -1;
      }
      
      public function pressJump() : void
      {
         this.framesJump = 1;
      }
      
      public function releaseJump() : void
      {
         this.framesJump = -1;
      }
      
      public function tapUp() : void
      {
         this.pressUp();
         this.tappedUp = true;
      }
      
      public function tapDown() : void
      {
         this.pressDown();
         this.tappedDown = true;
      }
      
      public function tapRight() : void
      {
         this.pressRight();
         this.tappedRight = true;
      }
      
      public function tapLeft() : void
      {
         this.pressLeft();
         this.tappedLeft = true;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(!PlayState.player.isParalyzed())
         {
            this.updateAi();
         }
         this.elapsed += FlxG.elapsed;
         this.fixGravity();
         if(this.justPressedJump() && this._jumping)
         {
            this.performGravityJump();
         }
         this.checkInput_move();
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
         FlxU.collide(this,PlayState.solidItems);
         FlxU.overlap(PlayState.playerBulletGroups,this._bulletGroups,this.overlapPlayerBulletBoss4Bullet);
         FlxU.overlap(PlayState.player,this._bulletGroups,this.overlapPlayerBoss4Bullet);
         this.attack();
         if(this.framesUp > 0)
         {
            ++this.framesUp;
         }
         if(this.framesDown > 0)
         {
            ++this.framesDown;
         }
         if(this.framesLeft > 0)
         {
            ++this.framesLeft;
         }
         if(this.framesRight > 0)
         {
            ++this.framesRight;
         }
         if(this.framesJump > 0)
         {
            ++this.framesJump;
         }
         super.update();
      }
      
      override public function hitLeft(param1:FlxObject, param2:Number) : void
      {
         this._justHitHeadOrWall = true;
         super.hitLeft(param1,param2);
      }
      
      override public function hitRight(param1:FlxObject, param2:Number) : void
      {
         this._justHitHeadOrWall = true;
         super.hitRight(param1,param2);
      }
      
      public function moveSnailCheckBounds(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2;
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
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         this._justHitHeadOrWall = false;
         super.hitBottom(param1,param2);
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         this._justHitHeadOrWall = true;
         super.hitTop(param1,param2);
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         this._bulletGroups = null;
         this._hasWeapon = null;
         for(_loc1_ in this._shadowBall)
         {
            this._shadowBall[_loc1_] = null;
         }
         this._shadowBall = null;
         super.destroy();
      }
      
      public function overlapPlayerBulletBoss4Bullet(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:PlayerBullet = null;
         var _loc4_:Boss4Bullet = null;
         if(param1 is PlayerBullet && param2 is Boss4Bullet)
         {
            _loc3_ = param1 as PlayerBullet;
            _loc4_ = param2 as Boss4Bullet;
            _loc4_.hitPlayerBullet(_loc3_);
         }
      }
      
      public function setGravityDir(param1:int) : void
      {
         this._gravityDir = param1;
         switch(this._gravityDir)
         {
            case GRAV_DOWN:
               acceleration.x = 0;
               acceleration.y = this._gravity;
               drag.x = this._runSpeed * 200;
               drag.y = 0;
               break;
            case GRAV_RIGHT:
               acceleration.x = this._gravity;
               acceleration.y = 0;
               drag.y = this._runSpeed * 200;
               drag.x = 0;
               break;
            case GRAV_UP:
               acceleration.x = 0;
               acceleration.y = -this._gravity;
               drag.x = this._runSpeed * 200;
               drag.y = 0;
               break;
            case GRAV_LEFT:
               acceleration.x = -this._gravity;
               acceleration.y = 0;
               drag.y = this._runSpeed * 200;
               drag.x = 0;
         }
      }
      
      public function hideInShell(param1:Boolean) : void
      {
         this._hidingInShell = param1;
         this.setFaceDir(this._faceDir,true);
      }
      
      public function overlapPlayerBoss4Bullet(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:Player = null;
         var _loc4_:Boss4Bullet = null;
         if(param1 is Player && param2 is Boss4Bullet)
         {
            _loc3_ = param1 as Player;
            _loc4_ = param2 as Boss4Bullet;
            _loc4_.hitPlayer(_loc3_);
         }
      }
      
      private function fixGravity() : void
      {
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
               if(!this._hasGravityJump && this._fallFrames == 1)
               {
                  this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
               }
               else if(this._hasGravityJump && this._fallFrames == 1 && this.pressedUp() && this.pressedRight())
               {
                  this.setFaceDir(FACE_LWALL_UP);
                  --y;
               }
               else if(this._hasGravityJump && this._fallFrames == 1 && this.pressedUp() && this.pressedLeft())
               {
                  this.setFaceDir(FACE_RWALL_UP);
                  --y;
                  x += 12;
               }
               else if(this._hasGravityJump && !this.pressedJump() && this._fallFrames == 1 && !this.pressedUp())
               {
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
               if(!this._jumping && velocity.y > 0 && this.pressedDown() && !this._justHitHeadOrWall)
               {
                  if(facing == RIGHT && this.pressedRight())
                  {
                     this.setFaceDir(FACE_LWALL_DOWN);
                     velocity.x = -this._runSpeed;
                     y -= 11;
                  }
                  else if(facing == LEFT && this.pressedLeft())
                  {
                     this.setFaceDir(FACE_RWALL_DOWN);
                     velocity.x = this._runSpeed;
                     x += 15;
                     y -= 11;
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
               if(this._fallFrames == 1)
               {
                  this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
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
               if(!this._hasGravityJump && this._fallFrames == 1)
               {
                  this.setFaceDir(FACE_FLOOR_LEFT);
                  y += 13;
               }
               else if(this._hasGravityJump && this._fallFrames == 1 && this.pressedUp() && this.pressedLeft())
               {
                  this.setFaceDir(FACE_FLOOR_LEFT);
                  y += 13;
               }
               else if(this._hasGravityJump && this._fallFrames == 1 && this.pressedDown() && this.pressedLeft())
               {
                  this.setFaceDir(FACE_CEIL_LEFT);
                  y += 1;
               }
               else if(this._hasGravityJump && !this.pressedJump() && this._fallFrames == 1 && !this.pressedLeft())
               {
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
               if(!this._hasGravityJump && this._jumping)
               {
                  this.setFaceDir(FACE_FLOOR_RIGHT);
                  x -= 6;
                  y += 13;
               }
               else if(this._hasGravityJump && this._fallFrames == 1 && this.pressedUp() && this.pressedRight())
               {
                  this.setFaceDir(FACE_FLOOR_RIGHT);
                  x -= 6;
                  y += 13;
               }
               else if(this._hasGravityJump && this._fallFrames == 1 && this.pressedDown() && this.pressedRight())
               {
                  this.setFaceDir(FACE_CEIL_RIGHT);
                  x -= 6;
                  y += 1;
               }
               else if(this._hasGravityJump && !this.pressedJump() && this._fallFrames == 1 && !this.pressedRight())
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
      
      private function doJump() : void
      {
         this.hideInShell(false);
         Sfx.playJump1();
         this.doGravityJump();
      }
      
      private function doGravityJump() : void
      {
         switch(this._gravityDir)
         {
            case GRAV_UP:
               velocity.y = this._jumpPower;
               break;
            case GRAV_DOWN:
               velocity.y = -this._jumpPower;
               break;
            case GRAV_LEFT:
               velocity.x = this._jumpPower;
               break;
            case GRAV_RIGHT:
               velocity.x = -this._jumpPower;
         }
      }
      
      public function setFaceDirHiding(param1:int) : void
      {
         switch(this._faceDir)
         {
            case FACE_FLOOR_LEFT:
               offset.x = 0 + 13;
               width = 32 - 13 - 7;
               offset.y = 16 + 6;
               height = 16 - 6;
               this.setGravityDir(GRAV_DOWN);
               this.playAnim("floor_right_hide");
               this._hideOfsX = 9;
               x += this._hideOfsX;
               this._hideOfsY = 4;
               y += this._hideOfsY;
               break;
            case FACE_FLOOR_RIGHT:
               offset.x = 0 + 7;
               width = 32 - 7 - 13;
               offset.y = 16 + 6;
               height = 16 - 6;
               this.setGravityDir(GRAV_DOWN);
               this._hideOfsX = 3;
               x += this._hideOfsX;
               this._hideOfsY = 4;
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
      
      public function setFaceDirNotHiding(param1:int) : void
      {
         switch(this._faceDir)
         {
            case FACE_FLOOR_LEFT:
            case FACE_FLOOR_RIGHT:
               offset.x = 0 + 4;
               width = 32 - 4 - 4;
               offset.y = 16 + 3;
               height = 16 - 3;
               this.setGravityDir(GRAV_DOWN);
               this.playAnim("floor_right_move");
               break;
            case FACE_CEIL_LEFT:
            case FACE_CEIL_RIGHT:
               offset.x = 0 + 4;
               width = 32 - 4 - 4;
               offset.y = 0 + 0;
               height = 16 - 3;
               this.setGravityDir(GRAV_UP);
               this.playAnim("ceil_right_move");
               break;
            case FACE_RWALL_UP:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 16 + 3;
               width = 16 - 3;
               this.setGravityDir(GRAV_RIGHT);
               this.playAnim("rwall_up_move");
               facing = RIGHT;
               break;
            case FACE_RWALL_DOWN:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 16 + 3;
               width = 16 - 3;
               this.setGravityDir(GRAV_RIGHT);
               this.playAnim("rwall_down_move");
               facing = RIGHT;
               break;
            case FACE_LWALL_UP:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 0 + 0;
               width = 16 - 3;
               this.setGravityDir(GRAV_LEFT);
               this.playAnim("rwall_up_move");
               facing = LEFT;
               break;
            case FACE_LWALL_DOWN:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 0 + 0;
               width = 16 - 3;
               this.setGravityDir(GRAV_LEFT);
               this.playAnim("rwall_down_move");
               facing = LEFT;
         }
      }
      
      public function setFaceDir(param1:int, param2:Boolean = false) : void
      {
         if(this._faceDir == param1 && !param2)
         {
            return;
         }
         this._faceDir = param1;
         x -= this._hideOfsX;
         this._hideOfsX = 0;
         y -= this._hideOfsY;
         this._hideOfsY = 0;
         if(this._hidingInShell)
         {
            this.setFaceDirHiding(this._faceDir);
         }
         else
         {
            this.setFaceDirNotHiding(this._faceDir);
         }
      }
      
      public function attack() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         this._weaponTimeout -= FlxG.elapsed;
         if(this._weaponTimeout > 0)
         {
            return;
         }
         if(!this._isAttacking)
         {
            return;
         }
         if(this._hidingInShell)
         {
            this.hideInShell(false);
         }
         var _loc1_:Boss4Bullet = this._bulletGroups.getBullet(this._currentWeapon);
         if(_loc1_)
         {
            _loc2_ = -1;
            if(this._jumping)
            {
               _loc3_ = [1,1,1,1,1,1,1,1];
            }
            else if(this._currentWeapon == WEAPON_PEA_SHOOTER)
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
            _loc4_ = [0,40,90,140,180,-140,-90,-40];
            _loc5_ = int(_loc4_[_loc2_]);
            _loc6_ = WEAPON_SPEED[this._currentWeapon] / this._turboMultiplier;
            _loc7_ = Math.cos(_loc5_ * Math.PI / 180) * _loc6_;
            _loc8_ = -Math.sin(_loc5_ * Math.PI / 180) * _loc6_;
            _loc1_.shoot(x + width / 2,y + height / 2,_loc7_,_loc8_);
            this._weaponTimeout = WEAPON_TIMEOUTS[this._currentWeapon] * this._turboMultiplier;
         }
      }
      
      private function justPressedDown() : Boolean
      {
         return this.framesDown == 1;
      }
      
      private function justPressedLeft() : Boolean
      {
         return this.framesLeft == 1;
      }
      
      private function justPressedUp() : Boolean
      {
         return this.framesUp == 1;
      }
      
      private function justPressedRight() : Boolean
      {
         return this.framesRight == 1;
      }
      
      private function justPressedJump() : Boolean
      {
         return this.framesJump == 1;
      }
      
      private function pressedDown() : Boolean
      {
         return this.framesDown > 0;
      }
      
      private function pressedLeft() : Boolean
      {
         return this.framesLeft > 0;
      }
      
      private function pressedUp() : Boolean
      {
         return this.framesUp > 0;
      }
      
      private function pressedRight() : Boolean
      {
         return this.framesRight > 0;
      }
      
      private function pressedJump() : Boolean
      {
         return this.framesJump > 0;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      private function performGravityJump() : void
      {
         switch(this._gravityDir)
         {
            case GRAV_DOWN:
               if((!this.pressedLeft() && !this.pressedRight() || this._mostRecentDir == DIR_UP) && this.pressedUp())
               {
                  this.setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                  this._desiredGravity = GRAV_UP;
               }
               else if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_RIGHT) && this.pressedRight())
               {
                  this.setFaceDir(FACE_RWALL_UP);
                  this._desiredGravity = GRAV_RIGHT;
               }
               else if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_LEFT) && this.pressedLeft())
               {
                  this.setFaceDir(FACE_LWALL_UP);
                  this._desiredGravity = GRAV_LEFT;
               }
               break;
            case GRAV_UP:
               if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_RIGHT) && this.pressedRight())
               {
                  this.setFaceDir(FACE_RWALL_DOWN);
                  this._desiredGravity = GRAV_RIGHT;
               }
               else if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_LEFT) && this.pressedLeft())
               {
                  this.setFaceDir(FACE_LWALL_DOWN);
                  this._desiredGravity = GRAV_LEFT;
               }
               else if(this.pressedDown())
               {
                  this.setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                  this._desiredGravity = GRAV_DOWN;
               }
               break;
            case GRAV_RIGHT:
               if((!this.pressedLeft() && !this.pressedRight() || this._mostRecentDir == DIR_UP) && this.pressedUp())
               {
                  this.setFaceDir(FACE_CEIL_RIGHT);
                  this._desiredGravity = GRAV_UP;
               }
               else if(!((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_RIGHT) && this.pressedRight()))
               {
                  if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_LEFT) && this.pressedLeft())
                  {
                     this.setFaceDir(this._faceDir == FACE_RWALL_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                     this._desiredGravity = GRAV_LEFT;
                  }
                  else
                  {
                     this.setFaceDir(FACE_FLOOR_RIGHT);
                     this._desiredGravity = GRAV_DOWN;
                  }
               }
               break;
            case GRAV_LEFT:
               if((!this.pressedLeft() && !this.pressedRight() || this._mostRecentDir == DIR_UP) && this.pressedUp())
               {
                  this.setFaceDir(FACE_CEIL_LEFT);
                  this._desiredGravity = GRAV_UP;
               }
               else if(!((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_LEFT) && this.pressedLeft()))
               {
                  if((!this.pressedDown() && !this.pressedUp() || this._mostRecentDir == DIR_RIGHT) && this.pressedRight())
                  {
                     this.setFaceDir(this._faceDir == FACE_LWALL_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
                     this._desiredGravity = GRAV_RIGHT;
                  }
                  else
                  {
                     this.setFaceDir(FACE_FLOOR_LEFT);
                     this._desiredGravity = GRAV_DOWN;
                  }
               }
         }
         this._desiredGravity = GRAV_DOWN;
      }
      
      private function checkInput_move() : void
      {
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
         var _loc1_:Boolean = this._hidingInShell && !this._jumping && !this._hasRoll;
         switch(this._gravityDir)
         {
            case GRAV_UP:
               acceleration.x = 0;
               if(this.pressedLeft())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  facing = LEFT;
                  velocity.x = -this._runSpeed;
                  this.setFaceDir(FACE_CEIL_LEFT);
               }
               else if(this.pressedRight())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  facing = RIGHT;
                  velocity.x = this._runSpeed;
                  this.setFaceDir(FACE_CEIL_RIGHT);
               }
               break;
            case GRAV_DOWN:
               acceleration.x = 0;
               if(this.pressedLeft())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  facing = LEFT;
                  velocity.x = -this._runSpeed;
                  this.setFaceDir(FACE_FLOOR_LEFT);
               }
               else if(this.pressedRight())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  facing = RIGHT;
                  velocity.x = this._runSpeed;
                  this.setFaceDir(FACE_FLOOR_RIGHT);
               }
               break;
            case GRAV_LEFT:
               acceleration.y = 0;
               if(this.pressedUp())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  velocity.y = -this._runSpeed;
                  facing = LEFT;
                  this.setFaceDir(FACE_LWALL_UP);
               }
               else if(this.pressedDown())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  velocity.y = this._runSpeed;
                  facing = LEFT;
                  this.setFaceDir(FACE_LWALL_DOWN);
               }
               break;
            case GRAV_RIGHT:
               acceleration.y = 0;
               if(this.pressedUp())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  velocity.y = -this._runSpeed;
                  facing = RIGHT;
                  this.setFaceDir(FACE_RWALL_UP);
               }
               else if(this.pressedDown())
               {
                  if(_loc1_)
                  {
                     this.hideInShell(false);
                  }
                  velocity.y = this._runSpeed;
                  facing = RIGHT;
                  this.setFaceDir(FACE_RWALL_DOWN);
               }
         }
      }
      
      private function playAnim(param1:String) : void
      {
         this._lastAnim = param1;
         play(this._snailTypePrefix + param1);
      }
      
      override public function kill() : void
      {
         super.kill();
         if(_hp <= 0 && !PlayState.player.dead)
         {
            PlayState.enemies.add(new Boss4RushSecondForm(this._originX,this._originY));
            PlayState.sprites.add(new QueuedExplosion(x,y));
         }
         else
         {
            Music.playBoss1();
         }
         this._bulletGroups.destroyAll();
         PlayState.enemyBulletPool.destroyAll();
         dead = true;
         exists = false;
         active = false;
         visible = false;
      }
      
      override public function hurt(param1:Number) : void
      {
         if(_hp <= this.MAX_HP * 0.4 && this._attackPhase < 1)
         {
            this._bossSpeed += 0.2;
            this._attackPhase = 1;
            this._snailTypePrefix = "snail2_";
            this.playAnim(this._lastAnim);
         }
         super.hurt(param1);
      }
   }
}

