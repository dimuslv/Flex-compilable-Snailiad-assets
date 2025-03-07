package
{
   import org.flixel.*;
   
   public class Boss3Spawn extends Enemy
   {
      private static const IMG_WIDTH:int = 64;
      
      private static const IMG_HEIGHT:int = 64;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 250;
      
      private static const DEFENSE:int = 9;
      
      private static const OFFENSE:int = 4;
      
      private static const MODE_TIMEOUT:Number = 0.6;
      
      private static const MODE_WAIT:int = 1;
      
      private static const MODE_UP:int = 2;
      
      private static const MODE_DOWN:int = 3;
      
      private static const MODE_LEFT:int = 4;
      
      private static const MODE_RIGHT:int = 5;
      
      private var _modeTimeout:Number = 0.6;
      
      private var _lastMode:int = 1;
      
      private var _mode:int = 1;
      
      private var _attackMode:int = 0;
      
      private var ACCEL:Number = 400;
      
      public function Boss3Spawn(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         _attackMode = param3;
         if(_attackMode == 1)
         {
            ACCEL = 500;
         }
         loadGraphic(Art.Boss3Spawn,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         if(param4)
         {
            _lastMode = MODE_UP;
         }
         else
         {
            _lastMode = MODE_LEFT;
         }
         addAnimation("start0",[0,1,2,3],20,false);
         addAnimation("start1",[4,5,6,7],20,false);
         addAnimation("stay1",[7]);
         play("start" + _attackMode.toString());
      }
      
      public function stomp() : void
      {
         if(Math.abs(velocity.x) > 100 || Math.abs(velocity.y) > 100)
         {
            FlxG.quake.start(0.02);
            Sfx.playStomp();
         }
         acceleration.x = 0;
         acceleration.y = 0;
         velocity.x = 0;
         velocity.y = 0;
         _lastMode = _mode;
         _mode = MODE_WAIT;
         _modeTimeout = MODE_TIMEOUT;
      }
      
      public function makeBlue() : void
      {
         play("stay1");
         ACCEL = 500;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         stomp();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         stomp();
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         stomp();
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function attackUp() : void
      {
         _lastMode = _mode;
         _mode = MODE_UP;
         acceleration.y = -ACCEL;
      }
      
      public function attackDown() : void
      {
         _lastMode = _mode;
         _mode = MODE_DOWN;
         acceleration.y = ACCEL;
      }
      
      public function attackLeft() : void
      {
         _lastMode = _mode;
         _mode = MODE_LEFT;
         acceleration.x = -ACCEL;
      }
      
      public function attackRight() : void
      {
         _lastMode = _mode;
         _mode = MODE_RIGHT;
         acceleration.x = ACCEL;
      }
      
      public function checkMode() : void
      {
         _modeTimeout -= FlxG.elapsed;
         if(_mode == MODE_WAIT && _modeTimeout < 0)
         {
            switch(_lastMode)
            {
               case MODE_WAIT:
               case MODE_RIGHT:
               case MODE_LEFT:
                  if(PlayState.player.y < y)
                  {
                     attackUp();
                  }
                  else
                  {
                     attackDown();
                  }
                  break;
               case MODE_UP:
               case MODE_DOWN:
                  if(PlayState.player.x < x)
                  {
                     attackLeft();
                  }
                  else
                  {
                     attackRight();
                  }
				  break;
            }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         checkMode();
         super.update();
      }
      
      override public function kill() : void
      {
         super.kill();
         dead = true;
         exists = false;
         active = false;
         visible = false;
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
      }
   }
}

