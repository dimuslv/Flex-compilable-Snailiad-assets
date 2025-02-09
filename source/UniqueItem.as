package
{
   import org.flixel.*;
   
   public class UniqueItem extends Item
   {
      private static const HOLD_TIMEOUT:int = 2;
      
      private var _origX:int;
      
      private var _origY:int;
      
      private var gotten:Boolean = false;
      
      private var disappearTime:Number = 0;
      
      public function UniqueItem(param1:int, param2:int, param3:Boolean = false)
      {
         super(param1,param2,false);
         x = param1;
         y = param2;
         if(!param3)
         {
            PlayState.miniMap.setSpecialItem(param1,param2);
         }
         this._origX = x;
         this._origY = y;
         this.gotten = false;
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         if(this.gotten)
         {
            return;
         }
         var _loc2_:int = this._origX / 16;
         var _loc3_:int = this._origY / 16;
         PlayState.worldMap.spmap.setTile(_loc2_,_loc3_,0);
         PlayState.miniMap.setSpecialItemGotten(this._origX,this._origY);
         if(!PlayState.bossRush)
         {
            PlayState.uniqueBlocks.rememberBlock(_loc2_,_loc3_);
         }
         solid = false;
         this.gotten = true;
         this.disappearTime = HOLD_TIMEOUT;
         if(PlayState.bossRush)
         {
            Sfx.playPickup4();
         }
         else
         {
            Sfx.playItemJingle();
         }
         PlayState.player.saveNoCoords();
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(this.gotten)
         {
            switch(PlayState.player._gravityDir)
            {
               case Player.GRAV_DOWN:
                  x = PlayState.player.x;
                  y = PlayState.player.y - height;
                  break;
               case Player.GRAV_UP:
                  x = PlayState.player.x;
                  y = PlayState.player.y + PlayState.player.height;
                  break;
               case Player.GRAV_LEFT:
                  x = PlayState.player.x + PlayState.player.width;
                  y = PlayState.player.y;
                  break;
               case Player.GRAV_RIGHT:
                  x = PlayState.player.x - width;
                  y = PlayState.player.y;
            }
            this.disappearTime -= FlxG.elapsed;
            if(this.disappearTime < 0)
            {
               kill();
            }
         }
         else if(x > PlayState.worldMap.maxX || x + width < PlayState.worldMap.minX || y > PlayState.worldMap.maxY || y + height < PlayState.worldMap.minY)
         {
            kill();
         }
      }
   }
}

