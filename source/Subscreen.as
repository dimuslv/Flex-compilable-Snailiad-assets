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
      
      private var WEAPON_BASE_X:int = FlxG.width - 56;
      
      private var WEAPON_SPACING:int = 5;
      
      public var weaponText:Array;
      
      public var tabText:FlxText;
      
      public var escText:FlxText;
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < texts.length)
         {
            texts[_loc1_] = null;
            _loc1_++;
         }
         texts = null;
         textY = null;
         _loc1_ = 0;
         while(_loc1_ < weaponText.length)
         {
            weaponText[_loc1_] = null;
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
         hide();
         bg = new FlxSprite();
         bg.y = 0;
         bg.x = 0;
         bg.createGraphic(FlxG.width,FlxG.height,bgColor);
         bg.scrollFactor.x = bg.scrollFactor.y = 0;
         bg.alpha = 0;
         add(bg);
         helixSprite = new HelixHud(65,-30);
         helixSprite.scrollFactor.x = helixSprite.scrollFactor.y = 0;
         helixSprite.visible = false;
         add(helixSprite);
         helixText = new FlxText(84,-30,350);
         helixText.font = Fonts.normal;
         helixText.size = 10;
         helixText.color = 16777215;
         helixText.shadow = 1;
         helixText.alignment = "left";
         helixText.text = "x 0";
         helixText.scrollFactor.x = helixText.scrollFactor.y = 0;
         helixText.visible = false;
         add(helixText);
         panel = new FlxSprite();
         if(PlayState.player._slugMode)
         {
            panel.loadGraphic(Art.SubscreenSlug,false,false,IMG_WIDTH,IMG_HEIGHT);
         }
         else
         {
            panel.loadGraphic(Art.Subscreen,false,false,IMG_WIDTH,IMG_HEIGHT);
         }
         panel.width = IMG_WIDTH;
         panel.height = IMG_HEIGHT - TAB_HEIGHT;
         panel.offset.y = TAB_HEIGHT;
         panel.x = 0;
         panel.y = targetY;
         panel.addAnimation("normal",[0]);
         panel.play("normal");
         add(panel);
         texts = new Array();
         textY = new Array();
         makeText(TEXT_GUN1,GROUP_WEAPON,0,"PEA SHOOTER");
         makeText(TEXT_GUN2,GROUP_WEAPON,1,"BOOMERANG");
         makeText(TEXT_GUN3,GROUP_WEAPON,2,"RAINBOW WAVE");
         if(PlayState.player._slugMode)
         {
            makeText(TEXT_NORMAL,GROUP_SHELL,0,"NORMAL SLUG");
            makeText(TEXT_ICE,GROUP_SHELL,1,"ICE SLUG");
            makeText(TEXT_GRAVITY,GROUP_SHELL,2,"GRAVITY SLUG");
            makeText(TEXT_ARMOR,GROUP_SHELL,3,"FULL POWER SLUG");
            makeText(TEXT_HIGHJUMP,GROUP_ABILITY,0,"HIGH JUMP");
            makeText(TEXT_RAPIDFIRE,GROUP_ABILITY,1,"RAPID FIRE");
            makeText(TEXT_DEVASTATOR,GROUP_ABILITY,2,"DEVASTATOR");
            makeText(TEXT_GRAVITYSHOCK,GROUP_ABILITY,3,"GRAVITY SHOCK");
            makeText(TEXT_SHELLSHIELD,GROUP_ABILITY,4,"");
         }
         else
         {
            makeText(TEXT_NORMAL,GROUP_SHELL,0,"NORMAL SHELL");
            makeText(TEXT_ICE,GROUP_SHELL,1,"ICE SHELL");
            makeText(TEXT_GRAVITY,GROUP_SHELL,2,"GRAVITY SHELL");
            makeText(TEXT_ARMOR,GROUP_SHELL,3,"FULL METAL SHELL");
            makeText(TEXT_SHELLSHIELD,GROUP_ABILITY,0,"SHELL SHIELD");
            makeText(TEXT_HIGHJUMP,GROUP_ABILITY,1,"HIGH JUMP");
            makeText(TEXT_RAPIDFIRE,GROUP_ABILITY,2,"RAPID FIRE");
            makeText(TEXT_DEVASTATOR,GROUP_ABILITY,3,"DEVASTATOR");
            makeText(TEXT_GRAVITYSHOCK,GROUP_ABILITY,4,"GRAVITY SHOCK");
         }
         weaponText = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            makeWeaponText(_loc1_);
            _loc1_++;
         }
         makeTabText();
         makeEscText();
         x = 0;
         y = 0;
         panel.scrollFactor.x = panel.scrollFactor.y = 0;
         scrollFactor.x = scrollFactor.y = 0;
         updatePosition();
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
         texts[param1] = _loc7_;
         textY[param1] = _loc7_.y;
      }
      
      private function makeWeaponText(param1:int) : void
      {
         var _loc2_:int = WEAPON_BASE_X;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += weaponText[_loc3_].realWidth + WEAPON_SPACING;
            _loc3_++;
         }
         if(param1 == 2)
         {
            _loc2_ -= 1;
         }
         var _loc4_:int = WEAPON_Y;
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
         weaponText[param1] = _loc5_;
      }
      
      private function makeEscText() : void
      {
         var _loc1_:FlxText = new FlxText(0,WEAPON_Y,FlxG.width);
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
         var _loc1_:FlxText = new FlxText(0,WEAPON_Y,FlxG.width);
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
         helixSprite.visible = true;
         helixText.visible = true;
         helixText.text = "x " + PlayState.player.getHelixFragments().toString();
         if(PlayState.isBossDead(4))
         {
            helixText.text += "        AREA ITEMS FOUND: " + PlayState.gottenItemsInArea() + "/" + PlayState.totalItemsInArea().toString();
         }
         texts[TEXT_GUN1].visible = PlayState.player.getHasWeapon(0);
         texts[TEXT_GUN2].visible = PlayState.player.getHasWeapon(1);
         texts[TEXT_GUN3].visible = PlayState.player.getHasWeapon(2);
         texts[TEXT_NORMAL].visible = true;
         texts[TEXT_ICE].visible = PlayState.player.isIcy();
         texts[TEXT_GRAVITY].visible = PlayState.player.hasGravityJump();
         texts[TEXT_ARMOR].visible = PlayState.player.hasArmor();
         texts[TEXT_SHELLSHIELD].visible = PlayState.player.getHasShellShield();
         texts[TEXT_HIGHJUMP].visible = PlayState.player.hasHighJump();
         texts[TEXT_RAPIDFIRE].visible = PlayState.player.hasTurbo();
         texts[TEXT_DEVASTATOR].visible = PlayState.player.getHasDevastator();
         texts[TEXT_GRAVITYSHOCK].visible = PlayState.player.hasGravityShock();
      }
      
      public function updatePosition() : void
      {
         panel.y = Utility.integrate(panel.y,targetY,SCROLL_RATE,FlxG.elapsed,1.1);
         bg.alpha = Utility.integrate(bg.alpha,targetBgAlpha,ALPHA_RATE,FlxG.elapsed);
         var _loc1_:int = 0;
         while(_loc1_ < texts.length)
         {
            texts[_loc1_].y = panel.y + textY[_loc1_];
            _loc1_++;
         }
         helixSprite.y = Utility.integrate(helixSprite.y,helixSpriteTargetY,SCROLL_RATE,FlxG.elapsed,0.1);
         helixText.y = helixSprite.y + 2;
      }
      
      public function updateWeapons() : void
      {
         escText.y = WEAPON_Y + panel.y;
         escText.alpha = (escText.y - 200) / 30;
         tabText.y = WEAPON_Y + panel.y;
         tabText.text = Player.MAP_KEY;
         if(!PlayState.player.hasAnyTwoWeapons())
         {
            return;
         }
         var _loc1_:int = PlayState.player.getCurrentWeapon();
         var _loc2_:int = 0;
         while(_loc2_ < weaponText.length)
         {
            weaponText[_loc2_].visible = PlayState.player.hasWeapon(_loc2_);
            weaponText[_loc2_].alpha = _loc1_ == _loc2_ ? 1 : 0.6;
            weaponText[_loc2_].y = WEAPON_Y + panel.y;
            _loc2_++;
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_SUBSCREEN)
         {
            hide();
         }
         updateWeapons();
         updatePosition();
         super.update();
      }
   }
}

