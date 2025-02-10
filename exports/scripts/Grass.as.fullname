package
{
   import org.flixel.FlxG;
   
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
      
      public function Grass(param1:int, param2:int)
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2,false);
         loadGraphic(Art.Grass,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         this.hp = MAX_HP;
         this.nextNom = 0;
         if(Boolean(PlayState.player) && PlayState.player._hardMode)
         {
            this.hp = 1;
         }
         else if(Boolean(PlayState.player) && PlayState.player._easyMode)
         {
            this.hp *= 2;
         }
         addAnimation("normal",[0]);
         play("normal");
         this._collidedThisFrame = false;
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         if(this._collidedThisFrame)
         {
            return;
         }
         if(param1.isParalyzed())
         {
            return;
         }
         this._collidedThisFrame = true;
         this.nextNom -= FlxG.elapsed;
         if(this.nextNom > 0)
         {
            return;
         }
         this.nextNom = NOM_DELAY;
         PlayState.sprites.add(new Nom(x,y));
         param1.heal(1);
         if(--this.hp <= 0)
         {
            visible = false;
            solid = false;
            this.growDelay = GROW_DELAY;
            if(Boolean(PlayState.player) && PlayState.player._hardMode)
            {
               this.growDelay = GROW_DELAY * 99999;
            }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this.growDelay -= FlxG.elapsed;
         if(!visible && this.growDelay < 0)
         {
            solid = true;
            visible = true;
            if(onScreen())
            {
               Sfx.playGrow();
            }
            this.hp = MAX_HP;
         }
         this._collidedThisFrame = false;
         super.update();
      }
   }
}

