package
{
   public class EnemyGear extends Enemy
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 500;
      
      private static const DEFENSE:int = 1;
      
      private static const OFFENSE:int = 4;
      
      public static const DIR_UP:int = 0;
      
      public static const DIR_DOWN:int = 1;
      
      public static const DIR_LEFT:int = 2;
      
      public static const DIR_RIGHT:int = 3;
      
      private static const X_SPEED:int = 500;
      
      private static const Y_SPEED:int = 410;
      
      private static const ACCEL:int = 330;
      
      private static const ACTIVATE_DISTANCE:int = 90;
      
      private static const START_DISTANCE:int = 80;
      
      private var elapsed:Number = 0;
      
      private var _wait:Boolean = false;
      
      private var _direction:int = 0;
      
      public function EnemyGear(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.EnemyGear,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this._direction = param3;
         this._wait = param4;
         if(!this._wait)
         {
            this.startMoving();
         }
         else
         {
            switch(this._direction)
            {
               case DIR_UP:
                  y += START_DISTANCE;
                  break;
               case DIR_DOWN:
                  y -= START_DISTANCE;
                  break;
               case DIR_LEFT:
                  x += START_DISTANCE;
                  break;
               case DIR_RIGHT:
                  x -= START_DISTANCE;
				  break;
            }
         }
         addAnimation("normal",[0,1],30,true);
         play("normal");
         active = true;
      }
      
      public function startMoving() : void
      {
         switch(this._direction)
         {
            case DIR_UP:
               velocity.y = -Y_SPEED;
               acceleration.y = Y_SPEED;
               break;
            case DIR_DOWN:
               velocity.y = Y_SPEED;
               acceleration.y = -Y_SPEED;
               break;
            case DIR_LEFT:
               velocity.x = -X_SPEED;
               acceleration.x = X_SPEED;
               break;
            case DIR_RIGHT:
               velocity.x = X_SPEED;
               acceleration.x = -X_SPEED;
			   break;
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
         if(this._wait && (this._direction == DIR_UP || this._direction == DIR_DOWN))
         {
            if(Math.abs(PlayState.player.x - x - width / 2) < ACTIVATE_DISTANCE)
            {
               _wait = false;
               this.startMoving();
            }
         }
         else if(this._wait && (this._direction == DIR_LEFT || this._direction == DIR_RIGHT))
         {
            if(Math.abs(PlayState.player.y - y - height / 2) < ACTIVATE_DISTANCE)
            {
               _wait = false;
               this.startMoving();
            }
         }
         super.update();
         if(x > PlayState.worldMap.maxX && velocity.x > 0 || x + width < PlayState.worldMap.minX && velocity.x < 0 || y > PlayState.worldMap.maxY && velocity.y > 0 || y + height < PlayState.worldMap.minY && velocity.y < 0)
         {
            kill();
         }
      }
   }
}

