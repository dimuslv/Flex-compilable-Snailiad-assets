package
{
   import org.flixel.*;
   
   public class EnemySpikey extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 70;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 2;
      
      private static const MODE_BOTTOM:int = 0;
      
      private static const MODE_RIGHT:int = 1;
      
      private static const MODE_TOP:int = 2;
      
      private static const MODE_LEFT:int = 3;
      
      private static const MODE_FALLING:int = 4;
      
      private static const SPEED:int = 1;
      
      private static const SEC_PER_TICK:Number = 0.03;
      
      private var _clockwise:Boolean = true;
      
      private var _elapsed:Number = 0;
      
      private var vx:int;
      
      private var vy:int;
      
      private var mode:int;
      
      private var turns:int;
      
      public function EnemySpikey(param1:int, param2:int, param3:Boolean) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         _clockwise = param3;
         loadGraphic(Art.EnemySpikey,true,true,IMG_WIDTH,IMG_HEIGHT);
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
            mode = MODE_BOTTOM;
            vx = _clockwise ? -SPEED : SPEED;
            play("bottom");
         }
         else if(PlayState.worldMap.enemySolidAt(param1 + 16,param2))
         {
            mode = MODE_RIGHT;
            vy = _clockwise ? SPEED : -SPEED;
            play("right");
         }
         else if(PlayState.worldMap.enemySolidAt(param1,param2 - 16))
         {
            mode = MODE_TOP;
            vx = _clockwise ? SPEED : -SPEED;
            play("top");
         }
         else if(PlayState.worldMap.enemySolidAt(param1 - 16,param2))
         {
            mode = MODE_LEFT;
            vy = _clockwise ? -SPEED : SPEED;
            play("left");
         }
         else
         {
            mode = MODE_FALLING;
            acceleration.y = 1200;
            vx = 0;
            vy = 0;
            play("bottom");
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
         _elapsed += FlxG.elapsed;
         while(_elapsed > SEC_PER_TICK)
         {
            _elapsed -= SEC_PER_TICK;
            x += vx;
            y += vy;
            if(turns >= 4)
            {
               turns = 0;
               mode = MODE_FALLING;
               vx = 0;
               vy = 0;
               acceleration.y = 1200;
            }
            if(_clockwise)
            {
               switch(mode)
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
                        ++turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x - 1,y))
                     {
                        mode = MODE_LEFT;
                        vx = 0;
                        vy = -SPEED;
                        play("left");
                        ++turns;
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
                        ++turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x,y + 16))
                     {
                        mode = MODE_BOTTOM;
                        vx = -SPEED;
                        vy = 0;
                        play("bottom");
                        ++turns;
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
                        ++turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x + 16,y))
                     {
                        mode = MODE_RIGHT;
                        vx = 0;
                        vy = SPEED;
                        play("right");
                        ++turns;
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
                        ++turns;
                     }
                     else if(PlayState.worldMap.enemySolidAt(x,y - 1))
                     {
                        mode = MODE_TOP;
                        vx = SPEED;
                        vy = 0;
                        play("top");
                        ++turns;
                     }
                     else
                     {
                        turns = 0;
                     }
					 break;
               }
               continue;
            }
            switch(mode)
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
                     ++turns;
                  }
                  else if(PlayState.worldMap.enemySolidAt(x + 16,y))
                  {
                     mode = MODE_RIGHT;
                     vx = 0;
                     vy = -SPEED;
                     play("right");
                     ++turns;
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
                     ++turns;
                  }
                  else if(PlayState.worldMap.enemySolidAt(x,y - 1))
                  {
                     mode = MODE_TOP;
                     vx = -SPEED;
                     vy = 0;
                     play("top");
                     ++turns;
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
                     ++turns;
                  }
                  else if(PlayState.worldMap.enemySolidAt(x - 1,y))
                  {
                     mode = MODE_LEFT;
                     vx = 0;
                     vy = SPEED;
                     play("left");
                     ++turns;
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
                     ++turns;
                  }
                  else if(PlayState.worldMap.enemySolidAt(x,y + 16))
                  {
                     mode = MODE_BOTTOM;
                     vx = SPEED;
                     vy = 0;
                     play("bottom");
                     ++turns;
                  }
                  else
                  {
                     turns = 0;
                  }
                  break;
            }
         }
         super.update();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         if(mode == MODE_FALLING)
         {
            mode = MODE_BOTTOM;
            acceleration.y = 0;
            velocity.y = 0;
            vx = _clockwise ? -SPEED : SPEED;
            vy = 0;
            play("bottom");
         }
      }
   }
}

