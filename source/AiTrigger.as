package
{
   import org.flixel.FlxSprite;
   
   public class AiTrigger extends FlxSprite
   {
      private var _number:int = 0;
      
      public function AiTrigger()
      {
         super();
         exists = false;
         offset.x = 0;
         offset.y = 0;
         velocity.x = 0;
         velocity.y = 0;
         width = 16;
         height = 16;
         visible = false;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      public function create(param1:int, param2:int, param3:int) : void
      {
         super.reset(param1,param2);
         this._number = param3;
         exists = true;
         dead = false;
      }
      
      public function getNumber() : int
      {
         return this._number;
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
      }
      
      override public function kill() : void
      {
         if(dead)
         {
            return;
         }
         dead = true;
         exists = false;
      }
   }
}

