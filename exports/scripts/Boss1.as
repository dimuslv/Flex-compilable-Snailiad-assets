package
{
   import org.flixel.*;
   
   public class Boss1 extends Boss
   {
      private static const IMGBODY_WIDTH:int = 48;
      
      private static const IMGBODY_HEIGHT:int = 48;
      
      private static const DEFENSE:int = 3;
      
      private static const OFFENSE:int = 2;
      
      private var MAX_HP:int = 450;
      
      private var _hand:Array;
      
      private var _eyes:Enemy;
      
      private var _handThetaCur:Array;
      
      private var _handThetaSpeed:Array;
      
      private var _handRadius:Number;
      
      private var _targetX:int;
      
      private var _targetY:int;
      
      private var HAND_NUM:int = 3;
      
      private var SHOT_NUM:int = 5;
      
      private var _shotNum:int = 0;
      
      private var _shotMax:int = 5;
      
      private var _shotTimeout:Number = 0;
      
      private var SHOT_DELAY:Number = 0.8;
      
      private var _firingPattern:int = 0;
      
      private var _firingPatternTimeout:Number = 0;
      
      private var PATTERN_DELAY:Number = 3;
      
      private var WEAPON_SPEED:Number = 270;
      
      private var _turboMultiplier:Number = 1;
      
      private var _originX:int = 0;
      
      private var _originY:int = 0;
      
      private var _radiusMultTarget:Number = 1;
      
      private var _radiusMultCur:Number = 1;
      
      private var _attackMode:int = 0;
      
      private var _createdChildren:Boolean = false;
      
      private var _totalElapsed:Number = 0;
      
      public function Boss1(param1:int, param2:int)
      {
         if(Boolean(PlayState.player) && PlayState.player._insaneMode)
         {
            this.HAND_NUM *= 4;
            this.SHOT_NUM *= 3;
            this.SHOT_DELAY /= 3;
            this._shotMax = 6;
            this.PATTERN_DELAY = 4;
            this.WEAPON_SPEED = 290;
         }
         else if(Boolean(PlayState.player) && PlayState.player._hardMode)
         {
            this.HAND_NUM *= 2;
            this.SHOT_NUM *= 2;
            this._shotMax = 10;
            this.MAX_HP *= 0.66;
         }
         else
         {
            this.MAX_HP *= 0.88;
         }
         super(param1,param2,this.MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.Boss1,true,true,IMGBODY_WIDTH,IMGBODY_HEIGHT);
         width = IMGBODY_WIDTH;
         height = IMGBODY_HEIGHT;
         this._turboMultiplier = 0.6;
         this._originX = param1;
         this._originY = param2;
         this._radiusMultTarget = 1;
         this._radiusMultCur = 1;
         this._attackMode = 0;
         addAnimation("normal0",[0]);
         addAnimation("shoot0",[1]);
         addAnimation("normal1",[2]);
         addAnimation("shoot1",[3]);
         addAnimation("normal2",[4]);
         addAnimation("shoot2",[5]);
         play("normal0");
         this._hand = new Array();
         this._handThetaCur = new Array();
         this._handThetaSpeed = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.HAND_NUM)
         {
            this._handThetaCur[_loc3_] = 2 * Math.PI / this.HAND_NUM;
            this._handThetaSpeed[_loc3_] = 2.5 + _loc3_ * 0.75;
            this._hand[_loc3_] = new Boss1Hand(x,y);
            PlayState.enemies.add(this._hand[_loc3_]);
            _loc3_++;
         }
         if(!dead)
         {
            PlayState.player.x += 35;
            PlayState.player.setFaceDir(Player.FACE_FLOOR_RIGHT);
            Music.playBoss1();
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this._hand)
         {
            this._hand[_loc1_] = null;
         }
         this._hand = null;
         this._eyes = null;
         this._handThetaCur = null;
         this._handThetaSpeed = null;
         super.destroy();
      }
      
      public function now() : Number
      {
         return this._totalElapsed;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(Boolean(PlayState.player) && PlayState.player._hardMode)
         {
            this._totalElapsed += FlxG.elapsed * 1.2;
         }
         else
         {
            this._totalElapsed += FlxG.elapsed;
         }
         if(!this._createdChildren)
         {
            this._eyes = new Boss1Eyes(x,y);
            PlayState.enemies.add(this._eyes);
            this._createdChildren = true;
         }
         _loc1_ = this.now();
         _loc2_ = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
         _loc3_ = _loc1_;
         var _loc4_:Number = Math.sin(3 / 7 * _loc3_);
         x = this._originX + 9 * 16 * Math.cos(_loc3_) * _loc4_;
         y = this._originY + 7 * 16 * Math.sin(_loc3_) * _loc4_;
         this._eyes.x = x - Math.cos(_loc2_) * 2 + 0.5;
         this._eyes.y = y - Math.sin(_loc2_) * 2.5;
         this.fire(_loc1_);
         this._handRadius = 40 + 90 * Math.sin(Math.sin(_loc1_ * 5 / 3));
         if(this._handRadius < 50)
         {
            this._handRadius = 50;
         }
         this._handRadius *= this._radiusMultCur;
         this._radiusMultCur = this._radiusMultCur * 0.9 + this._radiusMultTarget * 0.1;
         var _loc5_:int = 0;
         while(_loc5_ < this.HAND_NUM)
         {
            this._handThetaCur[_loc5_] += this._handThetaSpeed[_loc5_] * FlxG.elapsed * (1 + Math.sin(_loc1_ * 5 / 4)) * 1.2;
            this._hand[_loc5_].x = x - 12 + 24 - Math.sin(this._handThetaCur[_loc5_]) * this._handRadius;
            this._hand[_loc5_].y = y - 12 + 24 + Math.cos(this._handThetaCur[_loc5_]) * this._handRadius;
            if(this._radiusMultTarget == 0)
            {
               this._hand[_loc5_].solid = false;
            }
            else
            {
               this._hand[_loc5_].solid = true;
            }
            _loc5_++;
         }
         super.update();
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc2_:Number = this.WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         var _loc5_:EnemyBullet = PlayState.enemyBulletPool.getBullet(0);
         if(_loc5_)
         {
            _loc5_.shoot(x + width / 2,y + height / 2,_loc3_,_loc4_);
         }
      }
      
      public function fire(param1:Number) : void
      {
         if(!_introDone)
         {
            return;
         }
         var _loc2_:Number = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
         if(param1 > this._firingPatternTimeout)
         {
            play("shoot" + this._attackMode.toString());
            this._radiusMultTarget = 0;
            if(param1 > this._shotTimeout)
            {
               this._shotTimeout = param1 + this.SHOT_DELAY * this._turboMultiplier;
               ++this._shotNum;
               switch(this._firingPattern)
               {
                  case 0:
                     this.shoot(_loc2_);
                     break;
                  case 1:
                     this.shoot(_loc2_ + (Math.PI / this._shotMax - Math.PI / 2) * this._shotNum / 12);
                     break;
                  case 2:
                     this.shoot(_loc2_ + Math.PI);
                     break;
                  case 3:
                     this.shoot(_loc2_ - (Math.PI / this._shotMax - Math.PI / 2) * this._shotNum / 12);
               }
               if(this._shotNum >= this._shotMax)
               {
                  this._firingPattern = (this._firingPattern + 1) % 4;
                  this._firingPatternTimeout = param1 + this.PATTERN_DELAY;
                  this._radiusMultTarget = 1;
                  this._shotNum = 0;
                  play("normal" + this._attackMode.toString());
               }
            }
         }
      }
      
      override public function kill() : void
      {
         super.kill();
         if(_hp <= 0 && !PlayState.player.dead)
         {
            NgMedal.unlockFirstOfFour();
            PlayState.setBossDead(1);
            PlayState.showBossName(1,true);
            PlayState.sprites.add(new QueuedExplosion(x,y));
            PlayState.player.saveGame();
         }
         PlayState.miniMap.setMapLittle();
         Music.playArea1();
         this._eyes.kill();
         var _loc1_:int = 0;
         while(_loc1_ < this.HAND_NUM)
         {
            this._hand[_loc1_].kill();
            _loc1_++;
         }
         PlayState.enemyBulletPool.destroyAll();
         dead = true;
         exists = false;
         active = false;
         visible = false;
      }
      
      override public function hurt(param1:Number) : void
      {
         if(_hp <= this.MAX_HP * 0.33 && this._attackMode < 2)
         {
            this._shotMax += 27;
            this._turboMultiplier = 0.1;
            this._attackMode = 2;
            play("normal2");
         }
         else if(_hp <= this.MAX_HP * 0.66 && this._attackMode < 1)
         {
            this._shotMax += 9;
            this._turboMultiplier = 0.28;
            this._attackMode = 1;
            play("normal1");
         }
         super.hurt(param1);
      }
   }
}

