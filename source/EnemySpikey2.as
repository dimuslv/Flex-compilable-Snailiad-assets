package
{
   import org.flixel.*;
   
   public class EnemySpikey2 extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 4;
      
      private static const MODE_BOTTOM:int = 0;
      
      private static const MODE_RIGHT:int = 1;
      
      private static const MODE_TOP:int = 2;
      
      private static const MODE_LEFT:int = 3;
      
      private static const MODE_FALLING:int = 4;
      
      private static const SPEED:int = 1;
      
      private static const WEAPON_SPEED:Number = 80;
      
      private var MAX_HP:int = 340;
      
      private var SEC_PER_TICK:Number = 0.022;
      
      private var stopTimeout:Number = 0;
      
      private var startTimeout:Number = 0;
      
      private var STOP_TIMEOUT:Number = 5;
      
      private var START_TIMEOUT:Number = 1;
      
      private var _clockwise:Boolean = true;
      
      private var _elapsed:Number = 0;
      
      private var stopped:Boolean = false;
      
      private var vx:int;
      
      private var vy:int;
      
      private var mode:int;
      
      private var turns:int;
      
      public function EnemySpikey2(param1:int, param2:int, param3:Boolean) : void
      {
         super(param1,param2,this.MAX_HP,DEFENSE,OFFENSE);
         this._clockwise = param3;
         if(PlayState.player && PlayState.player._hardMode)
         {
            this.STOP_TIMEOUT = 4;
            this.START_TIMEOUT = 1;
         }
         if(PlayState.player && PlayState.player._insaneMode)
         {
            this.MAX_HP = 720;
            this.STOP_TIMEOUT = 3;
            this.START_TIMEOUT = 0.2;
            this.SEC_PER_TICK = 0.019;
         }
         loadGraphic(Art.EnemySpikey2,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         addAnimation("bottom",[0,1,2,3],6,true);
         addAnimation("right",[4,5,6,7],6,true);
         addAnimation("top",[8,9,10,11],6,true);
         addAnimation("left",[12,13,14,15],6,true);
         if(PlayState.worldMap.enemySolidAt(param1,param2 + 16))
         {
            this.mode = MODE_BOTTOM;
            this.vx = this._clockwise ? -SPEED : SPEED;
            play("bottom");
         }
         else if(PlayState.worldMap.enemySolidAt(param1 + 16,param2))
         {
            this.mode = MODE_RIGHT;
            this.vy = this._clockwise ? SPEED : -SPEED;
            play("right");
         }
         else if(PlayState.worldMap.enemySolidAt(param1,param2 - 16))
         {
            this.mode = MODE_TOP;
            this.vx = this._clockwise ? SPEED : -SPEED;
            play("top");
         }
         else if(PlayState.worldMap.enemySolidAt(param1 - 16,param2))
         {
            this.mode = MODE_LEFT;
            this.vy = this._clockwise ? -SPEED : SPEED;
            play("left");
         }
         else
         {
            this.mode = MODE_FALLING;
            acceleration.y = 1200;
            this.vx = 0;
            this.vy = 0;
            play("bottom");
         }
         this.stopTimeout = 2 + (x * 0.13 + y * 0.7) % 2.94;
         this.startTimeout = this.stopTimeout + this.START_TIMEOUT;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc2_:Number = WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         if(PlayState.player && PlayState.player._insaneMode)
         {
            var _loc5_:EnemyBullet = PlayState.enemyBulletPool.getBullet(1);
            if(_loc5_)
            {
               _loc5_.shoot(x + width / 2,y + height / 2,_loc3_ * 2.3,_loc4_ * 2.3);
            }
         }
         else
         {
            _loc5_ = PlayState.enemyBulletPool.getBullet(1);
            if(_loc5_)
            {
               _loc5_.shoot(x + width / 2,y + height / 2,_loc3_,_loc4_);
            }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         stopTimeout -= FlxG.elapsed;
         startTimeout -= FlxG.elapsed;
         if(this.stopTimeout < 0 && this.stopped == false)
         {
            stopTimeout = this.STOP_TIMEOUT;
            startTimeout = this.START_TIMEOUT;
            stopped = true;
         }
         else if(this.startTimeout < 0 && this.stopped == true)
         {
            stopped = false;
            var _loc1_:Number = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
            if(onScreen())
            {
               this.shoot(_loc1_);
            }
            stopTimeout = this.STOP_TIMEOUT;
            startTimeout = this.START_TIMEOUT + this.STOP_TIMEOUT;
         }
         if(!this.stopped)
         {
            _elapsed += FlxG.elapsed;
            while(this._elapsed > this.SEC_PER_TICK)
            {
               _elapsed -= this.SEC_PER_TICK;
               x += this.vx;
               y += this.vy;
               if(this.turns >= 4)
               {
                  turns = 0;
                  mode = MODE_FALLING;
                  vx = 0;
                  vy = 0;
                  acceleration.y = 1200;
               }
               if(this._clockwise)
               {
                  switch(this.mode)
                  {
                     case MODE_BOTTOM:
                        if(!PlayState.worldMap.enemySolidAt(x + 15,y + 16) && !PlayState.worldMap.enemySolidAt(x,y + 16))
                        {
                           mode = MODE_RIGHT;
                           vx = 0;
                           vy = SPEED;
                           play("right");
                           x = int(x / 16) * 16;
                           y += 2;
                           ++this.turns;
                        }
                        else if(PlayState.worldMap.enemySolidAt(x - 1,y))
                        {
                           mode = MODE_LEFT;
                           vx = 0;
                           vy = -SPEED;
                           play("left");
                           ++this.turns;
                        }
                        else
                        {
                           turns = 0;
                        }
                        break;
                     case MODE_RIGHT:
                        if(!PlayState.worldMap.enemySolidAt(x + 16,y + 15) && !PlayState.worldMap.enemySolidAt(x + 16,y))
                        {
                           mode = MODE_TOP;
                           vx = SPEED;
                           vy = 0;
                           play("top");
                           x += 2;
                           ++this.turns;
                        }
                        else if(PlayState.worldMap.enemySolidAt(x,y + 16))
                        {
                           mode = MODE_BOTTOM;
                           vx = -SPEED;
                           vy = 0;
                           play("bottom");
                           ++this.turns;
                        }
                        else
                        {
                           turns = 0;
                        }
                        break;
                     case MODE_TOP:
                        if(!PlayState.worldMap.enemySolidAt(x,y - 1) && !PlayState.worldMap.enemySolidAt(x + 15,y - 1))
                        {
                           mode = MODE_LEFT;
                           vx = 0;
                           vy = -SPEED;
                           play("left");
                           y -= 2;
                           ++this.turns;
                        }
                        else if(PlayState.worldMap.enemySolidAt(x + 16,y))
                        {
                           mode = MODE_RIGHT;
                           vx = 0;
                           vy = SPEED;
                           play("right");
                           ++this.turns;
                        }
                        else
                        {
                           turns = 0;
                        }
                        break;
                     case MODE_LEFT:
                        if(!PlayState.worldMap.enemySolidAt(x - 1,y + 15) && !PlayState.worldMap.enemySolidAt(x - 1,y))
                        {
                           mode = MODE_BOTTOM;
                           vx = -SPEED;
                           vy = 0;
                           play("bottom");
                           x -= 2;
                           y = int(y / 16) * 16;
                           ++this.turns;
                        }
                        else if(PlayState.worldMap.enemySolidAt(x,y - 1))
                        {
                           mode = MODE_TOP;
                           vx = SPEED;
                           vy = 0;
                           play("top");
                           ++this.turns;
                        }
                        else
                        {
                           turns = 0;
                        }
						break;
                  }
                  continue;
               }
               switch(this.mode)
               {
                  case MODE_BOTTOM:
                     if(!PlayState.worldMap.enemySolidAt(x + 15,y + 16) && !PlayState.worldMap.enemySolidAt(x,y + 16))
                     {
                        mode = MODE_LEFT;
                        vx = 0;
                        vy = SPEED;
                        play("left");
                        x = int(x / 16) * 16;
                        y += 1;
                        ++this.turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x + 16,y))
                     {
                        mode = MODE_RIGHT;
                        vx = 0;
                        vy = -SPEED;
                        play("right");
                        ++this.turns;
                     }
                     else
                     {
                        turns = 0;
                     }
                     break;
                  case MODE_RIGHT:
                     if(!PlayState.worldMap.enemySolidAt(x + 16,y + 15) && !PlayState.worldMap.enemySolidAt(x + 16,y))
                     {
                        mode = MODE_BOTTOM;
                        vx = SPEED;
                        vy = 0;
                        play("bottom");
                        x += 1;
                        ++this.turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x,y - 1))
                     {
                        mode = MODE_TOP;
                        vx = -SPEED;
                        vy = 0;
                        play("top");
                        ++this.turns;
                     }
                     else
                     {
                        turns = 0;
                     }
                     break;
                  case MODE_TOP:
                     if(!PlayState.worldMap.enemySolidAt(x,y - 1) && !PlayState.worldMap.enemySolidAt(x + 15,y - 1))
                     {
                        mode = MODE_RIGHT;
                        vx = 0;
                        vy = -SPEED;
                        play("right");
                        y -= 1;
                        ++this.turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x - 1,y))
                     {
                        mode = MODE_LEFT;
                        vx = 0;
                        vy = SPEED;
                        play("left");
                        ++this.turns;
                     }
                     else
                     {
                        turns = 0;
                     }
                     break;
                  case MODE_LEFT:
                     if(!PlayState.worldMap.enemySolidAt(x - 1,y + 15) && !PlayState.worldMap.enemySolidAt(x - 1,y))
                     {
                        mode = MODE_TOP;
                        vx = -SPEED;
                        vy = 0;
                        play("top");
                        x -= 1;
                        ++this.turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x,y + 16))
                     {
                        mode = MODE_BOTTOM;
                        vx = SPEED;
                        vy = 0;
                        play("bottom");
                        ++this.turns;
                     }
                     else
                     {
                        turns = 0;
                     }
                     break;
               }
            }
         }
         super.update();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         if(this.mode == MODE_FALLING)
         {
            mode = MODE_BOTTOM;
            acceleration.y = 0;
            velocity.y = 0;
            vx = this._clockwise ? -SPEED : SPEED;
            vy = 0;
            play("bottom");
         }
      }
   }
}

