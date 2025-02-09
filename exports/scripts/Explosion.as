package
{
   import org.flixel.FlxSprite;
   
   public class Explosion extends FlxSprite
   {
      public function Explosion()
      {
         super();
         exists = false;
         solid = false;
         visible = false;
         dead = true;
      }
      
      public function boom(param1:int, param2:int) : void
      {
         x = param1;
         y = param2;
         dead = false;
         visible = true;
         exists = true;
         play("boom");
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(finished)
         {
            dead = true;
            visible = false;
            exists = false;
         }
      }
      
      override public function kill() : void
      {
         dead = true;
         visible = false;
         exists = false;
         super.kill();
      }
   }
}

