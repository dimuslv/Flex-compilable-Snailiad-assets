package
{
   import org.flixel.*;
   
   public class QueuedExplosion extends FlxSprite
   {
      private static const DISAPPEAR_TIME:Number = 2.7;
      
      private var _disappearTimer:Number;
      
      private var _huge:Boolean = false;
      
      public function QueuedExplosion(param1:int, param2:int, param3:Boolean = false) : void
      {
         super();
         x = param1;
         y = param2;
         this._huge = param3;
         this._disappearTimer = DISAPPEAR_TIME;
         if(param3)
         {
            this._disappearTimer *= 4;
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _disappearTimer -= FlxG.elapsed;
         if(this._disappearTimer <= 0)
         {
            kill();
         }
         if(this._huge)
         {
            PlayState.explosionPool.boomRadial(x,y,1,FlxU.random() * 240,5);
            PlayState.explosionPool.boomRadial(x,y,0,FlxU.random() * 280,4);
            PlayState.explosionPool.boomRadial(x,y,1,FlxU.random() * 310,4);
            PlayState.explosionPool.boomRadial(x,y,0,FlxU.random() * 360,4);
            PlayState.explosionPool.boomRadial(x,y,1,FlxU.random() * 430,4);
            PlayState.explosionPool.boomRadial(x,y,2,FlxU.random() * 430,2);
            if(FlxU.random() * 20 > 17)
            {
               FlxG.quake.start(0.005);
            }
         }
         PlayState.explosionPool.boomRadial(x,y,0,FlxU.random() * 160,5);
         PlayState.explosionPool.boomRadial(x,y,1,FlxU.random() * 120,2);
         PlayState.explosionPool.boomRadial(x,y,0,FlxU.random() * 80,3);
         PlayState.explosionPool.boomRadial(x,y,1,FlxU.random() * 60,2);
         if(FlxU.random() * 20 > 17)
         {
            PlayState.explosionPool.boomRadial(x,y,2,FlxU.random() * 130,1);
         }
         if(FlxU.random() * 10)
         {
            Sfx.playRandomExplode();
         }
         if(FlxU.random() * 10 > 7)
         {
            Sfx.playRandomEnemyKilled();
         }
         super.update();
      }
   }
}

