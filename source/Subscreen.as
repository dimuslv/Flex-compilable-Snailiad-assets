package
{
   import org.flixel.*;
   
   public class Subscreen extends FlxGroup
   {
      private static var IMG_WIDTH:int = 400;
      
      private static var IMG_HEIGHT:int = 250;
      
      private static const SCROLL_RATE:Number = 5;
      
      private static const ALPHA_RATE:Number = 5;
      
      private static const TAB_HEIGHT:int = 10;
      
      public static const bgColor:uint = 2667577344;
      
      private static const BASE_X:int = 18;
      
      private static const BASE_Y:int = 82;
      
      private static const LINE_SPACING:int = 8;
      
      private static const GROUP_Y:Array = [0,50,104];
      
      private static const GROUP_WEAPON:int = 0;
      
      private static const GROUP_SHELL:int = 1;
      
      private static const GROUP_ABILITY:int = 2;
      
      private static var TEXT_GUN1:int = 0;
      
      private static var TEXT_GUN2:int = 1;
      
      private static var TEXT_GUN3:int = 2;
      
      private static var TEXT_NORMAL:int = 3;
      
      private static var TEXT_ICE:int = 4;
      
      private static var TEXT_GRAVITY:int = 5;
      
      private static var TEXT_ARMOR:int = 6;
      
      private static var TEXT_SHELLSHIELD:int = 7;
      
      private static var TEXT_HIGHJUMP:int = 8;
      
      private static var TEXT_RAPIDFIRE:int = 9;
      
      private static var TEXT_DEVASTATOR:int = 10;
      
      private static var TEXT_GRAVITYSHOCK:int = 11;
      
      public var panel:FlxSprite;
      
      private var bg:FlxSprite;
      
      public var targetY:int;
      
      public var targetBgAlpha:Number;
      
      public var texts:Array;
      
      public var textY:Array;
      
      public var helixSprite:FlxSprite;
      
      public var helixSpriteTargetY:Number = 0;
      
      public var helixText:FlxText;
      
      private var WEAPON_Y:int = 13;
      
      private var WEAPON_BASE_X:int;
      
      private var WEAPON_SPACING:int = 5;
      
      public var weaponText:Array;
      
      public var tabText:FlxText;
      
      public var escText:FlxText;
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.texts.length)
         {
            this.texts[_loc1_] = null;
            _loc1_++;
         }
         texts = null;
         textY = null;
         _loc1_ = 0;
         while(_loc1_ < this.weaponText.length)
         {
            this.weaponText[_loc1_] = null;
            _loc1_++;
         }
         tabText = null;
         weaponText = null;
         helixSprite = null;
         helixText = null;
         bg = null;
         panel = null;
         super.destroy();
      }
      
      public function Subscreen() : void
      {
         this.WEAPON_BASE_X = FlxG.width - 56;
         super();
         this.hide();
         this.bg = new FlxSprite();
         this.bg.y = 0;
         this.bg.x = 0;
         this.bg.createGraphic(FlxG.width,FlxG.height,bgColor);
         this.bg.scrollFactor.x = this.bg.scrollFactor.y = 0;
         this.bg.alpha = 0;
         add(this.bg);
         this.helixSprite = new HelixHud(65,-30);
         this.helixSprite.scrollFactor.x = this.helixSprite.scrollFactor.y = 0;
         this.helixSprite.visible = false;
         add(this.helixSprite);
         this.helixText = new FlxText(84,-30,350);
         this.helixText.font = Fonts.normal;
         this.helixText.size = 10;
         this.helixText.color = 16777215;
         this.helixText.shadow = 1;
         this.helixText.alignment = "left";
         this.helixText.text = "x 0";
         this.helixText.scrollFactor.x = this.helixText.scrollFactor.y = 0;
         this.helixText.visible = false;
         add(this.helixText);
         this.panel = new FlxSprite();
         if(PlayState.player._slugMode)
         {
            this.panel.loadGraphic(Art.SubscreenSlug,false,false,IMG_WIDTH,IMG_HEIGHT);
         }
         else
         {
            this.panel.loadGraphic(Art.Subscreen,false,false,IMG_WIDTH,IMG_HEIGHT);
         }
         this.panel.width = IMG_WIDTH;
         this.panel.height = IMG_HEIGHT - TAB_HEIGHT;
         this.panel.offset.y = TAB_HEIGHT;
         this.panel.x = 0;
         this.panel.y = this.targetY;
         this.panel.addAnimation("normal",[0]);
         this.panel.play("normal");
         add(this.panel);
         this.texts = new Array();
         this.textY = new Array();
         this.makeText(TEXT_GUN1,GROUP_WEAPON,0,"PEA SHOOTER");
         this.makeText(TEXT_GUN2,GROUP_WEAPON,1,"BOOMERANG");
         this.makeText(TEXT_GUN3,GROUP_WEAPON,2,"RAINBOW WAVE");
         if(PlayState.player._slugMode)
         {
            this.makeText(TEXT_NORMAL,GROUP_SHELL,0,"NORMAL SLUG");
            this.makeText(TEXT_ICE,GROUP_SHELL,1,"ICE SLUG");
            this.makeText(TEXT_GRAVITY,GROUP_SHELL,2,"GRAVITY SLUG");
            this.makeText(TEXT_ARMOR,GROUP_SHELL,3,"FULL POWER SLUG");
            this.makeText(TEXT_HIGHJUMP,GROUP_ABILITY,0,"HIGH JUMP");
            this.makeText(TEXT_RAPIDFIRE,GROUP_ABILITY,1,"RAPID FIRE");
            this.makeText(TEXT_DEVASTATOR,GROUP_ABILITY,2,"DEVASTATOR");
            this.makeText(TEXT_GRAVITYSHOCK,GROUP_ABILITY,3,"GRAVITY SHOCK");
            this.makeText(TEXT_SHELLSHIELD,GROUP_ABILITY,4,"");
         }
         else
         {
            this.makeText(TEXT_NORMAL,GROUP_SHELL,0,"NORMAL SHELL");
            this.makeText(TEXT_ICE,GROUP_SHELL,1,"ICE SHELL");
            this.makeText(TEXT_GRAVITY,GROUP_SHELL,2,"GRAVITY SHELL");
            this.makeText(TEXT_ARMOR,GROUP_SHELL,3,"FULL METAL SHELL");
            this.makeText(TEXT_SHELLSHIELD,GROUP_ABILITY,0,"SHELL SHIELD");
            this.makeText(TEXT_HIGHJUMP,GROUP_ABILITY,1,"HIGH JUMP");
            this.makeText(TEXT_RAPIDFIRE,GROUP_ABILITY,2,"RAPID FIRE");
            this.makeText(TEXT_DEVASTATOR,GROUP_ABILITY,3,"DEVASTATOR");
            this.makeText(TEXT_GRAVITYSHOCK,GROUP_ABILITY,4,"GRAVITY SHOCK");
         }
         this.weaponText = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.makeWeaponText(_loc1_);
            _loc1_++;
         }
         this.makeTabText();
         this.makeEscText();
         x = 0;
         y = 0;
         this.panel.scrollFactor.x = this.panel.scrollFactor.y = 0;
         scrollFactor.x = scrollFactor.y = 0;
         this.updatePosition();
      }
      
      private function makeText(param1:int, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:int = BASE_X;
         var _loc6_:int = GROUP_Y[param2] + BASE_Y + param3 * LINE_SPACING;
         var _loc7_:FlxText = new FlxText(_loc5_,_loc6_,200);
         _loc7_.font = Fonts.normal;
         _loc7_.size = 10;
         _loc7_.color = 16777215;
         _loc7_.shadow = 1;
         _loc7_.alignment = "left";
         _loc7_.text = param4;
         _loc7_.scrollFactor.x = _loc7_.scrollFactor.y = 0;
         _loc7_.visible = false;
         add(_loc7_);
         this.texts[param1] = _loc7_;
         this.textY[param1] = _loc7_.y;
      }
      
      private function makeWeaponText(param1:int) : void
      {
         var _loc2_:int = this.WEAPON_BASE_X;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += this.weaponText[_loc3_].realWidth + this.WEAPON_SPACING;
            _loc3_++;
         }
         if(param1 == 2)
         {
            _loc2_ -= 1;
         }
         var _loc4_:int = this.WEAPON_Y;
         var _loc5_:FlxText = new FlxText(_loc2_,_loc4_,20);
         _loc5_.font = Fonts.normal;
         _loc5_.size = 10;
         _loc5_.color = 16777215;
         _loc5_.shadow = 1;
         _loc5_.alignment = "left";
         _loc5_.text = (param1 + 1).toString();
         _loc5_.scrollFactor.x = _loc5_.scrollFactor.y = 0;
         _loc5_.visible = false;
         add(_loc5_);
         this.weaponText[param1] = _loc5_;
      }
      
      private function makeEscText() : void
      {
         var _loc1_:FlxText = new FlxText(0,this.WEAPON_Y,FlxG.width);
         _loc1_.font = Fonts.normal;
         _loc1_.size = 10;
         _loc1_.color = 16777215;
         _loc1_.shadow = 1;
         _loc1_.alignment = "left";
         _loc1_.text = "ESC";
         _loc1_.scrollFactor.x = _loc1_.scrollFactor.y = 0;
         _loc1_.visible = true;
         add(_loc1_);
         escText = _loc1_;
      }
      
      private function makeTabText() : void
      {
         var _loc1_:FlxText = new FlxText(0,this.WEAPON_Y,FlxG.width);
         _loc1_.font = Fonts.normal;
         _loc1_.size = 10;
         _loc1_.color = 16777215;
         _loc1_.shadow = 1;
         _loc1_.alignment = "right";
         _loc1_.text = Player.MAP_KEY;
         _loc1_.scrollFactor.x = _loc1_.scrollFactor.y = 0;
         _loc1_.visible = true;
         add(_loc1_);
         tabText = _loc1_;
      }
      
      public function hide() : void
      {
         targetY = FlxG.height - TAB_HEIGHT - (PlayState.hideTab ? 0 : 14);
         targetBgAlpha = 0;
         helixSpriteTargetY = -30;
      }
      
      public function show() : void
      {
         targetY = 0;
         targetBgAlpha = 1;
         helixSpriteTargetY = 4;
         this.helixSprite.visible = true;
         this.helixText.visible = true;
         this.helixText.text = "x " + PlayState.player.getHelixFragments().toString();
         if(PlayState.isBossDead(4))
         {
            this.helixText.text += "        AREA ITEMS FOUND: " + PlayState.gottenItemsInArea() + "/" + PlayState.totalItemsInArea().toString();
         }
         this.texts[TEXT_GUN1].visible = PlayState.player.getHasWeapon(0);
         this.texts[TEXT_GUN2].visible = PlayState.player.getHasWeapon(1);
         this.texts[TEXT_GUN3].visible = PlayState.player.getHasWeapon(2);
         this.texts[TEXT_NORMAL].visible = true;
         this.texts[TEXT_ICE].visible = PlayState.player.isIcy();
         this.texts[TEXT_GRAVITY].visible = PlayState.player.hasGravityJump();
         this.texts[TEXT_ARMOR].visible = PlayState.player.hasArmor();
         this.texts[TEXT_SHELLSHIELD].visible = PlayState.player.getHasShellShield();
         this.texts[TEXT_HIGHJUMP].visible = PlayState.player.hasHighJump();
         this.texts[TEXT_RAPIDFIRE].visible = PlayState.player.hasTurbo();
         this.texts[TEXT_DEVASTATOR].visible = PlayState.player.getHasDevastator();
         this.texts[TEXT_GRAVITYSHOCK].visible = PlayState.player.hasGravityShock();
      }
      
      public function updatePosition() : void
      {
         this.panel.y = Utility.integrate(this.panel.y,this.targetY,SCROLL_RATE,FlxG.elapsed,1.1);
         this.bg.alpha = Utility.integrate(this.bg.alpha,this.targetBgAlpha,ALPHA_RATE,FlxG.elapsed);
         var _loc1_:int = 0;
         while(_loc1_ < this.texts.length)
         {
            this.texts[_loc1_].y = this.panel.y + this.textY[_loc1_];
            _loc1_++;
         }
         this.helixSprite.y = Utility.integrate(this.helixSprite.y,this.helixSpriteTargetY,SCROLL_RATE,FlxG.elapsed,0.1);
         this.helixText.y = this.helixSprite.y + 2;
      }
      
      public function updateWeapons() : void
      {
         this.escText.y = this.WEAPON_Y + this.panel.y;
         this.escText.alpha = (this.escText.y - 200) / 30;
         this.tabText.y = this.WEAPON_Y + this.panel.y;
         this.tabText.text = Player.MAP_KEY;
         if(!PlayState.player.hasAnyTwoWeapons())
         {
            return;
         }
         var _loc1_:int = PlayState.player.getCurrentWeapon();
         var _loc2_:int = 0;
         while(_loc2_ < this.weaponText.length)
         {
            this.weaponText[_loc2_].visible = PlayState.player.hasWeapon(_loc2_);
            this.weaponText[_loc2_].alpha = _loc1_ == _loc2_ ? 1 : 0.6;
            this.weaponText[_loc2_].y = this.WEAPON_Y + this.panel.y;
            _loc2_++;
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_SUBSCREEN)
         {
            this.hide();
         }
         this.updateWeapons();
         this.updatePosition();
         super.update();
      }
   }
}

