package
{
   import org.flixel.*;
   
   public class EndingCredits extends FlxGroup
   {
      private static const VELOCITY_Y:Number = -33;
      
      private static const SPACING_Y_MINOR:Number = 2;
      
      private static const SPACING_Y_MAJOR:Number = 32;
      
      private var createY:Number = FlxG.height + 4;
      
      private var _theEnd:FlxObject;
      
      public var scrollDone:Boolean = false;
      
      override public function destroy() : void
      {
         _theEnd = null;
         super.destroy();
      }
      
      public function EndingCredits() : void
      {
         addEnemy(0,EndingEnemy.TYPE_NONE,"CREDITS");
         createY += 40;
         addEnemy(-30,EndingEnemy.TYPE_SPIKEY,"");
         addEnemy(30,EndingEnemy.TYPE_SPIKEY2,"SPIKEY");
         addEnemy(-25,EndingEnemy.TYPE_BABYFISH,"");
         addEnemy(25,EndingEnemy.TYPE_BABYFISH2,"BABYFISH");
         addEnemy(-13,EndingEnemy.TYPE_FLOATSPIKE,"");
         addEnemy(13,EndingEnemy.TYPE_FLOATSPIKE2,"FLOATSPIKE");
         addEnemy(-30,EndingEnemy.TYPE_BLOB1,"");
         addEnemy(-10,EndingEnemy.TYPE_BLOB2,"");
         addEnemy(10,EndingEnemy.TYPE_BLOB3,"");
         addEnemy(30,EndingEnemy.TYPE_BLOB4,"BLOB, BLUB, ANGELBLOB, AND DEVILBLOB");
         addEnemy(-14,EndingEnemy.TYPE_CHIRPY,"");
         addEnemy(14,EndingEnemy.TYPE_CHIRPY2,"CHIRPY");
         addEnemy(0,EndingEnemy.TYPE_BATTY_BAT,"BATTY BAT");
         addEnemy(-12,EndingEnemy.TYPE_FIREBALL,"");
         addEnemy(12,EndingEnemy.TYPE_ICEBALL,"FIREBALL AND ICEBALL");
         addEnemy(0,EndingEnemy.TYPE_SECRET_SNELK,"SECRET SNELK");
         addEnemy(0,EndingEnemy.TYPE_KITTY,"KITTY!!");
         addEnemy(0,EndingEnemy.TYPE_DANDELION,"GHOST DANDELION");
         addEnemy(-30,EndingEnemy.TYPE_CANNON,"");
         addEnemy(-30,EndingEnemy.TYPE_CANNON_HUB,"");
         addEnemy(30,EndingEnemy.TYPE_CANNON2,"");
         addEnemy(30,EndingEnemy.TYPE_CANNON2_HUB,"");
         createY += 30;
         addEnemy(0,EndingEnemy.TYPE_NONE,"CANON AND NON-CANON");
         addEnemy(-20,EndingEnemy.TYPE_SNAKEY,"");
         addEnemy(20,EndingEnemy.TYPE_BLUE_SNAKEY,"SNAKEY");
         addEnemy(0,EndingEnemy.TYPE_SKY_SNAKE,"SKY VIPER");
         addEnemy(0,EndingEnemy.TYPE_SPIDER,"SPIDER");
         addEnemy(0,EndingEnemy.TYPE_SPIDER_MAMA,"SPIDER MAMA");
         addEnemy(0,EndingEnemy.TYPE_GRAVITY_TURTLE,"GRAVITY TURTLE");
         addEnemy(0,EndingEnemy.TYPE_CHERRY_TURTLE,"GRAVITY TURTLE (CHERRY RED FINISH)");
         addEnemy(0,EndingEnemy.TYPE_JELLYFISH,"JELLYFISH");
         addEnemy(0,EndingEnemy.TYPE_SEAHORSE,"SYNGNATHIDA");
         addEnemy(-26,EndingEnemy.TYPE_TALLFISH,"");
         addEnemy(26,EndingEnemy.TYPE_TALLFISH2,"TALLFISH AND ANGRY TALLFISH");
         addEnemy(0,EndingEnemy.TYPE_WALLEYE,"WALLEYE");
         addEnemy(-17,EndingEnemy.TYPE_PINCER,"");
         addEnemy(17,EndingEnemy.TYPE_SKY_PINCER,"PINCER AND SKY PINCER");
         addEnemy(0,EndingEnemy.TYPE_GEAR,"SPINNYGEAR");
         addEnemy(0,EndingEnemy.TYPE_FEDERATION_DRONE,"FEDERATION DRONE");
         addEnemy(0,EndingEnemy.TYPE_BALLOON,"BALLOON BUSTER");
         createY += 30;
         createY += 30;
         addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER,"");
         addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND1,"");
         addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND2,"");
         addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND3,"");
         addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND4,"");
         addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND5,"");
         addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND6,"");
         addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_EYES,"SHELLBREAKER");
         createY += 30;
         createY += 30;
         addEnemy(-100,EndingEnemy.TYPE_STOMPY_LFOOT,"");
         addEnemy(100,EndingEnemy.TYPE_STOMPY_RFOOT,"");
         createY -= 27;
         addEnemy(-49,EndingEnemy.TYPE_STOMPY_EYE,"");
         addEnemy(-49,EndingEnemy.TYPE_STOMPY_EYELID,"");
         addEnemy(-49,EndingEnemy.TYPE_STOMPY_PUPIL,"");
         addEnemy(45,EndingEnemy.TYPE_STOMPY_EYE,"");
         addEnemy(45,EndingEnemy.TYPE_STOMPY_EYELID,"");
         addEnemy(45,EndingEnemy.TYPE_STOMPY_PUPIL,"");
         createY += 27;
         createY += 160;
         addEnemy(0,EndingEnemy.TYPE_NONE,"STOMPY");
         createY += 30;
         addEnemy(0,EndingEnemy.TYPE_SPACE_BOX,"SPACE BOX");
         createY += 30;
         addEnemy(0,EndingEnemy.TYPE_MOON_SNAIL,"MOON SNAIL");
         createY += 30;
         addEnemy(0,EndingEnemy.TYPE_GIGA_SNAIL,"GIGA SNAIL");
         createY += 30;
         addEnemy(0,EndingEnemy.TYPE_SNAILY_SNAIL,"SNAILY SNAIL");
         createY += 30;
         addEnemy(0,EndingEnemy.TYPE_SLUGGY_SLUG,"SLUGGY SLUG");
         createY += 30;
         addEnemy(0,EndingEnemy.TYPE_TARSH,"NEWSTARSHIPSMELL\n(TESTED SNAILY GAME EXTENSIVELY!!)");
         createY += 10;
         addEnemy(0,EndingEnemy.TYPE_XDANOND,"XDANOND\n(DREW SEVERAL THINGS FOR ME!!)");
         createY += 10;
         addEnemy(0,EndingEnemy.TYPE_ADAMATOMIC,"ADAMATOMIC\n(CREATED FLIXEL, WITHOUT WHICH\nSNAILY GAME WOULD NOT EXIST!)");
         createY += 10;
         addEnemy(0,EndingEnemy.TYPE_AURIPLANE,"AURIPLANE\n(AUTHOR ARTIST COMPOSER ETC ETC)");
         createY += 70;
         addEnemy(0,EndingEnemy.TYPE_NONE,"AND YOU\n\n\n" + "BECAUSE SERIOUSLY, WHY NOT\n\n\n" + "ALL THE OTHER GAMES\n" + "PUT \"AND YOU\" IN THE CREDITS\n" + "SO I FIGURE, \"AND YOU\" MUST BE\n" + "SOMEONE PRETTY COOL\n\n\n" + "THANKS, AND YOU!!");
         createY += 40;
         _theEnd = addEnemy(0,EndingEnemy.TYPE_THE_END,"");
      }
      
      public function addEnemy(param1:int, param2:int, param3:String) : FlxObject
      {
         var _loc4_:EndingEnemy = null;
         var _loc5_:FlxText = null;
         _loc4_ = new EndingEnemy(param1,createY,param2);
         _loc4_.velocity.y = VELOCITY_Y;
         add(_loc4_);
         if(param3 == "")
         {
            return _loc4_;
         }
         createY += _loc4_.height;
         createY += SPACING_Y_MINOR;
         _loc5_ = new FlxText(-4,createY,FlxG.width);
         _loc5_.font = Fonts.normal;
         _loc5_.size = 20;
         _loc5_.color = 16777215;
         _loc5_.outline = true;
         _loc5_.outlineColor = 4278190080;
         _loc5_.alignment = "center";
         _loc5_.text = param3;
         _loc5_.scrollFactor.x = _loc5_.scrollFactor.y = 0;
         _loc5_.velocity.y = VELOCITY_Y;
         add(_loc5_);
         createY += _loc5_.realHeight;
         createY += SPACING_Y_MAJOR;
         return _loc5_;
      }
      
      override public function update() : void
      {
         if(_theEnd.y < FlxG.height / 2 - _theEnd.height / 2)
         {
            _theEnd.y = FlxG.height / 2 - _theEnd.height / 2;
            _theEnd.velocity.y = 0;
            scrollDone = true;
         }
         super.update();
      }
   }
}

