package
{
   import org.flixel.*;
   
   public class Item extends FlxSprite
   {
      private static const DISAPPEAR_TIME:Number = 15000;
      
      private static const FLICKER_TIME:Number = 5000;
      
      private var _disappearTime:Number = 0;
      
      private var _flickerTime:Number = 0;
      
      private var _willThisDisappear:Boolean = false;
      
      public function Item(param1:int, param2:int, param3:Boolean = false) : void
      {
         x = param1;
         y = param2;
         if(param3)
         {
            _disappearTime = DISAPPEAR_TIME;
            _flickerTime = FLICKER_TIME;
            _willThisDisappear = true;
         }
         fixed = true;
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
         if(_willThisDisappear)
         {
            _disappearTime -= FlxG.elapsed;
            _flickerTime -= FlxG.elapsed;
            if(_disappearTime <= 0)
            {
               kill();
            }
            else if(_flickerTime <= 0)
            {
               flicker();
            }
         }
         if(x > PlayState.worldMap.maxX || x + width < PlayState.worldMap.minX || y > PlayState.worldMap.maxY || y + height < PlayState.worldMap.minY)
         {
            kill();
         }
      }
      
      public function triggerAi(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               triggerAi1();
               break;
            case 2:
               triggerAi2();
               break;
            case 3:
               triggerAi3();
               break;
            case 4:
               triggerAi4();
			   break;
         }
      }
      
      public function triggerAi1() : void
      {
      }
      
      public function triggerAi2() : void
      {
      }
      
      public function triggerAi3() : void
      {
      }
      
      public function triggerAi4() : void
      {
      }
   }
}

