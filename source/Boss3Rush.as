package
{
   import org.flixel.*;
   
   public class Boss3Rush extends Boss
   {
      private static const IMG_WIDTH:int = 128;
      
      private static const IMG_HEIGHT:int = 128;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 9000;
      
      private static const DEFENSE:int = 9;
      
      private static const OFFENSE:int = 3;
      
      private static const SHIELDS_MAX:int = 36;
      
      private static const SHIELDS_REALMAX:int = 26;
      
      private static const SHIELDS_START:int = 0;
      
      private static const SHIELDS_DMG_PER_SHIELD:int = 250;
      
      private static const SHIELDS_PERIOD:Number = 3;
      
      private static const MODE_TIMEOUT:Number = 0.6;
      
      private static const SPAWN_TIMEOUT:Number = 2.5;
      
      private static const MAX_SPAWN:int = 8;
      
      private static const MODE_INTRO1:int = 0;
      
      private static const MODE_WAIT:int = 1;
      
      private static const MODE_UP:int = 2;
      
      private static const MODE_DOWN:int = 3;
      
      private static const MODE_LEFT:int = 4;
      
      private static const MODE_RIGHT:int = 5;
      
      private static const SPAWN_COUNTER:int = 8;
      
      private static const STARTING_BOSS_SPEED:Number = 1.4;
      
      private static const DECISION_TABLE:Array = [0.1640168826,0.3892556902,0.0336081053,0.2246864975,0.5434009453,0.4227320437,0.1017472328,0.2041907897,0.9950191347,0.3634705228,0.0779175897,0.384822732,0.3284047846,0.0951552057,0.1941055446,0.496359046,0.2428007567,0.8280672868,0.852732986,0.6928913176,0.2023843678,0.7280045905,0.4311591744,0.796788024,0.41191487,0.7108575032,0.1134556829,0.6883870615,0.8149317527,0.8392490375,0.3647662453,0.3487805783,0.7900575239,0.1670561498,0.9810836953,0.0097847681,0.2244645569,0.0842442402,0.3263779227,0.1481701068,0.6538572663,0.2544128409,0.1991950422,0.541057099,0.574700257,0.5926224371,0.310134571,0.6104650203,0.3545506087,0.2313309166,0.3070387696,0.0790505658,0.9804949607,0.7704714904,0.7152660213,0.8215058975,0.9426850446,0.7483973576,0.7602092802,0.881605898,0.5136580468,0.0190696615,0.28759162,0.1565554394,0.3664312259,0.2586407176,0.3185483313,0.9837348993,0.3330417452,0.2801789805,0.3288621592,0.0230039287,0.303914672,0.7212895333,0.6296904139,0.8659332532,0.1715852607,0.3900271956,0.2824020982,0.1624092775,0.7599701669,0.6952292831,0.2161165745,0.9005386635,0.3707154895,0.6392742953,0.452149187,0.5595775233,0.686286675,0.7266258821,0.6904605229,0.6808205255,0.6856147591,0.299675182,0.8012191872,0.804475971,0.1926201715,0.8868517061,0.8347136807,0.1512707539];
      
      private static const SHOOTMODE_WAIT_CLUSTER:int = 0;
      
      private static const SHOOTMODE_ATTACK:int = 1;
      
      private var _shields:Array;
      
      private var _playerInverted:Boolean = false;
      
      private var _shieldNum:int = 0;
      
      private var _createdChildren:Boolean = false;
      
      private var _elapsed:Number = 0;
      
      private var _modeTimeout:Number = 0.6;
      
      private var _lastMode:int = 5;
      
      private var _mode:int = 1;
      
      private var _nextMode:int = 2;
      
      private var _spawnCounter:int = 8;
      
      private var _attackMode:int = 0;
      
      private var _bossSpeed:Number = 1.4;
      
      private var ACCEL:Number = 210;
      
      private var _decisionTableIndex:int = 0;
      
      private var _shootMode:int = 0;
      
      private var SHOT_NUM:int = 7;
      
      private var _shotNum:int;
      
      private var CLUSTER_TIMEOUT:Number = 4.1;
      
      private var SHOT_TIMEOUT:Number = 0.4;
      
      private var _clusterTimeout:Number = 0;
      
      private var _shotTimeout:Number = 0;
      
      private var _spawn:Array;
      
      private var _lastAnim:String = "";
      
      public function countSpawn() : int
      {
         var _loc1_:int = 0;
         for (var i:int = 0; i < _spawn.length; i++)
         {
            if(_spawn[i] && !_spawn[i].dead)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      override public function destroy() : void
      {
         for (var i:int = 0; i < _shields.length; i++)
         {
            _shields[i] = null;
         }
         _shields = null;
         for (i = 0; i < _spawn.length; i++)
         {
            _spawn[i] = null;
         }
         _spawn = null;
         super.destroy();
      }
      
      public function Boss3Rush(param1:int, param2:int) : void
      {
         _shotNum = SHOT_NUM;
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.Boss3Rush,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("up0",[0]);
         addAnimation("left0",[1]);
         addAnimation("right0",[2]);
         addAnimation("down0",[3]);
         addAnimation("mid0",[4]);
         addAnimation("up1",[5]);
         addAnimation("left1",[6]);
         addAnimation("right1",[7]);
         addAnimation("down1",[8]);
         addAnimation("mid1",[9]);
         playAnim("mid");
         PlayState.player.x += 20;
         PlayState.player.setFaceDir(Player.FACE_FLOOR_RIGHT);
         if(PlayState.player._slugMode)
         {
            SHOT_NUM += 2;
            _bossSpeed += 0.3;
         }
         _spawn = new Array();
         _shields = new Array();
      }
      
      public function getDecision() : Number
      {
         ++_decisionTableIndex;
         _decisionTableIndex %= DECISION_TABLE.length;
         return DECISION_TABLE[_decisionTableIndex];
      }
      
      public function stomp() : void
      {
         if(Math.abs(velocity.x) > 100 || Math.abs(velocity.y) > 100)
         {
            FlxG.quake.start(0.02);
            Sfx.playStomp();
         }
         acceleration.x = 0;
         acceleration.y = 0;
         velocity.x = 0;
         velocity.y = 0;
         _lastMode = _mode;
         _mode = MODE_WAIT;
         _modeTimeout = MODE_TIMEOUT;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         stomp();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         stomp();
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         stomp();
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function createChildren() : void
      {
         for (var i:int = 0; i < SHIELDS_REALMAX; i++)
         {
            _shields[i] = new Boss3RushShield();
            PlayState.enemiesNoCollide.add(_shields[i]);
         }
         updateShieldPositions();
         for (i = 0; i < SHIELDS_START; i++)
         {
            _shields[i].create();
         }
         _createdChildren = true;
      }
      
      public function updateShieldPositions() : void
      {
         for (var i:int = 0; i < SHIELDS_REALMAX; i++)
         {
            var _loc2_:Number = (_elapsed / SHIELDS_PERIOD % 1 * SHIELDS_MAX + 17 * i % SHIELDS_REALMAX) % SHIELDS_MAX;
            var _loc3_:Number = _loc2_ % 9;
            if(_loc2_ < 9)
            {
               _shields[i].x = x - 16 + 16 * _loc3_;
               _shields[i].y = y - 16;
            }
            else if(_loc2_ < 18)
            {
               _shields[i].x = x - 16 + 16 * 9;
               _shields[i].y = y - 16 + 16 * _loc3_;
            }
            else if(_loc2_ < 27)
            {
               _shields[i].x = x - 16 + 16 * 9 - 16 * _loc3_;
               _shields[i].y = y - 16 + 16 * 9;
            }
            else
            {
               _shields[i].x = x - 16;
               _shields[i].y = y - 16 + 16 * 9 - 16 * _loc3_;
            }
         }
      }
      
      public function addNewShields() : void
      {
         var _loc1_:int = (MAX_HP - _hp) / SHIELDS_DMG_PER_SHIELD;
         if(_loc1_ > SHIELDS_REALMAX)
         {
            _loc1_ = SHIELDS_REALMAX;
         }
         while(_loc1_ > _shieldNum)
         {
            _shields[_shieldNum++].create();
         }
      }
      
      public function playAnim(param1:String) : void
      {
         play(param1 + _attackMode.toString());
         _lastAnim = param1;
      }
      
      public function attackUp() : void
      {
         _lastMode = _mode;
         _mode = MODE_UP;
         acceleration.y = -ACCEL * _bossSpeed;
         playAnim("up");
      }
      
      public function attackDown() : void
      {
         _lastMode = _mode;
         _mode = MODE_DOWN;
         acceleration.y = ACCEL * _bossSpeed;
         playAnim("down");
      }
      
      public function attackLeft() : void
      {
         _lastMode = _mode;
         _mode = MODE_LEFT;
         acceleration.x = -ACCEL * _bossSpeed;
         playAnim("left");
      }
      
      public function attackRight() : void
      {
         _lastMode = _mode;
         _mode = MODE_RIGHT;
         acceleration.x = ACCEL * _bossSpeed;
         playAnim("right");
      }
      
      public function makeSpawn() : void
      {
         playAnim("mid");
         if(countSpawn() < MAX_SPAWN)
         {
            if(_attackMode == 0)
            {
               _spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 32,y + 32,_attackMode,true)));
               _spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 32,y + 32,_attackMode,false)));
            }
            else
            {
               _spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 0,y + 0,_attackMode,false)));
               _spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 0,y + 64,_attackMode,true)));
               _spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 64,y + 64,_attackMode,false)));
               _spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 64,y + 0,_attackMode,true)));
            }
         }
         _mode = MODE_WAIT;
         _modeTimeout = SPAWN_TIMEOUT;
      }
      
      public function shoot() : void
      {
         var _loc1_:EnemyBulletRotaryPea = PlayState.enemyBulletPool.getBullet(7) as EnemyBulletRotaryPea;
         if(_loc1_)
         {
            _loc1_.shootRotary(x + width / 2,y + height / 2,60,4,Math.PI * 2 / SHOT_NUM * _shotNum);
         }
         if(_loc1_.onScreen() && !_loc1_.dead)
         {
            Sfx.playShot7();
         }
      }
      
      public function checkShoot() : void
      {
         if(MAX_HP - _hp < 1500)
         {
            return;
         }
         switch(_shootMode)
         {
            case SHOOTMODE_WAIT_CLUSTER:
               _clusterTimeout -= FlxG.elapsed * _bossSpeed;
               if(_clusterTimeout <= 0)
               {
                  _shootMode = SHOOTMODE_ATTACK;
                  _shotNum = SHOT_NUM;
                  _shotTimeout = 0;
               }
               break;
            case SHOOTMODE_ATTACK:
               _shotTimeout -= FlxG.elapsed * _bossSpeed;
               if(_shotTimeout <= 0)
               {
                  --_shotNum;
                  if(_shotNum <= 0)
                  {
                     _shootMode = SHOOTMODE_WAIT_CLUSTER;
                     _clusterTimeout = CLUSTER_TIMEOUT;
                  }
                  _shotTimeout = SHOT_TIMEOUT;
                  shoot();
               }
			   break;
         }
      }
      
      public function attackVert() : void
      {
         if(PlayState.player.y < y + height / 2)
         {
            attackUp();
         }
         else
         {
            attackDown();
         }
      }
      
      public function attackHoriz() : void
      {
         if(PlayState.player.x < x + width / 2)
         {
            attackLeft();
         }
         else
         {
            attackRight();
         }
      }
      
      public function checkMode() : void
      {
         _modeTimeout -= FlxG.elapsed * _bossSpeed;
         if(_mode == MODE_WAIT && _modeTimeout < 0)
         {
            --_spawnCounter;
            if(_spawnCounter <= 0)
            {
               _spawnCounter = SPAWN_COUNTER;
               makeSpawn();
            }
            else
            {
               switch(_lastMode)
               {
                  case MODE_INTRO1:
                     attackUp();
                     break;
                  case MODE_RIGHT:
                  case MODE_LEFT:
                     if(getDecision() < 0.75)
                     {
                        attackVert();
                     }
                     else
                     {
                        attackHoriz();
                     }
                     break;
                  case MODE_UP:
                  case MODE_DOWN:
                     if(getDecision() < 0.75)
                     {
                        attackHoriz();
                     }
                     else
                     {
                        attackVert();
                     }
					 break;
               }
            }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(_elapsed > 1 && _elapsed < 2.5)
         {
            if(_elapsed > 1.1 && !_playerInverted)
            {
               PlayState.player.y -= 4;
               _playerInverted = true;
               FlxG.keys.unpress(Player.UP_KEY);
               FlxG.keys.unpress(Player.LEFT_KEY);
               FlxG.keys.unpress(Player.RIGHT_KEY);
               FlxG.keys.unpress(Player.DOWN_KEY);
               FlxG.keys.unpress(Player.ALT_UP_KEY);
               FlxG.keys.unpress(Player.ALT_LEFT_KEY);
               FlxG.keys.unpress(Player.ALT_RIGHT_KEY);
               FlxG.keys.unpress(Player.ALT_DOWN_KEY);
               PlayState.player.doJump();
               PlayState.player.setFaceDir(Player.FACE_CEIL_RIGHT);
            }
            PlayState.player.velocity.x = PlayState.player._runSpeed.value;
         }
         if(!_createdChildren)
         {
            createChildren();
         }
         _elapsed += FlxG.elapsed;
         checkMode();
         checkShoot();
         addNewShields();
         updateShieldPositions();
         super.update();
      }
      
      override public function kill() : void
      {
         super.kill();
         if(_hp <= 0 && !PlayState.player.dead)
         {
            PlayState.setBossDead(3);
            PlayState.showBossRushName(3,true);
            PlayState.sprites.add(new QueuedExplosion(x,y));
         }
         PlayState.enemyBulletPool.destroyAll();
         for (var i:int = 0; i < SHIELDS_REALMAX; i++)
         {
            _shields[i].kill();
         }
         for (i = 0; i < _spawn.length; i++)
         {
            _spawn[i].kill();
         }
         dead = true;
         exists = false;
         active = false;
         visible = false;
      }
      
      override public function hurt(param1:Number) : void
      {
         if(_hp <= MAX_HP * 0.3 && _attackMode < 1)
         {
            _bossSpeed += 0.5;
            _attackMode = 1;
            for (var i:int = 0; i < _spawn.length; i++)
            {
               if(!_spawn[i].dead)
               {
                  _spawn[i].makeBlue();
               }
            }
            SHOT_NUM = 6;
            CLUSTER_TIMEOUT = 4.1;
            SHOT_TIMEOUT = 0.2;
            playAnim(_lastAnim);
         }
         super.hurt(param1);
      }
   }
}

