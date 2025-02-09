package
{
   import flash.utils.getTimer;
   import org.flixel.FlxG;
   import org.flixel.FlxSound;
   import org.flixel.FlxU;
   
   public class Sfx
   {
      public static var EndingSfx:FlxSound;
      
      public static const MENUBEEP_TIMEOUT:int = 30;
      
      public static var nextMenuBeep:int = 0;
      
      public static const SNELK_TIMEOUT:int = 50;
      
      public static var nextSnelk:int = 0;
      
      public static const JUMP_TIMEOUT:int = 60;
      
      public static var nextJump:int = 0;
      
      public static const GROW_TIMEOUT:int = 30;
      
      public static var nextGrow:int = 0;
      
      public static const SHOT7_TIMEOUT:int = 30;
      
      public static var nextShot7:int = 0;
      
      public static const LASER_TIMEOUT:int = 30;
      
      public static var nextLaser:int = 0;
      
      public static const SHOTHIT_TIMEOUT:int = 30;
      
      public static var nextShotHit:int = 0;
      
      public static const SHOT1B_TIMEOUT:int = 15;
      
      public static var nextShot1b:int = 0;
      
      public static const PONG_TIMEOUT:int = 30;
      
      public static var nextPong:int = 0;
      
      public static const NOM_TIMEOUT:int = 30;
      
      public static var nextNom:int = 0;
      
      public static const EXPLOSION_TIMEOUT:int = 25;
      
      public static var nextExplosion:int = 0;
      
      public static const DOOROPEN_TIMEOUT:int = 30;
      
      public static var nextOpenDoor:int = 0;
      
      public static const BOSS_HP_BLEEP_TIMEOUT:int = 30;
      
      public static var nextBossHpBleep:int = 0;
      
      public static const DIALOGUE_LETTER_TIMEOUT:int = 25;
      
      public static var nextDialogueLetter:int = 0;
      
      public static const PING_TIMEOUT:int = 25;
      
      public static var nextPing:int = 0;
      
      public function Sfx()
      {
         super();
      }
      
      public static function playMenuBeep1() : void
      {
         var _loc1_:int = getTimer();
         if(nextMenuBeep > _loc1_)
         {
            return;
         }
         nextMenuBeep = _loc1_ + MENUBEEP_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx.swf', symbol = 'menubeep1')]
         const MenuBeep1:Class;
         FlxG.play(MenuBeep1);
      }
      
      public static function playMenuBeep2() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'menubeep2')]
         const MenuBeep2:Class;
         FlxG.play(MenuBeep2);
      }
      
      public static function playSnelk() : void
      {
         var _loc1_:int = getTimer();
         if(nextSnelk > _loc1_)
         {
            return;
         }
         nextSnelk = _loc1_ + SNELK_TIMEOUT;
		 [Embed(source = 'data/sfx/snelk.mp3')]
         const Snelk:Class;
         FlxG.play(Snelk);
      }
      
      public static function playJump1() : void
      {
         var _loc1_:int = getTimer();
         if(nextJump > _loc1_)
         {
            return;
         }
         nextJump = _loc1_ + JUMP_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx.swf', symbol = 'jump1')]
         const Jump1:Class;
         FlxG.play(Jump1);
      }
      
      public static function playGrow() : void
      {
         var _loc1_:int = getTimer();
         if(nextGrow > _loc1_)
         {
            return;
         }
         nextGrow = _loc1_ + GROW_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx.swf', symbol = 'grow')]
         const Grow:Class;
         FlxG.play(Grow);
      }
      
      public static function playShot7() : void
      {
         var _loc1_:int = getTimer();
         if(nextShot7 > _loc1_)
         {
            return;
         }
         nextShot7 = _loc1_ + SHOT7_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx.swf', symbol = 'shot7')]
         const Shot7:Class;
         FlxG.play(Shot7);
      }
      
      public static function playLaser() : void
      {
         var _loc1_:int = getTimer();
         if(nextLaser > _loc1_)
         {
            return;
         }
         nextLaser = _loc1_ + LASER_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx2.swf', symbol = 'laser')]
         const Laser1:Class;
         FlxG.play(Laser1);
      }
      
      public static function playGigaWave() : void
      {
         [Embed(source = 'data/sfx/gigawave.mp3')]
         const GigaWave:Class;
         FlxG.play(GigaWave);
      }
      
      public static function playShot1() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'shot1')]
         const Shot1:Class;
         FlxG.play(Shot1);
      }
      
      public static function playShot2() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'shot2')]
         const Shot2:Class;
         FlxG.play(Shot2);
      }
      
      public static function playShot3() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'shot3')]
         const Shot3:Class;
         FlxG.play(Shot3);
      }
      
      public static function playCannon() : void
      {
         [Embed(source = 'data/sfx/sfx2.swf', symbol = 'cannon1')]
         const Cannon1:Class;
         FlxG.play(Cannon1);
      }
      
      public static function playCannon2() : void
      {
         [Embed(source = 'data/sfx/sfx2.swf', symbol = 'cannon2')]
         const Cannon2:Class;
         FlxG.play(Cannon2);
      }
      
      public static function playShotHit() : void
      {
         var _loc1_:int = getTimer();
         if(nextShotHit > _loc1_)
         {
            return;
         }
         nextShotHit = _loc1_ + SHOTHIT_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx2.swf', symbol = 'shothit')]
         const ShotHit:Class;
         FlxG.play(ShotHit,0.1);
      }
      
      public static function playShell() : void
      {
         [Embed(source = 'data/sfx/sfx2.swf', symbol = 'shell1')]
         const Shell1:Class;
         FlxG.play(Shell1,0.5);
      }
      
      public static function playChirp() : void
      {
         [Embed(source = 'data/sfx/sfx2.swf', symbol = 'chirp1')]
         const Chirp1:Class;
         FlxG.play(Chirp1);
      }
      
      public static function playStomp() : void
      {
         [Embed(source = 'data/sfx/sfx2.swf', symbol = 'stomp1')]
         const Stomp1:Class;
         FlxG.play(Stomp1);
      }
      
      public static function playShot1b() : void
      {
         var _loc1_:int = getTimer();
         if(nextShot1b > _loc1_)
         {
            return;
         }
         nextShot1b = _loc1_ + SHOT1B_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx.swf', symbol = 'shot1b')]
         const Shot1b:Class;
         FlxG.play(Shot1b);
      }
      
      public static function playShot2b() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'shot2b')]
         const Shot2b:Class;
         FlxG.play(Shot2b);
      }
      
      public static function playShot3b() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'shot3b')]
         const Shot3b:Class;
         FlxG.play(Shot3b, 0.6);
      }
      
      public static function playHealth() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'health1')]
         const Health:Class;
         FlxG.play(Health);
      }
      
      public static function playPongBounce() : void
      {
         var _loc1_:int = getTimer();
         if(nextPong > _loc1_)
         {
            return;
         }
         nextPong = _loc1_ + PONG_TIMEOUT;
		 [Embed(source = 'data/sfx/pongbounce.mp3')]
         const PongBounce:Class;
         FlxG.play(PongBounce);
      }
      
      public static function playPongMiss() : void
      {
         [Embed(source = 'data/sfx/pongmiss.mp3')]
         const PongMiss:Class;
         FlxG.play(PongMiss);
      }
      
      public static function playPongHit() : void
      {
         [Embed(source = 'data/sfx/ponghit.mp3')]
         const PongHit:Class;
         FlxG.play(PongHit);
      }
      
      public static function playPickup1() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'pickup2')]
         const Pickup2:Class;
         FlxG.play(Pickup2);
      }
      
      public static function playPickup2() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'pickup2')]
         const Pickup2:Class;
         FlxG.play(Pickup2);
      }
      
      public static function playPickup3() : void
      {
         var _loc1_:int = getTimer();
         if(nextNom > _loc1_)
         {
            return;
         }
         nextNom = _loc1_ + NOM_TIMEOUT;
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'pickup3')]
         const Pickup3:Class;
         FlxG.play(Pickup3);
      }
      
      public static function playPickup4() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'pickup4')]
         const Pickup4:Class;
         FlxG.play(Pickup4);
      }
      
      public static function playSave1() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'save1')]
         const Save1:Class;
         FlxG.play(Save1,0.45);
      }
      
      public static function playSplash1() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'splash1')]
         const Splash1:Class;
         FlxG.play(Splash1);
      }
      
      public static function playHurt() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'hurt2')]
         const Hurt:Class;
         FlxG.play(Hurt,0.45);
      }
      
      public static function playDeath() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'death')]
         const Death:Class;
         FlxG.play(Death,0.45);
      }
      
      public static function playExplode1() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'explode1')]
         const Explode1:Class;
         FlxG.play(Explode1,0.4);
      }
      
      public static function playExplode2() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'explode2')]
         const Explode2:Class;
         FlxG.play(Explode2,0.4);
      }
      
      public static function playExplode3() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'explode3')]
         const Explode3:Class;
         FlxG.play(Explode3,0.4);
      }
      
      public static function playExplode4() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'explode4')]
         const Explode4:Class;
         FlxG.play(Explode4,0.4);
      }
      
      public static function playSuperItemJingle() : void
      {
         [Embed(source = 'data/sfx/jingle4.mp3')]
         const Jingle4:Class;
         FlxG.play(Jingle4,0.6);
      }
      
      public static function playItemJingle() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'jingle3')]
         const Jingle3:Class;
         FlxG.play(Jingle3);
      }
      
      public static function playRandomExplode() : void
      {
         var _loc1_:int = getTimer();
         if(nextExplosion > _loc1_)
         {
            return;
         }
         nextExplosion = _loc1_ + EXPLOSION_TIMEOUT;
         switch(int(FlxU.random() * 4))
         {
            case 0:
               playExplode1();
               break;
            case 1:
               playExplode2();
               break;
            case 2:
               playExplode3();
               break;
            case 3:
               playExplode4();
         }
      }
      
      public static function playEnding1() : void
      {
         [Embed(source = 'data/sfx/ending1song.mp3')]
         const Ending1Song:Class;
         EndingSfx = FlxG.play(Ending1Song,0.75 * FlxG.musicVolume);
      }
      
      public static function stopEnding1() : void
      {
         EndingSfx.fadeOut(1);
      }
      
      public static function playOpenDoor() : void
      {
         var _loc1_:int = getTimer();
         if(nextOpenDoor > _loc1_)
         {
            return;
         }
         nextOpenDoor = _loc1_ + DOOROPEN_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx.swf', symbol = 'opendoor')]
         const OpenDoor:Class;
         FlxG.play(OpenDoor);
      }
      
      public static function playCloseDoor() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'closedoor')]
         const CloseDoor:Class;
         FlxG.play(CloseDoor);
      }
      
      public static function playBossHpBleep() : void
      {
         var _loc1_:int = getTimer();
         if(nextBossHpBleep > _loc1_)
         {
            return;
         }
         nextBossHpBleep = _loc1_ + BOSS_HP_BLEEP_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx.swf', symbol = 'bosshpbleep')]
         const BossHpBleep:Class;
         FlxG.play(BossHpBleep);
      }
      
      public static function playDialogueLetter(param1:int = 0) : void
      {
         var _loc2_:int = getTimer();
         if(nextDialogueLetter > _loc2_)
         {
            return;
         }
         nextDialogueLetter = _loc2_ + DIALOGUE_LETTER_TIMEOUT;
         switch(param1)
         {
            case 0:
               [Embed(source = 'data/sfx/sfx.swf', symbol = 'dialogueletter0')]
			   const DialogueLetter0:Class;
               FlxG.play(DialogueLetter0,0.33);
               break;
            case 1:
               [Embed(source = 'data/sfx/sfx.swf', symbol = 'dialogueletter1')]
			   const DialogueLetter1:Class;
               FlxG.play(DialogueLetter1,0.33);
               break;
            case 2:
               [Embed(source = 'data/sfx/sfx.swf', symbol = 'dialogueletter2')]
			   const DialogueLetter2:Class;
               FlxG.play(DialogueLetter2,0.33);
               break;
            case 3:
               [Embed(source = 'data/sfx/sfx.swf', symbol = 'dialogueletter3')]
			   const DialogueLetter3:Class;
               FlxG.play(DialogueLetter3,0.33);
         }
      }
      
      public static function playEnemyKilled() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'bigboom1')]
         const EnemyKilled:Class;
         FlxG.play(EnemyKilled);
      }
      
      public static function playEnemyKilled2() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'bigboom2')]
         const EnemyKilled2:Class;
         FlxG.play(EnemyKilled2);
      }
      
      public static function playEnemyKilled3() : void
      {
         [Embed(source = 'data/sfx/sfx.swf', symbol = 'bigboom3')]
         const EnemyKilled3:Class;
         FlxG.play(EnemyKilled3);
      }
      
      public static function playRandomEnemyKilled() : void
      {
         switch(int(FlxU.random() * 3))
         {
            case 0:
               playEnemyKilled();
               break;
            case 1:
               playEnemyKilled2();
               break;
            case 2:
               playEnemyKilled3();
         }
      }
      
      public static function playSlugMode() : void
      {
         [Embed(source = 'data/sfx/slugmode.mp3')]
         const SlugMode:Class;
         FlxG.play(SlugMode);
      }
      
      public static function playEnemyHurt() : void
      {
      }
      
      public static function playEnemyPingOffArmor() : void
      {
         var _loc1_:int = getTimer();
         if(nextPing > _loc1_)
         {
            return;
         }
         nextPing = _loc1_ + PING_TIMEOUT;
		 [Embed(source = 'data/sfx/sfx.swf', symbol = 'ping')]
         const EnemyPingOffArmor:Class;
         FlxG.play(EnemyPingOffArmor);
      }
   }
}

