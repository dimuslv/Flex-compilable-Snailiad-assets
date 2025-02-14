package
{
   import org.flixel.*;
   
   public class IntroBg extends FlxGroup
   {
      private static const FADE_SPEED:Number = 0.8;
      
      private var _bg:FlxSprite;
      
      private var _fade:Number = 0;
      
      private var _fadingIn:Boolean = false;
      
      private var _fadingOut:Boolean = false;
      
      private var _spirals:Array;
      
      public function IntroBg()
      {
         var _loc3_:int = 0;
         super();
         this._bg = new FlxSprite();
         this._bg.scrollFactor.x = this._bg.scrollFactor.y = 0;
         this._bg.createGraphic(FlxG.width,FlxG.height,4278202416);
         this._bg.alpha = 0;
         add(this._bg);
         this.fadeIn();
         this._spirals = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc3_ = 0;
            while(_loc3_ < 6)
            {
               this._spirals.push(new IntroSpiral(82 * _loc3_ + _loc1_ % 2 * 41,56 * _loc1_));
               _loc3_++;
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._spirals.length)
         {
            this._spirals[_loc2_].alpha = this._bg.alpha / 7;
            add(this._spirals[_loc2_]);
            _loc2_++;
         }
      }
      
      override public function destroy() : void
      {
         this._bg = null;
         this._spirals = null;
         super.destroy();
      }
      
      public function isFadingIn() : Boolean
      {
         return this._fadingIn;
      }
      
      public function fadeIn() : void
      {
         this._fadingIn = true;
         this._fade = 0;
      }
      
      public function fadeOut() : void
      {
         this._fadingOut = true;
         this._fade = 1;
      }
      
      override public function update() : void
      {
         if(this._fadingOut)
         {
            this._fade -= FlxG.elapsed * FADE_SPEED;
            if(this._fade < 0)
            {
               this._fade = 0;
               this._fadingOut = false;
            }
            this._bg.alpha = this._fade;
         }
         else if(this._fadingIn)
         {
            this._fade += FlxG.elapsed * FADE_SPEED;
            if(this._fade >= 1)
            {
               this._fade = 1;
               this._fadingIn = false;
            }
            this._bg.alpha = this._fade;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this._spirals.length)
         {
            this._spirals[_loc1_].alpha = this._bg.alpha / 7;
            _loc1_++;
         }
         super.update();
      }
   }
}

