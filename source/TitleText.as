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
         _targetY = param1 + Y_POS;
         if(param2)
         {
            for (var i:int = 0; i < _letters.length; i++)
            {
               _letters[i].y = _targetY;
            }
         }
      }
      
      public function TitleText(param1:Boolean = false) : void
      {
         _letters = new Array();
         _letters.push(new TitleLetter("S"));
         _letters.push(new TitleLetter("N"));
         _letters.push(new TitleLetter("A"));
         _letters.push(new TitleLetter("I"));
         _letters.push(new TitleLetter("L"));
         _letters.push(new TitleLetter("I"));
         _letters.push(new TitleLetter("A"));
         _letters.push(new TitleLetter("D"));
         for (var i:int = 0; i < _letters.length; i++)
         {
            add(_letters[i]);
            _totalWidth += _letters[i].width;
         }
         _totalWidth += SPACING * (_letters.length - 1);
         _targetX = (FlxG.width - _totalWidth) / 2;
         var _loc3_:Number = _targetX;
         for (i = 0; i < _letters.length; i++)
         {
            _letters[i].targetX = _loc3_;
            _loc3_ += _letters[i].width;
            _loc3_ += SPACING;
            _letters[i].y = Y_POS;
            if(param1)
            {
               _letters[i].x = _letters[i].targetX;
            }
         }
         setYOffset(0);
         active = true;
      }
      
      override public function update() : void
      {
         _elapsed += FlxG.elapsed * TIME_SCALE;
         for (var i:int = 0; i < _letters.length; i++)
         {
            var _loc2_:Number = _elapsed - LETTER_DELAY * i + LETTER_START;
            if(_loc2_ < LETTER_START)
            {
               _letters[i].visible = false;
            }
            else if(_loc2_ < 0)
            {
               _letters[i].visible = true;
               var _loc3_:Number = -Math.sin(-_loc2_ * Math.PI) * _loc2_ * X_SCALE;
               _letters[i].x = _letters[i].targetX + _loc3_;
            }
            else
            {
               _letters[i].x = Utility.integrate(_letters[i].x,_letters[i].targetX,4,FlxG.elapsed);
            }
            _letters[i].y = Utility.integrate(_letters[i].y,_targetY,4,FlxG.elapsed);
         }
         super.update();
      }
   }
}

