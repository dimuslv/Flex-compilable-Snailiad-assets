package
{
   import org.flixel.*;
   
   public class Breakable extends Enemy
   {
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private var _silent:Boolean = false;
      
      public function Breakable(param1:int, param2:int, param3:int, param4:Boolean = false)
      {
         var _loc5_:int = 1;
         var _loc6_:int = 0;
         switch(param3)
         {
            case 0:
               _loc6_ = 0;
               break;
            case 1:
               _loc6_ = 20;
               break;
            case 2:
               _loc6_ = 35;
         }
         super(param1,param2,_loc5_,_loc6_,0);
         this._silent = param4;
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         visible = false;
         exists = true;
         solid = true;
         active = true;
         fixed = true;
      }
      
      override public function kill() : void
      {
         super.kill();
      }
      
      override public function hurt(param1:Number) : void
      {
         if(param1 == 10)
         {
            return;
         }
         param1 -= _defense;
         if(param1 <= 0)
         {
            if(!this._silent)
            {
               Sfx.playEnemyPingOffArmor();
            }
            return;
         }
         this.kill();
         var _loc2_:int = x / 16;
         var _loc3_:int = y / 16;
         PlayState.fixBlocks.rememberBlock(_loc2_,_loc3_,PlayState.worldMap.bgmap.getTile(_loc2_,_loc3_),PlayState.worldMap.fgmap.getTile(_loc2_,_loc3_));
         PlayState.worldMap.bgmap.setTile(_loc2_,_loc3_,0);
         PlayState.worldMap.fgmap.setTile(_loc2_,_loc3_,0);
         PlayState.explosionPool.boom(x,y,0,10,FlxU.random() * 2 + 1);
         PlayState.explosionPool.boom(x,y,0,10,FlxU.random() * 3 + 1);
         Sfx.playRandomExplode();
      }
   }
}

