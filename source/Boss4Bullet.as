package
{
   import org.flixel.*;
   
   public class Boss4Bullet extends EnemyBullet
   {
      private static const DEFAULT_LIFETIME:Number = 2;
      
      public function Boss4Bullet(param1:int) : void
      {
         super(param1);
      }
      
      public function hitPlayerBullet(param1:PlayerBullet) : void
      {
         PlayState.explosionPool.boom(x,y,0,10,FlxU.random() * 3 + 1);
         param1.kill();
         kill();
      }
      
      override public function kill() : void
      {
         if(dead)
         {
            return;
         }
         velocity.x = 0;
         velocity.y = 0;
         dead = true;
         exists = false;
         solid = false;
      }
   }
}

