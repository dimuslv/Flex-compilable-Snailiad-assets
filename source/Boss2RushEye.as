package
{
   import org.flixel.*;
   
   public class Boss2RushEye extends Enemy
   {
      private static const IMG_WIDTH:int = 100;
      
      private static const IMG_HEIGHT:int = 52;
      
      private static const MAX_HP:int = 50000;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      private static const CLUSTER_TIMEOUT:Number = 4.6;
      
      private static const SHOT_TIMEOUT:Number = 0.3;
      
      private static const SHOT_NUM:Number = 2;
      
      public var eyelid:Boss2RushEyelid;
      
      public var pupil:Boss2RushPupil;
      
      private var isOpen:Boolean;
      
      private var mode:int;
      
      private var _blinkTimeout:Number = 4;
      
      private var _openTimeout:Number = 0;
      
      private var _closeTimeout:Number = 0;
      
      private var _addedChildren:Boolean = false;
      
      private var _willClose:Boolean = false;
      
      private var _lastFlashed:int = 0;
      
      private var _isLeft:Boolean = false;
      
      private var _clusterTimeout:Number = 0;
      
      private var _shotTimeout:Number = 0;
      
      private var _shots:Number = 0;
      
      private var _shooting:Boolean = false;
      
      public var shouldAttack:Boolean = false;
      
      override public function destroy() : void
      {
         eyelid = null;
         pupil = null;
         super.destroy();
      }
      
      public function Boss2RushEye(param1:int, param2:int, param3:Boolean) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Boss2Eye,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         _isLeft = param3;
         _addedChildren = false;
         addAnimation("normal",[0]);
         play("normal");
         isOpen = true;
         _clusterTimeout = CLUSTER_TIMEOUT;
         _shotTimeout = SHOT_TIMEOUT;
         _shooting = false;
      }
      
      public function setMode(param1:int) : void
      {
         mode = param1;
         if(isOpen)
         {
            eyelid.playOpen(mode);
         }
         else
         {
            eyelid.playClose(mode);
         }
      }
      
      public function shoot(param1:int, param2:int, param3:Number) : void
      {
         var _loc4_:Number = 90;
         var _loc5_:Number = -Math.cos(param3) * _loc4_;
         var _loc6_:Number = -Math.sin(param3) * _loc4_;
         var _loc7_:EnemyBullet = PlayState.enemyBulletPool.getBullet(4);
         if(_loc7_)
         {
            _loc7_.shoot(param1 + pupil.width / 2,param2 + pupil.height / 2,_loc5_,_loc6_);
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
         if(!_addedChildren)
         {
            pupil = new Boss2RushPupil(x,y);
            PlayState.enemies.add(pupil);
            eyelid = new Boss2RushEyelid(x,y);
            PlayState.enemies.add(eyelid);
            _addedChildren = true;
         }
         var _loc1_:Number = Math.atan2(PlayState.player.y - (y - 20),PlayState.player.x - x);
         pupil.x = x + Math.cos(_loc1_) * 20;
         pupil.y = y + Math.sin(_loc1_) * 10;
         if(shouldAttack)
         {
            _clusterTimeout -= FlxG.elapsed;
            if(_clusterTimeout < 0)
            {
               _clusterTimeout = CLUSTER_TIMEOUT;
               _shotTimeout = SHOT_TIMEOUT;
               _shots = SHOT_NUM;
               _shooting = true;
            }
            if(_shooting)
            {
               _shotTimeout -= FlxG.elapsed;
               if(_shotTimeout < 0)
               {
                  _shotTimeout = SHOT_TIMEOUT;
                  --_shots;
                  if(_shots == 0)
                  {
                     _shooting = false;
                  }
                  if(_isLeft)
                  {
                     var _loc2_:Number = -Math.PI / SHOT_NUM * _shots;
                  }
                  else
                  {
                     _loc2_ = -Math.PI / SHOT_NUM * (SHOT_NUM - _shots);
                  }
                  shoot(pupil.x,pupil.y,_loc2_);
               }
            }
         }
         eyelid.x = x;
         eyelid.y = y;
         if(isOpen)
         {
            _blinkTimeout -= FlxG.elapsed;
            if(_blinkTimeout < 0)
            {
               _blinkTimeout = FlxU.random() * 8 + 1;
               eyelid.playBlink(mode);
            }
            if(_willClose)
            {
               _closeTimeout -= FlxG.elapsed;
               if(_closeTimeout < 0)
               {
                  _willClose = false;
                  isOpen = false;
                  eyelid.playClose(mode);
                  _openTimeout = 0.8;
               }
            }
         }
         else
         {
            _openTimeout -= FlxG.elapsed;
            if(_openTimeout < 0)
            {
               isOpen = true;
               eyelid.playOpen(mode);
            }
         }
         if(--_justFlashed <= 0)
         {
            eyelid.unFlashColor();
            pupil.unFlashColor();
            if(_isLeft)
            {
               (PlayState.boss2rush as Boss2Rush).lfoot.unFlashColor();
            }
            else
            {
               (PlayState.boss2rush as Boss2Rush).rfoot.unFlashColor();
            }
         }
         super.update();
      }
      
      override public function kill() : void
      {
         pupil.kill();
         eyelid.kill();
         super.kill();
      }
      
      override public function hurt(param1:Number) : void
      {
         if(!isOpen)
         {
            param1 -= 190;
         }
         else
         {
            if(!_willClose)
            {
               _willClose = true;
               _closeTimeout = 0.3;
            }
            if(--_lastFlashed <= 0 && param1 > Boss2Rush.DEFENSE)
            {
               eyelid.flashColor(16777215);
               pupil.flashColor(16777215);
               if(_isLeft)
               {
                  (PlayState.boss2rush as Boss2Rush).lfoot.flashColor(16777215);
               }
               else
               {
                  (PlayState.boss2rush as Boss2Rush).rfoot.flashColor(16777215);
               }
               _justFlashed = 1;
               _lastFlashed = 3;
            }
         }
         if(PlayState.boss2rush && param1 > 0)
         {
            PlayState.boss2rush.hurt(param1);
         }
      }
   }
}

