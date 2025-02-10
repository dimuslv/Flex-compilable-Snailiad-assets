package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class Item extends FlxSprite
   {
      private static const DISAPPEAR_TIME:Number = 15000;
      
      private static const FLICKER_TIME:Number = 5000;
      
      private var _disappearTime:Number = 0;
      
      private var _flickerTime:Number = 0;
      
      private var _willThisDisappear:Boolean = false;
      
      public function Item(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         x = param1;
         y = param2;
         if(param3)
         {
            this._disappearTime = DISAPPEAR_TIME;
            this._flickerTime = FLICKER_TIME;
            this._willThisDisappear = true;
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
         if(this._willThisDisappear)
         {
            this._disappearTime -= FlxG.elapsed;
            this._flickerTime -= FlxG.elapsed;
            if(this._disappearTime <= 0)
            {
               kill();
            }
            else if(this._flickerTime <= 0)
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
               this.triggerAi1();
               break;
            case 2:
               this.triggerAi2();
               break;
            case 3:
               this.triggerAi3();
               break;
            case 4:
               this.triggerAi4();
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

