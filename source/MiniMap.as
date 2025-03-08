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
         return FlxG.width - MARGIN - TILE_WIDTH * mapCols;
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
         subscreen = new Subscreen();
         add(subscreen);
         subscreen.hide();
         skillText = new SkillText();
         add(skillText);
         mapRate = new MapRate();
         add(mapRate);
         mapRate.visible = false;
         _map = new Array();
         for (var i:int = 0; i < SIZE_Y; i++)
         {
            _map[i] = new Array();
            for (var j:int = 0; j < SIZE_X; j++)
            {
               _map[i][j] = -1;
            }
         }
         _known = new Array();
         for (i = 0; i < SIZE_Y; i++)
         {
            _known[i] = new Array();
            for (j = 0; j < SIZE_X; j++)
            {
               _known[i][j] = false;
            }
         }
         _special = new Array();
         for (i = 0; i < SIZE_Y; i++)
         {
            _special[i] = new Array();
            for (j = 0; j < SIZE_X; j++)
            {
               _special[i][j] = SPECIAL_NONE;
            }
         }
         _display = new Array();
         for (i = 0; i < MAX_MAP_ROWS; i++)
         {
            _display[i] = new Array();
            for (j = 0; j < MAX_MAP_COLS; j++)
            {
               var _loc3_:FlxSprite = new FlxSprite();
               _loc3_.loadGraphic(Art.MiniMapSheet,false,false,TILE_WIDTH,TILE_HEIGHT);
               _loc3_.x = getXPos() + j * TILE_WIDTH;
               _loc3_.y = getYPos() + i * TILE_HEIGHT;
               _loc3_.exists = true;
               _loc3_.solid = false;
               _loc3_.scrollFactor.x = _loc3_.scrollFactor.y = 0;
               _loc3_.active = false;
               add(_loc3_);
               _display[i][j] = _loc3_;
               for (var k:int = 0; k < 240; k++)
               {
                  _loc3_.addAnimation(k.toString(),[k]);
                  _loc3_.play(BLANK_TILE);
               }
            }
         }
         _specialDisplay = new Array();
         for (i = 0; i < MAX_MAP_ROWS; i++)
         {
            _specialDisplay[i] = new Array();
            for (j = 0; j < MAX_MAP_COLS; j++)
            {
               _loc3_ = new FlxSprite();
               _loc3_.loadGraphic(Art.MiniMapSpecialSheet,false,false,TILE_WIDTH,TILE_HEIGHT);
               _loc3_.x = getXPos() + j * TILE_WIDTH;
               _loc3_.y = getYPos() + i * TILE_HEIGHT;
               _loc3_.exists = true;
               _loc3_.solid = false;
               _loc3_.scrollFactor.x = _loc3_.scrollFactor.y = 0;
               _loc3_.active = false;
               add(_loc3_);
               _specialDisplay[i][j] = _loc3_;
               for (k = 0; k < 5; k++)
               {
                  _loc3_.addAnimation(k.toString(),[k]);
                  _loc3_.play("0");
               }
            }
         }
         _center = new FlxSprite();
         _center.loadGraphic(Art.MiniMapCenter,true,false,TILE_WIDTH,TILE_HEIGHT);
         _center.x = getXPos() + TILE_WIDTH * getCenterCol();
         _center.y = getYPos() + TILE_HEIGHT * getCenterRow() + subOfsY;
         _center.addAnimation("normal",[0,1,2,2,1,0],4,true);
         _center.addAnimation("special",[4,4,5,5],4,true);
         _center.play("normal");
         _center.exists = true;
         _center.solid = false;
         _center.scrollFactor.x = _center.scrollFactor.y = 0;
         add(_center);
         tabText = new FlxText(0,0,FlxG.width - 4);
         tabText.font = Fonts.normal;
         tabText.size = 10;
         tabText.color = 16777215;
         tabText.shadow = 1;
         tabText.x = FlxG.width - MARGIN - tabText.realWidth - TABSPRITE_MARGIN;
         tabText.y = MARGIN + TILE_HEIGHT * DEFAULT_MAP_ROWS - tabText.realHeight - TABSPRITE_MARGIN;
         tabText.scrollFactor.x = tabText.scrollFactor.y = 0;
         tabText.setShadowDistance(1);
         tabText.visible = true;
         add(tabText);
         totalKnownText = new FlxText(0,0,FlxG.width - 4);
         totalKnownText.font = Fonts.normal;
         totalKnownText.size = 10;
         totalKnownText.color = 16777215;
         totalKnownText.shadow = 1;
         totalKnownText.alignment = "right";
         totalKnownText.scrollFactor.x = totalKnownText.scrollFactor.y = 0;
         totalKnownText.setShadowDistance(1);
         totalKnownText.visible = false;
         add(totalKnownText);
         resizeMiniMap(DEFAULT_MAP_COLS,DEFAULT_MAP_ROWS,DEFAULT_OFS_Y);
      }
      
      private function getCenterCol() : int
      {
         return (mapCols - 1) / 2;
      }
      
      private function getCenterRow() : int
      {
         return (mapRows - 1) / 2;
      }
      
      private function getMapOfsX() : int
      {
         return -getCenterCol();
      }
      
      private function getMapOfsY() : int
      {
         return -getCenterRow();
      }
      
      public function setMapBig() : void
      {
         resizeMiniMap(SIZE_X,SIZE_Y,FULL_OFS_Y);
         mapRate.visible = true;
         skillText.visible = true;
         tabText.visible = false;
         skillText.updateText();
         if(!PlayState.bossRush)
         {
            PlayState.gameTimeDisplay.visible = true;
            PlayState.itemRateHud.visible = true;
            PlayState.realState = PlayState.STATE_SUBSCREEN;
            PlayState.controlHelp.visible = false;
            PlayState.savingText.visible = false;
            subscreen.show();
         }
      }
      
      public function setMapLittle() : void
      {
         resizeMiniMap(DEFAULT_MAP_COLS,DEFAULT_MAP_ROWS,DEFAULT_OFS_Y);
         mapRate.visible = false;
         skillText.visible = false;
         tabText.visible = true;
         PlayState.gameTimeDisplay.visible = false;
         PlayState.itemRateHud.visible = false;
         if(PlayState.realState == PlayState.STATE_SUBSCREEN)
         {
            PlayState.realState = PlayState.STATE_GAME;
         }
         PlayState.controlHelp.visible = true;
         PlayState.savingText.visible = true;
         subscreen.hide();
      }
      
      public function toggleMapSize() : void
      {
         if(mapRows < 10)
         {
            setMapBig();
         }
         else
         {
            setMapLittle();
         }
      }
      
      public function updateMiniMapPos() : void
      {
         var _loc1_:int = getXPos();
         var _loc2_:int = getYPos() + subOfsY + subscreen.panel.y;
         for (var i:int = 0; i < MAX_MAP_ROWS; i++)
         {
            for (var j:int = 0; j < MAX_MAP_COLS; j++)
            {
               _display[i][j].x = _loc1_ + j * TILE_WIDTH;
               _display[i][j].y = _loc2_ + i * TILE_HEIGHT;
               _specialDisplay[i][j].x = _loc1_ + j * TILE_WIDTH;
               _specialDisplay[i][j].y = _loc2_ + i * TILE_HEIGHT;
            }
         }
         var _loc4_:int = PlayState.player.x / 16 / ROOM_WIDTH;
         var _loc5_:int = PlayState.player.y / 16 / ROOM_HEIGHT;
         var _loc6_:int = (mapRows > 10)? _loc4_ : getCenterCol();
         var _loc7_:int = (mapRows > 10)? _loc5_ : getCenterRow();
         _center.x = _loc1_ + TILE_WIDTH * _loc6_;
         _center.y = _loc2_ + TILE_HEIGHT * _loc7_;
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
         var _loc4_:int = getXPos();
         var _loc5_:int = getYPos() + param3;
         for (var i:int = 0; i < MAX_MAP_ROWS; i++)
         {
            for (var j:int = 0; j < MAX_MAP_COLS; j++)
            {
               _display[i][j].visible = i < param2 && j < param1;
               _display[i][j].x = _loc4_ + j * TILE_WIDTH;
               _display[i][j].y = _loc5_ + i * TILE_HEIGHT;
               _specialDisplay[i][j].visible = i < param2 && j < param1;
               _specialDisplay[i][j].x = _loc4_ + j * TILE_WIDTH;
               _specialDisplay[i][j].y = _loc5_ + i * TILE_HEIGHT;
            }
         }
         var _loc7_:int = PlayState.player.x / 16 / ROOM_WIDTH;
         var _loc8_:int = PlayState.player.y / 16 / ROOM_HEIGHT;
         var _loc9_:int = (mapRows > 10)? _loc7_ : getCenterCol();
         var _loc10_:int = (mapRows > 10)? _loc8_ : getCenterRow();
         _center.x = _loc4_ + TILE_WIDTH * _loc9_;
         _center.y = _loc5_ + TILE_HEIGHT * _loc10_;
         _lastX = -1;
         _lastY = -1;
      }
      
      public function updateMiniMap(param1:Boolean = false) : void
      {
         var _loc2_:int = PlayState.player.x / 16 / ROOM_WIDTH;
         var _loc3_:int = PlayState.player.y / 16 / ROOM_HEIGHT;
         if(_loc2_ == _lastX && _loc3_ == _lastY && !param1)
         {
            return;
         }
         _lastX = _loc2_;
         _lastY = _loc3_;
         var _loc4_:Boolean = mapRows > 10;
         var _loc5_:int = _loc4_ ? _loc2_ : getCenterCol();
         var _loc6_:int = _loc4_ ? _loc3_ : getCenterRow();
         if(!PlayState.player.dead)
         {
            setKnown(PlayState.player.x,PlayState.player.y,true);
         }
         var _loc7_:int = getMapOfsX();
         var _loc8_:int = getMapOfsY();
         var _loc9_:int = getXPos();
         var _loc10_:int = getYPos();
         _center.x = _loc9_ + TILE_WIDTH * _loc5_;
         _center.y = _loc10_ + TILE_HEIGHT * _loc6_ + subOfsY;
         for (var i:int = 0; i < mapRows; i++)
         {
            for (var j:int = 0; j < mapCols; j++)
            {
               var _loc13_:int = _loc4_ ? j : _loc2_ + j + _loc7_;
               var _loc14_:int = _loc4_ ? i : _loc3_ + i + _loc8_;
               if(_loc14_ < 0 || _loc13_ < 0 || _loc14_ >= SIZE_Y || _loc13_ >= SIZE_X || _map[_loc14_][_loc13_] < 0 || !_known[_loc14_][_loc13_])
               {
                  _display[i][j].play(BLANK_TILE);
                  _specialDisplay[i][j].play("0");
               }
               else
               {
                  _display[i][j].play(_map[_loc14_][_loc13_].toString());
                  _specialDisplay[i][j].play(_special[_loc14_][_loc13_].toString());
                  if(i == _loc6_ && j == _loc5_)
                  {
                     if(_special[_loc14_][_loc13_] == SPECIAL_NONE)
                     {
                        _center.play("normal");
                     }
                     else
                     {
                        _center.play("special");
                     }
                  }
               }
            }
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
            updateMiniMapPos();
         }
         super.update();
         updateMiniMap();
      }
      
      public function setKnown(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:int = param1 / 16 / ROOM_WIDTH;
         var _loc5_:int = param2 / 16 / ROOM_HEIGHT;
         if((_loc4_ != 0 || _loc5_ != 0) && !_known[_loc5_][_loc4_] && _map[_loc5_][_loc4_] >= 0)
         {
            ++_totalKnown;
            totalKnownText.text = _totalKnown.toString() + " ROOMS";
            mapRate.setRate(_totalKnown / MAX_KNOWN);
            if(knownList.length == 0 || knownList[knownList.length - 1].x != param1 || knownList[knownList.length - 1].y != param2)
            {
               knownList.push(new FlxPoint(param1,param2));
            }
            _known[_loc5_][_loc4_] = true;
         }
      }
      
      public function saveAll() : void
      {
         var _loc1_:XML = <mapData/>;
         for (var i:int = 0; i < knownList.length; i++)
         {
            var _loc3_:int = knownList[i].x;
            var _loc4_:int = knownList[i].y;
            var _loc5_:int = _loc3_ / 16 / ROOM_WIDTH;
            var _loc6_:int = _loc4_ / 16 / ROOM_HEIGHT;
            var _loc7_:XML = <k/>;
            _loc7_.@x = _loc3_;
            _loc7_.@y = _loc4_;
            _loc7_.@i = _loc5_;
            _loc7_.@j = _loc6_;
            _loc7_.@k = _map[_loc6_][_loc5_];
            _loc7_.@l = _special[_loc6_][_loc5_];
            _loc1_.appendChild(_loc7_);
         }
         if(PlayState.saveData.xml.mapData != null)
         {
            delete PlayState.saveData.xml.mapData;
         }
         PlayState.saveData.xml.appendChild(_loc1_);
      }
      
      public function loadAll() : void
      {
         knownList = new Array();
         if(!PlayState.saveData.data)
         {
            return;
         }
         for each(var i:XML in PlayState.saveData.xml.mapData.k)
         {
            var _loc2_:int = i.@x;
            var _loc3_:int = i.@y;
            var _loc4_:int = i.@i;
            var _loc5_:int = i.@j;
            _map[_loc5_][_loc4_] = i.@k;
            _special[_loc5_][_loc4_] = i.@l;
            knownList.push(new FlxPoint(_loc2_,_loc3_));
            setKnown(_loc2_,_loc3_,true);
         }
         updateMiniMap(true);
      }
      
      public function setSpecialSave(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 / 16 / ROOM_WIDTH;
         var _loc4_:int = param2 / 16 / ROOM_HEIGHT;
         _special[_loc4_][_loc3_] = SPECIAL_SAVE;
      }
      
      public function setSpecialItem(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 / 16 / ROOM_WIDTH;
         var _loc4_:int = param2 / 16 / ROOM_HEIGHT;
         _special[_loc4_][_loc3_] = SPECIAL_ITEM;
      }
      
      public function setSpecialBoss(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 / 16 / ROOM_WIDTH;
         var _loc4_:int = param2 / 16 / ROOM_HEIGHT;
         _special[_loc4_][_loc3_] = SPECIAL_BOSS;
      }
      
      public function setSpecialItemGotten(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 / 16 / ROOM_WIDTH;
         var _loc4_:int = param2 / 16 / ROOM_HEIGHT;
         _special[_loc4_][_loc3_] = SPECIAL_NONE;
         updateMiniMap(true);
      }
      
      public function setTile(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = param1 / 16 / ROOM_WIDTH;
         var _loc5_:int = param2 / 16 / ROOM_HEIGHT;
         _map[_loc5_][_loc4_] = param3;
      }
   }
}

