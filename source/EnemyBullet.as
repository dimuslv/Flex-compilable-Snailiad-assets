package
{
   import org.flixel.*;
   
   public class EnemyBullet extends FlxSprite
   {
      private static const DEFAULT_LIFETIME:Number = 1.6;
      
      protected var _lifetime:Number = 1.6;
      
      private var _firepower:int = 0;
      
      public function EnemyBullet(param1:int) : void
      {
         super();
         exists = false;
         offset.x = 0;
         offset.y = 0;
         velocity.x = 0;
         velocity.y = 0;
         this._firepower = param1;
      }
      
      public function shoot(param1:int, param2:int, param3:int, param4:int, param5:Number = 1.6) : void
      {
         param1 -= width / 2;
         param2 -= height / 2;
         super.reset(param1,param2);
         solid = true;
         exists = true;
         velocity.x = param3;
         velocity.y = param4;
         _lifetime = param5;
      }
      
      public function collideTerrain() : Boolean
      {
         return false;
      }
      
      public function hitPlayer(param1:Player) : void
      {
         param1.hurt(this._firepower);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(dead)
         {
            exists = false;
            return;
         }
         super.update();
         _lifetime -= FlxG.elapsed;
         if(this._lifetime <= 0)
         {
            this.kill();
         }
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         this.kill();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         this.kill();
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         this.kill();
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

