package
{
   import org.flixel.*;
   
   public class Door extends Item
   {
      private static const LEFTRIGHTDOOR_WIDTH:int = 16;
      
      private static const LEFTRIGHTDOOR_HEIGHT:int = 48;
      
      private static const LEFTRIGHTDOOR_OFS_X:int = 0;
      
      private static const LEFTRIGHTDOOR_OFS_Y:int = 32;
      
      private static const TOPBOTTOMDOOR_WIDTH:int = 48;
      
      private static const TOPBOTTOMDOOR_HEIGHT:int = 16;
      
      private static const TOPBOTTOMDOOR_OFS_X:int = 0;
      
      private static const TOPBOTTOMDOOR_OFS_Y:int = 0;
      
      private static const SOLIDBLANK:int = 2566;
      
      public static const SIDE_RIGHT:int = 0;
      
      public static const SIDE_LEFT:int = 1;
      
      public static const SIDE_TOP:int = 2;
      
      public static const SIDE_BOTTOM:int = 3;
      
      private var _waiting:Boolean = false;
      
      private var _doorType:int;
      
      private var _defense:int;
      
      private var BOSSDOOR_OPEN_DELAY:Number = 3.5;
      
      private var _willOpen:Boolean;
      
      private var _openTime:Number;
      
      private var _bossNum:int;
      
      public var fixBlocks:FixBlocks;
      
      public function blank(param1:int, param2:int) : void
      {
         if(PlayState.worldMap.bgmap.getTile(param1,param2) == SOLIDBLANK)
         {
            return;
         }
         this.fixBlocks.rememberBlock(param1,param2,PlayState.worldMap.bgmap.getTile(param1,param2),PlayState.worldMap.fgmap.getTile(param1,param2));
         PlayState.worldMap.bgmap.setTile(param1,param2,SOLIDBLANK);
      }
      
      override public function destroy() : void
      {
         fixBlocks = null;
         super.destroy();
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(this._bossNum != 0 && PlayState.isBossDead(this._bossNum) && this._doorType == 3)
         {
            _doorType = 0;
            _bossNum = 0;
            _openTime = this.BOSSDOOR_OPEN_DELAY;
            _willOpen = true;
         }
         _openTime -= FlxG.elapsed;
         if(this._willOpen && this._openTime <= 0)
         {
            this.fixBlocks.repairAll();
            this.hurt(2000);
            _willOpen = false;
         }
         if(this._waiting)
         {
            _loc1_ = PlayState.player.x - x;
            _loc2_ = PlayState.player.y - y;
            if(_loc1_ * _loc1_ + _loc2_ * _loc2_ > 70 * 70 || PlayState.player.isParalyzed())
            {
               play("close");
               solid = true;
               visible = true;
               _waiting = false;
               Sfx.playCloseDoor();
            }
         }
         else if(dead && finished)
         {
            exists = false;
            visible = false;
            solid = false;
            return;
         }
         super.update();
      }
      
      override public function hitRight(param1:FlxObject, param2:Number) : void
      {
         if(param1 is Player)
         {
            PlayState.player.x = int(PlayState.player.x);
         }
         super.hitRight(param1,param2);
      }
      
      override public function kill() : void
      {
         this.fixBlocks.repairAll();
         super.kill();
      }
      
      override public function hurt(param1:Number) : void
      {
         if(this._waiting)
         {
            return;
         }
         if(param1 <= this._defense)
         {
            if(this._bossNum == 0)
            {
               Sfx.playEnemyPingOffArmor();
            }
            return;
         }
         play("open");
         solid = false;
         dead = true;
         Sfx.playOpenDoor();
         this.fixBlocks.repairAll();
      }
      
      public function Door(param1:int, param2:int, param3:int, param4:int, param5:int = 0) : void
      {
         super(param1,param2,false);
         this._doorType = param4;
         this.fixBlocks = new FixBlocks();
         this._bossNum = param5;
         if(this._bossNum != 0 && PlayState.isBossDead(this._bossNum))
         {
            this._doorType = 0;
            this._bossNum = 0;
         }
         PlayState.doors.push(this);
         this._openTime = 0;
         this._willOpen = false;
         switch(this._doorType)
         {
            case 0:
               this._defense = 0;
               break;
            case 1:
               this._defense = 10;
               break;
            case 2:
               this._defense = 20;
               break;
            case 3:
               this._defense = 190;
               break;
            case 4:
               this._defense = 44;
			   break;
         }
         if(this._bossNum == 4 && !PlayState.bossRush)
         {
            this.BOSSDOOR_OPEN_DELAY = 11.3;
         }
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         switch(param3)
         {
            case SIDE_RIGHT:
               loadGraphic(Art.DoorVert,true,true,LEFTRIGHTDOOR_WIDTH,LEFTRIGHTDOOR_HEIGHT);
               width = LEFTRIGHTDOOR_WIDTH;
               height = LEFTRIGHTDOOR_HEIGHT;
               param1 -= LEFTRIGHTDOOR_OFS_X;
               param2 -= LEFTRIGHTDOOR_OFS_Y;
               if(this._bossNum != 0)
               {
                  this.blank(param1 / 16,param2 / 16);
                  this.blank(param1 / 16,param2 / 16 + 1);
                  this.blank(param1 / 16,param2 / 16 + 2);
               }
               _loc6_ = this._doorType * 2;
               _loc7_ = 10;
               break;
            case SIDE_LEFT:
               loadGraphic(Art.DoorVert,true,true,LEFTRIGHTDOOR_WIDTH,LEFTRIGHTDOOR_HEIGHT);
               width = LEFTRIGHTDOOR_WIDTH;
               height = LEFTRIGHTDOOR_HEIGHT;
               param1 -= LEFTRIGHTDOOR_OFS_X;
               param2 -= LEFTRIGHTDOOR_OFS_Y;
               if(this._bossNum != 0 && this._bossNum != 5)
               {
                  this.blank(param1 / 16,param2 / 16);
                  this.blank(param1 / 16,param2 / 16 + 1);
                  this.blank(param1 / 16,param2 / 16 + 2);
               }
               _loc6_ = this._doorType * 2 + 1;
               _loc7_ = 10;
               break;
            case SIDE_TOP:
               loadGraphic(Art.DoorHoriz,true,true,TOPBOTTOMDOOR_WIDTH,TOPBOTTOMDOOR_HEIGHT);
               width = TOPBOTTOMDOOR_WIDTH;
               height = TOPBOTTOMDOOR_HEIGHT;
               param1 -= TOPBOTTOMDOOR_OFS_X;
               param2 -= TOPBOTTOMDOOR_OFS_Y;
               _loc6_ = this._doorType * 12 + 6;
               _loc7_ = 1;
               break;
            case SIDE_BOTTOM:
               loadGraphic(Art.DoorHoriz,true,true,TOPBOTTOMDOOR_WIDTH,TOPBOTTOMDOOR_HEIGHT);
               width = TOPBOTTOMDOOR_WIDTH;
               height = TOPBOTTOMDOOR_HEIGHT;
               param1 -= TOPBOTTOMDOOR_OFS_X;
               param2 -= TOPBOTTOMDOOR_OFS_Y;
               _loc6_ = this._doorType * 12;
               _loc7_ = 1;
               break;
            default:
               throw new Error("Unknown door direction: " + param3.toString());
         }
         x = param1;
         y = param2;
         addAnimation("normal",[0 * _loc7_ + _loc6_]);
         addAnimation("open",[1 * _loc7_ + _loc6_,2 * _loc7_ + _loc6_,3 * _loc7_ + _loc6_,4 * _loc7_ + _loc6_,5 * _loc7_ + _loc6_],30,false);
         addAnimation("close",[5 * _loc7_ + _loc6_,4 * _loc7_ + _loc6_,3 * _loc7_ + _loc6_,2 * _loc7_ + _loc6_,1 * _loc7_ + _loc6_,0 * _loc7_ + _loc6_],30,false);
         fixed = true;
         solid = true;
         this._waiting = false;
         if(PlayState.player)
         {
            var _loc8_:int = PlayState.player.x - param1;
            var _loc9_:int = PlayState.player.y - param2;
            if(_loc8_ * _loc8_ + _loc9_ * _loc9_ < 50 * 50)
            {
               visible = false;
               solid = false;
               this._waiting = true;
            }
         }
         play("normal");
         active = true;
      }
   }
}

