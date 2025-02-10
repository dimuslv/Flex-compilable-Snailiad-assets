package
{
   import org.flixel.FlxG;
   import org.flixel.FlxObject;
   
   public class EnemyFireball extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 400;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 3;
      
      private static const MODE_BOTTOM:int = 0;
      
      private static const MODE_RIGHT:int = 1;
      
      private static const MODE_TOP:int = 2;
      
      private static const MODE_LEFT:int = 3;
      
      private static const MODE_FALLING:int = 4;
      
      private static const SPEED:int = 1;
      
      private var SEC_PER_TICK:Number = 0.02;
      
      private var _clockwise:Boolean = true;
      
      private var _elapsed:Number = 0;
      
      private var vx:int;
      
      private var vy:int;
      
      private var mode:int;
      
      private var turns:int;
      
      public function EnemyFireball(param1:int, param2:int, param3:Boolean)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         this._clockwise = param3;
         if(Boolean(PlayState.player) && PlayState.player._insaneMode)
         {
            this.SEC_PER_TICK = 0.01;
         }
         else if(Boolean(PlayState.player) && PlayState.player._hardMode)
         {
            this.SEC_PER_TICK = 0.013;
         }
         loadGraphic(Art.EnemyFireball,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         addAnimation("normal",[0,1,2,3],6,true);
         play("normal");
         if(PlayState.worldMap.enemySolidAt(param1,param2 + 16))
         {
            this.mode = MODE_BOTTOM;
            this.vx = this._clockwise ? int(-SPEED) : SPEED;
         }
         else if(PlayState.worldMap.enemySolidAt(param1 + 16,param2))
         {
            this.mode = MODE_RIGHT;
            this.vy = this._clockwise ? SPEED : int(-SPEED);
         }
         else if(PlayState.worldMap.enemySolidAt(param1,param2 - 16))
         {
            this.mode = MODE_TOP;
            this.vx = this._clockwise ? SPEED : int(-SPEED);
         }
         else if(PlayState.worldMap.enemySolidAt(param1 - 16,param2))
         {
            this.mode = MODE_LEFT;
            this.vy = this._clockwise ? int(-SPEED) : SPEED;
         }
         else
         {
            this.mode = MODE_FALLING;
            acceleration.y = 1200;
            this.vx = 0;
            this.vy = 0;
         }
      }
      
      override public function touch(param1:Player) : void
      {
         if(param1.hasArmor())
         {
            return;
         }
         super.touch(param1);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this._elapsed += FlxG.elapsed;
         while(this._elapsed > this.SEC_PER_TICK)
         {
            this._elapsed -= this.SEC_PER_TICK;
            x += this.vx;
            y += this.vy;
            if(this.turns >= 4)
            {
               this.turns = 0;
               this.mode = MODE_FALLING;
               this.vx = 0;
               this.vy = 0;
               acceleration.y = 1200;
            }
            if(this._clockwise)
            {
               switch(this.mode)
               {
                  case MODE_BOTTOM:
                     if(!PlayState.worldMap.enemySolidAt(x + 15,y + 16) && !PlayState.worldMap.enemySolidAt(x,y + 16))
                     {
                        this.mode = MODE_RIGHT;
                        this.vx = 0;
                        this.vy = SPEED;
                        x = int(x / 16) * 16;
                        y += 2;
                        ++this.turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x - 1,y))
                     {
                        this.mode = MODE_LEFT;
                        this.vx = 0;
                        this.vy = -SPEED;
                        ++this.turns;
                     }
                     else
                     {
                        this.turns = 0;
                     }
                     break;
                  case MODE_RIGHT:
                     if(!PlayState.worldMap.enemySolidAt(x + 16,y + 15) && !PlayState.worldMap.enemySolidAt(x + 16,y))
                     {
                        this.mode = MODE_TOP;
                        this.vx = SPEED;
                        this.vy = 0;
                        x += 2;
                        ++this.turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x,y + 16))
                     {
                        this.mode = MODE_BOTTOM;
                        this.vx = -SPEED;
                        this.vy = 0;
                        ++this.turns;
                     }
                     else
                     {
                        this.turns = 0;
                     }
                     break;
                  case MODE_TOP:
                     if(!PlayState.worldMap.enemySolidAt(x,y - 1) && !PlayState.worldMap.enemySolidAt(x + 15,y - 1))
                     {
                        this.mode = MODE_LEFT;
                        this.vx = 0;
                        this.vy = -SPEED;
                        y -= 2;
                        ++this.turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x + 16,y))
                     {
                        this.mode = MODE_RIGHT;
                        this.vx = 0;
                        this.vy = SPEED;
                        ++this.turns;
                     }
                     else
                     {
                        this.turns = 0;
                     }
                     break;
                  case MODE_LEFT:
                     if(!PlayState.worldMap.enemySolidAt(x - 1,y + 15) && !PlayState.worldMap.enemySolidAt(x - 1,y))
                     {
                        this.mode = MODE_BOTTOM;
                        this.vx = -SPEED;
                        this.vy = 0;
                        x -= 2;
                        y = int(y / 16) * 16;
                        ++this.turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x,y - 1))
                     {
                        this.mode = MODE_TOP;
                        this.vx = SPEED;
                        this.vy = 0;
                        ++this.turns;
                     }
                     else
                     {
                        this.turns = 0;
                     }
               }
               continue;
            }
            switch(this.mode)
            {
               case MODE_BOTTOM:
                  if(!PlayState.worldMap.enemySolidAt(x + 15,y + 16) && !PlayState.worldMap.enemySolidAt(x,y + 16))
                  {
                     this.mode = MODE_LEFT;
                     this.vx = 0;
                     this.vy = SPEED;
                     x = int(x / 16) * 16;
                     y += 1;
                     ++this.turns;
                  }
                  else if(PlayState.worldMap.enemySolidAt(x + 16,y))
                  {
                     this.mode = MODE_RIGHT;
                     this.vx = 0;
                     this.vy = -SPEED;
                     ++this.turns;
                  }
                  else
                  {
                     this.turns = 0;
                  }
                  break;
               case MODE_RIGHT:
                  if(!PlayState.worldMap.enemySolidAt(x + 16,y + 15) && !PlayState.worldMap.enemySolidAt(x + 16,y))
                  {
                     this.mode = MODE_BOTTOM;
                     this.vx = SPEED;
                     this.vy = 0;
                     x += 1;
                     ++this.turns;
                  }
                  else if(PlayState.worldMap.enemySolidAt(x,y - 1))
                  {
                     this.mode = MODE_TOP;
                     this.vx = -SPEED;
                     this.vy = 0;
                     ++this.turns;
                  }
                  else
                  {
                     this.turns = 0;
                  }
                  break;
               case MODE_TOP:
                  if(!PlayState.worldMap.enemySolidAt(x,y - 1) && !PlayState.worldMap.enemySolidAt(x + 15,y - 1))
                  {
                     this.mode = MODE_RIGHT;
                     this.vx = 0;
                     this.vy = -SPEED;
                     --y;
                     ++this.turns;
                  }
                  else if(PlayState.worldMap.enemySolidAt(x - 1,y))
                  {
                     this.mode = MODE_LEFT;
                     this.vx = 0;
                     this.vy = SPEED;
                     ++this.turns;
                  }
                  else
                  {
                     this.turns = 0;
                  }
                  break;
               case MODE_LEFT:
                  if(!PlayState.worldMap.enemySolidAt(x - 1,y + 15) && !PlayState.worldMap.enemySolidAt(x - 1,y))
                  {
                     this.mode = MODE_TOP;
                     this.vx = -SPEED;
                     this.vy = 0;
                     --x;
                     ++this.turns;
                  }
                  else if(PlayState.worldMap.enemySolidAt(x,y + 16))
                  {
                     this.mode = MODE_BOTTOM;
                     this.vx = SPEED;
                     this.vy = 0;
                     ++this.turns;
                  }
                  else
                  {
                     this.turns = 0;
                  }
                  break;
            }
         }
         super.update();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         if(this.mode == MODE_FALLING)
         {
            this.mode = MODE_BOTTOM;
            acceleration.y = 0;
            velocity.y = 0;
            this.vx = this._clockwise ? int(-SPEED) : SPEED;
            this.vy = 0;
         }
      }
   }
}

