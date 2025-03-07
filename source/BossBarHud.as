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
      
      override public function destroy() : void
      {
         _border = null;
         _bg = null;
         _bar = null;
         _leftSide = null;
         super.destroy();
      }
      
      public function BossBarHud() : void
      {
         super();
         _border = new FlxSprite();
         _bg = new FlxSprite();
         _bar = new FlxSprite();
         _leftSide = new FlxSprite();
         add(_border);
         add(_bar);
      }
      
      public function makeBar(param1:int) : void
      {
         _maxHp = param1;
         _pixelsPerHp = X_WIDTH / param1;
         _pxWidth = (int)(param1 / 2 * _pixelsPerHp);
         _border.y = Y_POS - 1;
         _border.x = FlxG.width / 2 - _pxWidth - 1;
         _border.createGraphic(param1 * _pixelsPerHp + 2,10,1073741823);
         _border.scrollFactor.x = _border.scrollFactor.y = 0;
         _leftSide.y = Y_POS - 1;
         _leftSide.x = FlxG.width / 2 - _pxWidth - 1;
         _leftSide.createGraphic(1,10,4294967295);
         _leftSide.scrollFactor.x = _leftSide.scrollFactor.y = 0;
         _bg.y = Y_POS;
         _bg.x = FlxG.width / 2 - _pxWidth;
         _bg.createGraphic(param1 * _pixelsPerHp,8,419430400);
         _bg.scrollFactor.x = _bg.scrollFactor.y = 0;
         _bg.scale.x = 1;
         _bar.y = Y_POS;
         _bar.x = FlxG.width / 2 - _pxWidth;
         _bar.createGraphic(param1 * _pixelsPerHp,8,4294736124);
         _bar.scrollFactor.x = _bar.scrollFactor.y = 0;
         _bar.scale.x = 0.0;
         _border.visible = true;
         _bg.visible = true;
         _bar.visible = true;
         _leftSide.visible = true;
         _shown = true;
      }
      
      public function isShown() : Boolean
      {
         return _shown;
      }
      
      public function removeBar() : void
      {
         _bar.visible = false;
         _bg.visible = false;
         _border.visible = false;
         _leftSide.visible = false;
         _shown = false;
      }
      
      public function setCurHp(param1:int) : void
      {
         _bar.x = FlxG.width / 2 - _maxHp / 2 * _pixelsPerHp * (1 + (1 - param1 / _maxHp));
         _bar.scale.x = (int)(_pxWidth * param1 / _maxHp) / _pxWidth;
         _justFlashed = 1;
         if(param1 <= 0)
         {
            removeBar();
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(--_justFlashed == 0)
         {
            _bar.unFlashColor();
         }
      }
   }
}

