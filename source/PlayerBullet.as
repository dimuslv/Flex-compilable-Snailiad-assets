package
{
   import org.flixel.*;
   
   public class PlayerBullet extends FlxSprite
   {
      private static const DEFAULT_LIFETIME:Number = 4;
      
      private var _lifetime:Number = 0;
      
      private var _firepower:int = 0;
      
      public function PlayerBullet(param1:int) : void
      {
         exists = false;
         offset.x = 0;
         offset.y = 0;
         velocity.x = 0;
         velocity.y = 0;
         this._firepower = param1;
      }
      
      public function shoot(param1:int, param2:int, param3:int, param4:int) : void
      {
         param1 -= width / 2;
         param2 -= height / 2;
         super.reset(param1,param2);
         solid = true;
         exists = true;
         velocity.x = param3;
         velocity.y = param4;
         _lifetime = DEFAULT_LIFETIME;
      }
      
      public function hitEnemy(param1:Enemy) : void
      {
         if(!param1.onScreen())
         {
            return;
         }
         if(PlayState.player._superattack)
         {
            param1.hurt(9999);
         }
         else
         {
            param1.hurt(this._firepower);
         }
         if(param1.getDefense() >= 200)
         {
            this.kill();
         }
      }
      
      public function hitItem(param1:Item) : void
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

