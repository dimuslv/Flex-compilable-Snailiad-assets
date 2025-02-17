package
{
   import org.flixel.*;
   
   public class Npc extends FlxSprite
   {
      public function Npc(param1:int, param2:int) : void
      {
         super();
         x = param1;
         y = param2;
      }
      
      public function touch(param1:Player) : void
      {
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(x > PlayState.worldMap.maxX || x + width < PlayState.worldMap.minX || y > PlayState.worldMap.maxY || y + height < PlayState.worldMap.minY)
         {
            kill();
         }
      }
   }
}

