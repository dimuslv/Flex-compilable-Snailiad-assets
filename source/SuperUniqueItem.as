package
{
   import org.flixel.*;
   
   public class SuperUniqueItem extends Item
   {
      private static const HOLD_TIMEOUT:int = 2;
      
      private static const SUPERANIM_TIMEOUT:int = 4;
      
      private var _origX:int;
      
      private var _origY:int;
      
      private var gotten:Boolean = false;
      
      private var disappearTime:Number = 0;
      
      private var superAnimTime:Number = 0;
      
      private var _superAnim:Boolean = false;
      
      private var _customFinish:Boolean = false;
      
      protected var _customReady:Boolean = false;
      
      private var _flickered:Boolean = false;
      
      public function SuperUniqueItem(param1:int, param2:int, param3:Boolean, param4:Boolean = false) : void
      {
         super(param1,param2,false);
         _superAnim = true;
         _customFinish = param4;
         if(PlayState.bossRush)
         {
            _superAnim = false;
         }
         x = param1;
         y = param2;
         PlayState.miniMap.setSpecialItem(param1,param2);
         _origX = x;
         _origY = y;
         gotten = false;
         active = true;
      }
      
      override public function touch(param1:Player) : void
      {
         if(gotten)
         {
            return;
         }
         var _loc2_:int = _origX / 16;
         var _loc3_:int = _origY / 16;
         PlayState.worldMap.spmap.setTile(_loc2_,_loc3_,0);
         PlayState.miniMap.setSpecialItemGotten(_origX,_origY);
         if(!PlayState.bossRush)
         {
            PlayState.uniqueBlocks.rememberBlock(_loc2_,_loc3_);
         }
         solid = false;
         gotten = true;
         disappearTime = HOLD_TIMEOUT;
         if(PlayState.bossRush)
         {
            Sfx.playPickup4();
         }
         else
         {
            Music.playNone();
            Sfx.playSuperItemJingle();
         }
         if(_superAnim)
         {
            superAnimTime = SUPERANIM_TIMEOUT;
            PlayState.player.paralyze(true);
            PlayState.sprites.add(new DustRing(PlayState.player.x,PlayState.player.y,0,1));
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
         if(gotten)
         {
            x = PlayState.player.x;
            y = PlayState.player.y - height;
            disappearTime -= FlxG.elapsed;
            if(disappearTime < 0 && !_superAnim)
            {
               if(!PlayState.bossRush)
               {
                  Music.playPrevSong();
               }
               kill();
            }
            superAnimTime -= FlxG.elapsed;
            if(_superAnim && superAnimTime < 0)
            {
               if(!_flickered)
               {
                  if(!PlayState.bossRush)
                  {
                     Music.playPrevSong();
                  }
                  PlayState.player.flicker(1);
                  _flickered = true;
               }
               if(_customFinish)
               {
                  _customReady = true;
                  visible = false;
               }
               else
               {
                  PlayState.player.paralyze(false);
                  kill();
               }
            }
         }
         else if(x > PlayState.worldMap.maxX || x + width < PlayState.worldMap.minX || y > PlayState.worldMap.maxY || y + height < PlayState.worldMap.minY)
         {
            kill();
         }
      }
   }
}

