package
{
    import org.flixel.*;

    public class Boss4SecondForm extends Boss
    {
        // sprite sheet, size per cel
        private static const IMG_WIDTH :int  = 80;
        private static const IMG_HEIGHT:int  = 44;
		
		private static const IMG_OFS_X:int   = 0;
		private static const IMG_OFS_Y:int   = 0;

        // basic boss stats
        private static const MAX_HP:int      = 34000;
        private static const DEFENSE:int     = 0;
        private static const OFFENSE:int     = 6;

        // used for collision with walls
        private static const HIT_NONE:int    = 0;
        private static const HIT_LEFT:int    = 1;
        private static const HIT_RIGHT:int   = 2;
        private static const HIT_TOP:int     = 3;
        private static const HIT_BOTTOM:int  = 4;
        private var _lastHitDir:int          = HIT_NONE;
		
        private var _lastStomp:int           = 0;
        private var _zzz:Array;
        private var _strafeNum:int           = 3;
        private var _lastSmashVelX:Number    = 0;
        private var _lastSmashVelY:Number    = 0;

        private var _decisionTableIndex:int  = 0;
        private var _shotTimeout:Number      = 0;

        private var _lastAnim:String;
        private var _bossSpeed:Number        = 1.0;
        private var _attackPhase:int         = 0;
        private var _elapsed:Number          = 0;
        private var _modeElapsed:Number      = 0;
        private var _modeInitialized:Boolean = false;
        private var _modeTimeout:Number      = 0;
        private var _originX:Number          = 0;
        private var _originY:Number          = 0;
        private var _targetX:Number          = 0;
        private var _targetY:Number          = 0;
        private var _strafeTheta:Number      = 0;
        private var _strafeThetaVel:Number   = 0;
        private var _strafeThetaAcc:Number   = 0;
        private var _waitingToJump:Boolean   = false;
		
        private var _strafeTimeout:Number = 0;
        private var STRAFE_TIMEOUT:Number = 0.03;
        private var STRAFE_SPEED:Number   = 400;
		
		private static const GRAV_JUMP_TIMEOUT:Number = 0.2;
        private static const START_ATTACK_TIME:Number = 0.45;

        private var SMASH_SPEED:Number    = 400;

        private var STOMP_TIMEOUT:Number = 0.25;
        private var _stompTimeout:Number = 0;

        private var WAVE_TIMEOUT:Number = 0.9;
		private var WAVE_SPEED:Number    = 30;
        private var _waveTimeout:Number = 0;

        private var _stomped:Boolean = false;
		private var _aimed:Boolean   = false;

        private var _gravJumpTimeout:Number           = 99999;

        private static const JUMP_POWER:Number        = 360;
        private static const JUMP_TIMEOUT:Number      = 0.8;
        private static const WALK_SPEED:Number        = 200;
        private var _jumpTimeout:Number;

        // one intro state, and four basic states we'll switch between
        // as the battle goes on
        private static const MODE_INTRO       :int = 0;
        private static const MODE_STOMP       :int = 1;
        private static const MODE_SHELLSTRAFE :int = 2;
        private static const MODE_SHELLSMASH  :int = 3;
        private static const MODE_SLEEP       :int = 4;
		
        private static const ZZZ_TIMEOUT:Number = 0.3;
		
        private var _mode:int     = MODE_INTRO;
        private var _lastMode:int = MODE_INTRO;
		
        // we have our own special background that covers up the screen
        private var bg:Boss4SecondFormBg;

        // we have two bullet groups; 0 is pea shooter, 1 is giga wave
        private var _bulletGroups:Boss4SecondFormBulletGroups;

        // used to heal the player at the beginning of the battle
        private var HEAL_TIMEOUT:Number = 0.10;
        private var _healAmount:int = PlayState.player.hpPerHeart()/2;
        private var _healNum:int = PlayState.player.getMaxHp() / _healAmount;
        private var _healTimeout:Number = 0.8;

        private var ZZZ_MAX:int                 = 3;
        private var _zzzTimeout:Number          = 0;
        private var _zzzNum:Number              = 0;

        public function blank(tileX:int, tileY:int):void
        {
            // save the old tile at this coordinate
            PlayState.fixBlocks.rememberBlock(tileX, tileY, 
                PlayState.worldMap.bgmap.getTile(tileX, tileY),
                PlayState.worldMap.fgmap.getTile(tileX, tileY));

            // blank out the tile at this position
            PlayState.worldMap.bgmap.setTile(tileX, tileY, 0);

            // ... the tile we saved will be restored later if snaily dies
        }

        override public function destroy():void
        {
            bg = null;
            _bulletGroups = null;
            _zzz = null; 
            super.destroy();
        }

        public function Boss4SecondForm(X:int, Y:int):void
        {
            // moon snail's first form started out around the middle left side of the screen,
            // facing snaily.  we want a different origin for giga snail, 7 1/2 blocks to the
            // right and 2 3/4 blocks upward; this will be the location we keep returning to
            // for various attacks and animations

            X += 7*16 + 8;
            Y -= 2*16 + 12;
            _originX = X;
            _originY = Y;
            X -= 20;

            // create the parent Boss object with our new origin.  the 'true' is to delay the
            // creation of the HP bar until the scripted sequence is finished
            super(X, Y, MAX_HP, DEFENSE, OFFENSE, true);

            // seed the boss's pseudo-rng based on snaily's x coordinate
            // (should be based on total map position, not screen position)
            _decisionTableIndex = int(PlayState.player.x) % DECISION_TABLE.length;

            _zzz = new Array();

            loadGraphic(Art.Boss4SecondForm, true, true, IMG_WIDTH, IMG_HEIGHT);
            width  = IMG_WIDTH;
            height = IMG_HEIGHT;

            //            name     [list of frames]          fps  looped
            addAnimation("floor0", [0,1],                      3, true);
            addAnimation("ceil0" , [2,3],                      3, true);
            addAnimation("shell0", [11,10,9,8,7,6,5,4],       16, true);
            addAnimation("sleep0", [4]);
            addAnimation("floor1", [12,13],                    4, true);
            addAnimation("ceil1" , [14,15],                    4, true);
            addAnimation("shell1", [23,22,21,20,19,18,17,16], 20, true);
            addAnimation("sleep1", [16]);

            // moon starts out in his shell
            playAnim("shell");
            Music.playNone();
            _noParalyze = false;

            _bulletGroups = PlayState.boss4SecondFormBulletGroups;

            // this makes almost everything go faster, be very careful with it
            if (PlayState.player._slugMode)
                _bossSpeed += 0.2;

            // moon starts out invisible and fades in with his background
            alpha = 0;
            solid = false;
            bg = new Boss4SecondFormBg();
            PlayState.bossBgLayer.add(bg);
        }

        // this is the custom rng, a replacement for Random() with a period of
        // only 100 values that can be manipulated
        public function getDecision():Number
        {
            _decisionTableIndex++;
            _decisionTableIndex %= DECISION_TABLE.length;
            return DECISION_TABLE[_decisionTableIndex];
        }

        // these four "hit" functions are called when moon hits a solid block at 
        // the edge of the screen.  for left/right, they should make moon turn
        // around.  all four can call stomp(), which sets the _stomped variable;
        // other functions will check _stomped and act accordingly

        override public function hitLeft(Contact:FlxObject,Velocity:Number):void
        {
            _lastHitDir = HIT_LEFT;
            if (_mode == MODE_STOMP)
            {
                velocity.x *= -1;
                if (velocity.x < 0)
                    facing = LEFT;
                else
                    facing = RIGHT;
            }
            else
                stomp();
        }   

        override public function hitRight(Contact:FlxObject,Velocity:Number):void
        {
            _lastHitDir = HIT_RIGHT;
            if (_mode == MODE_STOMP)
            {
                velocity.x *= -1;
                if (velocity.x < 0)
                    facing = LEFT;
                else
                    facing = RIGHT;
            }
            else
                stomp();
        }   

        // we hit the edge of the screen, let's make it shake and play a sound!
        public function stomp():void
        {
            if (_stomped)
                return;

            velocity.x = 0;
            velocity.y = 0;
            if (_stompTimeout <= 0)
            {
                FlxG.quake.start(0.02); // shake the screen
                Sfx.playStomp();
                _stompTimeout = STOMP_TIMEOUT;
            }

            _stomped = true;
            _gravJumpTimeout = 999999;
        }

        override public function hitBottom(Contact:FlxObject,Velocity:Number):void
        {   
            _lastHitDir = HIT_BOTTOM;
            stomp();
        }   

        override public function hitTop(Contact:FlxObject,Velocity:Number):void
        {   
            _lastHitDir = HIT_TOP;
            stomp();
        }   

        // this boss acts like any regular enemy and damages snaily on contact
        override public function touch(player:Player):void
        {
            super.touch(player);
        }

        public function playAnim(name:String):void
        {
            // when moon's in his shell, he's 40x44 instead of 80x44
            if (name == "shell")
            {
                if (width != 40)
                    x += 20;
                width = 40;
                offset.x = 20;
            }
            else
            {
                if (width == 40)
                    x -= 20;
                width = 80;
                offset.x = 0;
            }

            // this uses a second set of animations once we're in panic mode
            play(name + _attackPhase.toString());
            _lastAnim = name;
        }

        public function shootWave():void
        {
            if (_waveTimeout > 0)
                return;
            _waveTimeout = WAVE_TIMEOUT;

            // getBullet(1) gives us a new Giga Wave bullet
            var bullet:Boss4Bullet = _bulletGroups.getBullet(1);
            if (!bullet)
                return;

            // aim at the player, but always aim straight left/right
            var velX:Number;
            if (PlayState.player.x < x)
                velX = -WAVE_SPEED;
            else
                velX = WAVE_SPEED;

            bullet.shoot(x + width/2, y, velX, 0);
        }

        public function setMode(mode:int):void
        {
            if (mode == MODE_STOMP)
                _lastStomp = 0;
            else
                _lastStomp++;

            // minimum frequency for stomps, so player always has some chance to 
            // damage the boss (stomps should usually be more frequent, though)
            if (_lastStomp >= 4)
            {
                mode = MODE_STOMP;
                _lastStomp = 0;
            }

            _lastMode = _mode;
            _mode = mode;
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

        public function overlapPlayerBulletBoss4Bullet(obj1:FlxObject, obj2:FlxObject):void
        {
            if (obj1 is PlayerBullet && obj2 is Boss4Bullet)
            {
                var playerBullet:PlayerBullet = obj1 as PlayerBullet;
                var boss4Bullet:Boss4Bullet = obj2 as Boss4Bullet;

                // you can't see it in this file, but moon's giga wave doesn't destroy player
                // bullets if they're going straight up or down.  it only destroys diagonal 
                // or horizontal bullets
                boss4Bullet.hitPlayerBullet(playerBullet);
            }
        }

        private function updateAiIntro():void
        {
            if (_elapsed > 2 && _elapsed < 3)
            {
                alpha = _elapsed - 2;
            }
            else
            if (_elapsed > 3 && _delayIntro)
            {
                alpha = 1;
                _delayIntro = false;
                resetStartTime();
                PlayState.hud.bossBarHud.makeBar(_hp);
                Music.playBoss2();
            }
            if (_introDone)
            {
                // the moon snail boss arena has two blocks in the upper-left and 
                // upper-right corners.  let's destroy those blocks for the second
                // battle; they'll be restored if snaily dies and fights moon again
                blank(28,66);
                blank(50,66);

                // moon's ready to start fighting.  he always begins with a stomp
                setMode(MODE_STOMP);
                solid = true;
            }
        }

        // moon picks one of 7 locations to start his stomp.  it was supposed to be 8 locations
        // arranged in a square, but due to a mistake in coding, two of the cases are the same.
        // as a result that location is twice as common as the others.
        private function pickStompTarget():void
        {
            _targetX = x;
            _targetY = y;

            do {
                var targetNum:int = (getDecision() * 8);
                switch (targetNum)
                {
                    case 0: _targetX = _originX + 16* 7; _targetY = _originY + 16* 5; break;
                    case 1: _targetX = _originX + 16*-7; _targetY = _originY + 16* 5; break;
                    case 2: _targetX = _originX + 16* 7; _targetY = _originY + 16*-5; break;
                    case 3: _targetX = _originX + 16*-7; _targetY = _originY + 16*-5; break;
                    case 4: _targetX = _originX + 16* 7; _targetY = _originY;         break;
                    case 5: _targetX = _originX + 16*-7; _targetY = _originY;         break;
                    case 6: _targetX = _originX;         _targetY = _originY + 16*-5; break; // oops!
                    case 7: _targetX = _originX;         _targetY = _originY + 16*-5; break;
                }
            } while (Utility.dist(_targetX + width / 2, 
                                  _targetY + height / 2, 
                                  PlayState.player.x + PlayState.player.width / 2, 
                                  PlayState.player.y + PlayState.player.height / 2) < 130);
            // if snaily is too close, pick another spot; this causes the RNG to skip forward
        }

        private function updateAiSleep():void
        {
            if (!_modeInitialized)
            {
                // are we going to fall on the player?  that would be really unfair (we want the player to ALWAYS be able to
                // avoid damage through skill), so let's abort our sleep if that happens and go back to stomp.
                if (Math.abs(x + width/2 - (PlayState.player.x + PlayState.player.width / 2)) < 40 && y < PlayState.player.y)
                {
                    setMode(MODE_STOMP);
                    return;
                }

                _modeInitialized = true;
                bg.setTargetRgb(0xb0, 0xae, 0x00);
                _modeTimeout = 6.2;
                bg.bgColorSpeed = 3.0;
                playAnim("sleep");
                _zzzNum = 0;
                _zzzTimeout = ZZZ_TIMEOUT;
                if (PlayState.player._slugMode)
                {
                    ZZZ_MAX = 5;
                    _modeTimeout *= 1.23;
                }
                acceleration.y = 900;
                Sfx.playShell();
            }

            // have we hit the floor yet?
            if (_stomped)
            {
                _zzzTimeout -= FlxG.elapsed * _bossSpeed;
                if (_zzzTimeout < 0 && _zzzNum < ZZZ_MAX)
                {
                    // these are NoCollide enemies, which means they can fly through walls
                    PlayState.enemiesNoCollide.add(new BossZzz(x + width/2, y, x + width + 24*_zzzNum, y));
                    _zzzTimeout = ZZZ_TIMEOUT;
                    _zzzNum++;
                }
                acceleration.y = 0;
            }

            // we're done, pick our next AI phase
            if (_modeTimeout <= 0)
            {
                if (getDecision() > 0.5)
                    setMode(MODE_STOMP);
                else
                    setMode(MODE_SHELLSTRAFE);
            }
        }

        private function updateAiStomp():void
        {
            if (!_modeInitialized)
            {
                _modeInitialized = true;
                bg.setTargetRgb(0x00, 0x30, 0x00);
                _modeTimeout = 6.0;
                bg.bgColorSpeed = 3.0;

                // this is where we pick one of our 7 locations to start at ...
                pickStompTarget();
            }

            if (_lastAnim == "shell")
            {
                // once we're close to our target position, stop moving and decide 
                // to fall up or down.  NOTE: this means we don't actually reach our
                // target position before we stop and come out of our shell
                if (Utility.dist(x, y, _targetX, _targetY) < 10)
                {
                    if (getDecision() > 0.5)
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

                // we're not there yet, so we'll keep lerping toward our target position
                x = Utility.integrate(x, _targetX, 0.7, FlxG.elapsed * _bossSpeed); 
                y = Utility.integrate(y, _targetY, 0.7, FlxG.elapsed * _bossSpeed); 
            }
            else
            {
                facePlayer();

                if (_stomped)
                {
                    if (!_waitingToJump)
                    {
                        _waitingToJump = true;
                        _jumpTimeout = JUMP_TIMEOUT;
                    }

                    _jumpTimeout -= FlxG.elapsed * _bossSpeed;
                    if (_waitingToJump && _jumpTimeout <= 0)
                    {
                        _waitingToJump = false;
                        _stomped = false;

                        if (acceleration.y < 0)
                            velocity.y = JUMP_POWER;
                        else
                            velocity.y = -JUMP_POWER;

                        if (facing == LEFT)
                            velocity.x = -WALK_SPEED;
                        else
                            velocity.x = WALK_SPEED;

                        _gravJumpTimeout = GRAV_JUMP_TIMEOUT;
                        _jumpTimeout = 99999;
                    }
                    else
                    if (velocity.y != 0)
                    {
                        _gravJumpTimeout -= FlxG.elapsed;
                        if (_gravJumpTimeout < 0)
                        {
                            if (getDecision() > 0.66)
                            {
                                if (acceleration.y < 0)
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

            // we want to wait longer to start shooting in panic
            // phase, because our timer scales with boss speed,
            // and the boss speed just went up . . . so let's make
            // that more fair by counteracting it here
            if (_attackPhase == 0 && _modeElapsed > START_ATTACK_TIME*2.5)
                shootWave();
            if (_attackPhase == 1 && _modeElapsed > START_ATTACK_TIME*3.2)
                shootWave();

            // we're done, pick our next AI phase
            if (_modeTimeout <= 0)
            {
                // can only sleep in panic phase
                if (_attackPhase == 1 && getDecision() > 0.70)
                    setMode(MODE_SLEEP);
                else
                if (getDecision() > 0.7)
                    setMode(MODE_SHELLSMASH);
                else
                if (getDecision() > 0.8)
                    setMode(MODE_STOMP);
                else
                    setMode(MODE_SHELLSTRAFE);
            }
        }

        public function facePlayer():void
        {
            if (PlayState.player.x < x + width/2 - PlayState.player.width/2)
                facing = LEFT;
            else
                facing = RIGHT;
        }

        private function aimStrafe():void
        {
            // start by aiming directly at snaily
            var theta:Number = Math.atan2(
                PlayState.player.y - (y + height/2),
                PlayState.player.x - (x + width/2));

            // scale the number of beams so it gets gradually harder as moon's health drops toward zero
            _strafeNum = 2.3 + (5 * Number(MAX_HP - _hp) / MAX_HP);
            if (_strafeNum < 2)
                _strafeNum = 2;
            if (_strafeNum > 7)
                _strafeNum = 7;

            // then adjust the aim AWAY from snaily
            _strafeTheta = theta - Math.PI/_strafeNum;
        }

        private function updateAiShellStrafe():void
        {
            if (!_modeInitialized)
            {
                _modeInitialized = true;
                if (_attackPhase < 1)
                    bg.setTargetRgb(0x30, 0x00, 0x30);
                else
                    bg.setTargetRgb(0x00, 0x30, 0x30);
                bg.bgColorSpeed = 3.0;
                _modeTimeout = 5.2;
                playAnim("shell");
                _targetX = _originX;
                _targetY = _originY;
                _aimed = false;
            }

            // lerp smoothly to the center of the screen before we shoot
            x = Utility.integrate(x, _targetX, 1.7, FlxG.elapsed * _bossSpeed); 
            y = Utility.integrate(y, _targetY, 1.7, FlxG.elapsed * _bossSpeed); 

            // don't shoot until we're in the center or very close
            if (_modeElapsed > START_ATTACK_TIME && !_aimed && Utility.dist(x,y,_targetX,_targetY) < 10)
            {
                // to be fair, we want to aim so snaily is exactly halfway between two streams of bullets
                aimStrafe();

                // and then we choose a direction rotate, doesn't matter which one
                if (getDecision() > 0.5)
                    _strafeThetaVel = Math.PI / 8;
                else
                    _strafeThetaVel = -Math.PI / 8;
				
                // we only want to do this once per AI cycle . . .
                _aimed = true;

                // and we'll spin a lot faster in slug mode
                if (PlayState.player._slugMode)
                    _strafeThetaVel *= 1.6;
            }

            // the acceleration here is unused, but does show up in boss rush, where
            // sun snail will change directions to surprise the player
            _strafeTheta    += _strafeThetaVel * FlxG.elapsed * _bossSpeed;
            _strafeThetaVel += _strafeThetaAcc * FlxG.elapsed * _bossSpeed;

            if (_modeElapsed > START_ATTACK_TIME && _aimed)
            {
                shootStrafeMultiWay();
            }

            // we're done, pick our next AI phase
            if (_modeTimeout <= 0)
            {
                // can only sleep in panic phase
                if (_attackPhase == 1 && getDecision() > 0.74)
                    setMode(MODE_SLEEP);
                else
                if (getDecision() < 0.77)
                    setMode(MODE_STOMP);
                else
                    setMode(MODE_SHELLSMASH);
            }
        }

        public function shootStrafeSingleShot(theta:Number):void
        {
            // getBullet(0) gives us a new Pea Shooter bullet
            var bullet:Boss4Bullet = _bulletGroups.getBullet(0);
            if (!bullet)
                return;

            var xVel:Number = STRAFE_SPEED * Math.cos(theta);
            var yVel:Number = STRAFE_SPEED * Math.sin(theta);
            bullet.shoot(x + width/2, y + height/2, xVel, yVel);
        }

        public function shootStrafeMultiWay():void
        {
            if (_strafeTimeout > 0)
                return;
            _strafeTimeout = STRAFE_TIMEOUT;

            for (var i:int=0; i<_strafeNum; i++)
                shootStrafeSingleShot(_strafeTheta + 2*Math.PI/_strafeNum*i);
        }

        private function pickSmashDir(alwaysTargetPlayer:Boolean = false):void
        {
            var theta:Number = FlxU.random() * 2*Math.PI;
            if (getDecision() > 0.5 || alwaysTargetPlayer)
                theta = Math.atan2(
                    (PlayState.player.y + PlayState.player.height / 2) - (y + height / 2), 
                    (PlayState.player.x + PlayState.player.width  / 2) - (x + width / 2));
            velocity.x = 0;
            velocity.y = 0;
            acceleration.x = SMASH_SPEED * _bossSpeed * Math.cos(theta);
            acceleration.y = SMASH_SPEED * _bossSpeed * Math.sin(theta);

            // if we did pick a random direction, we might have aimed directly at a wall
            // that we just hit; if so, we want to aim the opposite direction to avoid
            // getting stuck on that wall
            if (_lastHitDir == HIT_RIGHT  && acceleration.x > 0) acceleration.x *= -1;
            if (_lastHitDir == HIT_LEFT   && acceleration.x < 0) acceleration.x *= -1;
            if (_lastHitDir == HIT_BOTTOM && acceleration.y > 0) acceleration.y *= -1;
            if (_lastHitDir == HIT_TOP    && acceleration.y < 0) acceleration.y *= -1;
        }

        private function updateAiShellSmash():void
        {
            if (!_modeInitialized)
            {
                _modeInitialized = true;
                bg.setTargetRgb(0x30, 0x00, 0x00);
                bg.bgColorSpeed = 3.0;
                _modeTimeout = 6.0;
                playAnim("shell");

                pickSmashDir();
            }

            // when we hit a wall during shell smash, we'll bounce off the wall in the
            // opposite direction.  however, we have a chance of aiming directly at the
            // player instead; this looks like it should be 30% here, but it combines
            // with a second getDecision in pickSmashDir to give a combined 65% chance.
            // once moon's in his panic phase, we'll always aim directly at snaily
            if (_stomped)
            {
                _stomped = false;

                if (getDecision() > 0.7 || _attackPhase == 1)
                    pickSmashDir(true);
                else
                {
                    if (velocity.y == 0)
                        acceleration.y *= -1;
                    else
                        acceleration.x *= -1;
                }
            }

            // we're done, pick our next AI phase
            if (_modeTimeout <= 0)
            {
                if (getDecision() > 0.5)
                    setMode(MODE_STOMP);
                else
                    setMode(MODE_SHELLSTRAFE);
            }
        }

        override public function update():void
        {
            if (PlayState.realState != PlayState.STATE_GAME)
                return;

            // this is the very start of the battle.  we want to
            // heal snaily to full health before he has to fight,
            // just to make things a little more fair
            if (_healNum > 0)
            {
                _healTimeout -= FlxG.elapsed;
                if (_healTimeout < 0)
                {
                    _healTimeout = HEAL_TIMEOUT;
                    _healNum--;
                    PlayState.player.heal(_healAmount);
                    Sfx.playPickup4();
                    if (PlayState.player.getCurHp() == PlayState.player.getMaxHp())
                        _healNum = -1;
                }
            }

            // timeout between repeated AI actions
            _waveTimeout   -= FlxG.elapsed * _bossSpeed;
            _modeTimeout   -= FlxG.elapsed * _bossSpeed;
            _strafeTimeout -= FlxG.elapsed * _bossSpeed;
            _stompTimeout  -= FlxG.elapsed * _bossSpeed;

            // keep track of the total time spent in the current mode
            _modeElapsed   += FlxG.elapsed * _bossSpeed;

            switch (_mode)
            {
                case MODE_INTRO:
                    updateAiIntro();
                    break;

                // moon comes out of his shell and stomps on the floor or ceiling, shooting giga waves
                case MODE_STOMP:
                    updateAiStomp();
                    break;

                // moon fires rotating beams of upgraded pea shooter from the center of the screen
                case MODE_SHELLSTRAFE:
                    updateAiShellStrafe();
                    break;

                // moon smashes against the side of the screen repeatedly
                case MODE_SHELLSMASH:
                    updateAiShellSmash();
                    break;

                // moon goes into his shell, then surprises snaily with cute and surreal combat Zs
                // (only happens in panic phase)
                case MODE_SLEEP:
                    updateAiSleep();
                    break;
            }

            // the boss's giga wave can destroy player bullets
            FlxU.overlap(PlayState.playerBulletGroups, _bulletGroups, overlapPlayerBulletBoss4Bullet);

            // and it can also destroy poor snaily
            FlxU.overlap(PlayState.player, _bulletGroups, overlapPlayerBoss4Bullet);

            // keep track of the total time spent fighting this boss
            _elapsed += FlxG.elapsed;

            super.update();

            // make sure snaily can always move; there's some shared code in the parent boss object which
            // paralyzes the player during scripted sequences
            PlayState.player.paralyze(false);
        }

        public function overlapPlayerBoss4Bullet(obj1:FlxObject, obj2:FlxObject):void
        {
            if (obj1 is Player && obj2 is Boss4Bullet)
            {
                var player:Player = obj1 as Player;
                var boss4Bullet:Boss4Bullet = obj2 as Boss4Bullet;

                boss4Bullet.hitPlayer(player);
            }
        }

        // giga snail's been defeated!  you win!!  yay you!! <3
        override public function kill():void
        {
            super.kill();
            if (_hp <= 0 && !PlayState.player.dead)
            {
                PlayState.setBossDead(4);
                PlayState.showBossName(4, true);
                PlayState.hud.areaName.increaseTimer(16);
                PlayState.sprites.add(new QueuedExplosion(x, y, true));
                PlayState.player.hasWonGame = true;
                if (PlayState.player._hardMode)
                    PlayState.player.hasWonHardMode = true;
                PlayState.player.saveGame();
                bg.fadeOut();

                PlayState.triggerEnding();
            }
            PlayState.miniMap.setMapLittle();

            Music.playNone();
            PlayState.enemyBulletPool.destroyAll();

            dead    = true;
            exists  = false;
            active  = false;
            visible = false;
        }

        override public function hurt(dmg:Number):void
        {
            // moon's shell is invincible
            if (_lastAnim == "shell" || _lastAnim == "sleep")
            {
                dmg = 0;
            }

            // moon enters his panic phase at 40% health
            if (_hp <= MAX_HP * 0.4 && _attackPhase < 1)
            {
                _bossSpeed += 0.5;
                _attackPhase = 1;

                playAnim(_lastAnim);
            }

            // otherwise, if moon's out of his shell, he can be hurt
            super.hurt(dmg);
        }

        // table of 100 "random" values used from getDecision()
        private static const DECISION_TABLE:Array = [
            0.1640168826, 0.3892556902, 0.0336081053, 0.2246864975, 0.5434009453, 
            0.4227320437, 0.1017472328, 0.2041907897, 0.9950191347, 0.3634705228, 
            0.0779175897, 0.3848227320, 0.3284047846, 0.0951552057, 0.1941055446, 
            0.4963590460, 0.2428007567, 0.8280672868, 0.8527329860, 0.6928913176, 
            0.2023843678, 0.7280045905, 0.4311591744, 0.7967880240, 0.4119148700, 
            0.7108575032, 0.1134556829, 0.6883870615, 0.8149317527, 0.8392490375, 
            0.3647662453, 0.3487805783, 0.7900575239, 0.1670561498, 0.9810836953, 
            0.0097847681, 0.2244645569, 0.0842442402, 0.3263779227, 0.1481701068, 
            0.6538572663, 0.2544128409, 0.1991950422, 0.5410570990, 0.5747002570, 
            0.5926224371, 0.3101345710, 0.6104650203, 0.3545506087, 0.2313309166, 
            0.3070387696, 0.0790505658, 0.9804949607, 0.7704714904, 0.7152660213, 
            0.8215058975, 0.9426850446, 0.7483973576, 0.7602092802, 0.8816058980, 
            0.5136580468, 0.0190696615, 0.2875916200, 0.1565554394, 0.3664312259, 
            0.2586407176, 0.3185483313, 0.9837348993, 0.3330417452, 0.2801789805, 
            0.3288621592, 0.0230039287, 0.3039146720, 0.7212895333, 0.6296904139, 
            0.8659332532, 0.1715852607, 0.3900271956, 0.2824020982, 0.1624092775, 
            0.7599701669, 0.6952292831, 0.2161165745, 0.9005386635, 0.3707154895, 
            0.6392742953, 0.4521491870, 0.5595775233, 0.6862866750, 0.7266258821, 
            0.6904605229, 0.6808205255, 0.6856147591, 0.2996751820, 0.8012191872, 
            0.8044759710, 0.1926201715, 0.8868517061, 0.8347136807, 0.1512707539
        ];
    }
};
