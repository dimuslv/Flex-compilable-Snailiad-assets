package
{
   import org.flixel.*;
   
   public class DamageNumber extends FlxText
   {
      private static const DEFAULT_LIFETIME:Number = 1;
      
      private var _lifetime:Number = 0;
      
      private var _originX:Number = 0;
      
      private var _originY:Number = 0;
      
      private var _elapsed:Number = 0;
      
      public function DamageNumber() : void
      {
         super(0,FlxG.height - 54,FlxG.width - 7);
         font = Fonts.normal;
         size = 10;
         color = 16777215;
         outlineColor = 4278190080;
         outline = true;
         visible = false;
         dead = true;
         exists = false;
         active = false;
      }
      
      public function makeText(param1:int, param2:int, param3:String, param4:int) : void
      {
         size = param4 * 10;
         text = param3;
         _originX = param1;
         _originY = param2;
         velocity.y = 0;
         _lifetime = DEFAULT_LIFETIME;
         updatePosition();
         _elapsed = 0;
         visible = true;
         exists = true;
         dead = false;
         active = true;
      }
      
      public function updatePosition() : void
      {
         x = _originX;
         var _loc1_:Number = _elapsed * 6 - 2;
         y = _originY + _loc1_ * _loc1_ * 10 - 10;
         if(y > _originY)
         {
            y = _originY;
         }
      }
      
      override public function update() : void
      {
         if(!dead)
         {
            _elapsed += FlxG.elapsed;
            updatePosition();
            _lifetime -= FlxG.elapsed;
            if(_lifetime <= 0)
            {
               kill();
            }
         }
         super.update();
      }
   }
}

