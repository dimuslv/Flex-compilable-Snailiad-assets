package
{
   import org.flixel.*;
   
   public class ItemRate extends FlxText
   {
      private static const FADEOUT_START:Number = 1.8;
      
      private static const FADEOUT_END:Number = 2.5;
      
      private static var _fadeOutStart:Number;
      
      private static var _fadeOutEnd:Number;
      
      private static var _colorNum:Number;
      
      private static const _colors:Array = [16040160,16570500,11595992,12370116];
      
      public function ItemRate() : void
      {
         super(0,FlxG.height / 2 + 64,FlxG.width);
         font = Fonts.normal;
         size = 10;
         color = 16040160;
         _colorNum = 0;
         shadow = 1;
         alignment = "center";
         scrollFactor.x = scrollFactor.y = 0;
         outline = true;
         outlineColor = 4278190080;
         if(PlayState.bossRush)
         {
            visible = false;
         }
         else
         {
            visible = true;
         }
      }
      
      public function setRate(param1:int, param2:Number = 0) : void
      {
         _fadeOutStart = FADEOUT_START + param2;
         _fadeOutEnd = FADEOUT_END + param2;
         if(PlayState.bossRush)
         {
            return;
         }
         text = "ITEM COLLECTION " + param1.toString() + "% COMPLETE!";
         if(param1 == 100)
         {
            NgMedal.unlockTreasureHunter();
            text += "\nFIND THE SHRINE OF IRIS!";
            _fadeOutStart += 6;
            _fadeOutEnd += 6;
            size = 20;
            PlayState.player.hasWonBossRush = true;
            var _loc3_:SaveData = PlayState.saveData;
            _loc3_.loadAll();
            if(!_loc3_.isVarTrue("hasWonBossRush"))
            {
               delete _loc3_.xml.vars.hasWonBossRush;
               _loc3_.xml.vars.appendChild(<hasWonBossRush>true</hasWonBossRush>);
               text += "\n(SLUG MODE UNLOCKED!)";
            }
            _loc3_.saveAll();
         }
         else
         {
            text += "  GAME SAVED.";
            if(0 && PlayState.isBossDead(4))
            {
               text += "\n(ITEMS FOUND IN CURRENT AREA: " + PlayState.gottenItemsInArea() + "/" + PlayState.totalItemsInArea().toString() + ")";
            }
         }
         alpha = 1;
         active = true;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _colorNum += FlxG.elapsed * 30;
         color = _colors[int(_colorNum) % _colors.length];
         _fadeOutStart -= FlxG.elapsed;
         _fadeOutEnd -= FlxG.elapsed;
         if(_fadeOutEnd < 0)
         {
            text = "";
            active = false;
         }
         else if(_fadeOutStart < 0)
         {
            alpha = _fadeOutEnd / (FADEOUT_END - FADEOUT_START);
         }
         super.update();
      }
   }
}

