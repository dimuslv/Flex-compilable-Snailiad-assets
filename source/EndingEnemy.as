package
{
   import org.flixel.*;
   
   public class EndingEnemy extends FlxSprite
   {
      public static const TYPE_NONE:int = -1;
      
      public static const TYPE_SPIKEY:int = 0;
      
      public static const TYPE_SPIKEY2:int = 1;
      
      public static const TYPE_BABYFISH:int = 2;
      
      public static const TYPE_BABYFISH2:int = 3;
      
      public static const TYPE_FLOATSPIKE:int = 4;
      
      public static const TYPE_FLOATSPIKE2:int = 5;
      
      public static const TYPE_BLOB1:int = 6;
      
      public static const TYPE_BLOB2:int = 7;
      
      public static const TYPE_BLOB3:int = 8;
      
      public static const TYPE_BLOB4:int = 9;
      
      public static const TYPE_CHIRPY:int = 10;
      
      public static const TYPE_CHIRPY2:int = 11;
      
      public static const TYPE_BATTY_BAT:int = 12;
      
      public static const TYPE_FIREBALL:int = 13;
      
      public static const TYPE_ICEBALL:int = 14;
      
      public static const TYPE_SECRET_SNELK:int = 15;
      
      public static const TYPE_KITTY:int = 16;
      
      public static const TYPE_DANDELION:int = 17;
      
      public static const TYPE_CANNON_HUB:int = 18;
      
      public static const TYPE_CANNON:int = 19;
      
      public static const TYPE_CANNON2_HUB:int = 20;
      
      public static const TYPE_CANNON2:int = 21;
      
      public static const TYPE_SNAKEY:int = 22;
      
      public static const TYPE_BLUE_SNAKEY:int = 23;
      
      public static const TYPE_SKY_SNAKE:int = 24;
      
      public static const TYPE_SPIDER:int = 25;
      
      public static const TYPE_SPIDER_MAMA:int = 26;
      
      public static const TYPE_GRAVITY_TURTLE:int = 27;
      
      public static const TYPE_CHERRY_TURTLE:int = 28;
      
      public static const TYPE_JELLYFISH:int = 29;
      
      public static const TYPE_SEAHORSE:int = 30;
      
      public static const TYPE_TALLFISH:int = 31;
      
      public static const TYPE_TALLFISH2:int = 32;
      
      public static const TYPE_WALLEYE:int = 33;
      
      public static const TYPE_PINCER:int = 34;
      
      public static const TYPE_SKY_PINCER:int = 35;
      
      public static const TYPE_GEAR:int = 36;
      
      public static const TYPE_FEDERATION_DRONE:int = 37;
      
      public static const TYPE_BALLOON:int = 38;
      
      public static const TYPE_SHELLBREAKER:int = 39;
      
      public static const TYPE_SHELLBREAKER_EYES:int = 40;
      
      public static const TYPE_SHELLBREAKER_HAND1:int = 41;
      
      public static const TYPE_SHELLBREAKER_HAND2:int = 42;
      
      public static const TYPE_SHELLBREAKER_HAND3:int = 43;
      
      public static const TYPE_SHELLBREAKER_HAND4:int = 44;
      
      public static const TYPE_SHELLBREAKER_HAND5:int = 45;
      
      public static const TYPE_SHELLBREAKER_HAND6:int = 46;
      
      public static const TYPE_STOMPY_LFOOT:int = 47;
      
      public static const TYPE_STOMPY_RFOOT:int = 48;
      
      public static const TYPE_STOMPY_EYE:int = 49;
      
      public static const TYPE_STOMPY_EYELID:int = 50;
      
      public static const TYPE_STOMPY_PUPIL:int = 51;
      
      public static const TYPE_SPACE_BOX:int = 52;
      
      public static const TYPE_BABY_BOX:int = 53;
      
      public static const TYPE_MOON_SNAIL:int = 54;
      
      public static const TYPE_GIGA_SNAIL:int = 55;
      
      public static const TYPE_SNAILY_SNAIL:int = 56;
      
      public static const TYPE_SLUGGY_SLUG:int = 57;
      
      public static const TYPE_TARSH:int = 58;
      
      public static const TYPE_XDANOND:int = 59;
      
      public static const TYPE_ADAMATOMIC:int = 60;
      
      public static const TYPE_AURIPLANE:int = 61;
      
      public static const TYPE_THE_END:int = 62;
      
      private var _hand:Boolean = false;
      
      private var _handTheta:Number = 0;
      
      private var _elapsed:Number = 0;
      
      private var _type:int;
      
      public function EndingEnemy(param1:int, param2:int, param3:int) : void
      {
         super(param1,param2);
         active = true;
         scrollFactor.x = scrollFactor.y = 0;
         _type = param3;
         if(param3 == TYPE_NONE)
         {
            width = 0;
            height = 0;
            visible = false;
            return;
         }
         switch(param3)
         {
            case TYPE_SPIKEY:
               loadGraphic(Art.EnemySpikey,true,true,16,16);
               addAnimation("normal",[0,1,2,3],6,true);
               break;
            case TYPE_SPIKEY2:
               loadGraphic(Art.EnemySpikey2,true,true,16,16);
               addAnimation("normal",[0,1,2,3],6,true);
               break;
            case TYPE_BABYFISH:
               loadGraphic(Art.EnemyBabyfish,true,true,13,10);
               addAnimation("normal",[0,1,0,1,0,1,0,0,1,1,0,0,0,1,1,1,1,1,0],10,true);
               break;
            case TYPE_BABYFISH2:
               loadGraphic(Art.EnemyBabyfish,true,true,13,10);
               addAnimation("normal",[2,3,2,3,2,3,2,2,3,3,2,2,2,3,3,3,3,3,2],12,true);
               break;
            case TYPE_FLOATSPIKE:
               loadGraphic(Art.EnemyFloatSpike,true,true,16,16);
               addAnimation("normal",[0]);
               break;
            case TYPE_FLOATSPIKE2:
               loadGraphic(Art.EnemyFloatSpike2,true,true,16,16);
               addAnimation("normal",[0]);
               break;
            case TYPE_BLOB1:
               loadGraphic(Art.EnemyBlob,true,true,16,16);
               addAnimation("normal",[0]);
               break;
            case TYPE_BLOB2:
               loadGraphic(Art.EnemyBlob,true,true,16,16);
               addAnimation("normal",[4]);
               break;
            case TYPE_BLOB3:
               loadGraphic(Art.EnemyBlob,true,true,16,16);
               addAnimation("normal",[12]);
               break;
            case TYPE_BLOB4:
               loadGraphic(Art.EnemyBlob,true,true,16,16);
               addAnimation("normal",[8]);
               break;
            case TYPE_CHIRPY:
               loadGraphic(Art.EnemyBird,true,true,16,16);
               addAnimation("normal",[0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],20,true);
               break;
            case TYPE_CHIRPY2:
               loadGraphic(Art.EnemyBird2,true,true,16,16);
               addAnimation("normal",[0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],18,true);
               break;
            case TYPE_BATTY_BAT:
               loadGraphic(Art.EnemyBat,true,true,32,16);
               addAnimation("normal",[1,2],6,true);
               break;
            case TYPE_FIREBALL:
               loadGraphic(Art.EnemyFireball,true,true,16,16);
               addAnimation("normal",[0,1,2,3],6,true);
               break;
            case TYPE_ICEBALL:
               loadGraphic(Art.EnemyFireball2,true,true,16,16);
               addAnimation("normal",[2,3,0,1],6.1,true);
               break;
            case TYPE_SECRET_SNELK:
               loadGraphic(Art.EnemySnelk,true,true,24,24);
               addAnimation("normal",[0]);
               break;
            case TYPE_KITTY:
               loadGraphic(Art.EnemyKitty2,true,true,32,16);
               addAnimation("normal",[0]);
               break;
            case TYPE_DANDELION:
               loadGraphic(Art.EnemyDandelion,true,true,16,16);
               addAnimation("normal",[0]);
               break;
            case TYPE_CANNON_HUB:
               loadGraphic(Art.EnemyCannonBottom,true,true,16,16);
               addAnimation("normal",[0]);
               y += 16;
               break;
            case TYPE_CANNON:
               loadGraphic(Art.EnemyCannon,true,true,48,48);
               addAnimation("normal",[1]);
               break;
            case TYPE_CANNON2_HUB:
               loadGraphic(Art.EnemyCannonBottom2,true,true,16,16);
               addAnimation("normal",[0]);
               y += 16;
               break;
            case TYPE_CANNON2:
               loadGraphic(Art.EnemyCannon2,true,true,48,48);
               addAnimation("normal",[3]);
               break;
            case TYPE_SNAKEY:
               loadGraphic(Art.EnemySnake,true,true,16,16);
               addAnimation("normal",[0,1],10,true);
               break;
            case TYPE_BLUE_SNAKEY:
               loadGraphic(Art.EnemySnake2,true,true,16,16);
               addAnimation("normal",[0,1],10,true);
               break;
            case TYPE_SKY_SNAKE:
               loadGraphic(Art.EnemySnake3,true,true,25,16);
               addAnimation("normal",[0,1],10,true);
               break;
            case TYPE_SPIDER:
               loadGraphic(Art.EnemySpider,true,true,16,16);
               addAnimation("normal",[0,1],6,true);
               break;
            case TYPE_SPIDER_MAMA:
               loadGraphic(Art.EnemySpider2,true,true,16,16);
               addAnimation("normal",[0,1],8,true);
               break;
            case TYPE_GRAVITY_TURTLE:
               loadGraphic(Art.EnemyGravTurtle,true,true,16,32);
               addAnimation("normal",[0,1,2,3],3,true);
               facing = LEFT;
               break;
            case TYPE_CHERRY_TURTLE:
               loadGraphic(Art.EnemyGravTurtle2,true,true,16,32);
               addAnimation("normal",[0,1,2,3],3,true);
               break;
            case TYPE_JELLYFISH:
               loadGraphic(Art.EnemyKurage,true,true,16,16);
               addAnimation("normal",[0,1,2,3],4,true);
               break;
            case TYPE_SEAHORSE:
               loadGraphic(Art.EnemySeahorse,true,true,16,32);
               addAnimation("normal",[0]);
               break;
            case TYPE_TALLFISH:
               loadGraphic(Art.EnemyTallfish,true,true,32,48);
               addAnimation("normal",[0,1,2,3,3,0,0,1,1,1,2,2,2,2,3,3,3,3,0],10,true);
               break;
            case TYPE_TALLFISH2:
               loadGraphic(Art.EnemyTallfish2,true,true,32,48);
               addAnimation("normal",[0,1,2,3,3,0,0,1,1,1,2,2,2,2,3,3,3,3,0],11,true);
               break;
            case TYPE_WALLEYE:
               loadGraphic(Art.EnemyWalleye,true,true,16,16);
               addAnimation("normal",[0]);
               break;
            case TYPE_PINCER:
               loadGraphic(Art.EnemyPincer,true,true,16,16);
               addAnimation("normal",[0,1],10,true);
               break;
            case TYPE_SKY_PINCER:
               loadGraphic(Art.EnemyPincer2,true,true,16,16);
               addAnimation("normal",[0,1],10,true);
               facing = LEFT;
               break;
            case TYPE_GEAR:
               loadGraphic(Art.EnemyGear,true,true,32,32);
               addAnimation("normal",[0,1],30,true);
               break;
            case TYPE_FEDERATION_DRONE:
               loadGraphic(Art.EnemyDrone,true,true,24,29);
               addAnimation("normal",[0,1],18,true);
               break;
            case TYPE_BALLOON:
               loadGraphic(Art.EnemyBalloon,true,true,16,32);
               addAnimation("normal",[0]);
               break;
            case TYPE_SHELLBREAKER:
               loadGraphic(Art.Boss1,true,true,48,48);
               addAnimation("normal",[0]);
               break;
            case TYPE_SHELLBREAKER_EYES:
               loadGraphic(Art.Boss1Eyes,true,true,48,48);
               addAnimation("normal",[0]);
               break;
            case TYPE_SHELLBREAKER_HAND1:
               loadGraphic(Art.Boss1Hand,true,true,24,24);
               addAnimation("normal",[5]);
               _hand = true;
               _handTheta = 2 * Math.PI / 6 * 1;
               break;
            case TYPE_SHELLBREAKER_HAND2:
               loadGraphic(Art.Boss1Hand,true,true,24,24);
               addAnimation("normal",[5]);
               _hand = true;
               _handTheta = 2 * Math.PI / 6 * 2;
               break;
            case TYPE_SHELLBREAKER_HAND3:
               loadGraphic(Art.Boss1Hand,true,true,24,24);
               addAnimation("normal",[5]);
               _hand = true;
               _handTheta = 2 * Math.PI / 6 * 3;
               break;
            case TYPE_SHELLBREAKER_HAND4:
               loadGraphic(Art.Boss1Hand,true,true,24,24);
               addAnimation("normal",[5]);
               _hand = true;
               _handTheta = 2 * Math.PI / 6 * 4;
               break;
            case TYPE_SHELLBREAKER_HAND5:
               loadGraphic(Art.Boss1Hand,true,true,24,24);
               addAnimation("normal",[5]);
               _hand = true;
               _handTheta = 2 * Math.PI / 6 * 5;
               break;
            case TYPE_SHELLBREAKER_HAND6:
               loadGraphic(Art.Boss1Hand,true,true,24,24);
               addAnimation("normal",[5]);
               _hand = true;
               _handTheta = 2 * Math.PI / 6 * 6;
               break;
            case TYPE_STOMPY_LFOOT:
               loadGraphic(Art.Boss2Foot,true,true,190,156);
               addAnimation("normal",[0]);
               facing = LEFT;
               break;
            case TYPE_STOMPY_RFOOT:
               loadGraphic(Art.Boss2Foot,true,true,190,156);
               addAnimation("normal",[0]);
               break;
            case TYPE_STOMPY_EYE:
               loadGraphic(Art.Boss2Eye,true,true,100,52);
               addAnimation("normal",[0]);
               break;
            case TYPE_STOMPY_EYELID:
               loadGraphic(Art.Boss2Eyelid,true,true,100,52);
               addAnimation("normal",[0]);
               break;
            case TYPE_STOMPY_PUPIL:
               loadGraphic(Art.Boss2Pupil,true,true,100,52);
               addAnimation("normal",[0]);
               break;
            case TYPE_SPACE_BOX:
               loadGraphic(Art.Boss3,true,true,128,128);
               addAnimation("normal",[0,1,2,3],1,true);
               break;
            case TYPE_BABY_BOX:
               loadGraphic(Art.Boss3RushSpawn,true,true,64,64);
               addAnimation("normal",[0]);
               break;
            case TYPE_MOON_SNAIL:
               loadGraphic(Art.Boss4,true,true,32,32);
               addAnimation("normal",[0,1],2.9,true);
               break;
            case TYPE_GIGA_SNAIL:
               loadGraphic(Art.Boss4SecondForm,true,true,80,44);
               addAnimation("normal",[0,1],3.1,true);
               break;
            case TYPE_SNAILY_SNAIL:
               loadGraphic(Art.SnailySnail,true,true,32,32);
               addAnimation("normal",[0,1],3,true);
               break;
            case TYPE_SLUGGY_SLUG:
               loadGraphic(Art.SnailySnail,true,true,32,32);
               addAnimation("normal",[80,81],3.05,true);
               break;
            case TYPE_AURIPLANE:
               loadGraphic(Art.PixelPeople,true,true,18,32);
               addAnimation("normal",[1]);
               break;
            case TYPE_XDANOND:
               loadGraphic(Art.PixelPeople,true,true,18,32);
               addAnimation("normal",[0]);
               break;
            case TYPE_ADAMATOMIC:
               loadGraphic(Art.PixelPeople,true,true,18,32);
               addAnimation("normal",[2]);
               break;
            case TYPE_TARSH:
               loadGraphic(Art.PixelPeople,true,true,18,32);
               addAnimation("normal",[3]);
               break;
            case TYPE_THE_END:
               loadGraphic(Art.TheEnd,true,true,194,122);
               addAnimation("normal",[0]);
			   break;
         }
         play("normal");
         x = FlxG.width / 2 - width / 2 + param1;
         if(_hand)
         {
            y += 24 - height / 2;
         }
      }
      
      override public function update() : void
      {
         if(y < -height - 60)
         {
            kill();
         }
         if(_hand)
         {
            _handTheta += FlxG.elapsed * 4;
            offset.x = 48 * Math.cos(_handTheta);
            offset.y = 48 * Math.sin(_handTheta);
         }
         if(_type == TYPE_FLOATSPIKE)
         {
            _handTheta += FlxG.elapsed * 0.8;
            offset.y = 2 * Math.sin(_handTheta);
         }
         if(_type == TYPE_FLOATSPIKE2)
         {
            _handTheta += FlxG.elapsed * 0.85;
            offset.y = 2 * Math.cos(_handTheta);
         }
         if(_type == TYPE_DANDELION || _type == TYPE_BALLOON)
         {
            _handTheta += FlxG.elapsed * 0.8;
            offset.x = 36 * Math.cos(_handTheta);
         }
         super.update();
      }
   }
}

