package
{
   import org.flixel.*;
   
   public class BossZzz extends Enemy
   {
      private static const IMG_WIDTH:int = 24;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 6;
      
      private static const ATTACK_TIMEOUT:Number = 3;
      
      private var _originX:int;
      
      private var _originY:int;
      
      private var _targetX:int;
      
      private var _targetY:int;
      
      private var _theta:Number = 0;
      
      private var _attackTimeout:Number = 3;
      
      public function BossZzz(param1:int, param2:int, param3:int, param4:int) : void
      {
         super(param1,param2,100,0,6,true);
         _originX = param1;
         _originY = param2;
         _targetX = param3;
         _targetY = param4;
         loadGraphic(Art.BossZzz,true,true,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0]);
         play("normal");
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         _theta += FlxG.elapsed;
         if(acceleration.x == 0 && acceleration.y == 0)
         {
            _originX = Utility.integrate(_originX,_targetX,2,FlxG.elapsed);
            _originY = Utility.integrate(_originY,_targetY,2,FlxG.elapsed);
            x = _originX;
            y = _originY + 14 * Math.sin(_theta * Math.PI * 2);
         }
         _attackTimeout -= FlxG.elapsed;
         if(_attackTimeout < 0)
         {
            _attackTimeout = 999999999;
            shootAtPlayer();
         }
         if(x > FlxG.MaxX + 100 || x + width < FlxG.MinX - 100 || y > FlxG.MaxY + 100 || y + height < FlxG.MinY - 100)
         {
            kill();
         }
         super.update();
      }
      
      public function shootAtPlayer() : void
      {
         var _loc1_:Number = Math.atan2(PlayState.player.y - (y + height / 2),PlayState.player.x - (x + width / 2));
         acceleration.x = 2200 * Math.cos(_loc1_);
         acceleration.y = 2200 * Math.sin(_loc1_);
      }
      
      override public function kill() : void
      {
         super.kill();
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}

