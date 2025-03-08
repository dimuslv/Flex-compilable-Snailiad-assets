package
{
   import org.flixel.*;
   
   public class Platform5b extends Item
   {
      private static const IMG_WIDTH:int = 48;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const MAX_HP:int = 150;
      
      private static const DEFENSE:int = 0;
      
      private static const ACCEL:Number = 0.02;
      
      private static const SPEED:Number = 0.5;
      
      private static const SEC_PER_TICK:Number = 0.01;
      
      private var _posy:Number;
      
      private var _accy:Number;
      
      private var _vely:Number;
      
      private var _lastHurt:int;
      
      private var _defense:int;
      
      private var _justFlashed:int;
      
      private var _elapsed:Number = 0;
      
      public function Platform5b(param1:int, param2:int) : void
      {
         super(param1,param2,false);
         loadGraphic(Art.Platform5b,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0]);
         play("normal");
         _posy = y;
         _accy = 0;
         _vely = -SPEED;
         solid = true;
         active = true;
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         if(param1 is Player)
         {
            var _loc3_:Player = param1 as Player;
         }
      }
      
      override public function triggerAi1() : void
      {
         _accy = ACCEL;
      }
      
      override public function triggerAi2() : void
      {
         _accy = -ACCEL;
      }
      
      override public function touch(param1:Player) : void
      {
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _elapsed += FlxG.elapsed;
         while(_elapsed > 0)
         {
            _elapsed -= SEC_PER_TICK;
            _vely += _accy;
            if(_vely > SPEED)
            {
               _vely = SPEED;
            }
            if(_vely < -SPEED)
            {
               _vely = -SPEED;
            }
            _posy += _vely;
            var _loc1_:int = int(_posy);
            var _loc2_:int = int(y);
            var _loc3_:int = _loc1_ - _loc2_;
            if(_loc2_ != _loc1_)
            {
               if(PlayState.player._gravityDir == Player.GRAV_DOWN)
               {
                  var _loc4_:int = _loc2_ - int(PlayState.player.y + PlayState.player.height);
                  if(Math.abs(_loc4_) < 3 && PlayState.player.x + PlayState.player.width > x && PlayState.player.x < x + width)
                  {
                     if(!PlayState.player.pressedJump())
                     {
                        PlayState.player.y = _loc1_ - PlayState.player.height;
                        PlayState.player.velocity.y = 0;
                     }
                  }
               }
               else if(PlayState.player._gravityDir == Player.GRAV_UP)
               {
                  _loc4_ = _loc2_ + height - int(PlayState.player.y);
                  if(Math.abs(_loc4_) < 3 && PlayState.player.x + PlayState.player.width > x && PlayState.player.x < x + width)
                  {
                     if(!PlayState.player.pressedJump())
                     {
                        PlayState.player.y = _loc1_ + height;
                        PlayState.player.velocity.y = 0;
                     }
                  }
               }
               else if(PlayState.player._gravityDir == Player.GRAV_LEFT)
               {
                  var _loc5_:int = int(x) + width - int(PlayState.player.x);
                  if(Math.abs(_loc5_) < 3 && PlayState.player.y + PlayState.player.height > y && PlayState.player.y < y + height)
                  {
                     if(!PlayState.player.pressedJump())
                     {
                        PlayState.player.y += _loc3_;
                        PlayState.player.velocity.x = 0;
                        if(_loc5_ < 0)
                        {
                           PlayState.player.x = int(x) + width;
                        }
                     }
                  }
               }
               else if(PlayState.player._gravityDir == Player.GRAV_RIGHT)
               {
                  _loc5_ = int(x) - int(PlayState.player.x + PlayState.player.width);
                  if(Math.abs(_loc5_) < 3 && PlayState.player.y + PlayState.player.height > y && PlayState.player.y < y + height)
                  {
                     if(!PlayState.player.pressedJump())
                     {
                        PlayState.player.y += _loc3_;
                        PlayState.player.velocity.x = 0;
                        if(_loc5_ > 0)
                        {
                           PlayState.player.x = int(x) - PlayState.player.width;
                        }
                     }
                  }
               }
            }
            y = _loc1_;
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

