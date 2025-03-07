package
{
   import org.flixel.*;
   
   public class HeartHud extends FlxGroup
   {
      private static const POS_X:int = 4;
      
      private static const POS_Y:int = 4;
      
      private static const HEARTS_MAX:int = 14;
      
      private static const HEARTS_PER_ROW:int = 7;
      
      private static const HEART_WIDTH:int = 8;
      
      private static const HEART_HEIGHT:int = 8;
      
      private var _hideOfs:Number;
      
      private var _hideOfsTarget:Number;
      
      private var _hearts:Array;
      
      override public function destroy() : void
      {
         for(var _loc1_:String in _hearts)
         {
            _hearts[_loc1_] = null;
         }
         _hearts = null;
         super.destroy();
      }
      
      public function HeartHud() : void
      {
         _hearts = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < HEARTS_MAX)
         {
            var _loc2_:int = POS_X + _loc1_ % HEARTS_PER_ROW * HEART_WIDTH;
            var _loc3_:int = POS_Y + (int)(_loc1_ / HEARTS_PER_ROW) * HEART_HEIGHT;
            _hearts[_loc1_] = new HeartHudSingle(_loc2_,_loc3_);
            add(_hearts[_loc1_]);
            _loc1_++;
         }
         setMaxHp(6);
         setCurHp(6);
      }
      
      public function setMaxHp(param1:int, param2:Player = null) : void
      {
         var _loc3_:int = param1;
         if(PlayState.player)
         {
            _loc3_ *= 4;
            _loc3_ /= PlayState.player.hpPerHeart();
         }
         else if(param2)
         {
            _loc3_ *= 4;
            _loc3_ /= param2.hpPerHeart();
         }
         var _loc4_:int = 0;
         while(_loc4_ < HEARTS_MAX)
         {
            _hearts[_loc4_].visible = _loc4_ < _loc3_ / 4;
            _loc4_++;
         }
      }
      
      public function setCurHp(param1:int, param2:Player = null) : void
      {
         var _loc3_:int = param1;
         if(PlayState.player)
         {
            _loc3_ *= 4;
            _loc3_ /= PlayState.player.hpPerHeart();
         }
         else if(param2)
         {
            _loc3_ *= 4;
            _loc3_ /= param2.hpPerHeart();
         }
         var _loc4_:int = 0;
         while(_loc4_ < HEARTS_MAX)
         {
            if(int(_loc3_ / 4) == _loc4_)
            {
               _hearts[_loc4_].play((_loc3_ % 4).toString());
            }
            else
            {
               _hearts[_loc4_].play(_loc4_ < _loc3_ / 4 ? "full" : "empty");
            }
            _loc4_++;
         }
         if(_loc3_ <= 0)
         {
            _hearts[0].play("empty");
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
      }
   }
}

