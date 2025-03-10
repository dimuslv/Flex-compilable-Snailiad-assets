package
{
   import org.flixel.*;
   
   public class PlayerBullet3 extends PlayerBullet
   {
      private static const WIDTH:int = 32;
      
      private static const HEIGHT:int = 32;
      
      private static const FIREPOWER:int = 30;
      
      public function PlayerBullet3() : void
      {
         super(FIREPOWER);
         loadGraphic(Art.PlayerBullet3,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         var _loc1_:Array = ["up","right_up","right","right_down","down","left_down","left","left_up"];
         for (var i:int = 0; i < 8; i++)
         {
            addAnimation(_loc1_[i],[0 + i * 6,1 + i * 6,2 + i * 6,3 + i * 6,4 + i * 6,5 + i * 6],14,true);
         }
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int) : void
      {
         super.shoot(param1,param2,param3,param4);
         acceleration.x = param3 * 18;
         acceleration.y = param4 * 18;
         Sfx.playShot3();
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
      
      override public function hitEnemy(param1:Enemy) : void
      {
         super.hitEnemy(param1);
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

