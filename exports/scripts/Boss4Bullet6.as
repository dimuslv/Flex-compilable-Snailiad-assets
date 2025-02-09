package
{
   import org.flixel.*;
   
   public class Boss4Bullet6 extends Boss4Bullet
   {
      private static const DEFAULT_LIFETIME:Number = 2;
      
      private static const WIDTH:int = 48;
      
      private static const HEIGHT:int = 48;
      
      private static const FIREPOWER:int = 16;
      
      public function Boss4Bullet6()
      {
         super(PlayState.bossRush ? int(FIREPOWER / 8) : FIREPOWER);
         loadGraphic(Art.Boss4Bullet6,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         var _loc1_:Array = ["up","right_up","right","right_down","down","left_down","left","left_up"];
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            addAnimation(_loc1_[_loc2_],[_loc2_ * 6]);
            _loc2_++;
         }
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int, param5:Number = 2) : void
      {
         super.shoot(param1,param2,param3,param4,param5);
         acceleration.x = param3 * 18;
         acceleration.y = param4 * 18;
         Sfx.playShot3b();
         if(param3 < 0)
         {
            if(param4 < 0)
            {
               play("left_up");
            }
            else if(param4 > 0)
            {
               play("left_down");
            }
            else
            {
               play("left");
            }
         }
         else if(param3 > 0)
         {
            if(param4 < 0)
            {
               play("right_up");
            }
            else if(param4 > 0)
            {
               play("right_down");
            }
            else
            {
               play("right");
            }
         }
         else if(param4 < 0)
         {
            play("up");
         }
         else if(param4 > 0)
         {
            play("down");
         }
      }
      
      override public function hitPlayer(param1:Player) : void
      {
         super.hitPlayer(param1);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(!onScreen())
         {
            super.kill();
         }
         if(x > FlxG.MaxX || x + width < FlxG.MinX || y > FlxG.MaxY || y + height < FlxG.MinY)
         {
            kill();
         }
      }
   }
}

