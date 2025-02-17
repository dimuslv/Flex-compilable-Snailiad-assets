package
{
   import org.flixel.*;
   
   public class Boss2Eye extends Enemy
   {
      private static const IMG_WIDTH:int = 100;
      
      private static const IMG_HEIGHT:int = 52;
      
      private static const MAX_HP:int = 50000;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
      
      private static const CLUSTER_TIMEOUT:Number = 7.2;
      
      public var eyelid:Boss2Eyelid;
      
      public var pupil:Boss2Pupil;
      
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
      
      private var SHOT_TIMEOUT:Number = 0.6;
      
      private var SHOT_NUM:Number = 2;
      
      public function Boss2Eye(param1:int, param2:int, param3:Boolean) : void
      {
         if(PlayState.player && PlayState.player._insaneMode)
         {
            this.SHOT_TIMEOUT /= 2;
            this.SHOT_NUM *= 2;
         }
         else if(PlayState.player && PlayState.player._hardMode)
         {
            this.SHOT_TIMEOUT /= 3;
            this.SHOT_NUM *= 3;
         }
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Boss2Eye,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         this._isLeft = param3;
         this._addedChildren = false;
         addAnimation("normal",[0]);
         play("normal");
         this.isOpen = true;
         this._clusterTimeout = CLUSTER_TIMEOUT;
         this._shotTimeout = this.SHOT_TIMEOUT;
         this._shooting = false;
      }
      
      override public function destroy() : void
      {
         eyelid = null;
         pupil = null;
         super.destroy();
      }
      
      public function setMode(param1:int) : void
      {
         mode = param1;
         if(this.isOpen)
         {
            this.eyelid.playOpen(this.mode);
         }
         else
         {
            this.eyelid.playClose(this.mode);
         }
      }
      
      public function shoot(param1:int, param2:int, param3:Number) : void
      {
         var _loc4_:Number = 40;
         var _loc5_:Number = -Math.cos(param3) * _loc4_;
         var _loc6_:Number = -Math.sin(param3) * _loc4_;
         var _loc7_:EnemyBullet = PlayState.enemyBulletPool.getBullet(4);
         if(_loc7_)
         {
            _loc7_.shoot(param1 + this.pupil.width / 2,param2 + this.pupil.height / 2,_loc5_,_loc6_);
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
         if(!this._addedChildren)
         {
            pupil = new Boss2Pupil(x,y);
            PlayState.enemies.add(this.pupil);
            eyelid = new Boss2Eyelid(x,y);
            PlayState.enemies.add(this.eyelid);
            _addedChildren = true;
         }
         var _loc1_:Number = Math.atan2(PlayState.player.y - (y - 20),PlayState.player.x - x);
         this.pupil.x = x + Math.cos(_loc1_) * 20;
         this.pupil.y = y + Math.sin(_loc1_) * 10;
         if(this.shouldAttack)
         {
            _clusterTimeout -= FlxG.elapsed;
            if(this._clusterTimeout < 0)
            {
               _clusterTimeout = CLUSTER_TIMEOUT;
               _shotTimeout = this.SHOT_TIMEOUT;
               _shots = this.SHOT_NUM;
               _shooting = true;
            }
            if(this._shooting)
            {
               _shotTimeout -= FlxG.elapsed;
               if(this._shotTimeout < 0)
               {
                  _shotTimeout = this.SHOT_TIMEOUT;
                  --this._shots;
                  if(this._shots == 0)
                  {
                     _shooting = false;
                  }
                  if(this._isLeft)
                  {
                     var _loc2_:Number = -Math.PI / this.SHOT_NUM * this._shots;
                  }
                  else
                  {
                     _loc2_ = -Math.PI / this.SHOT_NUM * (this.SHOT_NUM - this._shots);
                  }
                  this.shoot(this.pupil.x,this.pupil.y,_loc2_);
               }
            }
         }
         this.eyelid.x = x;
         this.eyelid.y = y;
         if(this.isOpen)
         {
            _blinkTimeout -= FlxG.elapsed;
            if(this._blinkTimeout < 0)
            {
               _blinkTimeout = FlxU.random() * 8 + 1;
               this.eyelid.playBlink(this.mode);
            }
            if(this._willClose)
            {
               _closeTimeout -= FlxG.elapsed;
               if(this._closeTimeout < 0)
               {
                  _willClose = false;
                  isOpen = false;
                  this.eyelid.playClose(this.mode);
                  _openTimeout = 0.8;
               }
            }
         }
         else
         {
            _openTimeout -= FlxG.elapsed;
            if(this._openTimeout < 0)
            {
               isOpen = true;
               this.eyelid.playOpen(this.mode);
            }
         }
         if(--_justFlashed <= 0)
         {
            this.eyelid.unFlashColor();
            this.pupil.unFlashColor();
            if(this._isLeft)
            {
               (PlayState.boss2 as Boss2).lfoot.unFlashColor();
            }
            else
            {
               (PlayState.boss2 as Boss2).rfoot.unFlashColor();
            }
         }
         super.update();
      }
      
      override public function kill() : void
      {
         this.pupil.kill();
         this.eyelid.kill();
         super.kill();
      }
      
      override public function hurt(param1:Number) : void
      {
         if(!this.isOpen)
         {
            param1 -= 190;
         }
         else
         {
            if(!this._willClose)
            {
               _willClose = true;
               _closeTimeout = 0.3;
            }
            if(--this._lastFlashed <= 0 && param1 > Boss2.DEFENSE)
            {
               this.eyelid.flashColor(16777215);
               this.pupil.flashColor(16777215);
               if(this._isLeft)
               {
                  (PlayState.boss2 as Boss2).lfoot.flashColor(16777215);
               }
               else
               {
                  (PlayState.boss2 as Boss2).rfoot.flashColor(16777215);
               }
               _justFlashed = 1;
               _lastFlashed = 3;
            }
         }
         if(PlayState.boss2 && param1 > 0)
         {
            PlayState.boss2.hurt(param1);
         }
      }
   }
}

