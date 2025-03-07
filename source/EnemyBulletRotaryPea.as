package
{
   import org.flixel.*;
   
   public class EnemyBulletRotaryPea extends EnemyBullet
   {
      private static const WIDTH:int = 24;
      
      private static const HEIGHT:int = 24;
      
      private static const FIREPOWER:int = 2;
      
      private static const DEFAULT_LIFETIME:Number = 3;
      
      private var _elapsed:Number = 0;
      
      private var _originX:Number = 0;
      
      private var _originY:Number = 0;
      
      private var _velocityR:Number = 0;
      
      private var _velocityTheta:Number = 0;
      
      private var _offsetTheta:Number = 0;
      
      public function EnemyBulletRotaryPea() : void
      {
         super(FIREPOWER);
         loadGraphic(Art.EnemyBulletDonut,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         _originX = x;
         _originY = y;
         addAnimation("normal",[0,1,2,3],30,true);
      }
      
      public function shootRotary(param1:int, param2:int, param3:Number, param4:Number, param5:Number) : void
      {
         param1 -= width / 2;
         param2 -= width / 2;
         super.shoot(param1,param2,0,0,DEFAULT_LIFETIME);
         play("normal");
         active = true;
         _elapsed = 0;
         _originX = param1;
         _originY = param2;
         _velocityR = param3;
         _velocityTheta = param4;
         _offsetTheta = param5;
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
         _elapsed += FlxG.elapsed;
         x = _originX + _velocityR * _elapsed * Math.cos(_elapsed * _velocityTheta + _offsetTheta);
         y = _originY + _velocityR * _elapsed * Math.sin(_elapsed * _velocityTheta + _offsetTheta);
         if(!onScreen())
         {
            kill();
         }
         if(x > FlxG.MaxX + 250 || x + width < FlxG.MinX - 250 || y > FlxG.MaxY + 250 || y + height < FlxG.MinY - 250)
         {
            kill();
         }
      }
   }
}

