package
{
   import org.flixel.*;
   
   public class Boss1Rush extends Boss
   {
      private static const IMGBODY_WIDTH:int = 48;
      
      private static const IMGBODY_HEIGHT:int = 48;
      
      private static const DEFENSE:int = 3;
      
      private static const OFFENSE:int = 2;
      
      private static const PATTERN_DELAY:Number = 5;
      
      private static const WEAPON_SPEED:Number = 330;
      
      private var MAX_HP:int = 10000;
      
      private var started:Boolean = false;
      
      private var _hand:Array;
      
      private var _eyes:Enemy;
      
      private var _handThetaCur:Array;
      
      private var _handThetaSpeed:Array;
      
      private var _handRadius:Number;
      
      private var _targetX:int;
      
      private var _targetY:int;
      
      private var HAND_NUM:int = 12;
      
      private var SHOT_NUM:int = 12;
      
      private var _shotNum:int = 0;
      
      private var _shotMax:int = 8;
      
      private var _shotTimeout:Number = 0;
      
      private var SHOT_DELAY:Number = 0.3;
      
      private var _firingPattern:int = 0;
      
      private var _firingPatternTimeout:Number = 0;
      
      private var _turboMultiplier:Number = 1;
      
      private var _originX:int = 0;
      
      private var _originY:int = 0;
      
      private var _radiusMultTarget:Number = 1;
      
      private var _radiusMultCur:Number = 1;
      
      private var _attackMode:int = 0;
      
      private var _createdChildren:Boolean = false;
      
      private var _totalElapsed:Number = 0;
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in _hand)
         {
            _hand[_loc1_] = null;
         }
         _hand = null;
         _eyes = null;
         _handThetaCur = null;
         _handThetaSpeed = null;
         super.destroy();
      }
      
      public function Boss1Rush(param1:int, param2:int) : void
      {
         if(PlayState.player && PlayState.player._hardMode)
         {
            HAND_NUM += 24;
         }
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.Boss1Rush,true,true,IMGBODY_WIDTH,IMGBODY_HEIGHT);
         width = IMGBODY_WIDTH;
         height = IMGBODY_HEIGHT;
         _turboMultiplier = 0.6;
         _originX = param1;
         _originY = param2;
         _radiusMultTarget = 1;
         _radiusMultCur = 1;
         _attackMode = 0;
         addAnimation("normal0",[0]);
         addAnimation("shoot0",[1]);
         addAnimation("normal1",[2]);
         addAnimation("shoot1",[3]);
         addAnimation("normal2",[4]);
         addAnimation("shoot2",[5]);
         play("normal0");
         _hand = new Array();
         _handThetaCur = new Array();
         _handThetaSpeed = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < HAND_NUM)
         {
            _handThetaCur[_loc3_] = 2 * Math.PI / HAND_NUM;
            _handThetaSpeed[_loc3_] = 2.5 + _loc3_ * 0.75;
            _hand[_loc3_] = new Boss1RushHand(x,y);
            PlayState.enemies.add(_hand[_loc3_]);
            _loc3_++;
         }
         PlayState.player.x += 28;
         PlayState.player.setFaceDir(Player.FACE_FLOOR_RIGHT);
      }
      
      public function now() : Number
      {
         return _totalElapsed * 1.15;
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
         _totalElapsed += FlxG.elapsed;
         if(!_createdChildren)
         {
            _eyes = new Boss1Eyes(x,y);
            PlayState.enemies.add(_eyes);
            _createdChildren = true;
         }
         var _loc1_:Number = now();
         var _loc2_:Number = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
         var _loc3_:Number;
		 _loc3_ = _loc1_;
         var _loc4_:Number = Math.sin(3 / 7 * _loc3_);
         x = _originX + 9 * 16 * Math.cos(_loc3_) * _loc4_;
         y = _originY + 7 * 16 * Math.sin(_loc3_) * _loc4_;
         _eyes.x = x - Math.cos(_loc2_) * 2 + 0.5;
         _eyes.y = y - Math.sin(_loc2_) * 2.5;
         fire(_loc1_);
         _handRadius = 40 + 90 * Math.sin(Math.sin(_loc1_ * 5 / 3));
         if(_handRadius < 50)
         {
            _handRadius = 50;
         }
         _handRadius *= _radiusMultCur;
         _radiusMultCur = _radiusMultCur * 0.9 + _radiusMultTarget * 0.1;
         var _loc5_:int = 0;
         while(_loc5_ < HAND_NUM)
         {
            _handThetaCur[_loc5_] += _handThetaSpeed[_loc5_] * FlxG.elapsed * (1 + Math.sin(_loc1_ * 5 / 4)) * 1.2;
            _hand[_loc5_].x = x - 12 + 24 - Math.sin(_handThetaCur[_loc5_]) * _handRadius;
            _hand[_loc5_].y = y - 12 + 24 + Math.cos(_handThetaCur[_loc5_]) * _handRadius;
            if(_radiusMultTarget == 0)
            {
               _hand[_loc5_].solid = false;
            }
            else
            {
               _hand[_loc5_].solid = true;
            }
            _loc5_++;
         }
         super.update();
         if(_introDone && !PlayState.player.dead && !started)
         {
            started = true;
            PlayState.bossRushTimer.going = true;
            PlayState.bossRushTimer.started = true;
         }
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc2_:Number = WEAPON_SPEED;
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
         if(param1 > _firingPatternTimeout)
         {
            play("shoot" + _attackMode.toString());
            _radiusMultTarget = 0.0;
            if(param1 > _shotTimeout)
            {
               _shotTimeout = param1 + SHOT_DELAY * _turboMultiplier;
               ++_shotNum;
               switch(_firingPattern)
               {
                  case 0:
                     shoot(_loc2_);
                     break;
                  case 1:
                     shoot(_loc2_ + (Math.PI / _shotMax - Math.PI / 2) * _shotNum / 8);
                     break;
                  case 2:
                     shoot(_loc2_ + Math.PI);
                     break;
                  case 3:
                     shoot(_loc2_ - (Math.PI / _shotMax - Math.PI / 2) * _shotNum / 8);
					 break;
               }
               if(_shotNum >= _shotMax)
               {
                  _firingPattern = (_firingPattern + 1) % 4;
                  _firingPatternTimeout = param1 + PATTERN_DELAY;
                  _radiusMultTarget = 1;
                  _shotNum = 0;
                  play("normal" + _attackMode.toString());
               }
            }
         }
      }
      
      override public function kill() : void
      {
         super.kill();
         if(_hp <= 0 && !PlayState.player.dead)
         {
            PlayState.setBossDead(1);
            PlayState.showBossRushName(1,true);
            PlayState.sprites.add(new QueuedExplosion(x,y));
         }
         _eyes.kill();
         var _loc1_:int = 0;
         while(_loc1_ < HAND_NUM)
         {
            _hand[_loc1_].kill();
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
         if(_hp <= MAX_HP * 0.33 && _attackMode < 2)
         {
            _shotMax += 27;
            _turboMultiplier = 0.19;
            _attackMode = 2;
            play("normal2");
         }
         else if(_hp <= MAX_HP * 0.66 && _attackMode < 1)
         {
            _shotMax += 9;
            _turboMultiplier = 0.28;
            _attackMode = 1;
            play("normal1");
         }
         super.hurt(param1);
      }
   }
}

