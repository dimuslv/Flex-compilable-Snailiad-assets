package
{
   import org.flixel.FlxG;
   
   public class PowerGrass extends Item
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 12;
      
      private static const NOM_DELAY:Number = 0.17;
      
      private var nextNom:Number = 0;
      
      private var hp:int = 12;
      
      private var _collidedThisFrame:Boolean;
      
      public function PowerGrass(param1:int, param2:int)
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2,false);
         loadGraphic(Art.PowerGrass,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         this.hp = MAX_HP;
         this.nextNom = 0;
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
         this._collidedThisFrame = true;
         this.nextNom -= FlxG.elapsed;
         if(this.nextNom > 0)
         {
            return;
         }
         this.nextNom = NOM_DELAY;
         PlayState.sprites.add(new PowerNom(x,y));
         if(param1._easyMode)
         {
            param1.heal(6);
         }
         else
         {
            param1.heal(3);
         }
         if(--this.hp <= 0)
         {
            kill();
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this._collidedThisFrame = false;
         super.update();
      }
   }
}

