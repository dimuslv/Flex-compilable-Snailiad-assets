package
{
   import org.flixel.*;
   
   public class Enemy extends FlxSprite
   {
      private static const HURT_TIMEOUT:Number = 0.025;
      
      protected var _hp:int;
      
      protected var _defense:int;
      
      protected var _offense:int;
      
      protected var _hurtTimeout:Number;
      
      protected var _justFlashed:int;
      
      private var _invuln:int;
      
      private var _noBoundsChecking:Boolean;
      
      public function Enemy(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean = false) : void
      {
         x = param1;
         y = param2;
         _hp = param3;
         _defense = param4;
         _offense = param5;
         _noBoundsChecking = param6;
         _hurtTimeout = 0;
      }
      
      public function touch(param1:Player) : void
      {
         if(_offense > 0)
         {
            param1.hurt(_offense);
         }
      }
      
      public function collideTerrain() : Boolean
      {
         return true;
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         if(!_noBoundsChecking)
         {
            if(x > PlayState.worldMap.maxX || x + width < PlayState.worldMap.minX || y > PlayState.worldMap.maxY || y + height < PlayState.worldMap.minY)
            {
               kill();
            }
         }
         _hurtTimeout -= FlxG.elapsed;
         if(--_justFlashed == 0)
         {
            unFlashColor();
         }
      }
      
      public function triggerAi(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               triggerAi1();
               break;
            case 2:
               triggerAi2();
               break;
            case 3:
               triggerAi3();
               break;
            case 4:
               triggerAi4();
			   break;
         }
      }
      
      public function triggerAi1() : void
      {
      }
      
      public function triggerAi2() : void
      {
      }
      
      public function triggerAi3() : void
      {
      }
      
      public function triggerAi4() : void
      {
      }
      
      public function getDefense() : int
      {
         return _defense;
      }
      
      override public function hurt(param1:Number) : void
      {
         if(_hurtTimeout > 0)
         {
            return;
         }
         param1 -= _defense;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(PlayState.player.cheatsEnabled)
         {
            PlayState.damageNumberPool.makeText(x + width / 2,y + height / 2,param1.toString(),1,width / 2,height / 2);
         }
         if(param1 <= 0)
         {
            Sfx.playEnemyPingOffArmor();
            _hurtTimeout = HURT_TIMEOUT;
         }
         else
         {
            _hp -= param1;
            if(_hp <= 0)
            {
               Sfx.playEnemyKilled();
               PlayState.explosionPool.boom(x,y,0,10,FlxU.random() * 3 + 1);
               kill();
            }
            else
            {
               Sfx.playRandomExplode();
               flashColor(16777215);
               _justFlashed = 1;
               _hurtTimeout = HURT_TIMEOUT;
            }
         }
      }
   }
}

