package
{
   import org.flixel.*;
   
   public class MiniMap extends FlxGroup
   {
      private static const IMG_TABSPRITE_WIDTH:int = 11;
      
      private static const IMG_TABSPRITE_HEIGHT:int = 5;
      
      private static const TABSPRITE_MARGIN:int = 2;
      
      private static const MARGIN:int = 4;
      
      private static const TILE_WIDTH:int = 8;
      
      private static const TILE_HEIGHT:int = 8;
      
      private static const DEFAULT_MAP_COLS:int = 7;
      
      private static const DEFAULT_MAP_ROWS:int = 5;
      
      public static const SIZE_X:int = 26;
      
      public static const SIZE_Y:int = 22;
      
      public static const ROOM_WIDTH:int = 26;
      
      public static const ROOM_HEIGHT:int = 16;
      
      private static const MAX_MAP_COLS:int = SIZE_X;
      
      private static const MAX_MAP_ROWS:int = SIZE_Y;
      
      private static const BLANK_TILE:String = "187";
      
      private static const FULL_OFS_Y:int = 24;
      
      public static const MAX_KNOWN:int = 324;
      
      private var totalKnownText:FlxText;
      
      private var mapRate:MapRate;
      
      private var skillText:SkillText;
      
      public var knownList:Array;
      
      private var tabSprite:FlxSprite;
      
      private var tabText:FlxText;
      
      private var DEFAULT_OFS_Y:int = 0;
      
      private var subOfsY:int = DEFAULT_OFS_Y;
      
      private var fullAlpha:Number = 0;
      
      private var targetFullAlpha:Number = 0;
      
      public var subscreen:Subscreen;
      
      private var _totalKnown:int = 0;
      
      private var mapCols:int = 7;
      
      private var mapRows:int = 5;
      
      private const SPECIAL_NONE:int = 0;
      
      private const SPECIAL_SAVE:int = 1;
      
      private const SPECIAL_ITEM:int = 2;
      
      private const SPECIAL_ITEMGOTTEN:int = 3;
      
      private const SPECIAL_BOSS:int = 4;
      
      private var _map:Array;
      
      private var _known:Array;
      
      private var _display:Array;
      
      private var _special:Array;
      
      private var _specialDisplay:Array;
      
      private var _lastX:int = 0;
      
      private var _lastY:int = 0;
      
      private var _center:FlxSprite;
      
      private function getXPos() : int
      {
         return FlxG.width - MARGIN - TILE_WIDTH * this.mapCols;
      }
      
      private function getYPos() : int
      {
         return MARGIN;
      }
      
      override public function destroy() : void
      {
         mapRate = null;
         totalKnownText = null;
         skillText = null;
         knownList = null;
         tabSprite = null;
         tabText = null;
         subscreen = null;
         super.destroy();
      }
      
      public function MiniMap() : void
      {
         this.subscreen = new Subscreen();
         add(this.subscreen);
         this.subscreen.hide();
         this.skillText = new SkillText();
         add(this.skillText);
         this.mapRate = new MapRate();
         add(this.mapRate);
         this.mapRate.visible = false;
         this._map = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < SIZE_Y)
         {
            this._map[_loc1_] = new Array();
            var _loc2_:int = 0;
            while(_loc2_ < SIZE_X)
            {
               this._map[_loc1_][_loc2_] = -1;
               _loc2_++;
            }
            _loc1_++;
         }
         this._known = new Array();
         _loc1_ = 0;
         while(_loc1_ < SIZE_Y)
         {
            this._known[_loc1_] = new Array();
            _loc2_ = 0;
            while(_loc2_ < SIZE_X)
            {
               this._known[_loc1_][_loc2_] = false;
               _loc2_++;
            }
            _loc1_++;
         }
         this._special = new Array();
         _loc1_ = 0;
         while(_loc1_ < SIZE_Y)
         {
            this._special[_loc1_] = new Array();
            _loc2_ = 0;
            while(_loc2_ < SIZE_X)
            {
               this._special[_loc1_][_loc2_] = this.SPECIAL_NONE;
               _loc2_++;
            }
            _loc1_++;
         }
         this._display = new Array();
         _loc1_ = 0;
         while(_loc1_ < MAX_MAP_ROWS)
         {
            this._display[_loc1_] = new Array();
            _loc2_ = 0;
            while(_loc2_ < MAX_MAP_COLS)
            {
               var _loc3_:FlxSprite = new FlxSprite();
               _loc3_.loadGraphic(Art.MiniMapSheet,false,false,TILE_WIDTH,TILE_HEIGHT);
               _loc3_.x = this.getXPos() + _loc2_ * TILE_WIDTH;
               _loc3_.y = this.getYPos() + _loc1_ * TILE_HEIGHT;
               _loc3_.exists = true;
               _loc3_.solid = false;
               _loc3_.scrollFactor.x = _loc3_.scrollFactor.y = 0;
               _loc3_.active = false;
               add(_loc3_);
               this._display[_loc1_][_loc2_] = _loc3_;
               var _loc4_:int = 0;
               while(_loc4_ < 240)
               {
                  _loc3_.addAnimation(_loc4_.toString(),[_loc4_]);
                  _loc3_.play(BLANK_TILE);
                  _loc4_++;
               }
               _loc2_++;
            }
            _loc1_++;
         }
         this._specialDisplay = new Array();
         _loc1_ = 0;
         while(_loc1_ < MAX_MAP_ROWS)
         {
            this._specialDisplay[_loc1_] = new Array();
            _loc2_ = 0;
            while(_loc2_ < MAX_MAP_COLS)
            {
               _loc3_ = new FlxSprite();
               _loc3_.loadGraphic(Art.MiniMapSpecialSheet,false,false,TILE_WIDTH,TILE_HEIGHT);
               _loc3_.x = this.getXPos() + _loc2_ * TILE_WIDTH;
               _loc3_.y = this.getYPos() + _loc1_ * TILE_HEIGHT;
               _loc3_.exists = true;
               _loc3_.solid = false;
               _loc3_.scrollFactor.x = _loc3_.scrollFactor.y = 0;
               _loc3_.active = false;
               add(_loc3_);
               this._specialDisplay[_loc1_][_loc2_] = _loc3_;
               _loc4_ = 0;
               while(_loc4_ < 5)
               {
                  _loc3_.addAnimation(_loc4_.toString(),[_loc4_]);
                  _loc3_.play("0");
                  _loc4_++;
               }
               _loc2_++;
            }
            _loc1_++;
         }
         this._center = new FlxSprite();
         this._center.loadGraphic(Art.MiniMapCenter,true,false,TILE_WIDTH,TILE_HEIGHT);
         this._center.x = this.getXPos() + TILE_WIDTH * this.getCenterCol();
         this._center.y = this.getYPos() + TILE_HEIGHT * this.getCenterRow() + this.subOfsY;
         this._center.addAnimation("normal",[0,1,2,2,1,0],4,true);
         this._center.addAnimation("special",[4,4,5,5],4,true);
         this._center.play("normal");
         this._center.exists = true;
         this._center.solid = false;
         this._center.scrollFactor.x = this._center.scrollFactor.y = 0;
         add(this._center);
         this.tabText = new FlxText(0,0,FlxG.width - 4);
         this.tabText.font = Fonts.normal;
         this.tabText.size = 10;
         this.tabText.color = 16777215;
         this.tabText.shadow = 1;
         this.tabText.x = FlxG.width - MARGIN - this.tabText.realWidth - TABSPRITE_MARGIN;
         this.tabText.y = MARGIN + TILE_HEIGHT * DEFAULT_MAP_ROWS - this.tabText.realHeight - TABSPRITE_MARGIN;
         this.tabText.scrollFactor.x = this.tabText.scrollFactor.y = 0;
         this.tabText.setShadowDistance(1);
         this.tabText.visible = true;
         add(this.tabText);
         this.totalKnownText = new FlxText(0,0,FlxG.width - 4);
         this.totalKnownText.font = Fonts.normal;
         this.totalKnownText.size = 10;
         this.totalKnownText.color = 16777215;
         this.totalKnownText.shadow = 1;
         this.totalKnownText.alignment = "right";
         this.totalKnownText.scrollFactor.x = this.totalKnownText.scrollFactor.y = 0;
         this.totalKnownText.setShadowDistance(1);
         this.totalKnownText.visible = false;
         add(this.totalKnownText);
         this.resizeMiniMap(DEFAULT_MAP_COLS,DEFAULT_MAP_ROWS,this.DEFAULT_OFS_Y);
      }
      
      private function getCenterCol() : int
      {
         return (this.mapCols - 1) / 2;
      }
      
      private function getCenterRow() : int
      {
         return (this.mapRows - 1) / 2;
      }
      
      private function getMapOfsX() : int
      {
         return -this.getCenterCol();
      }
      
      private function getMapOfsY() : int
      {
         return -this.getCenterRow();
      }
      
      public function setMapBig() : void
      {
         this.resizeMiniMap(SIZE_X,SIZE_Y,FULL_OFS_Y);
         this.mapRate.visible = true;
         this.skillText.visible = true;
         this.tabText.visible = false;
         this.skillText.updateText();
         if(!PlayState.bossRush)
         {
            PlayState.gameTimeDisplay.visible = true;
            PlayState.itemRateHud.visible = true;
            PlayState.realState = PlayState.STATE_SUBSCREEN;
            PlayState.controlHelp.visible = false;
            PlayState.savingText.visible = false;
            this.subscreen.show();
         }
      }
      
      public function setMapLittle() : void
      {
         this.resizeMiniMap(DEFAULT_MAP_COLS,DEFAULT_MAP_ROWS,this.DEFAULT_OFS_Y);
         this.mapRate.visible = false;
         this.skillText.visible = false;
         this.tabText.visible = true;
         PlayState.gameTimeDisplay.visible = false;
         PlayState.itemRateHud.visible = false;
         if(PlayState.realState == PlayState.STATE_SUBSCREEN)
         {
            PlayState.realState = PlayState.STATE_GAME;
         }
         PlayState.controlHelp.visible = true;
         PlayState.savingText.visible = true;
         this.subscreen.hide();
      }
      
      public function toggleMapSize() : void
      {
         if(this.mapRows < 10)
         {
            this.setMapBig();
         }
         else
         {
            this.setMapLittle();
         }
      }
      
      public function updateMiniMapPos() : void
      {
         var _loc1_:int = this.getXPos();
         var _loc2_:int = this.getYPos() + this.subOfsY + this.subscreen.panel.y;
         var _loc3_:int = 0;
         while(_loc3_ < MAX_MAP_ROWS)
         {
            var _loc8_:int = 0;
            while(_loc8_ < MAX_MAP_COLS)
            {
               this._display[_loc3_][_loc8_].x = _loc1_ + _loc8_ * TILE_WIDTH;
               this._display[_loc3_][_loc8_].y = _loc2_ + _loc3_ * TILE_HEIGHT;
               this._specialDisplay[_loc3_][_loc8_].x = _loc1_ + _loc8_ * TILE_WIDTH;
               this._specialDisplay[_loc3_][_loc8_].y = _loc2_ + _loc3_ * TILE_HEIGHT;
               _loc8_++;
            }
            _loc3_++;
         }
         var _loc4_:int = PlayState.player.x / 16 / ROOM_WIDTH;
         var _loc5_:int = PlayState.player.y / 16 / ROOM_HEIGHT;
         var _loc6_:int = (this.mapRows > 10)? _loc4_ : this.getCenterCol();
         var _loc7_:int = (this.mapRows > 10)? _loc5_ : this.getCenterRow();
         this._center.x = _loc1_ + TILE_WIDTH * _loc6_;
         this._center.y = _loc2_ + TILE_HEIGHT * _loc7_;
      }
      
      public function resizeMiniMap(param1:int, param2:int, param3:int) : void
      {
         if(param3 == 0 && (PlayState.hideMiniMap || PlayState.hud.bossBarHud.isShown()))
         {
            param3 = -FlxG.height;
         }
         mapRows = param2;
         mapCols = param1;
         subOfsY = param3;
         var _loc4_:int = this.getXPos();
         var _loc5_:int = this.getYPos() + param3;
         var _loc6_:int = 0;
         while(_loc6_ < MAX_MAP_ROWS)
         {
            var _loc11_:int = 0;
            while(_loc11_ < MAX_MAP_COLS)
            {
               this._display[_loc6_][_loc11_].visible = _loc6_ < param2 && _loc11_ < param1;
               this._display[_loc6_][_loc11_].x = _loc4_ + _loc11_ * TILE_WIDTH;
               this._display[_loc6_][_loc11_].y = _loc5_ + _loc6_ * TILE_HEIGHT;
               this._specialDisplay[_loc6_][_loc11_].visible = _loc6_ < param2 && _loc11_ < param1;
               this._specialDisplay[_loc6_][_loc11_].x = _loc4_ + _loc11_ * TILE_WIDTH;
               this._specialDisplay[_loc6_][_loc11_].y = _loc5_ + _loc6_ * TILE_HEIGHT;
               _loc11_++;
            }
            _loc6_++;
         }
         var _loc7_:int = PlayState.player.x / 16 / ROOM_WIDTH;
         var _loc8_:int = PlayState.player.y / 16 / ROOM_HEIGHT;
         var _loc9_:int = (this.mapRows > 10)? _loc7_ : this.getCenterCol();
         var _loc10_:int = (this.mapRows > 10)? _loc8_ : this.getCenterRow();
         this._center.x = _loc4_ + TILE_WIDTH * _loc9_;
         this._center.y = _loc5_ + TILE_HEIGHT * _loc10_;
         _lastX = -1;
         _lastY = -1;
      }
      
      public function updateMiniMap(param1:Boolean = false) : void
      {
         var _loc2_:int = PlayState.player.x / 16 / ROOM_WIDTH;
         var _loc3_:int = PlayState.player.y / 16 / ROOM_HEIGHT;
         if(_loc2_ == this._lastX && _loc3_ == this._lastY && !param1)
         {
            return;
         }
         _lastX = _loc2_;
         _lastY = _loc3_;
         var _loc4_:Boolean = this.mapRows > 10;
         var _loc5_:int = _loc4_ ? _loc2_ : this.getCenterCol();
         var _loc6_:int = _loc4_ ? _loc3_ : this.getCenterRow();
         if(!PlayState.player.dead)
         {
            this.setKnown(PlayState.player.x,PlayState.player.y,true);
         }
         var _loc7_:int = this.getMapOfsX();
         var _loc8_:int = this.getMapOfsY();
         var _loc9_:int = this.getXPos();
         var _loc10_:int = this.getYPos();
         this._center.x = _loc9_ + TILE_WIDTH * _loc5_;
         this._center.y = _loc10_ + TILE_HEIGHT * _loc6_ + this.subOfsY;
         var _loc11_:int = 0;
         while(_loc11_ < this.mapRows)
         {
            var _loc12_:int = 0;
            while(_loc12_ < this.mapCols)
            {
               var _loc13_:int = _loc4_ ? _loc12_ : _loc2_ + _loc12_ + _loc7_;
               var _loc14_:int = _loc4_ ? _loc11_ : _loc3_ + _loc11_ + _loc8_;
               if(_loc14_ < 0 || _loc13_ < 0 || _loc14_ >= SIZE_Y || _loc13_ >= SIZE_X || this._map[_loc14_][_loc13_] < 0 || !this._known[_loc14_][_loc13_])
               {
                  this._display[_loc11_][_loc12_].play(BLANK_TILE);
                  this._specialDisplay[_loc11_][_loc12_].play("0");
               }
               else
               {
                  this._display[_loc11_][_loc12_].play(this._map[_loc14_][_loc13_].toString());
                  this._specialDisplay[_loc11_][_loc12_].play(this._special[_loc14_][_loc13_].toString());
                  if(_loc11_ == _loc6_ && _loc12_ == _loc5_)
                  {
                     if(this._special[_loc14_][_loc13_] == this.SPECIAL_NONE)
                     {
                        this._center.play("normal");
                     }
                     else
                     {
                        this._center.play("special");
                     }
                  }
               }
               _loc12_++;
            }
            _loc11_++;
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME && PlayState.realState != PlayState.STATE_SUBSCREEN)
         {
            return;
         }
         if(PlayState.realState == PlayState.STATE_SUBSCREEN)
         {
            this.updateMiniMapPos();
         }
         super.update();
         this.updateMiniMap();
      }
      
      public function setKnown(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:int = param1 / 16 / ROOM_WIDTH;
         var _loc5_:int = param2 / 16 / ROOM_HEIGHT;
         if((_loc4_ != 0 || _loc5_ != 0) && !this._known[_loc5_][_loc4_] && this._map[_loc5_][_loc4_] >= 0)
         {
            ++this._totalKnown;
            this.totalKnownText.text = this._totalKnown.toString() + " ROOMS";
            this.mapRate.setRate(this._totalKnown / MAX_KNOWN);
            if(this.knownList.length == 0 || this.knownList[this.knownList.length - 1].x != param1 || this.knownList[this.knownList.length - 1].y != param2)
            {
               this.knownList.push(new FlxPoint(param1,param2));
            }
            this._known[_loc5_][_loc4_] = true;
         }
      }
      
      public function saveAll() : void
      {
         var _loc1_:XML = <mapData/>;
         var _loc2_:int = 0;
         while(_loc2_ < this.knownList.length)
         {
            var _loc3_:int = this.knownList[_loc2_].x;
            var _loc4_:int = this.knownList[_loc2_].y;
            var _loc5_:int = _loc3_ / 16 / ROOM_WIDTH;
            var _loc6_:int = _loc4_ / 16 / ROOM_HEIGHT;
            var _loc7_:XML = <k/>;
            _loc7_.@x = _loc3_;
            _loc7_.@y = _loc4_;
            _loc7_.@i = _loc5_;
            _loc7_.@j = _loc6_;
            _loc7_.@k = this._map[_loc6_][_loc5_];
            _loc7_.@l = this._special[_loc6_][_loc5_];
            _loc1_.appendChild(_loc7_);
            _loc2_++;
         }
         if(PlayState.saveData.xml.mapData != null)
         {
            delete PlayState.saveData.xml.mapData;
         }
         PlayState.saveData.xml.appendChild(_loc1_);
      }
      
      public function loadAll() : void
      {
         var _loc1_:XML = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         knownList = new Array();
         if(!PlayState.saveData.data)
         {
            return;
         }
         for each(_loc1_ in PlayState.saveData.xml.mapData.k)
         {
            _loc2_ = _loc1_.@x;
            _loc3_ = _loc1_.@y;
            _loc4_ = _loc1_.@i;
            _loc5_ = _loc1_.@j;
            this._map[_loc5_][_loc4_] = _loc1_.@k;
            this._special[_loc5_][_loc4_] = _loc1_.@l;
            this.knownList.push(new FlxPoint(_loc2_,_loc3_));
            this.setKnown(_loc2_,_loc3_,true);
         }
         this.updateMiniMap(true);
      }
      
      public function setSpecialSave(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 / 16 / ROOM_WIDTH;
         var _loc4_:int = param2 / 16 / ROOM_HEIGHT;
         this._special[_loc4_][_loc3_] = this.SPECIAL_SAVE;
      }
      
      public function setSpecialItem(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 / 16 / ROOM_WIDTH;
         var _loc4_:int = param2 / 16 / ROOM_HEIGHT;
         this._special[_loc4_][_loc3_] = this.SPECIAL_ITEM;
      }
      
      public function setSpecialBoss(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 / 16 / ROOM_WIDTH;
         var _loc4_:int = param2 / 16 / ROOM_HEIGHT;
         this._special[_loc4_][_loc3_] = this.SPECIAL_BOSS;
      }
      
      public function setSpecialItemGotten(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 / 16 / ROOM_WIDTH;
         var _loc4_:int = param2 / 16 / ROOM_HEIGHT;
         this._special[_loc4_][_loc3_] = this.SPECIAL_NONE;
         this.updateMiniMap(true);
      }
      
      public function setTile(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = param1 / 16 / ROOM_WIDTH;
         var _loc5_:int = param2 / 16 / ROOM_HEIGHT;
         this._map[_loc5_][_loc4_] = param3;
      }
   }
}

