package
{
   import org.flixel.*;
   
   public class BossBarHud extends FlxGroup
   {
      private var _border:FlxSprite;
      
      private var _bg:FlxSprite;
      
      private var _bar:FlxSprite;
      
      private var _leftSide:FlxSprite;
      
      private var _justFlashed:int = 0;
      
      private const Y_POS:int = 5;
      
      private const X_WIDTH:int = 250;
      
      private var _maxHp:int = 0;
      
      private var _pxWidth:int = 0;
      
      private var _pixelsPerHp:Number = 0;
      
      private var _shown:Boolean = false;
      
      public function BossBarHud() : void
      {
         super();
         this._border = new FlxSprite();
         this._bg = new FlxSprite();
         this._bar = new FlxSprite();
         this._leftSide = new FlxSprite();
         add(this._border);
         add(this._bar);
      }
      
      override public function destroy() : void
      {
         _border = null;
         _bg = null;
         _bar = null;
         _leftSide = null;
         super.destroy();
      }
      
      public function makeBar(param1:int) : void
      {
         _maxHp = param1;
         _pixelsPerHp = this.X_WIDTH / param1;
         _pxWidth = (int)(param1 / 2 * this._pixelsPerHp);
         this._border.y = this.Y_POS - 1;
         this._border.x = FlxG.width / 2 - this._pxWidth - 1;
         this._border.createGraphic(param1 * this._pixelsPerHp + 2,10,1073741823);
         this._border.scrollFactor.x = this._border.scrollFactor.y = 0;
         this._leftSide.y = this.Y_POS - 1;
         this._leftSide.x = FlxG.width / 2 - this._pxWidth - 1;
         this._leftSide.createGraphic(1,10,4294967295);
         this._leftSide.scrollFactor.x = this._leftSide.scrollFactor.y = 0;
         this._bg.y = this.Y_POS;
         this._bg.x = FlxG.width / 2 - this._pxWidth;
         this._bg.createGraphic(param1 * this._pixelsPerHp,8,419430400);
         this._bg.scrollFactor.x = this._bg.scrollFactor.y = 0;
         this._bg.scale.x = 1;
         this._bar.y = this.Y_POS;
         this._bar.x = FlxG.width / 2 - this._pxWidth;
         this._bar.createGraphic(param1 * this._pixelsPerHp,8,4294736124);
         this._bar.scrollFactor.x = this._bar.scrollFactor.y = 0;
         this._bar.scale.x = 0.0;
         this._border.visible = true;
         this._bg.visible = true;
         this._bar.visible = true;
         this._leftSide.visible = true;
         _shown = true;
      }
      
      public function isShown() : Boolean
      {
         return this._shown;
      }
      
      public function removeBar() : void
      {
         this._bar.visible = false;
         this._bg.visible = false;
         this._border.visible = false;
         this._leftSide.visible = false;
         _shown = false;
      }
      
      public function setCurHp(param1:int) : void
      {
         this._bar.x = FlxG.width / 2 - this._maxHp / 2 * this._pixelsPerHp * (1 + (1 - param1 / this._maxHp));
         this._bar.scale.x = (int)(this._pxWidth * param1 / this._maxHp) / this._pxWidth;
         _justFlashed = 1;
         if(param1 <= 0)
         {
            this.removeBar();
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(--this._justFlashed == 0)
         {
            this._bar.unFlashColor();
         }
      }
   }
}

