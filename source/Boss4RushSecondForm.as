package
{
   import org.flixel.*;
   
   public class Boss4RushSecondForm extends Boss
   {
      private static const IMG_WIDTH:int = 80;
      
      private static const IMG_HEIGHT:int = 44;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 30000;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 2;
      
      private static const HIT_NONE:int = 0;
      
      private static const HIT_LEFT:int = 1;
      
      private static const HIT_RIGHT:int = 2;
      
      private static const HIT_TOP:int = 3;
      
      private static const HIT_BOTTOM:int = 4;
      
      private static const GRAV_JUMP_TIMEOUT:Number = 0.1;
      
      private static const START_ATTACK_TIME:Number = 0.4;
      
      private static const JUMP_POWER:Number = 360;
      
      private static const JUMP_TIMEOUT:Number = 0.8;
      
      private static const WALK_SPEED:Number = 200;
      
      private static const MODE_INTRO:int = 0;
      
      private static const MODE_STOMP:int = 1;
      
      private static const MODE_SHELLSTRAFE:int = 2;
      
      private static const MODE_SHELLSMASH:int = 3;
      
      private static const MODE_SLEEP:int = 4;
      
      private static const ZZZ_TIMEOUT:Number = 0.3;
      
      private static const DECISION_TABLE:Array = [0.1640168826,0.3892556902,0.0336081053,0.2246864975,0.5434009453,0.4227320437,0.1017472328,0.2041907897,0.9950191347,0.3634705228,0.0779175897,0.384822732,0.3284047846,0.0951552057,0.1941055446,0.496359046,0.2428007567,0.8280672868,0.852732986,0.6928913176,0.2023843678,0.7280045905,0.4311591744,0.796788024,0.41191487,0.7108575032,0.1134556829,0.6883870615,0.8149317527,0.8392490375,0.3647662453,0.3487805783,0.7900575239,0.1670561498,0.9810836953,0.0097847681,0.2244645569,0.0842442402,0.3263779227,0.1481701068,0.6538572663,0.2544128409,0.1991950422,0.541057099,0.574700257,0.5926224371,0.310134571,0.6104650203,0.3545506087,0.2313309166,0.3070387696,0.0790505658,0.9804949607,0.7704714904,0.7152660213,0.8215058975,0.9426850446,0.7483973576,0.7602092802,0.881605898,0.5136580468,0.0190696615,0.28759162,0.1565554394,0.3664312259,0.2586407176,0.3185483313,0.9837348993,0.3330417452,0.2801789805,0.3288621592,0.0230039287,0.303914672,0.7212895333,0.6296904139,0.8659332532,0.1715852607,0.3900271956,0.2824020982,0.1624092775,0.7599701669,0.6952292831,0.2161165745,0.9005386635,0.3707154895,0.6392742953,0.452149187,0.5595775233,0.686286675,0.7266258821,0.6904605229,0.6808205255,0.6856147591,0.299675182,0.8012191872,0.804475971,0.1926201715,0.8868517061,0.8347136807,0.1512707539];
      
      private var _lastHitDir:int = 0;
      
      private var _lastStomp:int = 0;
      
      private var _zzz:Array;
      
      private var _strafeNum:int = 3;
      
      private var _lastSmashVelX:Number = 0;
      
      private var _lastSmashVelY:Number = 0;
      
      private var _decisionTableIndex:int = 0;
      
      private var _shotTimeout:Number = 0;
      
      private var _lastAnim:String;
      
      private var _bossSpeed:Number = 1;
      
      private var _attackPhase:int = 0;
      
      private var _elapsed:Number = 0;
      
      private var _modeElapsed:Number = 0;
      
      private var _modeInitialized:Boolean = false;
      
      private var _modeTimeout:Number = 0;
      
      private var _originX:Number = 0;
      
      private var _originY:Number = 0;
      
      private var _targetX:Number = 0;
      
      private var _targetY:Number = 0;
      
      private var _strafeTheta:Number = 0;
      
      private var _strafeThetaVel:Number = 0;
      
      private var _strafeThetaAcc:Number = 0;
      
      private var _waitingToJump:Boolean = false;
      
      private var _strafeTimeout:Number = 0;
      
      private var STRAFE_TIMEOUT:Number = 0.03;
      
      private var STRAFE_SPEED:Number = 400;
      
      private var SMASH_SPEED:Number = 400;
      
      private var STOMP_TIMEOUT:Number = 0.25;
      
      private var _stompTimeout:Number = 0;
      
      private var WAVE_TIMEOUT:Number = 1;
      
      private var WAVE_SPEED:Number = 20;
      
      private var _waveTimeout:Number = 0;
      
      private var _stomped:Boolean = false;
      
      private var _aimed:Boolean = false;
      
      private var _gravJumpTimeout:Number = 99999;
      
      private var _jumpTimeout:Number;
      
      private var _mode:int = 0;
      
      private var _lastMode:int = 0;
      
      private var bg:Boss4SecondFormBg;
      
      private var _bulletGroups:Boss4SecondFormBulletGroups;
      
      private var HEAL_TIMEOUT:Number = 0.1;
      
      private var _healAmount:int;
      
      private var _healNum:int;
      
      private var _healTimeout:Number = 0.8;
      
      private var ZZZ_MAX:int = 3;
      
      private var _zzzTimeout:Number = 0;
      
      private var _zzzNum:Number = 0;
      
      public function blank(param1:int, param2:int) : void
      {
         PlayState.fixBlocks.rememberBlock(param1,param2,PlayState.worldMap.bgmap.getTile(param1,param2),PlayState.worldMap.fgmap.getTile(param1,param2));
         PlayState.worldMap.bgmap.setTile(param1,param2,0);
      }
      
      override public function destroy() : void
      {
         bg = null;
         _bulletGroups = null;
         _zzz = null;
         super.destroy();
      }
      
      public function Boss4RushSecondForm(param1:int, param2:int) : void
      {
         _healAmount = PlayState.player.hpPerHeart() / 2;
         _healNum = PlayState.player.getMaxHp() / _healAmount;
         param1 += 7 * 16 + 8;
         param2 -= 2 * 16 + 12;
         _originX = param1;
         _originY = param2;
         param1 -= 20;
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         _decisionTableIndex = int(PlayState.player.x) % DECISION_TABLE.length;
         _zzz = new Array();
         loadGraphic(Art.Boss4RushSecondForm,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("floor0",[0,1],3,true);
         addAnimation("ceil0",[2,3],3,true);
         addAnimation("shell0",[11,10,9,8,7,6,5,4],22,true);
         addAnimation("sleep0",[4]);
         addAnimation("floor1",[12,13],4,true);
         addAnimation("ceil1",[14,15],4,true);
         addAnimation("shell1",[23,22,21,20,19,18,17,16],30,true);
         addAnimation("sleep1",[16]);
         playAnim("shell");
         Music.playNone();
         _noParalyze = false;
         _bulletGroups = PlayState.boss4SecondFormBulletGroups;
         alpha = 0;
         solid = false;
         bg = new Boss4SecondFormBg();
         PlayState.bossBgLayer.add(bg);
      }
      
      public function getDecision() : Number
      {
         ++_decisionTableIndex;
         _decisionTableIndex %= DECISION_TABLE.length;
         return DECISION_TABLE[_decisionTableIndex];
      }
      
      override public function hitLeft(param1:FlxObject, param2:Number) : void
      {
         _lastHitDir = HIT_LEFT;
         if(_mode == MODE_STOMP)
         {
            velocity.x *= -1;
            if(velocity.x < 0)
            {
               facing = LEFT;
            }
            else
            {
               facing = RIGHT;
            }
         }
         else
         {
            stomp();
         }
      }
      
      override public function hitRight(param1:FlxObject, param2:Number) : void
      {
         _lastHitDir = HIT_RIGHT;
         if(_mode == MODE_STOMP)
         {
            velocity.x *= -1;
            if(velocity.x < 0)
            {
               facing = LEFT;
            }
            else
            {
               facing = RIGHT;
            }
         }
         else
         {
            stomp();
         }
      }
      
      public function stomp() : void
      {
         if(_stomped)
         {
            return;
         }
         velocity.x = 0;
         velocity.y = 0;
         if(_stompTimeout <= 0)
         {
            FlxG.quake.start(0.02);
            Sfx.playStomp();
            _stompTimeout = STOMP_TIMEOUT;
         }
         _stomped = true;
         _gravJumpTimeout = 999999;
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         _lastHitDir = HIT_BOTTOM;
         stomp();
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         _lastHitDir = HIT_TOP;
         stomp();
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function playAnim(param1:String) : void
      {
         if(param1 == "shell")
         {
            if(width != 40)
            {
               x += 20;
            }
            width = 40;
            offset.x = 20;
         }
         else
         {
            if(width == 40)
            {
               x -= 20;
            }
            width = 80;
            offset.x = 0;
         }
         play(param1 + _attackPhase.toString());
         _lastAnim = param1;
      }
      
      public function shootWave() : void
      {
         if(_waveTimeout > 0)
         {
            return;
         }
         _waveTimeout = WAVE_TIMEOUT;
         var _loc1_:Boss4Bullet = _bulletGroups.getBullet(1);
         if(!_loc1_)
         {
            return;
         }
         if(PlayState.player.x < x)
         {
            var _loc2_:Number = -WAVE_SPEED;
         }
         else
         {
            _loc2_ = WAVE_SPEED;
         }
         _loc1_.shoot(x + width / 2,y,_loc2_,0);
      }
      
      public function setMode(param1:int) : void
      {
         if(param1 == MODE_STOMP)
         {
            _lastStomp = 0;
         }
         else
         {
            ++_lastStomp;
         }
         if(_lastStomp >= 4)
         {
            param1 = MODE_STOMP;
            _lastStomp = 0;
         }
         _lastMode = _mode;
         _mode = param1;
         _modeInitialized = false;
         _stomped = false;
         acceleration.x = 0;
         acceleration.y = 0;
         velocity.x = 0;
         velocity.y = 0;
         playAnim("shell");
         _modeElapsed = 0;
         _waitingToJump = false;
      }
      
      public function overlapPlayerBulletBoss4Bullet(param1:FlxObject, param2:FlxObject) : void
      {
         if(param1 is PlayerBullet && param2 is Boss4Bullet)
         {
            var _loc3_:PlayerBullet = param1 as PlayerBullet;
            var _loc4_:Boss4Bullet = param2 as Boss4Bullet;
            _loc4_.hitPlayerBullet(_loc3_);
         }
      }
      
      private function updateAiIntro() : void
      {
         if(_elapsed > 2 && _elapsed < 3)
         {
            alpha = _elapsed - 2;
         }
         else if(_elapsed > 3 && _delayIntro)
         {
            alpha = 1;
            _delayIntro = false;
            resetStartTime();
            PlayState.hud.bossBarHud.makeBar(_hp);
            Music.playBoss2();
         }
         if(_introDone)
         {
            blank(581,188);
            blank(559,188);
            blank(581,176);
            blank(559,176);
            setMode(MODE_STOMP);
            solid = true;
         }
      }
      
      private function pickStompTarget() : void
      {
         _targetX = x;
         _targetY = y;
         do
         {
            var _loc1_:int = getDecision() * 8;
            switch(_loc1_)
            {
               case 0:
                  _targetX = _originX + 16 * 7;
                  _targetY = _originY + 16 * 5;
                  break;
               case 1:
                  _targetX = _originX + 16 * -7;
                  _targetY = _originY + 16 * 5;
                  break;
               case 2:
                  _targetX = _originX + 16 * 7;
                  _targetY = _originY + 16 * -5;
                  break;
               case 3:
                  _targetX = _originX + 16 * -7;
                  _targetY = _originY + 16 * -5;
                  break;
               case 4:
                  _targetX = _originX + 16 * 7;
                  _targetY = _originY;
                  break;
               case 5:
                  _targetX = _originX + 16 * -7;
                  _targetY = _originY;
                  break;
               case 6:
                  _targetX = _originX;
                  _targetY = _originY + 16 * -5;
                  break;
               case 7:
                  _targetX = _originX;
                  _targetY = _originY + 16 * -5;
                  break;
            }
         }
         while(Utility.dist(_targetX + width / 2,_targetY + height / 2,PlayState.player.x + PlayState.player.width / 2,PlayState.player.y + PlayState.player.height / 2) < 130);
         
      }
      
      private function updateAiSleep() : void
      {
         if(!_modeInitialized)
         {
            if(Math.abs(x + width / 2 - (PlayState.player.x + PlayState.player.width / 2)) < 40 && y < PlayState.player.y)
            {
               setMode(MODE_STOMP);
               return;
            }
            _modeInitialized = true;
            bg.setTargetRgb(176,174,0);
            _modeTimeout = 6.2;
            bg.bgColorSpeed = 3;
            playAnim("sleep");
            _zzzNum = 0;
            _zzzTimeout = ZZZ_TIMEOUT;
            if(PlayState.player._slugMode)
            {
               ZZZ_MAX = 6;
            }
            acceleration.y = 900;
            Sfx.playShell();
         }
         if(_stomped)
         {
            _zzzTimeout -= FlxG.elapsed * _bossSpeed;
            if(_zzzTimeout < 0 && _zzzNum < ZZZ_MAX)
            {
               PlayState.enemiesNoCollide.add(new BossZzz(x + width / 2,y,x + width + 24 * _zzzNum,y));
               _zzzTimeout = ZZZ_TIMEOUT;
               ++_zzzNum;
            }
            acceleration.y = 0;
         }
         if(_modeTimeout <= 0)
         {
            if(getDecision() > 0.5)
            {
               setMode(MODE_STOMP);
            }
            else
            {
               setMode(MODE_SHELLSTRAFE);
            }
         }
      }
      
      private function updateAiStomp() : void
      {
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            bg.setTargetRgb(0,48,0);
            _modeTimeout = 6;
            bg.bgColorSpeed = 3;
            pickStompTarget();
         }
         if(_lastAnim == "shell")
         {
            if(Utility.dist(x,y,_targetX,_targetY) < 10)
            {
               if(getDecision() > 0.5)
               {
                  acceleration.y = 900;
                  playAnim("floor");
               }
               else
               {
                  acceleration.y = -900;
                  playAnim("ceil");
               }
            }
            x = Utility.integrate(x,_targetX,0.7,FlxG.elapsed * _bossSpeed);
            y = Utility.integrate(y,_targetY,0.7,FlxG.elapsed * _bossSpeed);
         }
         else
         {
            facePlayer();
            if(_stomped)
            {
               if(!_waitingToJump)
               {
                  _waitingToJump = true;
                  _jumpTimeout = JUMP_TIMEOUT;
               }
               _jumpTimeout -= FlxG.elapsed * _bossSpeed;
               if(_waitingToJump && _jumpTimeout <= 0)
               {
                  _waitingToJump = false;
                  _stomped = false;
                  if(acceleration.y < 0)
                  {
                     velocity.y = JUMP_POWER;
                  }
                  else
                  {
                     velocity.y = -JUMP_POWER;
                  }
                  if(facing == LEFT)
                  {
                     velocity.x = -WALK_SPEED;
                  }
                  else
                  {
                     velocity.x = WALK_SPEED;
                  }
                  _gravJumpTimeout = GRAV_JUMP_TIMEOUT;
                  _jumpTimeout = 99999;
               }
               else if(velocity.y != 0)
               {
                  _gravJumpTimeout -= FlxG.elapsed;
                  if(_gravJumpTimeout < 0)
                  {
                     if(getDecision() > 0.66)
                     {
                        if(acceleration.y < 0)
                        {
                           acceleration.y = 900;
                           playAnim("floor");
                        }
                        else
                        {
                           acceleration.y = -900;
                           playAnim("ceil");
                        }
                     }
                     _gravJumpTimeout = 999999;
                  }
               }
            }
         }
         if(_attackPhase == 0 && _modeElapsed > START_ATTACK_TIME * 3)
         {
            shootWave();
         }
         if(_attackPhase == 1 && _modeElapsed > START_ATTACK_TIME * 3.5)
         {
            shootWave();
         }
         if(_modeTimeout <= 0)
         {
            if(_attackPhase == 1 && getDecision() > 0.7)
            {
               setMode(MODE_SLEEP);
            }
            else if(getDecision() > 0.7)
            {
               setMode(MODE_SHELLSMASH);
            }
            else if(getDecision() > 0.8)
            {
               setMode(MODE_STOMP);
            }
            else
            {
               setMode(MODE_SHELLSTRAFE);
            }
         }
      }
      
      public function facePlayer() : void
      {
         if(PlayState.player.x < x + width / 2 - PlayState.player.width / 2)
         {
            facing = LEFT;
         }
         else
         {
            facing = RIGHT;
         }
      }
      
      private function aimStrafe() : void
      {
         var _loc1_:Number = Math.atan2(PlayState.player.y - (y + height / 2),PlayState.player.x - (x + width / 2));
         _strafeNum = 2.3 + 5 * Number(MAX_HP - _hp) / MAX_HP;
         if(_strafeNum < 4)
         {
            _strafeNum = 4;
         }
         if(_strafeNum > 7)
         {
            _strafeNum = 7;
         }
         _strafeTheta = _loc1_ - Math.PI / _strafeNum;
      }
      
      private function updateAiShellStrafe() : void
      {
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            if(_attackPhase < 1)
            {
               bg.setTargetRgb(48,0,48);
            }
            else
            {
               bg.setTargetRgb(0,48,48);
            }
            bg.bgColorSpeed = 3;
            _modeTimeout = 5.2;
            playAnim("shell");
            _targetX = _originX;
            _targetY = _originY;
            _aimed = false;
         }
         x = Utility.integrate(x,_targetX,1.7,FlxG.elapsed * _bossSpeed);
         y = Utility.integrate(y,_targetY,1.7,FlxG.elapsed * _bossSpeed);
         if(_modeElapsed > START_ATTACK_TIME && !_aimed && Utility.dist(x,y,_targetX,_targetY) < 10)
         {
            aimStrafe();
            if(getDecision() > 0.5)
            {
               _strafeThetaVel = Math.PI / 8;
            }
            else
            {
               _strafeThetaVel = -Math.PI / 8;
            }
            if(getDecision() > 0.5)
            {
               _strafeThetaAcc = -_strafeThetaVel * 1.3;
            }
            _aimed = true;
            if(PlayState.player._slugMode)
            {
               _strafeThetaVel *= 1.6;
            }
         }
         if(_strafeThetaVel < -Math.PI / 5)
         {
            _strafeThetaVel = -Math.PI / 5;
         }
         if(_strafeThetaVel > Math.PI / 5)
         {
            _strafeThetaVel = Math.PI / 5;
         }
         _strafeTheta += _strafeThetaVel * FlxG.elapsed * _bossSpeed;
         _strafeThetaVel += _strafeThetaAcc * FlxG.elapsed * _bossSpeed;
         if(_modeElapsed > START_ATTACK_TIME && _aimed)
         {
            shootStrafeMultiWay();
         }
         if(_modeTimeout <= 0)
         {
            if(_attackPhase == 1 && getDecision() > 0.74)
            {
               setMode(MODE_SLEEP);
            }
            else if(getDecision() < 0.7)
            {
               setMode(MODE_STOMP);
            }
            else
            {
               setMode(MODE_SHELLSMASH);
            }
         }
      }
      
      public function shootStrafeSingleShot(param1:Number) : void
      {
         var _loc2_:Boss4Bullet = _bulletGroups.getBullet(0);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Number = STRAFE_SPEED * Math.cos(param1);
         var _loc4_:Number = STRAFE_SPEED * Math.sin(param1);
         _loc2_.shoot(x + width / 2,y + height / 2,_loc3_,_loc4_);
      }
      
      public function shootStrafeMultiWay() : void
      {
         if(_strafeTimeout > 0)
         {
            return;
         }
         _strafeTimeout = STRAFE_TIMEOUT;
         for (var i:int = 0; i < _strafeNum; i++)
         {
            shootStrafeSingleShot(_strafeTheta + 2 * Math.PI / _strafeNum * i);
         }
      }
      
      private function pickSmashDir(param1:Boolean = false) : void
      {
         var _loc2_:Number = FlxU.random() * 2 * Math.PI;
         if(getDecision() > 0.15 || param1)
         {
            _loc2_ = Math.atan2(PlayState.player.y + PlayState.player.height / 2 - (y + height / 2),PlayState.player.x + PlayState.player.width / 2 - (x + width / 2));
         }
         velocity.x = 0;
         velocity.y = 0;
         acceleration.x = SMASH_SPEED * _bossSpeed * Math.cos(_loc2_);
         acceleration.y = SMASH_SPEED * _bossSpeed * Math.sin(_loc2_);
         if(_lastHitDir == HIT_RIGHT && acceleration.x > 0)
         {
            acceleration.x *= -1;
         }
         if(_lastHitDir == HIT_LEFT && acceleration.x < 0)
         {
            acceleration.x *= -1;
         }
         if(_lastHitDir == HIT_BOTTOM && acceleration.y > 0)
         {
            acceleration.y *= -1;
         }
         if(_lastHitDir == HIT_TOP && acceleration.y < 0)
         {
            acceleration.y *= -1;
         }
      }
      
      private function updateAiShellSmash() : void
      {
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            bg.setTargetRgb(48,0,0);
            bg.bgColorSpeed = 3;
            _modeTimeout = 6;
            playAnim("shell");
            pickSmashDir();
         }
         if(_stomped)
         {
            _stomped = false;
            if(getDecision() > 0.7 || _attackPhase == 1)
            {
               pickSmashDir(true);
            }
            else if(velocity.y == 0)
            {
               acceleration.y *= -1;
            }
            else
            {
               acceleration.x *= -1;
            }
         }
         if(_modeTimeout <= 0)
         {
            if(getDecision() > 0.5)
            {
               setMode(MODE_STOMP);
            }
            else
            {
               setMode(MODE_SHELLSTRAFE);
            }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(_healNum > 0)
         {
            _healTimeout -= FlxG.elapsed;
            if(_healTimeout < 0)
            {
               _healTimeout = HEAL_TIMEOUT;
               --_healNum;
               PlayState.player.heal(_healAmount);
               Sfx.playPickup4();
               if(PlayState.player.getCurHp() == PlayState.player.getMaxHp())
               {
                  _healNum = -1;
               }
            }
         }
         _waveTimeout -= FlxG.elapsed * _bossSpeed;
         _modeTimeout -= FlxG.elapsed * _bossSpeed;
         _strafeTimeout -= FlxG.elapsed * _bossSpeed;
         _stompTimeout -= FlxG.elapsed * _bossSpeed;
         _modeElapsed += FlxG.elapsed * _bossSpeed;
         switch(_mode)
         {
            case MODE_INTRO:
               updateAiIntro();
               break;
            case MODE_STOMP:
               updateAiStomp();
               break;
            case MODE_SHELLSTRAFE:
               updateAiShellStrafe();
               break;
            case MODE_SHELLSMASH:
               updateAiShellSmash();
               break;
            case MODE_SLEEP:
               updateAiSleep();
			   break;
         }
         FlxU.overlap(PlayState.playerBulletGroups,_bulletGroups,overlapPlayerBulletBoss4Bullet);
         FlxU.overlap(PlayState.player,_bulletGroups,overlapPlayerBoss4Bullet);
         _elapsed += FlxG.elapsed;
         super.update();
         PlayState.player.paralyze(false);
      }
      
      public function overlapPlayerBoss4Bullet(param1:FlxObject, param2:FlxObject) : void
      {
         if(param1 is Player && param2 is Boss4Bullet)
         {
            var _loc3_:Player = param1 as Player;
            var _loc4_:Boss4Bullet = param2 as Boss4Bullet;
            _loc4_.hitPlayer(_loc3_);
         }
      }
      
      override public function kill() : void
      {
         super.kill();
         if(_hp <= 0 && !PlayState.player.dead)
         {
            PlayState.setBossDead(4);
            PlayState.showBossRushName(4,true);
            PlayState.sprites.add(new QueuedExplosion(x,y,false));
            bg.fadeOut();
            Music.playNone();
         }
         else
         {
            Music.playBoss1();
         }
         PlayState.bossRushTimer.going = false;
         PlayState.enemyBulletPool.destroyAll();
         dead = true;
         exists = false;
         active = false;
         visible = false;
      }
      
      override public function hurt(param1:Number) : void
      {
         if(_lastAnim == "shell" || _lastAnim == "sleep")
         {
            param1 = 0;
         }
         if(_hp <= MAX_HP * 0.4 && _attackPhase < 1)
         {
            _bossSpeed += 0.3;
            _attackPhase = 1;
            playAnim(_lastAnim);
         }
         super.hurt(param1);
      }
   }
}

