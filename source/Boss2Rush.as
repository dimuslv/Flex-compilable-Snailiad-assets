package
{
   import org.flixel.*;
   
   public class Boss2Rush extends Boss
   {
      public static const DEFENSE:int = 5;
      
      private static const OFFENSE:int = 0;
      
      private static const NO_ORIGIN:Number = -999999999;
      
      private static const MODE_INTRO1:int = 0;
      
      private static const MODE_INTRO2:int = 1;
      
      private static const MODE_INTRO3:int = 2;
      
      private static const MODE_MOVESTOMP:int = 3;
      
      private static const MODE_HUNT:int = 4;
      
      private static const MODE_SYNC:int = 5;
      
      private static const MODE_STEP:int = 6;
      
      private static const FOOTMODE_NONE:int = 0;
      
      private static const FOOTMODE_STOMP:int = 1;
      
      private static const FOOTMODE_WAITRAISE:int = 2;
      
      private static const FOOTMODE_RAISE:int = 3;
      
      private static const FOOTMODE_MOVE:int = 4;
      
      private static const FOOTMODE_SYNC:int = 5;
      
      private static const FOOTMODE_STEP:int = 6;
      
      private static const FOOTMODE_STEPNOW:int = 7;
      
      private static const FOOTMODE_STEPWAIT:int = 8;
      
      private static const RAISED_Y:int = -220;
      
      private static const STOMP_Y:int = 0;
      
      private static const LEYE_OFS_X:int = 97;
      
      private static const LEYE_OFS_Y:int = -25;
      
      private static const REYE_OFS_X:int = -9;
      
      private static const REYE_OFS_Y:int = -25;
      
      private static const LFOOT_OFS_X:int = -250;
      
      private static const RFOOT_OFS_X:int = 0;
      
      private static const MIN_DIST:int = 36;
      
      private static const SEC_PER_TICK:Number = 0.01;
      
      private var MAX_HP:int = 10000;
      
      private var _originX:int = 0;
      
      private var _originY:int = 0;
      
      private var _attackMode:int = 0;
      
      private var _bossSpeed:Number = 1.1;
      
      private var _createdChildren:Boolean = false;
      
      private var _totalElapsed:Number = 0;
      
      private var beingKilled:Boolean = false;
      
      public var lfoot:Boss2RushFoot;
      
      public var rfoot:Boss2RushFoot;
      
      private var leye:Boss2RushEye;
      
      private var reye:Boss2RushEye;
      
      private var mode:int = 0;
      
      private var eyesOnFeet:Boolean;
      
      private var lmode:int = 0;
      
      private var rmode:int = 0;
      
      private var lfooty:int = 0;
      
      private var rfooty:int = 0;
      
      private var lfootxtarget:Number = 0;
      
      private var rfootxtarget:Number = 0;
      
      private var lfootxvel:Number = 0;
      
      private var rfootxvel:Number = 0;
      
      private var lfootx:Number = 0;
      
      private var rfootx:Number = 0;
      
      private var lfootyVel:Number = 0;
      
      private var rfootyVel:Number = 0;
      
      private var lfootytarget:int = 0;
      
      private var rfootytarget:int = 0;
      
      private var lsteporiginx:Number = 0;
      
      private var lsteporiginy:Number = 0;
      
      private var rsteporiginx:Number = 0;
      
      private var rsteporiginy:Number = 0;
      
      private var stepradius:Number = 40;
      
      private var mineyey:int;
      
      private var nextStepIsLeft:Boolean = true;
      
      private var stepDirIsLeft:Boolean = true;
      
      private var stepModeTimeout:Number = 0;
      
      private var SYNC_MODE_TIMEOUT:Number = 3;
      
      private var STEP_MODE_TIMEOUT:Number = 9;
      
      private var lsteptheta:Number = 0;
      
      private var rsteptheta:Number = 0;
      
      private var lfootStompTimeout:Number = 0;
      
      private var rfootStompTimeout:Number = 0;
      
      private var lfootStompTimeoutIndex:int = 23;
      
      private var rfootStompTimeoutIndex:int = 34;
      
      private var lfootRaiseTimeout:Number = 0;
      
      private var rfootRaiseTimeout:Number = 0;
      
      private var _elapsed:Number = 0;
      
      private var cannons:Array;
      
      private var ltheta:Number = 0;
      
      private var rtheta:Number = 0;
	  
	  private var TIMEOUTS:Array;
      
      public function Boss2Rush(param1:int, param2:int)
      {
         this.TIMEOUTS = [0.60153,0.48509,0.70037,0.66276,0.70802,0.79541,0.62043,0.5796,0.99605,0.15058,0.72121,0.86851,0.64371,0.76708,0.89401,0.52828,0.72309,0.15963,0.15116,0.1799,0.27829,0.40878,0.92538,0.45074,0.18865,0.59797,0.4318,0.94098,0.23463,0.29221,0.59734,0.34877,0.81676,0.57617,0.14883,0.16094,0.14123,0.57931,0.85924,0.22828,0.63834,0.10387,0.54746,0.24897,0.11105,0.49748,0.54746,0.19405,0.79792,0.36023,0.53726,0.78544,0.60425,0.83512,0.01696,0.10451,0.01513,0.78678,0.51617,0.24251];
         if(Boolean(PlayState.player) && PlayState.player._hardMode)
         {
            this._bossSpeed + 0.35;
            this.MAX_HP *= 1.3;
         }
         super(param1,param2,this.MAX_HP,DEFENSE,OFFENSE,true);
         y += 41;
         this.mineyey = y - 80;
         PlayState.boss2rush = this;
         this.eyesOnFeet = true;
         this.lfooty = RAISED_Y;
         this.rfooty = RAISED_Y;
         solid = false;
         this.lfoot = new Boss2RushFoot(x + LFOOT_OFS_X,y + this.lfooty,true);
         this.rfoot = new Boss2RushFoot(x,y + this.rfooty,false);
         PlayState.enemies.add(this.lfoot);
         PlayState.enemies.add(this.rfoot);
         this.leye = new Boss2RushEye(this.lfoot.x + LEYE_OFS_X,this.lfoot.y + LEYE_OFS_Y,true);
         this.reye = new Boss2RushEye(this.rfoot.x + REYE_OFS_X,this.rfoot.y + REYE_OFS_Y,false);
         PlayState.enemies.add(this.leye);
         PlayState.enemies.add(this.reye);
         this.cannons = new Array();
         this.cannons[0] = PlayState.enemies.add(new EnemyCannonTopBossRush(x - 160 - 32,y - 25));
         this.cannons[1] = PlayState.enemies.add(new EnemyCannonTopBossRush(x + 160 - 32,y - 25));
         this.cannons[2] = PlayState.enemies.add(new EnemyCannonTopBossRush(x - 256 - 32,y - 25));
         this.cannons[3] = PlayState.enemies.add(new EnemyCannonTopBossRush(x + 256 - 32,y - 25));
         this.cannons[4] = PlayState.enemies.add(new EnemyCannonTopBossRush(x - 204 - 32,y - 25));
         this.cannons[5] = PlayState.enemies.add(new EnemyCannonTopBossRush(x + 204 - 32,y - 25));
         this.cannons[6] = PlayState.enemies.add(new EnemyCannonTopBossRush(x - 112 - 32,y - 25));
         this.cannons[7] = PlayState.enemies.add(new EnemyCannonTopBossRush(x + 112 - 32,y - 25));
         visible = false;
         addAnimation("normal",[0]);
         play("normal");
         PlayState.player.x -= 20;
         PlayState.player.setFaceDir(Player.FACE_FLOOR_LEFT);
         PlayState.player.velocity.x = -PlayState.player._runSpeed.value;
         PlayState.player.paralyze(true);
         this.moveChildren();
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this.cannons)
         {
            this.cannons[_loc1_] = null;
         }
         this.cannons = null;
         this.lfoot = null;
         this.rfoot = null;
         this.leye = null;
         this.reye = null;
         PlayState.boss2rush = null;
         super.destroy();
      }
      
      public function moveChildren() : void
      {
         var _loc1_:Number = NaN;
         if(this.lmode == FOOTMODE_STOMP)
         {
            this.lfootyVel += 0.2;
            this.lfooty += this.lfootyVel;
            if(this.lfooty > 0)
            {
               this.lfooty = 0;
               this.lmode = FOOTMODE_WAITRAISE;
               if(this.mode == MODE_STEP)
               {
                  this.lmode = FOOTMODE_STEP;
               }
               this.lfootyVel = 0;
               this.lfootRaiseTimeout = 50;
               this.lfootStompTimeout = 1000000;
               Sfx.playStomp();
               FlxG.quake.start(0.03);
            }
         }
         else if(this.mode > MODE_INTRO3 && this.lmode == FOOTMODE_WAITRAISE && --this.lfootRaiseTimeout <= 0)
         {
            if(this.mode != MODE_STEP)
            {
               this.lmode = FOOTMODE_RAISE;
            }
            else
            {
               this.lmode = FOOTMODE_STEP;
            }
         }
         if(this.mode > MODE_INTRO3 && this.lmode == FOOTMODE_RAISE)
         {
            this.lfootyVel -= 0.2;
            this.lfooty += this.lfootyVel;
            if(this.lfooty < RAISED_Y)
            {
               this.lfooty = RAISED_Y;
               this.lmode = FOOTMODE_MOVE;
               this.leye.shouldAttack = true;
               this.lfootRaiseTimeout = 1000000;
               this.lfootStompTimeout = int(this.TIMEOUTS[++this.lfootStompTimeoutIndex % this.TIMEOUTS.length] * 360) + 60;
               if(this.mode == MODE_SYNC)
               {
                  this.lfootStompTimeout = 10;
               }
            }
         }
         if(this.rmode == FOOTMODE_STOMP)
         {
            this.rfootyVel += 0.2;
            this.rfooty += this.rfootyVel;
            if(this.rfooty > 0)
            {
               this.rfooty = 0;
               this.rmode = FOOTMODE_WAITRAISE;
               if(this.mode == MODE_STEP)
               {
                  this.rmode = FOOTMODE_STEP;
               }
               this.rfootyVel = 0;
               this.rfootRaiseTimeout = 50;
               this.rfootStompTimeout = 1000000;
               Sfx.playStomp();
               FlxG.quake.start(0.03);
            }
         }
         else if(this.mode > MODE_INTRO3 && this.rmode == FOOTMODE_WAITRAISE && --this.rfootRaiseTimeout <= 0)
         {
            if(this.mode != MODE_STEP)
            {
               this.rmode = FOOTMODE_RAISE;
            }
            else
            {
               this.rmode = FOOTMODE_STEP;
            }
         }
         if(this.mode > MODE_INTRO3 && this.rmode == FOOTMODE_RAISE)
         {
            this.rfootyVel -= 0.2;
            this.rfooty += this.rfootyVel;
            if(this.rfooty < RAISED_Y)
            {
               this.rfooty = RAISED_Y;
               this.rmode = FOOTMODE_MOVE;
               this.reye.shouldAttack = true;
               this.rfootRaiseTimeout = 1000000;
               this.rfootStompTimeout = int(this.TIMEOUTS[++this.lfootStompTimeoutIndex % this.TIMEOUTS.length] * 360) + 60;
               if(this.mode == MODE_SYNC)
               {
                  this.rfootStompTimeout = 10;
               }
            }
         }
         if(this.mode > MODE_INTRO3 && this.lmode == FOOTMODE_MOVE)
         {
            this.ltheta += 0.2;
            if(this.mode == MODE_HUNT)
            {
               this.lfootxtarget = PlayState.player.x - x;
            }
            else
            {
               this.lfootxtarget = Math.cos(this.ltheta / 8.7) * 160;
            }
            if(this.rfootx - this.lfootxtarget < MIN_DIST)
            {
               this.lfootxtarget = this.rfootx - MIN_DIST;
            }
            if(PlayState.player.x - x < -320)
            {
               this.lfootxtarget = PlayState.player.x - x + 100;
            }
            --this.lfootStompTimeout;
            this.lfootxvel = this.lfootxtarget - this.lfootx;
            this.lfootx += this.lfootxvel * 0.1;
            if(this.lfootStompTimeout <= 0 && this.lfooty <= RAISED_Y + 10 && this.lfootyVel < 1)
            {
               this.lmode = FOOTMODE_STOMP;
               this.lfootyVel = 10;
               this.leye.shouldAttack = false;
            }
         }
         if(this.mode > MODE_INTRO3 && this.rmode == FOOTMODE_MOVE)
         {
            this.rtheta += 0.2;
            if(this.mode == MODE_HUNT)
            {
               this.rfootxtarget = PlayState.player.x - x;
            }
            else
            {
               this.rfootxtarget = Math.cos(this.rtheta / 9.5 + Math.PI / 3) * 160;
            }
            if(this.rfootxtarget - this.lfootx < MIN_DIST)
            {
               this.rfootxtarget = this.lfootx + MIN_DIST;
            }
            if(PlayState.player.x - x > 302)
            {
               this.rfootxtarget = PlayState.player.x - x - 40;
            }
            this.rfootxvel = this.rfootxtarget - this.rfootx;
            this.rfootx += this.rfootxvel * 0.1;
            --this.rfootStompTimeout;
            if(this.rfootStompTimeout <= 0 && this.rfooty <= RAISED_Y + 10 && this.rfootyVel < 1)
            {
               this.rmode = FOOTMODE_STOMP;
               this.rfootyVel = 10;
               this.reye.shouldAttack = false;
            }
         }
         if(this.lmode == FOOTMODE_STEP && this.rmode == FOOTMODE_STEP)
         {
            if(this.lfootx < x)
            {
               this.stepDirIsLeft = true;
               this.lmode = FOOTMODE_STEPNOW;
               this.rmode = FOOTMODE_STEPWAIT;
               this.lsteptheta = 0;
               this.rsteptheta = 0;
               this.lsteporiginx = NO_ORIGIN;
               this.lsteporiginy = this.lfooty;
            }
            else
            {
               this.stepDirIsLeft = false;
               this.rmode = FOOTMODE_STEPNOW;
               this.lmode = FOOTMODE_STEPWAIT;
               this.lsteptheta = 0;
               this.rsteptheta = 0;
               this.rsteporiginx = NO_ORIGIN;
               this.rsteporiginy = this.rfooty;
            }
         }
         if(this.lmode == FOOTMODE_STEPNOW)
         {
            if(this.stepDirIsLeft && this.lsteptheta == 0 && this.lfootx < -170)
            {
               this.stepDirIsLeft = false;
               this.lmode = FOOTMODE_STEPWAIT;
               this.rmode = FOOTMODE_STEPNOW;
               this.rsteptheta = 0;
               this.rsteporiginx = NO_ORIGIN;
               this.rsteporiginy = this.rfooty;
            }
            else
            {
               this.lsteptheta += 0.05;
               if(this.lsteptheta >= Math.PI)
               {
                  this.lsteptheta = Math.PI;
                  Sfx.playStomp();
                  FlxG.quake.start();
                  this.lmode = FOOTMODE_STEPWAIT;
                  this.rmode = FOOTMODE_STEPNOW;
                  this.rsteptheta = 0;
                  this.rsteporiginx = NO_ORIGIN;
                  this.rsteporiginy = this.rfooty;
               }
               if(this.stepDirIsLeft)
               {
                  if(this.lsteporiginx == NO_ORIGIN)
                  {
                     this.lsteporiginx = this.lfootx - this.stepradius;
                  }
                  this.lfootx = this.lsteporiginx + Math.cos(this.lsteptheta) * this.stepradius;
                  this.lfooty = this.lsteporiginy - Math.sin(this.lsteptheta) * this.stepradius * 3.4;
               }
               else
               {
                  if(this.lsteporiginx == NO_ORIGIN)
                  {
                     this.lsteporiginx = this.lfootx + this.stepradius;
                  }
                  this.lfootx = this.lsteporiginx - Math.cos(this.lsteptheta) * this.stepradius;
                  this.lfooty = this.lsteporiginy - Math.sin(this.lsteptheta) * this.stepradius * 3.4;
               }
            }
         }
         else if(this.rmode == FOOTMODE_STEPNOW)
         {
            if(!this.stepDirIsLeft && this.rsteptheta == 0 && this.rfootx > 170)
            {
               this.stepDirIsLeft = true;
               this.rmode = FOOTMODE_STEPWAIT;
               this.lmode = FOOTMODE_STEPNOW;
               this.lsteptheta = 0;
               this.lsteporiginx = NO_ORIGIN;
               this.lsteporiginy = this.lfooty;
            }
            else
            {
               this.rsteptheta += 0.05;
               if(this.rsteptheta >= Math.PI)
               {
                  this.rsteptheta = Math.PI;
                  Sfx.playStomp();
                  FlxG.quake.start();
                  this.lmode = FOOTMODE_STEPNOW;
                  this.rmode = FOOTMODE_STEPWAIT;
                  this.lsteporiginx = NO_ORIGIN;
                  this.lsteporiginy = this.lfooty;
                  this.lsteptheta = 0;
               }
               if(this.stepDirIsLeft)
               {
                  if(this.rsteporiginx == NO_ORIGIN)
                  {
                     this.rsteporiginx = this.rfootx - this.stepradius;
                  }
                  this.rfootx = this.rsteporiginx + Math.cos(this.rsteptheta) * this.stepradius;
                  this.rfooty = this.rsteporiginy - Math.sin(this.rsteptheta) * this.stepradius * 3.4;
               }
               else
               {
                  if(this.rsteporiginx == NO_ORIGIN)
                  {
                     this.rsteporiginx = this.rfootx + this.stepradius;
                  }
                  this.rfootx = this.rsteporiginx - Math.cos(this.rsteptheta) * this.stepradius;
                  this.rfooty = this.rsteporiginy - Math.sin(this.rsteptheta) * this.stepradius * 3.4;
               }
            }
         }
         if(this.rfootx - this.lfootx < MIN_DIST)
         {
            _loc1_ = MIN_DIST - (this.rfootx - this.lfootx);
            if(this.lmode == FOOTMODE_MOVE && this.rmode == FOOTMODE_STOMP)
            {
               this.lfootx -= _loc1_;
            }
            else if(this.rmode == FOOTMODE_MOVE && this.lmode == FOOTMODE_STOMP)
            {
               this.rfootx += _loc1_;
            }
            else
            {
               this.lfootx -= _loc1_ / 2;
               this.rfootx += _loc1_ / 2;
            }
         }
         this.lfoot.x = x + LFOOT_OFS_X + this.lfootx;
         this.lfoot.y = y + this.lfooty;
         this.rfoot.x = x + RFOOT_OFS_X + this.rfootx;
         this.rfoot.y = y + this.rfooty;
         if(this.eyesOnFeet)
         {
            this.leye.x = this.lfoot.x + LEYE_OFS_X;
            this.leye.y = this.lfoot.y + LEYE_OFS_Y;
            this.reye.x = this.rfoot.x + REYE_OFS_X;
            this.reye.y = this.rfoot.y + REYE_OFS_Y;
         }
         if(this.leye.y <= this.mineyey)
         {
            this.leye.y = this.mineyey;
            this.leye.solid = false;
         }
         else
         {
            this.leye.solid = true;
         }
         if(this.reye.y <= this.mineyey)
         {
            this.reye.y = this.mineyey;
            this.reye.solid = false;
         }
         else
         {
            this.reye.solid = true;
         }
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this._elapsed += FlxG.elapsed * this._bossSpeed;
         while(this._elapsed > SEC_PER_TICK)
         {
            this._elapsed -= SEC_PER_TICK;
            this.moveChildren();
         }
         if(_delayIntro)
         {
            switch(this.mode)
            {
               case MODE_INTRO1:
                  if(PlayState.player.x < x - 89)
                  {
                     this.lmode = FOOTMODE_STOMP;
                  }
                  if(PlayState.player.x < x - 109)
                  {
                     PlayState.player.velocity.x = PlayState.player._runSpeed.value;
                     PlayState.player.setFaceDir(Player.FACE_FLOOR_RIGHT,true);
                     this.mode = MODE_INTRO2;
                  }
                  else
                  {
                     PlayState.player.velocity.x = -PlayState.player._runSpeed.value;
                  }
                  break;
               case MODE_INTRO2:
                  if(PlayState.player.x > x - 46)
                  {
                     this.rmode = FOOTMODE_STOMP;
                  }
                  if(PlayState.player.x > x - 38)
                  {
                     PlayState.player.setFaceDir(Player.FACE_FLOOR_LEFT,true);
                     PlayState.player.velocity.x = 0;
                     this.mode = MODE_INTRO3;
                     _delayIntro = false;
                     resetStartTime();
                     PlayState.hud.bossBarHud.makeBar(_hp);
                     PlayState.showBossRushName(2);
                  }
                  else
                  {
                     PlayState.player.velocity.x = PlayState.player._runSpeed.value;
                  }
            }
         }
         else
         {
            switch(this.mode)
            {
               case MODE_INTRO3:
                  if(_introDone)
                  {
                     this.mode = MODE_MOVESTOMP;
                     this.stepModeTimeout = this.STEP_MODE_TIMEOUT;
                  }
                  break;
               case MODE_MOVESTOMP:
                  this.stepModeTimeout -= FlxG.elapsed * this._bossSpeed;
                  if(this.stepModeTimeout < 0)
                  {
                     this.mode = MODE_HUNT;
                  }
                  break;
               case MODE_HUNT:
                  if(this.rfootx - this.lfootx <= MIN_DIST + 2)
                  {
                     this.stepModeTimeout = this.SYNC_MODE_TIMEOUT;
                     this.mode = MODE_SYNC;
                  }
                  break;
               case MODE_SYNC:
                  if(this.lmode == FOOTMODE_MOVE && this.rmode == FOOTMODE_MOVE)
                  {
                     this.lmode = FOOTMODE_STOMP;
                     this.rmode = FOOTMODE_STOMP;
                  }
                  this.stepModeTimeout -= FlxG.elapsed * this._bossSpeed;
                  if(this.stepModeTimeout < 0)
                  {
                     this.stepModeTimeout = this.STEP_MODE_TIMEOUT;
                     this.mode = MODE_STEP;
                  }
                  break;
               case MODE_STEP:
                  if(this.lmode == FOOTMODE_MOVE)
                  {
                     this.lmode = FOOTMODE_STOMP;
                  }
                  if(this.rmode == FOOTMODE_MOVE)
                  {
                     this.rmode = FOOTMODE_STOMP;
                  }
                  this.stepModeTimeout -= FlxG.elapsed * this._bossSpeed;
                  if(this.stepModeTimeout < 0)
                  {
                     this.stepModeTimeout = this.STEP_MODE_TIMEOUT;
                     this.mode = MODE_MOVESTOMP;
                     this.lmode = FOOTMODE_RAISE;
                     this.rmode = FOOTMODE_RAISE;
                     this.lfootRaiseTimeout = 0;
                     this.rfootRaiseTimeout = 0;
                     this.lfootStompTimeout = 50;
                     this.rfootStompTimeout = 50;
                  }
            }
         }
         this._totalElapsed += FlxG.elapsed * this._bossSpeed;
         if(!this._createdChildren)
         {
            this._createdChildren = true;
         }
         this.attack(this._totalElapsed);
         super.update();
         if(_justFlashed <= 0)
         {
            this.leye.eyelid.unFlashColor();
            this.reye.eyelid.unFlashColor();
         }
      }
      
      public function shoot(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = -Math.cos(param1) * param2;
         var _loc4_:Number = -Math.sin(param1) * param2;
         var _loc5_:EnemyBullet = PlayState.enemyBulletPool.getBullet(1);
         if(_loc5_)
         {
            _loc5_.shoot(x + width / 2,y + height / 2,_loc3_,_loc4_);
         }
      }
      
      public function attack(param1:Number) : void
      {
         if(!_introDone)
         {
            return;
         }
      }
      
      override public function kill() : void
      {
         if(this.beingKilled)
         {
            return;
         }
         this.beingKilled = true;
         super.kill();
         PlayState.boss2rush = null;
         if(_hp <= 0 && !PlayState.player.dead)
         {
            PlayState.setBossDead(2);
            PlayState.showBossRushName(2,true);
            this.cannons[0].kill();
            this.cannons[1].kill();
            this.cannons[2].kill();
            this.cannons[3].kill();
            this.cannons[4].kill();
            this.cannons[5].kill();
            this.cannons[6].kill();
            this.cannons[7].kill();
            PlayState.sprites.add(new QueuedExplosion(this.lfoot.x + this.lfoot.width / 2,this.lfoot.y + this.lfoot.height / 2));
            PlayState.sprites.add(new QueuedExplosion(this.rfoot.x + this.rfoot.width / 2,this.rfoot.y + this.rfoot.height / 2));
         }
         this.leye.kill();
         this.reye.kill();
         this.lfoot.kill();
         this.rfoot.kill();
         PlayState.enemyBulletPool.destroyAll();
         dead = true;
         exists = false;
         active = false;
         visible = false;
      }
      
      override public function hurt(param1:Number) : void
      {
         if(_hp <= this.MAX_HP * 0.2 && this._attackMode < 2)
         {
            this._bossSpeed = 1.4;
            this._attackMode = 2;
            this.leye.setMode(this._attackMode);
            this.reye.setMode(this._attackMode);
            this.lfoot.play("hurt");
            this.rfoot.play("hurt");
         }
         else if(_hp <= this.MAX_HP * 0.66 && this._attackMode < 1)
         {
            this._bossSpeed = 1.3;
            this._attackMode = 1;
            this.leye.setMode(this._attackMode);
            this.reye.setMode(this._attackMode);
         }
         super.hurt(param1);
      }
   }
}

