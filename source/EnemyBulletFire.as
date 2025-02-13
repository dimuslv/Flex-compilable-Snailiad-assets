package
{
   import org.flixel.*;
   
   public class EnemyBulletFire extends EnemyBullet
   {
      private static const WIDTH:int = 16;
      
      private static const HEIGHT:int = 16;
      
      private static const FIREPOWER:int = 3;
      
      private static const DEFAULT_LIFETIME:Number = 1.6;
      
      public function EnemyBulletFire() : void
      {
         super(FIREPOWER);
         loadGraphic(Art.EnemyBulletFire,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         var _loc1_:Array = ["left","left_up","up","right_up","right","right_down","down","left_down"];
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            addAnimation(_loc1_[_loc2_],[_loc2_]);
            _loc2_++;
         }
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int, param5:Number = 1.6) : void
      {
         super.shoot(param1,param2,param3,param4,param5);
         Sfx.playShot7();
         if(param3 < 0)
         {
            if(param4 < 0)
            {
               play("left_up");
               width = height = 11;
            }
            else if(param4 > 0)
            {
               play("left_down");
               width = height = 11;
            }
            else
            {
               play("left");
               width = 14;
               height = 9;
            }
         }
         else if(param3 > 0)
         {
            if(param4 < 0)
            {
               play("right_up");
               width = height = 11;
            }
            else if(param4 > 0)
            {
               play("right_down");
               width = height = 11;
            }
            else
            {
               play("right");
               width = 14;
               height = 9;
            }
         }
         else if(param4 < 0)
         {
            play("up");
            width = 9;
            height = 14;
         }
         else if(param4 > 0)
         {
            play("down");
            width = 9;
            height = 14;
         }
      }
      
      override public function hitPlayer(param1:Player) : void
      {
         super.hitPlayer(param1);
      }
      
      override public function collideTerrain() : Boolean
      {
         return true;
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
         if(x > FlxG.MaxX + 250 || x + width < FlxG.MinX - 250 || y > FlxG.MaxY + 250 || y + height < FlxG.MinY - 250)
         {
            kill();
         }
      }
   }
}

