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
      
      public function HeartHud()
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super();
         this._hearts = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < HEARTS_MAX)
         {
            _loc2_ = POS_X + _loc1_ % HEARTS_PER_ROW * HEART_WIDTH;
            _loc3_ = POS_Y + int(_loc1_ / HEARTS_PER_ROW) * HEART_HEIGHT;
            this._hearts[_loc1_] = new HeartHudSingle(_loc2_,_loc3_);
            add(this._hearts[_loc1_]);
            _loc1_++;
         }
         this.setMaxHp(6);
         this.setCurHp(6);
      }
      
      override public function destroy() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this._hearts)
         {
            this._hearts[_loc1_] = null;
         }
         this._hearts = null;
         super.destroy();
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
            this._hearts[_loc4_].visible = _loc4_ < _loc3_ / 4;
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
               this._hearts[_loc4_].play((_loc3_ % 4).toString());
            }
            else
            {
               this._hearts[_loc4_].play(_loc4_ < _loc3_ / 4 ? "full" : "empty");
            }
            _loc4_++;
         }
         if(_loc3_ <= 0)
         {
            this._hearts[0].play("empty");
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

