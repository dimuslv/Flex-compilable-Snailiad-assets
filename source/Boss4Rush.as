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
      
      public function setMode(param1:int, param2:Boolean = false) : void
      {
         _attackMode = param1;
         _modeElapsed = 0;
         _modeInitialized = false;
         _isAttacking = false;
         _actionTimeout = ACTION_TIMEOUT;
         var _loc3_:int = 0;
         while(_loc3_ < _shadowBall.length)
         {
            _shadowBall[_loc3_].visible = false;
            _loc3_++;
         }
         visible = true;
         solid = true;
         releaseUp();
         releaseDown();
         releaseLeft();
         releaseRight();
         releaseJump();
         _attackStopTimeout = ATTACK_STOP_TIMEOUT;
         _attackStartTimeout = ATTACK_START_TIMEOUT;
         if(param2)
         {
            checkFireRings();
         }
      }
      
      public function checkFireRings() : void
      {
         if(_ringTimeout <= 0)
         {
            _ringTimeout = RING_TIMEOUT;
            PlayState.enemiesNoCollide.add(new Boss4RingCenter(x,y));
         }
      }
      
      public function pickMoveTarget() : void
      {
         var _loc1_:int = 0;
         _moveStartX = x;
         _moveStartY = y;
         _moveEndX = x;
         _moveEndY = y;
         while(Utility.dist(_moveEndX,_moveEndY,x,y) < 60)
         {
            _loc1_ = getDecision() * 6;
            switch(_loc1_)
            {
               case 0:
                  _moveEndX = _originX + 16 * 1;
                  _moveEndY = _originY + 16 * 4;
                  _targetGravity = GRAV_DOWN;
                  break;
               case 1:
                  _moveEndX = _originX + 16 * 14;
                  _moveEndY = _originY + 16 * 4;
                  _targetGravity = GRAV_DOWN;
                  break;
               case 2:
                  _moveEndX = _originX + 16 * 1;
                  _moveEndY = _originY + 16 * -8;
                  _targetGravity = GRAV_UP;
                  break;
               case 3:
                  _moveEndX = _originX + 16 * 14;
                  _moveEndY = _originY + 16 * -8;
                  _targetGravity = GRAV_UP;
                  break;
               case 4:
                  _moveEndX = _originX + 16 * -3;
                  _moveEndY = _originY + 16 * -2;
                  _targetGravity = GRAV_LEFT;
                  break;
               case 5:
                  _moveEndX = _originX + 16 * 18;
                  _moveEndY = _originY + 16 * -2;
                  _targetGravity = GRAV_RIGHT;
                  break;
            }
         }
      }
      
      public function pickTeleTarget() : void
      {
         var _loc1_:int = 0;
         _teleStartX = x;
         _teleStartY = y;
         _teleEndX = x;
         _teleEndY = y;
         while(Utility.dist(_teleEndX,_teleEndY,x,y) < 60)
         {
            _loc1_ = getDecision() * 6;
            switch(_loc1_)
            {
               case 0:
                  _teleEndX = _originX + 16 * 1;
                  _teleEndY = _originY + 16 * 4;
                  setGravityDir(GRAV_DOWN);
                  setFaceDir(FACE_FLOOR_RIGHT);
                  break;
               case 1:
                  _teleEndX = _originX + 16 * 14;
                  _teleEndY = _originY + 16 * 4;
                  setGravityDir(GRAV_DOWN);
                  setFaceDir(FACE_FLOOR_LEFT);
                  break;
               case 2:
                  _teleEndX = _originX + 16 * 1;
                  _teleEndY = _originY + 16 * -8;
                  setGravityDir(GRAV_UP);
                  setFaceDir(FACE_CEIL_RIGHT);
                  break;
               case 3:
                  _teleEndX = _originX + 16 * 14;
                  _teleEndY = _originY + 16 * -8;
                  setGravityDir(GRAV_UP);
                  setFaceDir(FACE_CEIL_LEFT);
                  break;
               case 4:
                  _teleEndX = _originX + 16 * -3;
                  _teleEndY = _originY + 16 * -2;
                  setGravityDir(GRAV_LEFT);
                  setFaceDir(FACE_LWALL_UP);
                  break;
               case 5:
                  _teleEndX = _originX + 16 * 19;
                  _teleEndY = _originY + 16 * -2;
                  setGravityDir(GRAV_RIGHT);
                  setFaceDir(FACE_RWALL_UP);
                  break;
            }
         }
      }
      
      public function updateAiMove() : void
      {
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            pickMoveTarget();
            _currentWeapon = 1;
            releaseUp();
            releaseDown();
            releaseLeft();
            releaseRight();
         }
         if(_attackPhase >= 1 || PlayState.player._slugMode)
         {
            _isAttacking = true;
         }
         if((_gravityDir == GRAV_DOWN || _gravityDir == GRAV_UP) && Math.abs(_moveEndX - x) > 10)
         {
            if(_moveEndX > x)
            {
               pressRight();
            }
            else
            {
               pressLeft();
            }
         }
         else
         {
            releaseRight();
            releaseLeft();
         }
         if((_gravityDir == GRAV_LEFT || _gravityDir == GRAV_RIGHT) && Math.abs(_moveEndY - y) > 10)
         {
            if(_moveEndY > y)
            {
               pressDown();
            }
            else
            {
               pressUp();
            }
         }
         else
         {
            releaseDown();
            releaseUp();
         }
         if(!_jumping)
         {
            if(_gravityDir != _targetGravity)
            {
               aiJump(_targetGravity);
            }
            else
            {
               aiJump();
            }
         }
         checkFireRings();
         if(Utility.dist(_moveEndX,_moveEndY,x,y) < 40)
         {
            setMode(MODE_ATTACK);
         }
      }
      
      public function updateAiIntro() : void
      {
         if(_modeElapsed > 0.3)
         {
            setMode(MODE_ATTACK);
         }
      }
      
      public function updateAiTeleport() : void
      {
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            pickTeleTarget();
            visible = false;
            solid = false;
            var _loc4_:int = 0;
            while(_loc4_ < _shadowBall.length)
            {
               _shadowBall[_loc4_].x = _teleStartX;
               _shadowBall[_loc4_].y = _teleStartY;
               _shadowBall[_loc4_].visible = true;
               _loc4_++;
            }
         }
         var _loc1_:Number = normalizedSigmoid(_modeElapsed / TELEPORT_TIME);
         var _loc2_:Number;
         var _loc3_:Number;
         if(_loc1_ <= 0.5)
         {
            _loc2_ = SHADOW_BALL_RADIUS * normalizedSigmoid(_modeElapsed / TELEPORT_TIME * 2);
         }
         else
         {
            _loc2_ = SHADOW_BALL_RADIUS * normalizedSigmoid((1 - _modeElapsed / TELEPORT_TIME) * 2);
         }
         if(_loc1_ <= 0.5)
         {
            _loc3_ = Math.PI * 2 * normalizedSigmoid(_modeElapsed / TELEPORT_TIME * 2);
         }
         else
         {
            _loc3_ = Math.PI * 2 * normalizedSigmoid((1 - _modeElapsed / TELEPORT_TIME) * 2);
         }
         _loc4_ = 0;
         while(_loc4_ < _shadowBall.length)
         {
            _shadowBall[_loc4_].x = _teleStartX * (1 - _loc1_) + _teleEndX * _loc1_ + Math.cos(_loc3_ + Math.PI * 2 / _shadowBall.length * _loc4_) * _loc2_;
            _shadowBall[_loc4_].y = _teleStartY * (1 - _loc1_) + _teleEndY * _loc1_ - Math.sin(_loc3_ + Math.PI * 2 / _shadowBall.length * _loc4_) * _loc2_;
            _loc4_++;
         }
         velocity.x = 0;
         velocity.y = 0;
         x = _teleEndX;
         y = _teleEndY;
         releaseJump();
         if(_modeElapsed / TELEPORT_TIME >= 1)
         {
            setMode(MODE_ATTACK,true);
         }
      }
      
      public function facePlayer() : void
      {
         switch(_gravityDir)
         {
            case GRAV_UP:
            case GRAV_DOWN:
               if(PlayState.player.x < x && facing == RIGHT)
               {
                  tapLeft();
               }
               else if(PlayState.player.x > x && facing == LEFT)
               {
                  tapRight();
               }
               break;
            case GRAV_LEFT:
               if(PlayState.player.y < y && _faceDir == FACE_LWALL_DOWN)
               {
                  tapUp();
               }
               else if(PlayState.player.y > y && _faceDir == FACE_LWALL_UP)
               {
                  tapDown();
               }
               break;
            case GRAV_RIGHT:
               if(PlayState.player.y < y && _faceDir == FACE_RWALL_DOWN)
               {
                  tapUp();
               }
               else if(PlayState.player.y > y && _faceDir == FACE_RWALL_UP)
               {
                  tapDown();
               }
			   break;
         }
      }
      
      public function aiJump(param1:int = -1, param2:Number = 0.3) : void
      {
         if(_releaseJumpTimeout > 0)
         {
            return;
         }
         pressJump();
         _releaseJumpTimeout = param2;
         _gravJumpDir = param1;
      }
      
      public function updateAiAttack() : void
      {
         facePlayer();
         if(!_isAttacking)
         {
            _attackStartTimeout -= FlxG.elapsed * _bossSpeed;
            if(_attackStartTimeout < 0)
            {
               _attackStopTimeout = ATTACK_STOP_TIMEOUT;
               _isAttacking = true;
            }
         }
         else
         {
            _attackStopTimeout -= FlxG.elapsed * _bossSpeed;
            if(_attackStopTimeout < 0)
            {
               _attackStartTimeout = ATTACK_START_TIMEOUT;
               _isAttacking = false;
            }
         }
         _currentWeapon = 2;
         if(_actionTimeout <= 0)
         {
            _actionTimeout = ACTION_TIMEOUT;
            if(getDecision() < 0.2)
            {
               switch(_gravityDir)
               {
                  case GRAV_RIGHT:
                     aiJump(GRAV_LEFT);
                     break;
                  case GRAV_LEFT:
                     aiJump(GRAV_RIGHT);
                     break;
                  case GRAV_UP:
                     aiJump(GRAV_DOWN);
                     break;
                  case GRAV_DOWN:
                     aiJump(GRAV_UP);
					 break;
               }
            }
            else if(getDecision() < 0.4)
            {
               aiJump();
            }
            else if(getDecision() < 0.4)
            {
               setMode(MODE_TELEPORT);
            }
            else
            {
               setMode(MODE_MOVE);
            }
         }
         if(Utility.dist(x + width / 2,y + width / 2,PlayState.player.x + PlayState.player.width / 2,PlayState.player.y + PlayState.player.height / 2) < 60)
         {
            setMode(MODE_TELEPORT);
         }
         else
         {
            switch(_gravityDir)
            {
               case GRAV_RIGHT:
                  if(Math.abs(PlayState.player.y - y) < 50 || Math.abs(PlayState.player.x - x) > 200)
                  {
                     pressLeft();
                  }
                  else
                  {
                     releaseLeft();
                  }
                  break;
               case GRAV_LEFT:
                  if(Math.abs(PlayState.player.y - y) < 50 || Math.abs(PlayState.player.x - x) > 200)
                  {
                     pressRight();
                  }
                  else
                  {
                     releaseRight();
                  }
                  break;
               case GRAV_DOWN:
                  if(Math.abs(PlayState.player.x - x) < 50 || Math.abs(PlayState.player.y - y) > 200)
                  {
                     pressUp();
                  }
                  else
                  {
                     releaseUp();
                  }
                  break;
               case GRAV_UP:
                  if(Math.abs(PlayState.player.x - x) < 50 || Math.abs(PlayState.player.y - y) > 200)
                  {
                     pressDown();
                  }
                  else
                  {
                     releaseDown();
                  }
				  break;
            }
         }
      }
      
      private function normalizedSigmoid(param1:Number) : Number
      {
         return 1 / (1 + Math.exp(-(param1 * 8 - 4)));
      }
      
      public function updateAi() : void
      {
         _ringTimeout -= FlxG.elapsed * _bossSpeed;
         if(tappedUp)
         {
            tappedUp = false;
            releaseUp();
         }
         if(tappedDown)
         {
            tappedDown = false;
            releaseDown();
         }
         if(tappedRight)
         {
            tappedRight = false;
            releaseRight();
         }
         if(tappedLeft)
         {
            tappedLeft = false;
            releaseLeft();
         }
         _modeElapsed += FlxG.elapsed * _bossSpeed;
         _actionTimeout -= FlxG.elapsed * _bossSpeed;
         switch(_attackMode)
         {
            case MODE_INTRO:
               updateAiIntro();
               break;
            case MODE_MOVE:
               updateAiMove();
               break;
            case MODE_ATTACK:
               updateAiAttack();
               break;
            case MODE_TELEPORT:
               updateAiTeleport();
               break;
            case MODE_STRAFE:
			   break;
         }
         _releaseJumpTimeout -= FlxG.elapsed;
         if(_releaseJumpTimeout <= 0 && pressedJump())
         {
            releaseJump();
            if(_gravJumpDir != GRAV_NONE)
            {
               switch(_gravJumpDir)
               {
                  case GRAV_RIGHT:
                     tapRight();
                     aiJump(GRAV_NONE,0.1);
                     break;
                  case GRAV_LEFT:
                     tapLeft();
                     aiJump(GRAV_NONE,0.1);
                     break;
                  case GRAV_UP:
                     tapUp();
                     aiJump(GRAV_NONE,0.1);
                     break;
                  case GRAV_DOWN:
                     tapDown();
                     aiJump(GRAV_NONE,0.1);
					 break;
               }
            }
         }
      }
      
      public function getDecision() : Number
      {
         ++_decisionTableIndex;
         _decisionTableIndex %= DECISION_TABLE.length;
         return DECISION_TABLE[_decisionTableIndex];
      }
      
      public function pressRight() : void
      {
         framesRight = 1;
         framesLeft = -1;
      }
      
      public function releaseRight() : void
      {
         framesRight = -1;
      }
      
      public function pressLeft() : void
      {
         framesLeft = 1;
         framesRight = -1;
      }
      
      public function releaseLeft() : void
      {
         framesLeft = -1;
      }
      
      public function pressDown() : void
      {
         framesDown = 1;
         framesUp = -1;
      }
      
      public function releaseDown() : void
      {
         framesDown = -1;
      }
      
      public function pressUp() : void
      {
         framesUp = 1;
         framesDown = -1;
      }
      
      public function releaseUp() : void
      {
         framesUp = -1;
      }
      
      public function pressJump() : void
      {
         framesJump = 1;
      }
      
      public function releaseJump() : void
      {
         framesJump = -1;
      }
      
      public function tapUp() : void
      {
         pressUp();
         tappedUp = true;
      }
      
      public function tapDown() : void
      {
         pressDown();
         tappedDown = true;
      }
      
      public function tapRight() : void
      {
         pressRight();
         tappedRight = true;
      }
      
      public function tapLeft() : void
      {
         pressLeft();
         tappedLeft = true;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(!PlayState.player.isParalyzed())
         {
            updateAi();
         }
         elapsed += FlxG.elapsed;
         fixGravity();
         if(justPressedJump() && _jumping)
         {
            performGravityJump();
         }
         checkInput_move();
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
         FlxU.collide(this,PlayState.solidItems);
         FlxU.overlap(PlayState.playerBulletGroups,_bulletGroups,overlapPlayerBulletBoss4Bullet);
         FlxU.overlap(PlayState.player,_bulletGroups,overlapPlayerBoss4Bullet);
         attack();
         if(framesUp > 0)
         {
            ++framesUp;
         }
         if(framesDown > 0)
         {
            ++framesDown;
         }
         if(framesLeft > 0)
         {
            ++framesLeft;
         }
         if(framesRight > 0)
         {
            ++framesRight;
         }
         if(framesJump > 0)
         {
            ++framesJump;
         }
         super.update();
      }
      
      override public function hitLeft(param1:FlxObject, param2:Number) : void
      {
         _justHitHeadOrWall = true;
         super.hitLeft(param1,param2);
      }
      
      override public function hitRight(param1:FlxObject, param2:Number) : void
      {
         _justHitHeadOrWall = true;
         super.hitRight(param1,param2);
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
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         _justHitHeadOrWall = false;
         super.hitBottom(param1,param2);
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         _justHitHeadOrWall = true;
         super.hitTop(param1,param2);
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         _bulletGroups = null;
         _hasWeapon = null;
         for(_loc1_ in _shadowBall)
         {
            _shadowBall[_loc1_] = null;
         }
         _shadowBall = null;
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
         _gravityDir = param1;
         switch(_gravityDir)
         {
            case GRAV_DOWN:
               acceleration.x = 0;
               acceleration.y = _gravity;
               drag.x = _runSpeed * 200;
               drag.y = 0;
               break;
            case GRAV_RIGHT:
               acceleration.x = _gravity;
               acceleration.y = 0;
               drag.y = _runSpeed * 200;
               drag.x = 0;
               break;
            case GRAV_UP:
               acceleration.x = 0;
               acceleration.y = -_gravity;
               drag.x = _runSpeed * 200;
               drag.y = 0;
               break;
            case GRAV_LEFT:
               acceleration.x = -_gravity;
               acceleration.y = 0;
               drag.y = _runSpeed * 200;
               drag.x = 0;
			   break;
         }
      }
      
      public function hideInShell(param1:Boolean) : void
      {
         _hidingInShell = param1;
         setFaceDir(_faceDir,true);
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
               if(!_hasGravityJump && _fallFrames == 1)
               {
                  setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
               }
               else if(_hasGravityJump && _fallFrames == 1 && pressedUp() && pressedRight())
               {
                  setFaceDir(FACE_LWALL_UP);
                  y -= 1;
               }
               else if(_hasGravityJump && _fallFrames == 1 && pressedUp() && pressedLeft())
               {
                  setFaceDir(FACE_RWALL_UP);
                  y -= 1;
                  x += 12;
               }
               else if(_hasGravityJump && !pressedJump() && _fallFrames == 1 && !pressedUp())
               {
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
               if(!_jumping && velocity.y > 0 && pressedDown() && !_justHitHeadOrWall)
               {
                  if(facing == RIGHT && pressedRight())
                  {
                     setFaceDir(FACE_LWALL_DOWN);
                     velocity.x = -_runSpeed;
                     y -= 11;
                  }
                  else if(facing == LEFT && pressedLeft())
                  {
                     setFaceDir(FACE_RWALL_DOWN);
                     velocity.x = _runSpeed;
                     x += 15;
                     y -= 11;
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
               if(_fallFrames == 1)
               {
                  setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
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
               if(!_hasGravityJump && _fallFrames == 1)
               {
                  setFaceDir(FACE_FLOOR_LEFT);
                  y += 13;
               }
               else if(_hasGravityJump && _fallFrames == 1 && pressedUp() && pressedLeft())
               {
                  setFaceDir(FACE_FLOOR_LEFT);
                  y += 13;
               }
               else if(_hasGravityJump && _fallFrames == 1 && pressedDown() && pressedLeft())
               {
                  setFaceDir(FACE_CEIL_LEFT);
                  y += 1;
               }
               else if(_hasGravityJump && !pressedJump() && _fallFrames == 1 && !pressedLeft())
               {
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
               if(!_hasGravityJump && _jumping)
               {
                  setFaceDir(FACE_FLOOR_RIGHT);
                  x -= 6;
                  y += 13;
               }
               else if(_hasGravityJump && _fallFrames == 1 && pressedUp() && pressedRight())
               {
                  setFaceDir(FACE_FLOOR_RIGHT);
                  x -= 6;
                  y += 13;
               }
               else if(_hasGravityJump && _fallFrames == 1 && pressedDown() && pressedRight())
               {
                  setFaceDir(FACE_CEIL_RIGHT);
                  x -= 6;
                  y += 1;
               }
               else if(_hasGravityJump && !pressedJump() && _fallFrames == 1 && !pressedRight())
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
      
      private function doJump() : void
      {
         hideInShell(false);
         Sfx.playJump1();
         doGravityJump();
      }
      
      private function doGravityJump() : void
      {
         switch(_gravityDir)
         {
            case GRAV_UP:
               velocity.y = _jumpPower;
               break;
            case GRAV_DOWN:
               velocity.y = -_jumpPower;
               break;
            case GRAV_LEFT:
               velocity.x = _jumpPower;
               break;
            case GRAV_RIGHT:
               velocity.x = -_jumpPower;
			   break;
         }
      }
      
      public function setFaceDirHiding(param1:int) : void
      {
         switch(_faceDir)
         {
            case FACE_FLOOR_LEFT:
               offset.x = 0 + 13;
               width = 32 - 13 - 7;
               offset.y = 16 + 6;
               height = 16 - 6;
               setGravityDir(GRAV_DOWN);
               playAnim("floor_right_hide");
               _hideOfsX = 9;
               x += _hideOfsX;
               _hideOfsY = 4;
               y += _hideOfsY;
               break;
            case FACE_FLOOR_RIGHT:
               offset.x = 0 + 7;
               width = 32 - 7 - 13;
               offset.y = 16 + 6;
               height = 16 - 6;
               setGravityDir(GRAV_DOWN);
               _hideOfsX = 3;
               x += _hideOfsX;
               _hideOfsY = 4;
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
      
      public function setFaceDirNotHiding(param1:int) : void
      {
         switch(_faceDir)
         {
            case FACE_FLOOR_LEFT:
            case FACE_FLOOR_RIGHT:
               offset.x = 0 + 4;
               width = 32 - 4 - 4;
               offset.y = 16 + 3;
               height = 16 - 3;
               setGravityDir(GRAV_DOWN);
               playAnim("floor_right_move");
               break;
            case FACE_CEIL_LEFT:
            case FACE_CEIL_RIGHT:
               offset.x = 0 + 4;
               width = 32 - 4 - 4;
               offset.y = 0 + 0;
               height = 16 - 3;
               setGravityDir(GRAV_UP);
               playAnim("ceil_right_move");
               break;
            case FACE_RWALL_UP:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 16 + 3;
               width = 16 - 3;
               setGravityDir(GRAV_RIGHT);
               playAnim("rwall_up_move");
               facing = RIGHT;
               break;
            case FACE_RWALL_DOWN:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 16 + 3;
               width = 16 - 3;
               setGravityDir(GRAV_RIGHT);
               playAnim("rwall_down_move");
               facing = RIGHT;
               break;
            case FACE_LWALL_UP:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 0 + 0;
               width = 16 - 3;
               setGravityDir(GRAV_LEFT);
               playAnim("rwall_up_move");
               facing = LEFT;
               break;
            case FACE_LWALL_DOWN:
               offset.y = 0 + 4;
               height = 32 - 8;
               offset.x = 0 + 0;
               width = 16 - 3;
               setGravityDir(GRAV_LEFT);
               playAnim("rwall_down_move");
               facing = LEFT;
			   break;
         }
      }
      
      public function setFaceDir(param1:int, param2:Boolean = false) : void
      {
         if(_faceDir == param1 && !param2)
         {
            return;
         }
         _faceDir = param1;
         x -= _hideOfsX;
         _hideOfsX = 0;
         y -= _hideOfsY;
         _hideOfsY = 0;
         if(_hidingInShell)
         {
            setFaceDirHiding(_faceDir);
         }
         else
         {
            setFaceDirNotHiding(_faceDir);
         }
      }
      
      public function attack() : void
      {
         _weaponTimeout -= FlxG.elapsed;
         if(_weaponTimeout > 0)
         {
            return;
         }
         if(!_isAttacking)
         {
            return;
         }
         if(_hidingInShell)
         {
            hideInShell(false);
         }
         var _loc1_:Boss4Bullet = _bulletGroups.getBullet(_currentWeapon);
         if(_loc1_)
         {
            var _loc2_:int = -1;
			var _loc3_:Array;
            if(_jumping)
            {
               _loc3_ = [1,1,1,1,1,1,1,1];
            }
            else if(_currentWeapon == WEAPON_PEA_SHOOTER)
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
            var _loc4_:Array = [0,40,90,140,180,-140,-90,-40];
            var _loc5_:int = _loc4_[_loc2_];
            var _loc6_:int = WEAPON_SPEED[_currentWeapon] / _turboMultiplier;
            var _loc7_:int = Math.cos(_loc5_ * Math.PI / 180) * _loc6_;
            var _loc8_:int = -Math.sin(_loc5_ * Math.PI / 180) * _loc6_;
            _loc1_.shoot(x + width / 2,y + height / 2,_loc7_,_loc8_);
            _weaponTimeout = WEAPON_TIMEOUTS[_currentWeapon] * _turboMultiplier;
         }
      }
      
      private function justPressedDown() : Boolean
      {
         return framesDown == 1;
      }
      
      private function justPressedLeft() : Boolean
      {
         return framesLeft == 1;
      }
      
      private function justPressedUp() : Boolean
      {
         return framesUp == 1;
      }
      
      private function justPressedRight() : Boolean
      {
         return framesRight == 1;
      }
      
      private function justPressedJump() : Boolean
      {
         return framesJump == 1;
      }
      
      private function pressedDown() : Boolean
      {
         return framesDown > 0;
      }
      
      private function pressedLeft() : Boolean
      {
         return framesLeft > 0;
      }
      
      private function pressedUp() : Boolean
      {
         return framesUp > 0;
      }
      
      private function pressedRight() : Boolean
      {
         return framesRight > 0;
      }
      
      private function pressedJump() : Boolean
      {
         return framesJump > 0;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      private function performGravityJump() : void
      {
         switch(_gravityDir)
         {
            case GRAV_DOWN:
               if((!pressedLeft() && !pressedRight() || _mostRecentDir == DIR_UP) && pressedUp())
               {
                  setFaceDir(facing == RIGHT ? FACE_CEIL_RIGHT : FACE_CEIL_LEFT);
                  _desiredGravity = GRAV_UP;
               }
               else if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_RIGHT) && pressedRight())
               {
                  setFaceDir(FACE_RWALL_UP);
                  _desiredGravity = GRAV_RIGHT;
               }
               else if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_LEFT) && pressedLeft())
               {
                  setFaceDir(FACE_LWALL_UP);
                  _desiredGravity = GRAV_LEFT;
               }
               break;
            case GRAV_UP:
               if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_RIGHT) && pressedRight())
               {
                  setFaceDir(FACE_RWALL_DOWN);
                  _desiredGravity = GRAV_RIGHT;
               }
               else if((!pressedDown() && !pressedUp() || _mostRecentDir == DIR_LEFT) && pressedLeft())
               {
                  setFaceDir(FACE_LWALL_DOWN);
                  _desiredGravity = GRAV_LEFT;
               }
               else if(pressedDown())
               {
                  setFaceDir(facing == RIGHT ? FACE_FLOOR_RIGHT : FACE_FLOOR_LEFT);
                  _desiredGravity = GRAV_DOWN;
               }
               break;
            case GRAV_RIGHT:
               if((!pressedLeft() && !pressedRight() || _mostRecentDir == DIR_UP) && pressedUp())
               {
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
                     setFaceDir(_faceDir == FACE_RWALL_UP ? FACE_LWALL_UP : FACE_LWALL_DOWN);
                     _desiredGravity = GRAV_LEFT;
                  }
                  else
                  {
                     setFaceDir(FACE_FLOOR_RIGHT);
                     _desiredGravity = GRAV_DOWN;
                  }
               }
               break;
            case GRAV_LEFT:
               if((!pressedLeft() && !pressedRight() || _mostRecentDir == DIR_UP) && pressedUp())
               {
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
                     setFaceDir(_faceDir == FACE_LWALL_UP ? FACE_RWALL_UP : FACE_RWALL_DOWN);
                     _desiredGravity = GRAV_RIGHT;
                  }
                  else
                  {
                     setFaceDir(FACE_FLOOR_LEFT);
                     _desiredGravity = GRAV_DOWN;
                  }
               }
			   break;
         }
         _desiredGravity = GRAV_DOWN;
      }
      
      private function checkInput_move() : void
      {
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
         var _loc1_:Boolean = _hidingInShell && !_jumping && !_hasRoll;
         switch(_gravityDir)
         {
            case GRAV_UP:
               acceleration.x = 0;
               if(pressedLeft())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  facing = LEFT;
                  velocity.x = -_runSpeed;
                  setFaceDir(FACE_CEIL_LEFT);
               }
               else if(pressedRight())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  facing = RIGHT;
                  velocity.x = _runSpeed;
                  setFaceDir(FACE_CEIL_RIGHT);
               }
               break;
            case GRAV_DOWN:
               acceleration.x = 0;
               if(pressedLeft())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  facing = LEFT;
                  velocity.x = -_runSpeed;
                  setFaceDir(FACE_FLOOR_LEFT);
               }
               else if(pressedRight())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  facing = RIGHT;
                  velocity.x = _runSpeed;
                  setFaceDir(FACE_FLOOR_RIGHT);
               }
               break;
            case GRAV_LEFT:
               acceleration.y = 0;
               if(pressedUp())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  velocity.y = -_runSpeed;
                  facing = LEFT;
                  setFaceDir(FACE_LWALL_UP);
               }
               else if(pressedDown())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  velocity.y = _runSpeed;
                  facing = LEFT;
                  setFaceDir(FACE_LWALL_DOWN);
               }
               break;
            case GRAV_RIGHT:
               acceleration.y = 0;
               if(pressedUp())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  velocity.y = -_runSpeed;
                  facing = RIGHT;
                  setFaceDir(FACE_RWALL_UP);
               }
               else if(pressedDown())
               {
                  if(_loc1_)
                  {
                     hideInShell(false);
                  }
                  velocity.y = _runSpeed;
                  facing = RIGHT;
                  setFaceDir(FACE_RWALL_DOWN);
               }
			   break;
         }
      }
      
      private function playAnim(param1:String) : void
      {
         _lastAnim = param1;
         play(_snailTypePrefix + param1);
      }
      
      override public function kill() : void
      {
         super.kill();
         if(_hp <= 0 && !PlayState.player.dead)
         {
            PlayState.enemies.add(new Boss4RushSecondForm(_originX,_originY));
            PlayState.sprites.add(new QueuedExplosion(x,y));
         }
         else
         {
            Music.playBoss1();
         }
         _bulletGroups.destroyAll();
         PlayState.enemyBulletPool.destroyAll();
         dead = true;
         exists = false;
         active = false;
         visible = false;
      }
      
      override public function hurt(param1:Number) : void
      {
         if(_hp <= MAX_HP * 0.4 && _attackPhase < 1)
         {
            _bossSpeed += 0.2;
            _attackPhase = 1;
            _snailTypePrefix = "snail2_";
            playAnim(_lastAnim);
         }
         super.hurt(param1);
      }
      
      public function Boss4Rush(param1:int, param2:int) : void
      {
         _hasWeapon = [true,true,true];
         if(PlayState.player._slugMode)
         {
            _bossSpeed += 0.1;
         }
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         _originX = param1;
         _originY = param2;
         _decisionTableIndex = PlayState.player.getMaxHp() + PlayState.player.getPercentComplete();
         _decisionTableIndex %= DECISION_TABLE.length;
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
         _runSpeed = 410;
         _maxSpeed = 600;
         _gravity = 1200;
         maxVelocity.x = _maxSpeed;
         maxVelocity.y = _maxSpeed;
         _shadowBall = new Array();
         _loc3_ = 0;
         while(_loc3_ < SHADOW_BALL_NUM)
         {
            _shadowBall[_loc3_] = new Boss4ShadowBall();
            PlayState.enemies.add(_shadowBall[_loc3_]);
            _loc3_++;
         }
         setGravityDir(GRAV_DOWN);
         setFaceDir(FACE_FLOOR_RIGHT,true);
         playAnim("floor_right_move");
         _bulletGroups = PlayState.boss4BulletGroups;
         PlayState.player.x -= 60;
         Music.playBoss1();
         PlayState.player.setFaceDir(Player.FACE_FLOOR_LEFT);
      }
   }
}

