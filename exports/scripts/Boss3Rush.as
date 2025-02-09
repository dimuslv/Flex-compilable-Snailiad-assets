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
      
      public function Boss3Rush(param1:int, param2:int)
      {
         this._shotNum = this.SHOT_NUM;
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
         this.playAnim("mid");
         PlayState.player.x += 20;
         PlayState.player.setFaceDir(Player.FACE_FLOOR_RIGHT);
         if(PlayState.player._slugMode)
         {
            this.SHOT_NUM += 2;
            this._bossSpeed += 0.3;
         }
         this._spawn = new Array();
         this._shields = new Array();
      }
      
      public function countSpawn() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._spawn.length)
         {
            if(Boolean(this._spawn[_loc2_]) && !this._spawn[_loc2_].dead)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._shields.length)
         {
            this._shields[_loc1_] = null;
            _loc1_++;
         }
         this._shields = null;
         _loc1_ = 0;
         while(_loc1_ < this._spawn.length)
         {
            this._spawn[_loc1_] = null;
            _loc1_++;
         }
         this._spawn = null;
         super.destroy();
      }
      
      public function getDecision() : Number
      {
         ++this._decisionTableIndex;
         this._decisionTableIndex %= DECISION_TABLE.length;
         return DECISION_TABLE[this._decisionTableIndex];
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
         this._lastMode = this._mode;
         this._mode = MODE_WAIT;
         this._modeTimeout = MODE_TIMEOUT;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         this.stomp();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         this.stomp();
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         this.stomp();
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function createChildren() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < SHIELDS_REALMAX)
         {
            this._shields[_loc1_] = new Boss3RushShield();
            PlayState.enemiesNoCollide.add(this._shields[_loc1_]);
            _loc1_++;
         }
         this.updateShieldPositions();
         _loc1_ = 0;
         while(_loc1_ < SHIELDS_START)
         {
            this._shields[_loc1_].create();
            _loc1_++;
         }
         this._createdChildren = true;
      }
      
      public function updateShieldPositions() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         while(_loc3_ < SHIELDS_REALMAX)
         {
            _loc1_ = (this._elapsed / SHIELDS_PERIOD % 1 * SHIELDS_MAX + 17 * _loc3_ % SHIELDS_REALMAX) % SHIELDS_MAX;
            _loc2_ = _loc1_ % 9;
            if(_loc1_ < 9)
            {
               this._shields[_loc3_].x = x - 16 + 16 * _loc2_;
               this._shields[_loc3_].y = y - 16;
            }
            else if(_loc1_ < 18)
            {
               this._shields[_loc3_].x = x - 16 + 16 * 9;
               this._shields[_loc3_].y = y - 16 + 16 * _loc2_;
            }
            else if(_loc1_ < 27)
            {
               this._shields[_loc3_].x = x - 16 + 16 * 9 - 16 * _loc2_;
               this._shields[_loc3_].y = y - 16 + 16 * 9;
            }
            else
            {
               this._shields[_loc3_].x = x - 16;
               this._shields[_loc3_].y = y - 16 + 16 * 9 - 16 * _loc2_;
            }
            _loc3_++;
         }
      }
      
      public function addNewShields() : void
      {
         var _loc1_:int = (MAX_HP - _hp) / SHIELDS_DMG_PER_SHIELD;
         if(_loc1_ > SHIELDS_REALMAX)
         {
            _loc1_ = SHIELDS_REALMAX;
         }
         while(_loc1_ > this._shieldNum)
         {
            this._shields[this._shieldNum++].create();
         }
      }
      
      public function playAnim(param1:String) : void
      {
         play(param1 + this._attackMode.toString());
         this._lastAnim = param1;
      }
      
      public function attackUp() : void
      {
         this._lastMode = this._mode;
         this._mode = MODE_UP;
         acceleration.y = -this.ACCEL * this._bossSpeed;
         this.playAnim("up");
      }
      
      public function attackDown() : void
      {
         this._lastMode = this._mode;
         this._mode = MODE_DOWN;
         acceleration.y = this.ACCEL * this._bossSpeed;
         this.playAnim("down");
      }
      
      public function attackLeft() : void
      {
         this._lastMode = this._mode;
         this._mode = MODE_LEFT;
         acceleration.x = -this.ACCEL * this._bossSpeed;
         this.playAnim("left");
      }
      
      public function attackRight() : void
      {
         this._lastMode = this._mode;
         this._mode = MODE_RIGHT;
         acceleration.x = this.ACCEL * this._bossSpeed;
         this.playAnim("right");
      }
      
      public function makeSpawn() : void
      {
         this.playAnim("mid");
         if(this.countSpawn() < MAX_SPAWN)
         {
            if(this._attackMode == 0)
            {
               this._spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 32,y + 32,this._attackMode,true)));
               this._spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 32,y + 32,this._attackMode,false)));
            }
            else
            {
               this._spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 0,y + 0,this._attackMode,false)));
               this._spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 0,y + 64,this._attackMode,true)));
               this._spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 64,y + 64,this._attackMode,false)));
               this._spawn.push(PlayState.enemies.add(new Boss3RushSpawn(x + 64,y + 0,this._attackMode,true)));
            }
         }
         this._mode = MODE_WAIT;
         this._modeTimeout = SPAWN_TIMEOUT;
      }
      
      public function shoot() : void
      {
         var _loc1_:EnemyBulletRotaryPea = PlayState.enemyBulletPool.getBullet(7) as EnemyBulletRotaryPea;
         if(_loc1_)
         {
            _loc1_.shootRotary(x + width / 2,y + height / 2,60,4,Math.PI * 2 / this.SHOT_NUM * this._shotNum);
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
         switch(this._shootMode)
         {
            case SHOOTMODE_WAIT_CLUSTER:
               this._clusterTimeout -= FlxG.elapsed * this._bossSpeed;
               if(this._clusterTimeout <= 0)
               {
                  this._shootMode = SHOOTMODE_ATTACK;
                  this._shotNum = this.SHOT_NUM;
                  this._shotTimeout = 0;
               }
               break;
            case SHOOTMODE_ATTACK:
               this._shotTimeout -= FlxG.elapsed * this._bossSpeed;
               if(this._shotTimeout <= 0)
               {
                  --this._shotNum;
                  if(this._shotNum <= 0)
                  {
                     this._shootMode = SHOOTMODE_WAIT_CLUSTER;
                     this._clusterTimeout = this.CLUSTER_TIMEOUT;
                  }
                  this._shotTimeout = this.SHOT_TIMEOUT;
                  this.shoot();
               }
         }
      }
      
      public function attackVert() : void
      {
         if(PlayState.player.y < y + height / 2)
         {
            this.attackUp();
         }
         else
         {
            this.attackDown();
         }
      }
      
      public function attackHoriz() : void
      {
         if(PlayState.player.x < x + width / 2)
         {
            this.attackLeft();
         }
         else
         {
            this.attackRight();
         }
      }
      
      public function checkMode() : void
      {
         this._modeTimeout -= FlxG.elapsed * this._bossSpeed;
         if(this._mode == MODE_WAIT && this._modeTimeout < 0)
         {
            --this._spawnCounter;
            if(this._spawnCounter <= 0)
            {
               this._spawnCounter = SPAWN_COUNTER;
               this.makeSpawn();
            }
            else
            {
               switch(this._lastMode)
               {
                  case MODE_INTRO1:
                     this.attackUp();
                     break;
                  case MODE_RIGHT:
                  case MODE_LEFT:
                     if(this.getDecision() < 0.75)
                     {
                        this.attackVert();
                     }
                     else
                     {
                        this.attackHoriz();
                     }
                     break;
                  case MODE_UP:
                  case MODE_DOWN:
                     if(this.getDecision() < 0.75)
                     {
                        this.attackHoriz();
                     }
                     else
                     {
                        this.attackVert();
                     }
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
         if(this._elapsed > 1 && this._elapsed < 2.5)
         {
            if(this._elapsed > 1.1 && !this._playerInverted)
            {
               PlayState.player.y -= 4;
               this._playerInverted = true;
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
         if(!this._createdChildren)
         {
            this.createChildren();
         }
         this._elapsed += FlxG.elapsed;
         this.checkMode();
         this.checkShoot();
         this.addNewShields();
         this.updateShieldPositions();
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
         var _loc1_:int = 0;
         while(_loc1_ < SHIELDS_REALMAX)
         {
            this._shields[_loc1_].kill();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._spawn.length)
         {
            this._spawn[_loc1_].kill();
            _loc1_++;
         }
         dead = true;
         exists = false;
         active = false;
         visible = false;
      }
      
      override public function hurt(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(_hp <= MAX_HP * 0.3 && this._attackMode < 1)
         {
            this._bossSpeed += 0.5;
            this._attackMode = 1;
            _loc2_ = 0;
            while(_loc2_ < this._spawn.length)
            {
               if(!this._spawn[_loc2_].dead)
               {
                  this._spawn[_loc2_].makeBlue();
               }
               _loc2_++;
            }
            this.SHOT_NUM = 6;
            this.CLUSTER_TIMEOUT = 4.1;
            this.SHOT_TIMEOUT = 0.2;
            this.playAnim(this._lastAnim);
         }
         super.hurt(param1);
      }
   }
}

