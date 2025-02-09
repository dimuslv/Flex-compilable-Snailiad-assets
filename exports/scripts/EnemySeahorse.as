package
{
   import org.flixel.FlxG;
   
   public class EnemySeahorse extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 250;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 2;
      
      private static const MODE_WAIT:int = 0;
      
      private static const MODE_COS_UP_LEFT:int = 1;
      
      private static const MODE_COS_DOWN_LEFT:int = 2;
      
      private static const MODE_COS_UP_RIGHT:int = 3;
      
      private static const MODE_COS_DOWN_RIGHT:int = 4;
      
      private static const MODE_SEMICIRCLE_LEFT_UP:int = 5;
      
      private static const MODE_SEMICIRCLE_LEFT_DOWN:int = 6;
      
      private static const MODE_SEMICIRCLE_RIGHT_UP:int = 7;
      
      private static const MODE_SEMICIRCLE_RIGHT_DOWN:int = 8;
      
      private var mode:int = 0;
      
      private var originX:Number;
      
      private var originY:Number;
      
      private var theta:Number = 0;
      
      private var elapsed:Number = 0;
      
      private var X_RADIUS:Number = 70;
      
      private var Y_RADIUS:Number = 20;
      
      private var MOVE_TIME:Number = 1.8;
      
      private var AI_TRIGGER_TIMEOUT:Number = 1.5;
      
      private var _aiTriggerTimeout:Number = 0;
      
      public function EnemySeahorse(param1:int, param2:int)
      {
         if(Boolean(PlayState.player) && PlayState.player._insaneMode)
         {
            this.MOVE_TIME = 1.3;
            this.X_RADIUS = 130;
            this.Y_RADIUS = 40;
         }
         else if(Boolean(PlayState.player) && PlayState.player._hardMode)
         {
            this.MOVE_TIME = 1.9;
            this.X_RADIUS = 140;
            this.Y_RADIUS = 50;
         }
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.EnemySeahorse,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.originX = param1;
         this.originY = param2;
         this.elapsed = this.MOVE_TIME;
         addAnimation("normal",[0]);
         play("normal");
         active = true;
         visible = true;
      }
      
      private function normalizedSigmoid(param1:Number) : Number
      {
         return 1 / (1 + Math.exp(-(param1 * 12 - 6)));
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function triggerAi3() : void
      {
         this._aiTriggerTimeout -= FlxG.elapsed;
         if(this._aiTriggerTimeout > 0)
         {
            return;
         }
         this._aiTriggerTimeout = this.AI_TRIGGER_TIMEOUT;
         this.elapsed = 0;
         this.originX = x;
         this.originY = y;
         if(PlayState.player.x < x)
         {
            if(facing == LEFT)
            {
               this.mode = MODE_COS_DOWN_LEFT;
            }
            else
            {
               this.mode = MODE_SEMICIRCLE_RIGHT_DOWN;
            }
         }
         else if(facing == RIGHT)
         {
            this.mode = MODE_COS_DOWN_RIGHT;
         }
         else
         {
            this.mode = MODE_SEMICIRCLE_LEFT_DOWN;
         }
      }
      
      public function updatePosition() : void
      {
         var _loc1_:Number = NaN;
         if(this.mode == MODE_WAIT)
         {
            return;
         }
         _loc1_ = this.normalizedSigmoid(this.elapsed / this.MOVE_TIME);
         switch(this.mode)
         {
            case MODE_COS_UP_LEFT:
               x = this.originX - this.X_RADIUS * _loc1_;
               y = this.originY - this.Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_COS_DOWN_LEFT:
               x = this.originX - this.X_RADIUS * _loc1_;
               y = this.originY + this.Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_COS_UP_RIGHT:
               x = this.originX + this.X_RADIUS * _loc1_;
               y = this.originY - this.Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_COS_DOWN_RIGHT:
               x = this.originX + this.X_RADIUS * _loc1_;
               y = this.originY + this.Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               break;
            case MODE_SEMICIRCLE_LEFT_UP:
               x = this.originX - this.Y_RADIUS * Math.sin(_loc1_ * Math.PI);
               y = this.originY - this.Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               if(_loc1_ > 0.5)
               {
                  facing = RIGHT;
               }
               break;
            case MODE_SEMICIRCLE_LEFT_DOWN:
               x = this.originX - this.Y_RADIUS * Math.sin(_loc1_ * Math.PI);
               y = this.originY + this.Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               if(_loc1_ > 0.5)
               {
                  facing = RIGHT;
               }
               break;
            case MODE_SEMICIRCLE_RIGHT_UP:
               x = this.originX + this.Y_RADIUS * Math.sin(_loc1_ * Math.PI);
               y = this.originY - this.Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               if(_loc1_ > 0.5)
               {
                  facing = LEFT;
               }
               break;
            case MODE_SEMICIRCLE_RIGHT_DOWN:
               x = this.originX + this.Y_RADIUS * Math.sin(_loc1_ * Math.PI);
               y = this.originY + this.Y_RADIUS * (1 - Math.cos(_loc1_ * Math.PI));
               if(_loc1_ > 0.5)
               {
                  facing = LEFT;
               }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(onScreen())
         {
            this.elapsed += FlxG.elapsed;
            this.updatePosition();
            if(this.elapsed >= this.MOVE_TIME)
            {
               this.elapsed = 0;
               this.originX = x;
               this.originY = y;
               if(PlayState.player.x < x)
               {
                  if(facing == LEFT)
                  {
                     if(PlayState.player.y < y)
                     {
                        this.mode = MODE_COS_UP_LEFT;
                     }
                     else
                     {
                        this.mode = MODE_COS_DOWN_LEFT;
                     }
                  }
                  else if(PlayState.player.y < y)
                  {
                     this.mode = MODE_SEMICIRCLE_RIGHT_UP;
                  }
                  else
                  {
                     this.mode = MODE_SEMICIRCLE_RIGHT_DOWN;
                  }
               }
               else if(facing == RIGHT)
               {
                  if(PlayState.player.y < y)
                  {
                     this.mode = MODE_COS_UP_RIGHT;
                  }
                  else
                  {
                     this.mode = MODE_COS_DOWN_RIGHT;
                  }
               }
               else if(PlayState.player.y < y)
               {
                  this.mode = MODE_SEMICIRCLE_LEFT_UP;
               }
               else
               {
                  this.mode = MODE_SEMICIRCLE_LEFT_DOWN;
               }
            }
         }
         super.update();
      }
   }
}

