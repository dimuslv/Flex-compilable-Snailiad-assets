package
{
   import org.flixel.FlxG;
   
   public class Boss4Bullet4 extends Boss4Bullet
   {
      private static const DEFAULT_LIFETIME:Number = 2;
      
      private static const WIDTH:int = 24;
      
      private static const HEIGHT:int = 24;
      
      private static const FIREPOWER:int = 6;
      
      private var startx:int = 0;
      
      private var starty:int = 0;
      
      public function Boss4Bullet4() : void
      {
         super(PlayState.bossRush ? FIREPOWER / 3 : FIREPOWER);
         loadGraphic(Art.PlayerBullet4,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         offset.x = 2;
         offset.y = 2;
         width = 20;
         height = 20;
         addAnimation("normal",[0,1,2,3,4,5],45,true);
      }
      
      override public function shoot(param1:int, param2:int, param3:int, param4:int, param5:Number = 2.0) : void
      {
         super.shoot(param1,param2,param3 * 1.5,param4 * 1.5,param5);
         Sfx.playShot1b();
         play("normal");
         startx = param1;
         starty = param2;
      }
      
      override public function hitPlayer(param1:Player) : void
      {
         super.hitPlayer(param1);
      }
      
      override public function hitPlayerBullet(param1:PlayerBullet) : void
      {
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

