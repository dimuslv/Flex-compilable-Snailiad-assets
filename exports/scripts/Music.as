package
{
   import org.flixel.FlxG;
   
   public class Music
   {
      private static var SONG_NONE:int = 0;
      
      private static var SONG_TOWN:int = 1;
      
      private static var SONG_AREA1:int = 2;
      
      private static var SONG_AREA2:int = 3;
      
      private static var SONG_AREA3:int = 4;
      
      private static var SONG_AREA4:int = 5;
      
      private static var SONG_BOSS1:int = 6;
      
      private static var SONG_BOSS2:int = 7;
      
      private static var SONG_ENDING2:int = 9;
      
      private static var SONG_TITLE:int = 10;
      
      private static var SONG_ISIS:int = 11;
      
      private static var lastSong:int = SONG_NONE;
      
      private static var prevSong:int = SONG_NONE;
      
      public function Music()
      {
         super();
      }
      
      public static function playTown() : void
      {
         playSong(SONG_TOWN);
      }
      
      public static function playArea1() : void
      {
         playSong(SONG_AREA1);
      }
      
      public static function playArea2() : void
      {
         playSong(SONG_AREA2);
      }
      
      public static function playArea3() : void
      {
         playSong(SONG_AREA3);
      }
      
      public static function playArea4() : void
      {
         playSong(SONG_AREA4);
      }
      
      public static function playBoss1() : void
      {
         playSong(SONG_BOSS1);
      }
      
      public static function playBoss2() : void
      {
         playSong(SONG_BOSS2);
      }
      
      public static function playEnding2() : void
      {
         playSong(SONG_ENDING2);
      }
      
      public static function playTitle() : void
      {
         playSong(SONG_TITLE);
      }
      
      public static function playIsis() : void
      {
         playSong(SONG_ISIS);
      }
      
      public static function playNone() : void
      {
         playSong(SONG_NONE);
      }
      
      public static function playPrevSong() : void
      {
         playSong(prevSong);
      }
      
      private static function playSong(param1:int) : void
      {
         if(param1 == lastSong)
         {
            return;
         }
         prevSong = lastSong;
         lastSong = param1;
         var _loc2_:Class = Music_Area3Song;
         var _loc3_:Class = Music_TownSong;
         var _loc4_:Class = Music_Boss1Song;
         var _loc5_:Class = Music_TitleSong;
         var _loc6_:Class = Music_IsisSong;
         var _loc7_:Class = Music_Area1Song;
         var _loc8_:Class = Music_Area2Song;
         var _loc9_:Class = Music_Area4Song;
         var _loc10_:Class = Music_Boss2Song;
         var _loc11_:Class = Music_Ending2Song;
         switch(param1)
         {
            case SONG_TOWN:
               FlxG.playMusic(_loc3_,0.85);
               break;
            case SONG_AREA1:
               FlxG.playMusic(_loc7_,0.77);
               break;
            case SONG_AREA2:
               FlxG.playMusic(_loc8_,0.85);
               break;
            case SONG_AREA3:
               FlxG.playMusic(_loc2_,0.74);
               break;
            case SONG_AREA4:
               FlxG.playMusic(_loc9_,0.78);
               break;
            case SONG_BOSS1:
               FlxG.playMusic(_loc4_,1);
               break;
            case SONG_BOSS2:
               FlxG.playMusic(_loc10_,0.85);
               break;
            case SONG_ENDING2:
               FlxG.playMusic(_loc11_,0.75);
               break;
            case SONG_TITLE:
               FlxG.playMusic(_loc5_,0.74);
               break;
            case SONG_ISIS:
               FlxG.playMusic(_loc6_,0.3);
               break;
            case SONG_NONE:
               FlxG.music.stop();
         }
      }
   }
}

