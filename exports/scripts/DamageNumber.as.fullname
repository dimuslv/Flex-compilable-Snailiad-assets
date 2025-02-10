package
{
   import org.flixel.FlxG;
   import org.flixel.FlxText;
   
   public class DamageNumber extends FlxText
   {
      private static const DEFAULT_LIFETIME:Number = 1;
      
      private var _lifetime:Number = 0;
      
      private var _originX:Number = 0;
      
      private var _originY:Number = 0;
      
      private var _elapsed:Number = 0;
      
      public function DamageNumber()
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
         this._originX = param1;
         this._originY = param2;
         velocity.y = 0;
         this._lifetime = DEFAULT_LIFETIME;
         this.updatePosition();
         this._elapsed = 0;
         visible = true;
         exists = true;
         dead = false;
         active = true;
      }
      
      public function updatePosition() : void
      {
         x = this._originX;
         var _loc1_:Number = this._elapsed * 6 - 2;
         y = this._originY + _loc1_ * _loc1_ * 10 - 10;
         if(y > this._originY)
         {
            y = this._originY;
         }
      }
      
      override public function update() : void
      {
         if(!dead)
         {
            this._elapsed += FlxG.elapsed;
            this.updatePosition();
            this._lifetime -= FlxG.elapsed;
            if(this._lifetime <= 0)
            {
               kill();
            }
         }
         super.update();
      }
   }
}

