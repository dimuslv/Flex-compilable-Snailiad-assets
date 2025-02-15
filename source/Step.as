package
{
   import org.flixel.FlxG;
   
   public class Step extends Item
   {
      private var _stepHeight:int = 0;
      
      public function Step(param1:int, param2:int, param3:int) : void
      {
         super(param1,param2,false);
         active = true;
         y += 16 - param3;
         visible = false;
      }
      
      override public function touch(param1:Player) : void
      {
         if(PlayState.player._gravityDir == Player.GRAV_DOWN)
         {
            if(param1.y > y - param1.height)
            {
               param1.y = y - param1.height;
               param1.velocity.y = 0;
               param1._jumping = false;
               param1._justHitSteps = true;
            }
         }
         else if(PlayState.player._gravityDir == Player.GRAV_RIGHT)
         {
            if(param1.y > y - param1.height)
            {
               param1.y = y - param1.height;
               param1.velocity.y = 0;
               if(FlxG.keys.pressed(Player.LEFT_KEY) || FlxG.keys.pressed(Player.ALT_LEFT_KEY))
               {
                  param1.y += 11;
                  param1.x -= 11;
                  param1.setFaceDir(Player.FACE_FLOOR_RIGHT,true);
                  param1.facing = left;
               }
               param1._justHitSteps = true;
            }
         }
         else if(param1.y > y - param1.height)
         {
            param1.y = y - param1.height;
            param1.velocity.y = 0;
            param1._justHitSteps = true;
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
      }
   }
}

