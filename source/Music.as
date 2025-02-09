package
{
    import org.flixel.*;

    public class Music
    {
        static public function playTown():void   { playSong(SONG_TOWN);   }
        static public function playArea1():void  { playSong(SONG_AREA1);  }
        static public function playArea2():void  { playSong(SONG_AREA2);  }
        static public function playArea3():void  { playSong(SONG_AREA3);  }
        static public function playArea4():void  { playSong(SONG_AREA4);  }
        static public function playBoss1():void  { playSong(SONG_BOSS1);  }
        static public function playBoss2():void  { playSong(SONG_BOSS2);  }
        static public function playEnding2():void { playSong(SONG_ENDING2); }
        static public function playTitle():void  { playSong(SONG_TITLE);  }
        static public function playIsis():void   { playSong(SONG_ISIS);   }
        static public function playNone():void   { playSong(SONG_NONE);   }

        static private var SONG_NONE:int    = 0;
        static private var SONG_TOWN:int    = 1;
        static private var SONG_AREA1:int   = 2;
        static private var SONG_AREA2:int   = 3;
        static private var SONG_AREA3:int   = 4;
        static private var SONG_AREA4:int   = 5;
        static private var SONG_BOSS1:int   = 6;
        static private var SONG_BOSS2:int   = 7;
        static private var SONG_ENDING2:int = 9;
        static private var SONG_TITLE:int   = 10;
        static private var SONG_ISIS:int    = 11;

        static private var lastSong:int = SONG_NONE;
        static private var prevSong:int = SONG_NONE;

        static public function playPrevSong():void
        {
            playSong(prevSong);
        }

        static private function playSong(songNum:int):void
        {
            if (songNum == lastSong)
                return;

            //prevSong = lastSong;
            lastSong = songNum;

            [Embed(source = 'data/music/music64kbit.swf', symbol='amastrida1loop')]  const Area3Song:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='snailtownloop2')]  const TownSong:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='boss1loop')]       const Boss1Song:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='introloop')]       const TitleSong:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='isisloop')]        const IsisSong:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='carelia1loop2')]   const Area1Song:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='spiralis1loop')]   const Area2Song:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='lirata2loop')]     const Area4Song:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='moonsnail1loop')]  const Boss2Song:Class;
            [Embed(source = 'data/music/music64kbit.swf', symbol='endingpart2loop')] const Ending2Song:Class;

            switch (songNum)
            {
                case SONG_TOWN:    FlxG.playMusic(TownSong,    0.85); break;
                case SONG_AREA1:   FlxG.playMusic(Area1Song,   0.77); break;
                case SONG_AREA2:   FlxG.playMusic(Area2Song,   0.85); break;
                case SONG_AREA3:   FlxG.playMusic(Area3Song,   0.74); break;
                case SONG_AREA4:   FlxG.playMusic(Area4Song,   0.78); break;
                case SONG_BOSS1:   FlxG.playMusic(Boss1Song,   1.00); break;
                case SONG_BOSS2:   FlxG.playMusic(Boss2Song,   0.85); break;
                case SONG_ENDING2: FlxG.playMusic(Ending2Song, 0.75); break;
                case SONG_TITLE:   FlxG.playMusic(TitleSong,   0.74); break;
                case SONG_ISIS:    FlxG.playMusic(IsisSong,    0.30); break;
                case SONG_NONE:    FlxG.music.stop();                 break;
            }
        }
    }
}