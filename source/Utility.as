package
{
   import org.flixel.*;
   
   public class Utility
   {
      public function Utility()
      {
         super();
      }
      
      public static function dist(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Math.sqrt((param3 - param1) * (param3 - param1) + (param4 - param2) * (param4 - param2));
      }
      
      public static function integrate(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0.1) : Number
      {
         var _loc6_:Number = Math.pow(0.1,param3);
         param1 = param1 * Math.pow(_loc6_,param4) + param2 * (1 - Math.pow(_loc6_,param4));
         if(Math.abs(param1 - param2) < param5)
         {
            param1 = param2;
         }
         return param1;
      }
      
      public static function stackTrace(param1:String = "stackTrace") : void
      {
         var _loc2_:Error = new Error();
         var _loc3_:String = _loc2_.getStackTrace();
         FlxG.log(param1 + ": " + _loc3_);
      }
      
      public static function justPressedAnyKey() : Boolean
      {
         if(FlxG.keys.justPressed("A") || FlxG.keys.justPressed("B") || FlxG.keys.justPressed("C") || FlxG.keys.justPressed("D") || FlxG.keys.justPressed("E") || FlxG.keys.justPressed("F") || FlxG.keys.justPressed("G") || FlxG.keys.justPressed("H") || FlxG.keys.justPressed("I") || FlxG.keys.justPressed("J") || FlxG.keys.justPressed("K") || FlxG.keys.justPressed("L") || FlxG.keys.justPressed("M") || FlxG.keys.justPressed("N") || FlxG.keys.justPressed("O") || FlxG.keys.justPressed("P") || FlxG.keys.justPressed("Q") || FlxG.keys.justPressed("R") || FlxG.keys.justPressed("S") || FlxG.keys.justPressed("T") || FlxG.keys.justPressed("U") || FlxG.keys.justPressed("V") || FlxG.keys.justPressed("W") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("Y") || FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("QUOTE") || FlxG.keys.justPressed("ONE") || FlxG.keys.justPressed("TWO") || FlxG.keys.justPressed("THREE") || FlxG.keys.justPressed("FOUR") || FlxG.keys.justPressed("FIVE") || FlxG.keys.justPressed("SIX") || FlxG.keys.justPressed("SEVEN") || FlxG.keys.justPressed("EIGHT") || FlxG.keys.justPressed("NINE") || FlxG.keys.justPressed("ZERO") || FlxG.keys.justPressed("MINUS") || FlxG.keys.justPressed("PLUS") || FlxG.keys.justPressed("LBRACKET") || FlxG.keys.justPressed("RBRACKET") || FlxG.keys.justPressed("SEMICOLON") || FlxG.keys.justPressed("BACKSLASH") || FlxG.keys.justPressed("SLASH") || FlxG.keys.justPressed("COMMA") || FlxG.keys.justPressed("PERIOD") || FlxG.keys.justPressed("ALT") || FlxG.keys.justPressed("CONTROL") || FlxG.keys.justPressed("SHIFT") || FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("LEFT") || FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("RIGHT"))
         {
            return true;
         }
         return false;
      }
   }
}

