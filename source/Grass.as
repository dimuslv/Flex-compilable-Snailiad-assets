package
{
   import org.flixel.*;
   
   public class Grass extends Item
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 3;
      
      private static const NOM_DELAY:Number = 0.22;
      
      private static const GROW_DELAY:Number = 16;
      
      private var growDelay:Number = 0;
      
      private var nextNom:Number = 0;
      
      private var hp:int = 3;
      
      private var _collidedThisFrame:Boolean;
      
      public function Grass(param1:int, param2:int) : void
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2,false);
         loadGraphic(Art.Grass,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         hp = MAX_HP;
         nextNom = 0;
         if(PlayState.player && PlayState.player._hardMode)
         {
            hp = 1;
         }
         else if(PlayState.player && PlayState.player._easyMode)
         {
            hp *= 2;
         }
         addAnimation("normal",[0]);
         play("normal");
         _collidedThisFrame = false;
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         if(_collidedThisFrame)
         {
            return;
         }
         if(param1.isParalyzed())
         {
            return;
         }
         _collidedThisFrame = true;
         nextNom -= FlxG.elapsed;
         if(nextNom > 0)
         {
            return;
         }
         nextNom = NOM_DELAY;
         PlayState.sprites.add(new Nom(x,y));
         param1.heal(1);
         if(--hp <= 0)
         {
            visible = false;
            solid = false;
            growDelay = GROW_DELAY;
            if(PlayState.player && PlayState.player._hardMode)
            {
               growDelay = GROW_DELAY * 99999;
            }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         growDelay -= FlxG.elapsed;
         if(!visible && growDelay < 0)
         {
            solid = true;
            visible = true;
            if(onScreen())
            {
               Sfx.playGrow();
            }
            hp = MAX_HP;
         }
         _collidedThisFrame = false;
         super.update();
      }
   }
}

