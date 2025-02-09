package
{
   import org.flixel.FlxG;
   
   public class GravJump extends SuperUniqueItem
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 16;
      
      private static const MODE_NONE:int = 0;
      
      private static const MODE_GORIGHT:int = 1;
      
      private static const MODE_GRAVUP:int = 2;
      
      private static const MODE_GRAVLEFT:int = 3;
      
      private static const MODE_GRAVRIGHT:int = 4;
      
      private static const MODE_GRAVFALL:int = 5;
      
      private static const MODE_GRAVDONE:int = 6;
      
      private static const GRAV_TIMER:Number = 0.5;
      
      private static const DONE_TIMEOUT:Number = 1;
      
      private var _mode:int = 0;
      
      private var _modeFrames:Number = 0;
      
      private var _gravTimer:Number = 0;
      
      private var _doneTimeout:Number = 0;
      
      private var _shot:Boolean = false;
      
      private var _totalElapsed:Number = 0;
      
      public function GravJump(param1:int, param2:int)
      {
         super(param1,param2,true,true);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemGravJump,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1,2,3],22,true);
         play("normal");
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addGravityJump();
         if(PlayState.player._slugMode)
         {
            PlayState.hud.itemName.setItem("GRAVITY SLUG");
         }
         else
         {
            PlayState.hud.itemName.setItem("GRAVITY SNAIL");
         }
         super.touch(param1);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(_customReady)
         {
            this._totalElapsed += FlxG.elapsed;
            if(this._totalElapsed > 7)
            {
               PlayState.player.paralyze(false);
               kill();
               return;
            }
            if(this._mode == MODE_NONE)
            {
               this._mode = MODE_GORIGHT;
            }
            switch(this._mode)
            {
               case MODE_GORIGHT:
                  if(this._modeFrames == 0)
                  {
                     PlayState.player.setFaceDir(Player.FACE_FLOOR_RIGHT,true);
                     PlayState.player.playAnim("floor_right_move");
                     PlayState.player.facing = RIGHT;
                  }
                  PlayState.player.velocity.x = PlayState.player._runSpeed.value;
                  if(!PlayState.player._jumping && PlayState.player.y > 345 * 16 + 8)
                  {
                     PlayState.player.doJump();
                  }
                  if(PlayState.player.x > 152 * 16 + 8)
                  {
                     PlayState.player.x = 152 * 16 + 8;
                     this._mode = MODE_GRAVUP;
                     this._gravTimer = 99999;
                     PlayState.player.velocity.x = 0;
                  }
                  break;
               case MODE_GRAVUP:
                  if(!PlayState.player._jumping && PlayState.player.y > 344 * 16)
                  {
                     PlayState.player.doJump();
                     this._gravTimer = GRAV_TIMER;
                     if(!this._shot)
                     {
                        this._shot = true;
                        PlayState.player._weaponTimeout.value = 0;
                        PlayState.player.switchToWeapon(2);
                        FlxG.keys.unpress(Player.ALT_UP_KEY);
                        FlxG.keys.unpress(Player.ALT_LEFT_KEY);
                        FlxG.keys.unpress(Player.ALT_RIGHT_KEY);
                        FlxG.keys.unpress(Player.ALT_DOWN_KEY);
                        FlxG.keys.press(Player.UP_KEY);
                        FlxG.keys.unpress(Player.LEFT_KEY);
                        FlxG.keys.unpress(Player.RIGHT_KEY);
                        FlxG.keys.unpress(Player.DOWN_KEY);
                        PlayState.player.shootCurrentWeapon();
                        FlxG.keys.unpress(Player.UP_KEY);
                     }
                  }
                  this._gravTimer -= FlxG.elapsed;
                  if(this._gravTimer <= 0)
                  {
                     FlxG.keys.unpress(Player.ALT_UP_KEY);
                     FlxG.keys.unpress(Player.ALT_LEFT_KEY);
                     FlxG.keys.unpress(Player.ALT_RIGHT_KEY);
                     FlxG.keys.unpress(Player.ALT_DOWN_KEY);
                     FlxG.keys.press(Player.UP_KEY);
                     FlxG.keys.unpress(Player.LEFT_KEY);
                     FlxG.keys.unpress(Player.RIGHT_KEY);
                     FlxG.keys.unpress(Player.DOWN_KEY);
                     PlayState.player.performGravityJump();
                     FlxG.keys.unpress(Player.UP_KEY);
                     this._mode = MODE_GRAVLEFT;
                  }
                  break;
               case MODE_GRAVLEFT:
                  if(PlayState.player.y < 329 * 16)
                  {
                     PlayState.player.y = 329 * 16;
                     FlxG.keys.unpress(Player.ALT_UP_KEY);
                     FlxG.keys.unpress(Player.ALT_LEFT_KEY);
                     FlxG.keys.unpress(Player.ALT_RIGHT_KEY);
                     FlxG.keys.unpress(Player.ALT_DOWN_KEY);
                     FlxG.keys.press(Player.LEFT_KEY);
                     FlxG.keys.unpress(Player.UP_KEY);
                     FlxG.keys.unpress(Player.RIGHT_KEY);
                     FlxG.keys.unpress(Player.DOWN_KEY);
                     PlayState.player.performGravityJump();
                     FlxG.keys.unpress(Player.LEFT_KEY);
                     this._mode = MODE_GRAVRIGHT;
                  }
                  break;
               case MODE_GRAVRIGHT:
                  if(PlayState.player.x < 140 * 16)
                  {
                     PlayState.player.x = 140 * 16;
                     FlxG.keys.unpress(Player.ALT_UP_KEY);
                     FlxG.keys.unpress(Player.ALT_LEFT_KEY);
                     FlxG.keys.unpress(Player.ALT_RIGHT_KEY);
                     FlxG.keys.unpress(Player.ALT_DOWN_KEY);
                     FlxG.keys.press(Player.RIGHT_KEY);
                     FlxG.keys.unpress(Player.UP_KEY);
                     FlxG.keys.unpress(Player.LEFT_KEY);
                     FlxG.keys.unpress(Player.DOWN_KEY);
                     PlayState.player.performGravityJump();
                     FlxG.keys.unpress(Player.RIGHT_KEY);
                     this._mode = MODE_GRAVFALL;
                  }
                  break;
               case MODE_GRAVFALL:
                  if(PlayState.player.x < 134 * 16)
                  {
                     PlayState.player.x < 134 * 16;
                     PlayState.player.velocity.x = 0;
                  }
                  if(PlayState.player.x > 146 * 16 + 8)
                  {
                     PlayState.player.x = 146 * 16 + 8;
                     FlxG.keys.unpress(Player.ALT_UP_KEY);
                     FlxG.keys.unpress(Player.ALT_LEFT_KEY);
                     FlxG.keys.unpress(Player.ALT_RIGHT_KEY);
                     FlxG.keys.unpress(Player.ALT_DOWN_KEY);
                     FlxG.keys.unpress(Player.UP_KEY);
                     FlxG.keys.unpress(Player.LEFT_KEY);
                     FlxG.keys.unpress(Player.RIGHT_KEY);
                     FlxG.keys.press(Player.DOWN_KEY);
                     PlayState.player.performGravityJump();
                     FlxG.keys.unpress(Player.DOWN_KEY);
                     this._mode = MODE_GRAVDONE;
                     this._doneTimeout = DONE_TIMEOUT;
                  }
                  break;
               case MODE_GRAVDONE:
                  this._doneTimeout -= FlxG.elapsed;
                  if(this._doneTimeout < 0)
                  {
                     PlayState.player.paralyze(false);
                     kill();
                  }
            }
            ++this._modeFrames;
         }
      }
   }
}

