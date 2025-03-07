package
{
   import org.flixel.*;
   
   public class Intro extends FlxGroup
   {
      private static const MODE_NONE:int = 0;
      
      private static const MODE_WAIT_START:int = 1;
      
      private static const MODE_STORY:int = 2;
      
      private static const MODE_END:int = 3;
      
      private var _bg:IntroBg;
      
      private var _pictureLayer:FlxGroup;
      
      private var _elapsed:Number = 0;
      
      private var _picture:IntroPicture;
      
      private var _picture2:IntroPicture;
      
      private var _picture3:IntroPicture;
      
      private var _skipText:FlxText;
      
      private var _mode:int = 0;
      
      private var _modeElapsed:Number = 0;
      
      private var _modeInitialized:Boolean = false;
      
      private var _dialogueMode:Number = 0;
      
      private var _targetAlpha:Array;
      
      private var _dialogueLayer:IntroDialogue;
      
      override public function destroy() : void
      {
         _bg = null;
         _picture = null;
         _picture2 = null;
         _picture3 = null;
         _pictureLayer = null;
         _targetAlpha = null;
         _dialogueLayer = null;
         _skipText = null;
         super.destroy();
      }
      
      public function Intro() : void
      {
         FlxG.noPause = true;
         FlxG.mouse.hide();
         setMode(MODE_WAIT_START);
         _bg = new IntroBg();
         add(_bg);
         _dialogueLayer = new IntroDialogue();
         add(_dialogueLayer);
         var _loc1_:FlxText = new FlxText(0,-1,FlxG.width - 2);
         _loc1_.font = Fonts.normal;
         _loc1_.size = 10;
         _loc1_.color = 16579836;
         _loc1_.shadow = 1;
         _loc1_.alignment = "right";
         _loc1_.scrollFactor.x = _loc1_.scrollFactor.y = 0;
         _loc1_.text = "ESC TO SKIP";
         _loc1_.alpha = 0;
         _skipText = _loc1_;
         add(_skipText);
         Music.playTitle();
      }
      
      public function setMode(param1:int) : void
      {
         _mode = param1;
         _modeElapsed = 0;
         _modeInitialized = false;
      }
      
      public function updateIntroWaitStart() : void
      {
         if(!_bg.isFadingIn())
         {
            setMode(MODE_STORY);
         }
      }
      
      public function updateIntroStory() : void
      {
         var _loc1_:String = null;
         if(!_modeInitialized)
         {
            _modeInitialized = true;
            _dialogueMode = 0;
            _picture = new IntroPicture(1);
            add(_picture);
         }
         switch(_dialogueMode)
         {
            case 0:
               _skipText.alpha = _picture.alpha;
               if(_picture.alpha > 0.7)
               {
                  ++_dialogueMode;
                  _modeElapsed = 0;
                  _dialogueLayer.start("  ALL WAS PEACEFUL IN SNAIL TOWN...\n");
               }
               break;
            case 1:
               _skipText.alpha = _picture.alpha;
               if(_modeElapsed >= 5.4)
               {
                  ++_dialogueMode;
                  _picture.fadeOut();
               }
               break;
            case 2:
               if(_picture.alpha == 0)
               {
                  ++_dialogueMode;
                  remove(_picture);
                  _picture = new IntroPicture(2);
                  add(_picture);
               }
               break;
            case 3:
               if(_picture.alpha >= 0.1)
               {
                  ++_dialogueMode;
                  _modeElapsed = 0;
                  _dialogueLayer.start(" UNTIL ONE DAY...\n" + "     MOON SNAIL LEFT ON A JOURNEY");
               }
               break;
            case 4:
               if(_modeElapsed >= 6)
               {
                  ++_dialogueMode;
                  _picture.fadeOut();
               }
               break;
            case 5:
               if(_picture.alpha == 0)
               {
                  ++_dialogueMode;
                  remove(_picture);
                  _picture = new IntroPicture(1);
                  add(_picture);
               }
               break;
            case 6:
               if(_picture.alpha > 0.1)
               {
                  ++_dialogueMode;
                  _modeElapsed = 0;
                  _dialogueLayer.start(" SOON AFTER...\n" + "     THE SNAILS BEGAN TO DISAPPEAR\n" + "                   ONE BY ONE");
               }
               break;
            case 7:
               if(_modeElapsed >= 3)
               {
                  ++_dialogueMode;
                  _picture2 = new IntroPicture(3);
                  add(_picture2);
               }
               break;
            case 8:
               if(_modeElapsed >= 5.5)
               {
                  ++_dialogueMode;
                  _picture3 = new IntroPicture(4);
                  add(_picture3);
               }
               break;
            case 9:
               if(_modeElapsed >= 8.5)
               {
                  ++_dialogueMode;
                  _modeElapsed = 0;
                  _dialogueLayer.start("WILL ANYONE HELP?  CAN ANYONE\n" + "        RESCUE THE MISSING SNAILS??\n");
               }
               break;
            case 10:
               if(_modeElapsed >= 6.5)
               {
                  ++_dialogueMode;
                  remove(_picture);
                  remove(_picture2);
                  _picture3.fadeOut();
               }
               break;
            case 11:
               if(_picture3.alpha == 0)
               {
                  ++_dialogueMode;
                  remove(_picture3);
                  _picture = new IntroPicture(5);
                  add(_picture);
               }
               break;
            case 12:
               if(_picture.alpha > 0.1)
               {
                  ++_dialogueMode;
                  _modeElapsed = 0;
                  _loc1_ = PlayState.introSlugMode ? "SLUGGY SLUG" : "SNAILY SNAIL";
                  _dialogueLayer.start("YOU CAN DO IT, " + _loc1_ + "!!\n" + "        IT\'S UP TO YOU!!  GOOD LUCK!!\n");
               }
               break;
            case 13:
               if(_modeElapsed >= 7.6)
               {
                  setMode(MODE_END);
               }
			   break;
         }
         if(FlxG.keys.pressed("ESCAPE"))
         {
            setMode(MODE_END);
         }
      }
      
      public function updateIntroEnd() : void
      {
         if(!_modeInitialized)
         {
            FlxG.noPause = false;
            _modeInitialized = true;
            FlxG.fade.start(4278206591,1,PlayState.loadGame);
            FlxG.music.fadeOut(1);
         }
      }
      
      override public function update() : void
      {
         _modeElapsed += FlxG.elapsed;
         switch(_mode)
         {
            case MODE_NONE:
               setMode(MODE_WAIT_START);
               break;
            case MODE_WAIT_START:
               updateIntroWaitStart();
               break;
            case MODE_STORY:
               updateIntroStory();
               break;
            case MODE_END:
               updateIntroEnd();
			   break;
         }
         super.update();
      }
   }
}

