package
{
   import flash.utils.*;
   import org.flixel.*;
   
   public class Boss extends Enemy
   {
      private static const DELAY_START_FOCUS:int = 500;
      
      private static const DELAY_START_HP_FILL:int = 1000;
      
      private static const DELAY_FINISH_HP_FILL:int = 2500;
      
      private static const DELAY_STOP_FOCUS:int = 2700;
      
      private static const DELAY_VULNERABLE:int = 2900;
      
      protected var _startTime:int = 0;
      
      protected var _vulnerable:Boolean = false;
      
      protected var _introDone:Boolean = false;
      
      protected var _delayIntro:Boolean = false;
      
      protected var _noParalyze:Boolean = false;
      
      public function Boss(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean = false) : void
      {
         super(param1,param2,param3,param4,param5);
         _startTime = getTimer();
         _introDone = false;
         _delayIntro = param6;
         if(!_delayIntro)
         {
            PlayState.hud.bossBarHud.makeBar(param3);
            PlayState.miniMap.setMapLittle();
         }
      }
      
      public function resetStartTime() : void
      {
         _startTime = getTimer();
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
         if(!_introDone && !_delayIntro)
         {
            if(!_noParalyze)
            {
               PlayState.player.paralyze(true);
            }
            _loc1_ = getTimer() - _startTime;
            if(_loc1_ > DELAY_VULNERABLE)
            {
               _vulnerable = true;
               PlayState.hud.bossBarHud.makeBar(_hp);
               _introDone = true;
               if(!_noParalyze)
               {
                  PlayState.player.paralyze(false);
               }
            }
            if(_loc1_ > DELAY_STOP_FOCUS)
            {
               FlxG.follow(PlayState.player,5,false);
            }
            else if(_loc1_ > DELAY_START_FOCUS)
            {
               FlxG.follow(this,5,false);
            }
            if(_loc1_ > DELAY_START_HP_FILL)
            {
               _loc2_ = _hp * (Number)(_loc1_ - DELAY_START_HP_FILL) / (Number)(DELAY_FINISH_HP_FILL - DELAY_START_HP_FILL);
               if(_loc2_ < 1)
               {
                  _loc2_ = 1;
               }
               if(_loc2_ > _hp)
               {
                  _loc2_ = _hp;
               }
               PlayState.hud.bossBarHud.setCurHp(_loc2_);
               if(_loc2_ != _hp)
               {
                  Sfx.playBossHpBleep();
               }
            }
         }
         super.update();
      }
      
      override public function kill() : void
      {
         PlayState.hud.bossBarHud.removeBar();
         super.kill();
      }
      
      override public function hurt(param1:Number) : void
      {
         if(!_vulnerable)
         {
            param1 = -10;
            super.hurt(param1);
         }
         else
         {
            super.hurt(param1);
            PlayState.hud.bossBarHud.setCurHp(_hp);
         }
      }
   }
}

