package
{
   import org.flixel.*;
   
   public class TitleText extends FlxGroup
   {
      private static const Y_POS:int = 15;
      
      private static const SPACING:int = 4;
      
      private static const LETTER_DELAY:Number = Math.PI / 11;
      
      private static const LETTER_START:Number = -2.5;
      
      private static const TIME_SCALE:Number = 0.8;
      
      private static const X_SCALE:Number = 80;
      
      private var _letters:Array;
      
      private var _totalWidth:int = 0;
      
      private var _targetX:int = 0;
      
      private var _elapsed:Number = 0;
      
      private var _targetY:Number = 0;
      
      override public function destroy() : void
      {
         _letters = null;
         super.destroy();
      }
      
      public function setYOffset(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         _targetY = param1 + Y_POS;
         if(param2)
         {
            _loc3_ = 0;
            while(_loc3_ < this._letters.length)
            {
               this._letters[_loc3_].y = this._targetY;
               _loc3_++;
            }
         }
      }
      
      public function TitleText(param1:Boolean = false) : void
      {
         this._letters = new Array();
         this._letters.push(new TitleLetter("S"));
         this._letters.push(new TitleLetter("N"));
         this._letters.push(new TitleLetter("A"));
         this._letters.push(new TitleLetter("I"));
         this._letters.push(new TitleLetter("L"));
         this._letters.push(new TitleLetter("I"));
         this._letters.push(new TitleLetter("A"));
         this._letters.push(new TitleLetter("D"));
         var _loc2_:int = 0;
         while(_loc2_ < this._letters.length)
         {
            add(this._letters[_loc2_]);
            this._totalWidth += this._letters[_loc2_].width;
            _loc2_++;
         }
         this._totalWidth += SPACING * (this._letters.length - 1);
         this._targetX = (FlxG.width - this._totalWidth) / 2;
         var _loc3_:Number = this._targetX;
         _loc2_ = 0;
         while(_loc2_ < this._letters.length)
         {
            this._letters[_loc2_].targetX = _loc3_;
            _loc3_ += this._letters[_loc2_].width;
            _loc3_ += SPACING;
            this._letters[_loc2_].y = Y_POS;
            if(param1)
            {
               this._letters[_loc2_].x = this._letters[_loc2_].targetX;
            }
            _loc2_++;
         }
         this.setYOffset(0);
         active = true;
      }
      
      override public function update() : void
      {
         _elapsed += FlxG.elapsed * TIME_SCALE;
         var _loc1_:int = 0;
         while(_loc1_ < this._letters.length)
         {
            var _loc2_:Number = this._elapsed - LETTER_DELAY * _loc1_ + LETTER_START;
            if(_loc2_ < LETTER_START)
            {
               this._letters[_loc1_].visible = false;
            }
            else if(_loc2_ < 0)
            {
               this._letters[_loc1_].visible = true;
               var _loc3_:Number = -Math.sin(-_loc2_ * Math.PI) * _loc2_ * X_SCALE;
               this._letters[_loc1_].x = this._letters[_loc1_].targetX + _loc3_;
            }
            else
            {
               this._letters[_loc1_].x = Utility.integrate(this._letters[_loc1_].x,this._letters[_loc1_].targetX,4,FlxG.elapsed);
            }
            this._letters[_loc1_].y = Utility.integrate(this._letters[_loc1_].y,this._targetY,4,FlxG.elapsed);
            _loc1_++;
         }
         super.update();
      }
   }
}

