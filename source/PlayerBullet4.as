package
{
   import org.flixel.*;
   
   public class PlayerBullet4 extends PlayerBullet
   {
      private static const WIDTH:int = 24;
      
      private static const HEIGHT:int = 24;
      
      private static const FIREPOWER:int = 45;
      
      private var startx:int = 0;
      
      private var starty:int = 0;
      
      public function PlayerBullet4() : void
      {
         super(FIREPOWER);
         loadGraphic(Art.PlayerBullet4,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         addAnimation("normal",[0,1,2,3,4,5],45,true);
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int) : void
      {
         super.shoot(param1,param2,param3 * 1.5,param4 * 1.5);
         Sfx.playShot1b();
         play("normal");
         startx = param1;
         starty = param2;
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

