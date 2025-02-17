package
{
   import org.flixel.*;
   
   public class EndingCredits extends FlxGroup
   {
      private static const VELOCITY_Y:Number = -33;
      
      private static const SPACING_Y_MINOR:Number = 2;
      
      private static const SPACING_Y_MAJOR:Number = 32;
      
      private var createY:Number;
      
      private var _theEnd:FlxObject;
      
      public var scrollDone:Boolean = false;
      
      public function EndingCredits() : void
      {
         this.createY = FlxG.height + 4;
         super();
         this.addEnemy(0,EndingEnemy.TYPE_NONE,"CREDITS");
         this.createY += 40;
         this.addEnemy(-30,EndingEnemy.TYPE_SPIKEY,"");
         this.addEnemy(30,EndingEnemy.TYPE_SPIKEY2,"SPIKEY");
         this.addEnemy(-25,EndingEnemy.TYPE_BABYFISH,"");
         this.addEnemy(25,EndingEnemy.TYPE_BABYFISH2,"BABYFISH");
         this.addEnemy(-13,EndingEnemy.TYPE_FLOATSPIKE,"");
         this.addEnemy(13,EndingEnemy.TYPE_FLOATSPIKE2,"FLOATSPIKE");
         this.addEnemy(-30,EndingEnemy.TYPE_BLOB1,"");
         this.addEnemy(-10,EndingEnemy.TYPE_BLOB2,"");
         this.addEnemy(10,EndingEnemy.TYPE_BLOB3,"");
         this.addEnemy(30,EndingEnemy.TYPE_BLOB4,"BLOB, BLUB, ANGELBLOB, AND DEVILBLOB");
         this.addEnemy(-14,EndingEnemy.TYPE_CHIRPY,"");
         this.addEnemy(14,EndingEnemy.TYPE_CHIRPY2,"CHIRPY");
         this.addEnemy(0,EndingEnemy.TYPE_BATTY_BAT,"BATTY BAT");
         this.addEnemy(-12,EndingEnemy.TYPE_FIREBALL,"");
         this.addEnemy(12,EndingEnemy.TYPE_ICEBALL,"FIREBALL AND ICEBALL");
         this.addEnemy(0,EndingEnemy.TYPE_SECRET_SNELK,"SECRET SNELK");
         this.addEnemy(0,EndingEnemy.TYPE_KITTY,"KITTY!!");
         this.addEnemy(0,EndingEnemy.TYPE_DANDELION,"GHOST DANDELION");
         this.addEnemy(-30,EndingEnemy.TYPE_CANNON,"");
         this.addEnemy(-30,EndingEnemy.TYPE_CANNON_HUB,"");
         this.addEnemy(30,EndingEnemy.TYPE_CANNON2,"");
         this.addEnemy(30,EndingEnemy.TYPE_CANNON2_HUB,"");
         this.createY += 30;
         this.addEnemy(0,EndingEnemy.TYPE_NONE,"CANON AND NON-CANON");
         this.addEnemy(-20,EndingEnemy.TYPE_SNAKEY,"");
         this.addEnemy(20,EndingEnemy.TYPE_BLUE_SNAKEY,"SNAKEY");
         this.addEnemy(0,EndingEnemy.TYPE_SKY_SNAKE,"SKY VIPER");
         this.addEnemy(0,EndingEnemy.TYPE_SPIDER,"SPIDER");
         this.addEnemy(0,EndingEnemy.TYPE_SPIDER_MAMA,"SPIDER MAMA");
         this.addEnemy(0,EndingEnemy.TYPE_GRAVITY_TURTLE,"GRAVITY TURTLE");
         this.addEnemy(0,EndingEnemy.TYPE_CHERRY_TURTLE,"GRAVITY TURTLE (CHERRY RED FINISH)");
         this.addEnemy(0,EndingEnemy.TYPE_JELLYFISH,"JELLYFISH");
         this.addEnemy(0,EndingEnemy.TYPE_SEAHORSE,"SYNGNATHIDA");
         this.addEnemy(-26,EndingEnemy.TYPE_TALLFISH,"");
         this.addEnemy(26,EndingEnemy.TYPE_TALLFISH2,"TALLFISH AND ANGRY TALLFISH");
         this.addEnemy(0,EndingEnemy.TYPE_WALLEYE,"WALLEYE");
         this.addEnemy(-17,EndingEnemy.TYPE_PINCER,"");
         this.addEnemy(17,EndingEnemy.TYPE_SKY_PINCER,"PINCER AND SKY PINCER");
         this.addEnemy(0,EndingEnemy.TYPE_GEAR,"SPINNYGEAR");
         this.addEnemy(0,EndingEnemy.TYPE_FEDERATION_DRONE,"FEDERATION DRONE");
         this.addEnemy(0,EndingEnemy.TYPE_BALLOON,"BALLOON BUSTER");
         this.createY += 30;
         this.createY += 30;
         this.addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER,"");
         this.addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND1,"");
         this.addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND2,"");
         this.addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND3,"");
         this.addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND4,"");
         this.addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND5,"");
         this.addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_HAND6,"");
         this.addEnemy(0,EndingEnemy.TYPE_SHELLBREAKER_EYES,"SHELLBREAKER");
         this.createY += 30;
         this.createY += 30;
         this.addEnemy(-100,EndingEnemy.TYPE_STOMPY_LFOOT,"");
         this.addEnemy(100,EndingEnemy.TYPE_STOMPY_RFOOT,"");
         this.createY -= 27;
         this.addEnemy(-49,EndingEnemy.TYPE_STOMPY_EYE,"");
         this.addEnemy(-49,EndingEnemy.TYPE_STOMPY_EYELID,"");
         this.addEnemy(-49,EndingEnemy.TYPE_STOMPY_PUPIL,"");
         this.addEnemy(45,EndingEnemy.TYPE_STOMPY_EYE,"");
         this.addEnemy(45,EndingEnemy.TYPE_STOMPY_EYELID,"");
         this.addEnemy(45,EndingEnemy.TYPE_STOMPY_PUPIL,"");
         this.createY += 27;
         this.createY += 160;
         this.addEnemy(0,EndingEnemy.TYPE_NONE,"STOMPY");
         this.createY += 30;
         this.addEnemy(0,EndingEnemy.TYPE_SPACE_BOX,"SPACE BOX");
         this.createY += 30;
         this.addEnemy(0,EndingEnemy.TYPE_MOON_SNAIL,"MOON SNAIL");
         this.createY += 30;
         this.addEnemy(0,EndingEnemy.TYPE_GIGA_SNAIL,"GIGA SNAIL");
         this.createY += 30;
         this.addEnemy(0,EndingEnemy.TYPE_SNAILY_SNAIL,"SNAILY SNAIL");
         this.createY += 30;
         this.addEnemy(0,EndingEnemy.TYPE_SLUGGY_SLUG,"SLUGGY SLUG");
         this.createY += 30;
         this.addEnemy(0,EndingEnemy.TYPE_TARSH,"NEWSTARSHIPSMELL\n(TESTED SNAILY GAME EXTENSIVELY!!)");
         this.createY += 10;
         this.addEnemy(0,EndingEnemy.TYPE_XDANOND,"XDANOND\n(DREW SEVERAL THINGS FOR ME!!)");
         this.createY += 10;
         this.addEnemy(0,EndingEnemy.TYPE_ADAMATOMIC,"ADAMATOMIC\n(CREATED FLIXEL, WITHOUT WHICH\nSNAILY GAME WOULD NOT EXIST!)");
         this.createY += 10;
         this.addEnemy(0,EndingEnemy.TYPE_AURIPLANE,"AURIPLANE\n(AUTHOR ARTIST COMPOSER ETC ETC)");
         this.createY += 70;
         this.addEnemy(0,EndingEnemy.TYPE_NONE,"AND YOU\n\n\n" + "BECAUSE SERIOUSLY, WHY NOT\n\n\n" + "ALL THE OTHER GAMES\n" + "PUT \"AND YOU\" IN THE CREDITS\n" + "SO I FIGURE, \"AND YOU\" MUST BE\n" + "SOMEONE PRETTY COOL\n\n\n" + "THANKS, AND YOU!!");
         this.createY += 40;
         this._theEnd = this.addEnemy(0,EndingEnemy.TYPE_THE_END,"");
      }
      
      override public function destroy() : void
      {
         _theEnd = null;
         super.destroy();
      }
      
      public function addEnemy(param1:int, param2:int, param3:String) : FlxObject
      {
         var _loc4_:EndingEnemy = null;
         var _loc5_:FlxText = null;
         _loc4_ = new EndingEnemy(param1,this.createY,param2);
         _loc4_.velocity.y = VELOCITY_Y;
         add(_loc4_);
         if(param3 == "")
         {
            return _loc4_;
         }
         createY += _loc4_.height;
         createY += SPACING_Y_MINOR;
         _loc5_ = new FlxText(-4,this.createY,FlxG.width);
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
         if(this._theEnd.y < FlxG.height / 2 - this._theEnd.height / 2)
         {
            this._theEnd.y = FlxG.height / 2 - this._theEnd.height / 2;
            this._theEnd.velocity.y = 0;
            scrollDone = true;
         }
         super.update();
      }
   }
}

