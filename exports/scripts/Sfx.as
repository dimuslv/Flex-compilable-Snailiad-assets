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
         var _loc2_:Class = Sfx_MenuBeep1;
         FlxG.play(_loc2_);
      }
      
      public static function playMenuBeep2() : void
      {
         var _loc1_:Class = Sfx_MenuBeep2;
         FlxG.play(_loc1_);
      }
      
      public static function playSnelk() : void
      {
         var _loc1_:int = getTimer();
         if(nextSnelk > _loc1_)
         {
            return;
         }
         nextSnelk = _loc1_ + SNELK_TIMEOUT;
         var _loc2_:Class = Sfx_Snelk;
         FlxG.play(_loc2_);
      }
      
      public static function playJump1() : void
      {
         var _loc1_:int = getTimer();
         if(nextJump > _loc1_)
         {
            return;
         }
         nextJump = _loc1_ + JUMP_TIMEOUT;
         var _loc2_:Class = Sfx_Jump1;
         FlxG.play(_loc2_);
      }
      
      public static function playGrow() : void
      {
         var _loc1_:int = getTimer();
         if(nextGrow > _loc1_)
         {
            return;
         }
         nextGrow = _loc1_ + GROW_TIMEOUT;
         var _loc2_:Class = Sfx_Grow;
         FlxG.play(_loc2_);
      }
      
      public static function playShot7() : void
      {
         var _loc1_:int = getTimer();
         if(nextShot7 > _loc1_)
         {
            return;
         }
         nextShot7 = _loc1_ + SHOT7_TIMEOUT;
         var _loc2_:Class = Sfx_Shot7;
         FlxG.play(_loc2_);
      }
      
      public static function playLaser() : void
      {
         var _loc1_:int = getTimer();
         if(nextLaser > _loc1_)
         {
            return;
         }
         nextLaser = _loc1_ + LASER_TIMEOUT;
         var _loc2_:Class = Sfx_Laser1;
         FlxG.play(_loc2_);
      }
      
      public static function playGigaWave() : void
      {
         var _loc1_:Class = Sfx_GigaWave;
         FlxG.play(_loc1_);
      }
      
      public static function playShot1() : void
      {
         var _loc1_:Class = Sfx_Shot1;
         FlxG.play(_loc1_);
      }
      
      public static function playShot2() : void
      {
         var _loc1_:Class = Sfx_Shot2;
         FlxG.play(_loc1_);
      }
      
      public static function playShot3() : void
      {
         var _loc1_:Class = Sfx_Shot3;
         FlxG.play(_loc1_);
      }
      
      public static function playCannon() : void
      {
         var _loc1_:Class = Sfx_Cannon1;
         FlxG.play(_loc1_);
      }
      
      public static function playCannon2() : void
      {
         var _loc1_:Class = Sfx_Cannon2;
         FlxG.play(_loc1_);
      }
      
      public static function playShotHit() : void
      {
         var _loc1_:int = getTimer();
         if(nextShotHit > _loc1_)
         {
            return;
         }
         nextShotHit = _loc1_ + SHOTHIT_TIMEOUT;
         var _loc2_:Class = Sfx_ShotHit;
         FlxG.play(_loc2_,0.1);
      }
      
      public static function playShell() : void
      {
         var _loc1_:Class = Sfx_Shell1;
         FlxG.play(_loc1_,0.5);
      }
      
      public static function playChirp() : void
      {
         var _loc1_:Class = Sfx_Chirp1;
         FlxG.play(_loc1_);
      }
      
      public static function playStomp() : void
      {
         var _loc1_:Class = Sfx_Stomp1;
         FlxG.play(_loc1_);
      }
      
      public static function playShot1b() : void
      {
         var _loc1_:int = getTimer();
         if(nextShot1b > _loc1_)
         {
            return;
         }
         nextShot1b = _loc1_ + SHOT1B_TIMEOUT;
         var _loc2_:Class = Sfx_Shot1b;
         FlxG.play(_loc2_);
      }
      
      public static function playShot2b() : void
      {
         var _loc1_:Class = Sfx_Shot2b;
         FlxG.play(_loc1_);
      }
      
      public static function playShot3b() : void
      {
         var _loc1_:Class = Sfx_Shot3b;
         FlxG.play(_loc1_,0.6);
      }
      
      public static function playHealth() : void
      {
         var _loc1_:Class = Sfx_Health;
         FlxG.play(_loc1_);
      }
      
      public static function playPongBounce() : void
      {
         var _loc1_:int = getTimer();
         if(nextPong > _loc1_)
         {
            return;
         }
         nextPong = _loc1_ + PONG_TIMEOUT;
         var _loc2_:Class = Sfx_PongBounce;
         FlxG.play(_loc2_);
      }
      
      public static function playPongMiss() : void
      {
         var _loc1_:Class = Sfx_PongMiss;
         FlxG.play(_loc1_);
      }
      
      public static function playPongHit() : void
      {
         var _loc1_:Class = Sfx_PongHit;
         FlxG.play(_loc1_);
      }
      
      public static function playPickup1() : void
      {
         var _loc1_:Class = Sfx_Pickup2;
         FlxG.play(_loc1_);
      }
      
      public static function playPickup2() : void
      {
         var _loc1_:Class = Sfx_Pickup2;
         FlxG.play(_loc1_);
      }
      
      public static function playPickup3() : void
      {
         var _loc1_:int = getTimer();
         if(nextNom > _loc1_)
         {
            return;
         }
         nextNom = _loc1_ + NOM_TIMEOUT;
         var _loc2_:Class = Sfx_Pickup3;
         FlxG.play(_loc2_);
      }
      
      public static function playPickup4() : void
      {
         var _loc1_:Class = Sfx_Pickup4;
         FlxG.play(_loc1_);
      }
      
      public static function playSave1() : void
      {
         var _loc1_:Class = Sfx_Save1;
         FlxG.play(_loc1_,0.45);
      }
      
      public static function playSplash1() : void
      {
         var _loc1_:Class = Sfx_Splash1;
         FlxG.play(_loc1_);
      }
      
      public static function playHurt() : void
      {
         var _loc1_:Class = Sfx_Hurt;
         FlxG.play(_loc1_,0.45);
      }
      
      public static function playDeath() : void
      {
         var _loc1_:Class = Sfx_Death;
         FlxG.play(_loc1_,0.45);
      }
      
      public static function playExplode1() : void
      {
         var _loc1_:Class = Sfx_Explode1;
         FlxG.play(_loc1_,0.4);
      }
      
      public static function playExplode2() : void
      {
         var _loc1_:Class = Sfx_Explode2;
         FlxG.play(_loc1_,0.4);
      }
      
      public static function playExplode3() : void
      {
         var _loc1_:Class = Sfx_Explode3;
         FlxG.play(_loc1_,0.4);
      }
      
      public static function playExplode4() : void
      {
         var _loc1_:Class = Sfx_Explode4;
         FlxG.play(_loc1_,0.4);
      }
      
      public static function playSuperItemJingle() : void
      {
         var _loc1_:Class = Sfx_Jingle4;
         FlxG.play(_loc1_,0.6);
      }
      
      public static function playItemJingle() : void
      {
         var _loc1_:Class = Sfx_Jingle3;
         FlxG.play(_loc1_);
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
         var _loc1_:Class = Sfx_Ending1Song;
         EndingSfx = FlxG.play(_loc1_,0.75 * FlxG.musicVolume);
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
         var _loc2_:Class = Sfx_OpenDoor;
         FlxG.play(_loc2_);
      }
      
      public static function playCloseDoor() : void
      {
         var _loc1_:Class = Sfx_CloseDoor;
         FlxG.play(_loc1_);
      }
      
      public static function playBossHpBleep() : void
      {
         var _loc1_:int = getTimer();
         if(nextBossHpBleep > _loc1_)
         {
            return;
         }
         nextBossHpBleep = _loc1_ + BOSS_HP_BLEEP_TIMEOUT;
         var _loc2_:Class = Sfx_BossHpBleep;
         FlxG.play(_loc2_);
      }
      
      public static function playDialogueLetter(param1:int = 0) : void
      {
         var _loc2_:Class = null;
         var _loc3_:Class = null;
         var _loc4_:Class = null;
         var _loc5_:Class = null;
         var _loc6_:int = getTimer();
         if(nextDialogueLetter > _loc6_)
         {
            return;
         }
         nextDialogueLetter = _loc6_ + DIALOGUE_LETTER_TIMEOUT;
         switch(param1)
         {
            case 0:
               _loc2_ = Sfx_DialogueLetter0;
               FlxG.play(_loc2_,0.33);
               break;
            case 1:
               _loc3_ = Sfx_DialogueLetter1;
               FlxG.play(_loc3_,0.33);
               break;
            case 2:
               _loc4_ = Sfx_DialogueLetter2;
               FlxG.play(_loc4_,0.33);
               break;
            case 3:
               _loc5_ = Sfx_DialogueLetter3;
               FlxG.play(_loc5_,0.33);
         }
      }
      
      public static function playEnemyKilled() : void
      {
         var _loc1_:Class = Sfx_EnemyKilled;
         FlxG.play(_loc1_);
      }
      
      public static function playEnemyKilled2() : void
      {
         var _loc1_:Class = Sfx_EnemyKilled2;
         FlxG.play(_loc1_);
      }
      
      public static function playEnemyKilled3() : void
      {
         var _loc1_:Class = Sfx_EnemyKilled3;
         FlxG.play(_loc1_);
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
         var _loc1_:Class = Sfx_SlugMode;
         FlxG.play(_loc1_);
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
         var _loc2_:Class = Sfx_EnemyPingOffArmor;
         FlxG.play(_loc2_);
      }
   }
}

