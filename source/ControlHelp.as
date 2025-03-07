package
{
   import org.flixel.*;
   
   public class ControlHelp extends FlxGroup
   {
      private static const IMG_WIDTH:int = 336;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_LETTER_WIDTH:int = 16;
      
      private static const IMG_LETTER_HEIGHT:int = 16;
      
      private static const SCROLL_RATE:Number = 2.5;
      
      private static const TEXTPOS_BASE:int = 0;
      
      private static const TEXTPOS_SPACING:int = 16;
      
      private static const TEXT_JUMP1:int = 0;
      
      private static const TEXT_SHOOT1:int = 1;
      
      private static const TEXT_UP1:int = 2;
      
      private static const TEXT_DOWN1:int = 3;
      
      private static const TEXT_LEFT1:int = 4;
      
      private static const TEXT_RIGHT1:int = 5;
      
      private static const TEXT_UP2:int = 6;
      
      private static const TEXT_DOWN2:int = 7;
      
      private static const TEXT_LEFT2:int = 8;
      
      private static const TEXT_RIGHT2:int = 9;
      
      private static const TEXT_JUMP2:int = 10;
      
      private static const TEXT_SHOOT2:int = 11;
      
      public var bg:FlxSprite;
      
      public var letters:Array;
      
      public var textX:Array;
      
      public var textY:Array;
      
      public var targetX:int = -IMG_WIDTH;
      
      public var targetXv:Number = 0;
      
      public var xv:Number = 0;
      
      public var hideTimer:Number = 0;
      
      public var animTimer:Number = 0;
      
      public var menuHelp:Boolean = false;
      
      public function updateLetterGraphics() : void
      {
         letters[TEXT_JUMP1].play(Player.JUMP_KEY);
         letters[TEXT_UP1].play(Player.UP_KEY);
         letters[TEXT_DOWN1].play(Player.DOWN_KEY);
         letters[TEXT_LEFT1].play(Player.LEFT_KEY);
         letters[TEXT_RIGHT1].play(Player.RIGHT_KEY);
         letters[TEXT_UP2].play(Player.ALT_UP_KEY);
         letters[TEXT_DOWN2].play(Player.ALT_DOWN_KEY);
         letters[TEXT_LEFT2].play(Player.ALT_LEFT_KEY);
         letters[TEXT_RIGHT2].play(Player.ALT_RIGHT_KEY);
         letters[TEXT_JUMP2].play(Player.ALT_JUMP_KEY);
         letters[TEXT_SHOOT1].play(Player.SHOOT_KEY);
         letters[TEXT_SHOOT2].play(Player.ALT_SHOOT_KEY);
         if(PlayState.player && PlayState.player.hasAnyWeapon())
         {
            letters[TEXT_SHOOT1].visible = true;
            letters[TEXT_SHOOT2].visible = true;
         }
         else
         {
            letters[TEXT_SHOOT1].visible = false;
            letters[TEXT_SHOOT2].visible = false;
         }
      }
      
      public function ControlHelp(param1:Boolean = false) : void
      {
         bg = new FlxSprite();
         bg.loadGraphic(Art.ControlHelpBg,false,false,IMG_WIDTH,IMG_HEIGHT);
         bg.width = IMG_WIDTH;
         bg.height = IMG_HEIGHT;
         bg.x = -IMG_WIDTH;
         bg.y = 200;
         bg.scrollFactor.x = bg.scrollFactor.y = 0;
         bg.addAnimation("nogun",[0]);
         bg.addAnimation("gun",[1]);
         bg.x = -500;
         targetX = x;
         bg.play("nogun");
         bg.visible = true;
         add(bg);
         createAndAddAllLetters();
      }
      
      public function updateLetterPositions() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < letters.length)
         {
            letters[_loc1_].x = textX[_loc1_] + bg.x;
            _loc1_++;
         }
      }
      
      private function createAndAddSingleLetter(param1:int, param2:int, param3:int) : void
      {
         textX[param1] = param2 * TEXTPOS_SPACING + TEXTPOS_BASE;
         textY[param1] = param3 * TEXTPOS_SPACING + TEXTPOS_BASE;
         var _loc4_:FlxSprite = new FlxSprite();
         _loc4_.loadGraphic(Art.ControlHelpLetters,false,false,IMG_LETTER_WIDTH,IMG_LETTER_HEIGHT);
         _loc4_.width = IMG_WIDTH;
         _loc4_.height = IMG_HEIGHT;
         _loc4_.x = -900;
         _loc4_.y = bg.y + textY[param1];
         _loc4_.addAnimation("A",[0]);
         _loc4_.addAnimation("B",[1]);
         _loc4_.addAnimation("C",[2]);
         _loc4_.addAnimation("D",[3]);
         _loc4_.addAnimation("E",[4]);
         _loc4_.addAnimation("F",[5]);
         _loc4_.addAnimation("G",[6]);
         _loc4_.addAnimation("H",[7]);
         _loc4_.addAnimation("I",[8]);
         _loc4_.addAnimation("J",[9]);
         _loc4_.addAnimation("K",[10]);
         _loc4_.addAnimation("L",[11]);
         _loc4_.addAnimation("M",[12]);
         _loc4_.addAnimation("N",[13]);
         _loc4_.addAnimation("O",[14]);
         _loc4_.addAnimation("P",[15]);
         _loc4_.addAnimation("Q",[16]);
         _loc4_.addAnimation("R",[17]);
         _loc4_.addAnimation("S",[18]);
         _loc4_.addAnimation("T",[19]);
         _loc4_.addAnimation("U",[20]);
         _loc4_.addAnimation("V",[21]);
         _loc4_.addAnimation("W",[22]);
         _loc4_.addAnimation("X",[23]);
         _loc4_.addAnimation("Y",[24]);
         _loc4_.addAnimation("Z",[25]);
         _loc4_.addAnimation("QUOTE",[26]);
         _loc4_.addAnimation("ONE",[27]);
         _loc4_.addAnimation("TWO",[28]);
         _loc4_.addAnimation("THREE",[29]);
         _loc4_.addAnimation("FOUR",[30]);
         _loc4_.addAnimation("FIVE",[31]);
         _loc4_.addAnimation("SIX",[32]);
         _loc4_.addAnimation("SEVEN",[33]);
         _loc4_.addAnimation("EIGHT",[34]);
         _loc4_.addAnimation("NINE",[35]);
         _loc4_.addAnimation("ZERO",[36]);
         _loc4_.addAnimation("MINUS",[37]);
         _loc4_.addAnimation("PLUS",[38]);
         _loc4_.addAnimation("LBRACKET",[39]);
         _loc4_.addAnimation("RBRACKET",[40]);
         _loc4_.addAnimation("SEMICOLON",[41]);
         _loc4_.addAnimation("BACKSLASH",[43]);
         _loc4_.addAnimation("SLASH",[44]);
         _loc4_.addAnimation("COMMA",[45]);
         _loc4_.addAnimation("PERIOD",[46]);
         _loc4_.addAnimation("COLON",[48]);
         _loc4_.addAnimation("ALT",[49]);
         _loc4_.addAnimation("CONTROL",[50]);
         _loc4_.addAnimation("SHIFT",[51]);
         _loc4_.addAnimation("ENTER",[52]);
         _loc4_.addAnimation("UP",[53]);
         _loc4_.addAnimation("LEFT",[54]);
         _loc4_.addAnimation("DOWN",[55]);
         _loc4_.addAnimation("RIGHT",[56]);
         _loc4_.addAnimation("SPACE",[57]);
         _loc4_.scrollFactor.x = _loc4_.scrollFactor.y = 0;
         _loc4_.visible = true;
         add(_loc4_);
         letters[param1] = _loc4_;
      }
      
      private function createAndAddAllLetters() : void
      {
         letters = new Array();
         textX = new Array();
         textY = new Array();
         createAndAddSingleLetter(TEXT_JUMP1,0,1);
         createAndAddSingleLetter(TEXT_SHOOT1,1,1);
         createAndAddSingleLetter(TEXT_UP1,5,0);
         createAndAddSingleLetter(TEXT_LEFT1,4,1);
         createAndAddSingleLetter(TEXT_DOWN1,5,1);
         createAndAddSingleLetter(TEXT_RIGHT1,6,1);
         createAndAddSingleLetter(TEXT_UP2,14,0);
         createAndAddSingleLetter(TEXT_LEFT2,13,1);
         createAndAddSingleLetter(TEXT_DOWN2,14,1);
         createAndAddSingleLetter(TEXT_RIGHT2,15,1);
         createAndAddSingleLetter(TEXT_SHOOT2,17,1);
         createAndAddSingleLetter(TEXT_JUMP2,18,1);
         updateLetterPositions();
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < letters.length())
         {
            letters[_loc1_] = null;
            _loc1_++;
         }
         letters = null;
         textX = null;
         textY = null;
         super.destroy();
      }
      
      public function toggle() : void
      {
         if(hideTimer > 0)
         {
            hide();
         }
         else
         {
            show();
         }
      }
      
      public function show(param1:Boolean = false) : void
      {
         if(PlayState.player && PlayState.player.hasAnyWeapon() || param1)
         {
            bg.play("gun");
         }
         else
         {
            bg.play("nogun");
         }
         if(bg.x > FlxG.width)
         {
            bg.x = -bg.width;
         }
         targetX = FlxG.width / 2 - bg.width / 2;
         xv = 0;
         updateLetterGraphics();
         hideTimer = 11;
      }
      
      public function hide() : void
      {
         if(bg.x > bg.width + 1)
         {
            targetX = FlxG.width + 300;
         }
         else
         {
            targetX = -bg.width;
         }
         hideTimer = -1;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME && !menuHelp)
         {
            return;
         }
         hideTimer -= FlxG.elapsed;
         if(hideTimer <= 0)
         {
            hide();
         }
         updateLetterPositions();
         targetXv = (targetX - bg.x) * FlxG.elapsed * 4;
         if(targetXv > 10)
         {
            targetXv = 10;
         }
         xv = (xv * 81 + targetXv * 19) / 100;
         if(xv < 0.05 && xv > -0.05)
         {
            xv = 0;
         }
         bg.x += xv;
      }
   }
}

