package
{
   import org.flixel.*;
   
   public class SnailNpc extends Npc
   {
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static var talkedToCaveSnail:Boolean = false;
      
      private var _snailNum:int = 0;
      
      private var _talkOpen:Boolean = false;
      
      private var _nexted:int = 0;
      
      private var _elapsed:Number = 0;
      
      private var _hasFallen:Boolean = false;
      
      private var _speed:Number = 1;
      
      public function SnailNpc(param1:int, param2:int, param3:int)
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2);
         loadGraphic(Art.SnailNpc,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         if(param3 == 26 && PlayState.player._slugMode)
         {
            param3 = 44;
         }
         if(param3 == 38)
         {
            if(!PlayState.bossesKilled[4])
            {
               exists = false;
            }
            else if(PlayState.player.getHelixFragments() < 30)
            {
               param3 = 49;
               y += 32;
               x += 16;
            }
         }
         addAnimation("normal",[2 * param3,2 * param3 + 1],3,true);
         play("normal");
         this._snailNum = param3;
         acceleration.y = 1200;
         if(param3 == 17)
         {
            acceleration.y = -1200;
         }
         if(param3 == 35 || param3 == 47)
         {
            acceleration.y = -1200;
         }
         if(param3 == 43)
         {
            acceleration.y = -1200;
         }
         if(param3 == 39 || param3 == 38 || param3 == 49)
         {
            acceleration.y = 0;
         }
         maxVelocity.y = PlayState.player.maxVelocity.y;
      }
      
      override public function touch(param1:Player) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:* = null;
         var _loc6_:int = this._snailNum % 4;
         var _loc7_:String = "Snaily";
         if(param1._slugMode)
         {
            _loc7_ = "Sluggy";
         }
         var _loc8_:String = "Snaily Snail";
         if(param1._slugMode)
         {
            _loc8_ = "Sluggy Slug";
         }
         var _loc9_:String = "snail";
         if(param1._slugMode)
         {
            _loc9_ = "slug";
         }
         if(!this._talkOpen)
         {
            _loc2_ = PlayState.player.getPercentComplete();
            _loc3_ = PlayState.player.getHelixFragments();
            _loc4_ = false;
            _loc5_ = "[no text yet: NPC #" + this._snailNum.toString() + "]";
            switch(this._snailNum)
            {
               case 0:
                  if(!PlayState.player.hasWeapon(0))
                  {
                     _loc5_ = "Hi, " + _loc7_ + "!!  Why don\'t you try\n" + "climbing up the walls?\n" + "    Just hold \"UP\" and \"RIGHT\".\n";
                  }
                  else if(!PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "Oh, nice pea shooter!  I heard\n" + "you can shoot a blue door open\n" + "with one of those!\n";
                  }
                  else if(!PlayState.player.hasWeapon(2))
                  {
                     _loc5_ = "Wow, a boomerang!  You could\n" + "break a pink door open with\n" + "just one of those!\n";
                  }
                  else if(!PlayState.player.getHasDevastator())
                  {
                     _loc5_ = "Is that a rainbow wave!?  Well,\n" + "then!  You can open a red door\n" + "with one of those!\n";
                  }
                  else if(_loc2_ < 100)
                  {
                     _loc5_ = "A devastator!?  That opens up\n" + "green doors!  It also upgrades\n" + "all three weapons!  Wow!!\n";
                  }
                  else
                  {
                     _loc5_ = "I hope the next game has more\n" + "weapons.  This game could have\n" + "used a flame whip!\n";
                  }
                  break;
               case 1:
                  if(!PlayState.hasJumped && !PlayState.player.hasWeapon(0) && !PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "Hiya, " + _loc7_ + "!  Did you know you\n" + "can jump?  Just press \"" + Player.JUMP_KEY + "\"!\n";
                  }
                  else if(!PlayState.player.hasWeapon(0))
                  {
                     _loc5_ = "" + _loc7_ + ", some snails are missing!\n" + "Do you think you could go look\n" + "for them?  I\'m getting worried!\n";
                  }
                  else if(_loc2_ < 100)
                  {
                     _loc5_ = "I have a goal in life.  One day,\n" + "I will eat a pizza.  I mean it!!\n" + "Just you watch, " + _loc7_ + "!!\n";
                  }
                  else
                  {
                     _loc5_ = "" + _loc7_ + ", you missed it!  I made a\n" + "delicious pizza, and I ate the\n" + "whole thing!!!  Om nom nom!\n";
                  }
                  break;
               case 2:
                  if(!PlayState.player.hasWeapon(0) && !PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you finding a weapon\n" + "somewhere under the water!\n";
                  }
                  else if(!PlayState.bossesKilled[1] && !PlayState.bossesKilled[2])
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you heading to the upper\n" + "right part of the map!!\n";
                  }
                  else if(!PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "I can see the past, " + _loc7_ + "!\n" + "I see you forgot to grab the\n" + "boomerang after Shellbreaker!\n";
                  }
                  else if(!PlayState.bossesKilled[2])
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you heading to the lower\n" + "right part of the map!!\n";
                  }
                  else if(!PlayState.player.hasWeapon(2))
                  {
                     _loc5_ = "I can see the past, " + _loc7_ + "!\n" + "I see you forgot to grab the\n" + "rainbow wave after Stompy!\n";
                  }
                  else if(!PlayState.bossesKilled[3])
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you heading to the lower\n" + "left part of the map!!\n";
                  }
                  else if(!PlayState.player.hasTurbo())
                  {
                     _loc5_ = "I can see the past, " + _loc7_ + "!\n" + "I see you forgot to grab the\n" + "rapid fire before Space Box!\n";
                  }
                  else if(!PlayState.bossesKilled[4])
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you heading to the upper\n" + "left part of the map!!\n";
                  }
                  else if(_loc3_ < 30)
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you heading all over the\n" + "map, finding little shells!\n";
                  }
                  else if(!PlayState.player.hasSeenIsis)
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you heading precisely two\n" + "screens to the left of here!!\n";
                  }
                  else if(!PlayState.player._slugMode)
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you having 18,000,000\n" + "baby snails!!  Congratulations!!\n";
                  }
                  else
                  {
                     _loc5_ = "I can see the future, " + _loc7_ + "!\n" + "I see you having 18,000,000\n" + "baby slugs!!  Congratulations!!\n";
                  }
                  break;
               case 3:
                  if(!PlayState.player.hasGravityJump())
                  {
                     _loc5_ = "I wonder why I can\'t crawl on\n" + "ceiling corners...  Do you think\n" + "I\'ll ever be able to, " + _loc7_ + "?\n";
                  }
                  else if(!PlayState.player.hasArmor())
                  {
                     _loc5_ = "Oh, my, you\'re a gravity " + _loc9_ + "!\n" + "You must be really good at\n" + "crawling around ceilings!!\n";
                  }
                  else
                  {
                     _loc5_ = "Oh, my, you\'re a full metal\n" + _loc9_ + "! You must be really good\n" + "at crawling around ceilings!!\n";
                  }
                  break;
               case 4:
                  if(PlayState.worldMap.bgmap.getTile(295,143))
                  {
                     _loc5_ = "I wish I had some way to break\n" + "green blocks.  Those suckers\n" + "are always getting in my way!!\n";
                  }
                  else
                  {
                     _loc5_ = "Whew!  Thanks, " + _loc7_ + "!  I think\n" + "those blocks were planning to\n" + "attack!!  You saved the day!!\n";
                  }
                  break;
               case 5:
                  if(_loc2_ < 100)
                  {
                     _loc5_ = "There\'s a lot of secrets\n" + "in and around Snail Town.\n" + "Have you found them all?\n";
                  }
                  else
                  {
                     _loc5_ = "They say Boss Rush is the\n" + "true test of snail skill.\n" + "But what about slug skill?\n";
                  }
                  break;
               case 6:
                  if(PlayState.player.hasHighJump() || PlayState.player.hasGravityJump())
                  {
                     _loc5_ = "Don\'t you think it\'s weird that\n" + "we all live in treehouses?\n";
                  }
                  else
                  {
                     _loc5_ = "Hey " + _loc7_ + ", how\'d you get up\n" + "here?  And how do I get down?\n";
                  }
                  break;
               case 7:
                  if(!PlayState.player.hasWeapon(0))
                  {
                     _loc5_ = "Are you leaving town, " + _loc7_ + "?\n" + "Well, be careful!  Make sure\n" + "you save your game often!!\n";
                  }
                  else if(!PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "Hey, " + _loc7_ + "!  Where\'d you get\n" + "the pea shooter?\n";
                  }
                  else if(!PlayState.player.hasWeapon(2))
                  {
                     _loc5_ = "Ooh, boomerangs!  If I had\n" + "those, I\'d try breaking the\n" + "ceiling over the save spot!\n";
                  }
                  else if(!PlayState.player.getHasDevastator())
                  {
                     _loc5_ = "Rainbows are so pretty!\n" + "Don\'t you think so, " + _loc7_ + "?\n";
                  }
                  else if(!PlayState.isBossDead(4))
                  {
                     _loc5_ = "I\'m scared, " + _loc7_ + "!\n" + "Is Moon Snail going to take\n" + "me away like the others?\n";
                  }
                  else
                  {
                     _loc5_ = "Snail Town is safe again,\n" + "thanks to you, " + _loc7_ + "!\n";
                  }
                  break;
               case 8:
                  if(PlayState.worldMap.bgmap.getTile(328,185))
                  {
                     _loc5_ = "There\'s something funny about\n" + "that tree...\n";
                  }
                  else
                  {
                     _loc5_ = "I knew there was something\n" + "weird about that tree!!\n";
                  }
                  break;
               case 9:
                  if(_loc2_ < 100)
                  {
                     _loc5_ = "The other snails live in houses,\n" + "but I like it here in the dirt.\n" + "Isn\'t it nice in here?\n";
                  }
                  else
                  {
                     _loc5_ = "It\'s so cozy in here!  I just\n" + "love my little underground\n" + "home!\n";
                  }
                  break;
               case 10:
                  _loc5_ = "Oh, " + _loc8_ + "!  My heart\n" + "will forever belong to you!\n" + "             <3\n";
                  break;
               case 11:
                  if(!PlayState.player.hasWeapon(0))
                  {
                     _loc5_ = "" + _loc7_ + ", it\'s dangerous to go\n" + "alone!  Take this Pea Shooter!\n" + "Press \"" + Player.SHOOT_KEY + "\" to shoot with it!!\n";
                  }
                  else
                  {
                     _loc5_ = "Don\'t forget!\n" + "Press \"" + Player.SHOOT_KEY + "\" to shoot your\n" + "weapon at stuff!!\n";
                  }
                  break;
               case 12:
                  if(PlayState.worldMap.spmap.getTile(359,174))
                  {
                     _loc5_ = "Heya, " + _loc7_ + "! I filled the heart\n" + "container over there with some\n" + "fresh slime! Enjoy!!\n";
                  }
                  else
                  {
                     _loc5_ = "Isn\'t breaking blocks fun!?\n";
                  }
                  break;
               case 13:
                  _loc5_ = "Wow!  It looks like you\'ve\n" + "found " + _loc2_.toString() + "% of the items in this\n" + "game!  Nice going, " + _loc7_ + "!\n";
                  break;
               case 14:
                  if(_loc3_ < 15)
                  {
                     _loc5_ = "Hey, " + _loc7_ + "!  Keep an eye out\n" + "for \"Helix Fragments\".  They\n" + "look like spinning white shells!\n";
                  }
                  else if(_loc3_ < 30 || !PlayState.player.hasSeenIsis)
                  {
                     _loc5_ = "They say that the Shrine of\n" + "Iris is not located on any map!\n";
                  }
                  else
                  {
                     _loc5_ = "Wow, " + _loc7_ + "!  You\'re pretty good\n" + "at finding secrets!  Maybe you\n" + "should become a detective!\n";
                  }
                  break;
               case 15:
                  if(_loc2_ < 20)
                  {
                     _loc5_ = "Hi, " + _loc7_ + "!  Let me give you a\n" + "hint: Come back to town after\n" + "each area to find secret items!\n";
                  }
                  else if(_loc2_ < 40 && !param1._slugMode)
                  {
                     _loc5_ = "Hi, " + _loc7_ + "!  Let me give you a\n" + "little hint: A shell can fit\n" + "where a snail cannot!\n";
                  }
                  else if(_loc2_ < 40 && param1._slugMode)
                  {
                     _loc5_ = "Hi, " + _loc7_ + "!  Here\'s a li\'l hint:\n" + "Slugs may be more fragile than\n" + "snails, but they\'re also faster!\n";
                  }
                  else if(_loc2_ < 60)
                  {
                     _loc5_ = "Hi, " + _loc7_ + "!  Let me give you a\n" + "hint: Sometimes, you\'ll miss a\n" + "secret if you cling to a wall!\n";
                  }
                  else if(_loc2_ < 80)
                  {
                     _loc5_ = "Hi, " + _loc7_ + "!  Let me give you a\n" + "hint: You can find the \"high\n" + "jump\" before any other item!\n";
                  }
                  else if(_loc2_ < 100)
                  {
                     _loc5_ = "Hi, " + _loc7_ + "!  Let me tell you a\n" + "secret: There\'s a boomerang\n" + "somewhere in Snail Town!\n";
                  }
                  else
                  {
                     _loc5_ = "Hi, " + _loc7_ + "!  Let me tell you a\n" + "secret: there\'s a secret\n" + "somewhere in the main menu!\n";
                  }
                  break;
               case 16:
                  if(!PlayState.player.hasWeapon(0) && !PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "If you ever get hurt, eat some\n" + "plants!  You need to eat well\n" + "to stay fit and healthy!\n";
                  }
                  else if(y < 2656)
                  {
                     _loc5_ = "I want to go for a ride!!!\n";
                  }
                  else
                  {
                     _loc5_ = "WHEEEE!!  That was fun,\n" + "" + _loc7_ + "!  Let\'s do it again!!\n";
                  }
                  break;
               case 17:
                  if(_loc2_ < 100)
                  {
                     _loc5_ = "There\'s a hidden room under the\n" + "path into town.  I don\'t know\n" + "how to get in yet, though...\n";
                  }
                  else
                  {
                     _loc5_ = "They call me upside-down snail,\n" + "but I think everyone else is\n" + "upside down!";
                  }
                  break;
               case 18:
                  if(PlayState.worldMap.spmap.getTile(215,140))
                  {
                     _loc5_ = "You found the super secret\n" + "boomerang!  Way to go!\n" + "Press \"" + Player.SHOOT_KEY + "\" to shoot with it!\n";
                  }
                  else
                  {
                     _loc5_ = "Don\'t forget!\n" + "Press \"" + Player.SHOOT_KEY + "\" to shoot your\n" + "weapon at stuff!!\n";
                  }
                  break;
               case 19:
                  if(!PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "Hey, " + _loc7_ + "!  If you had a\n" + "boomerang, you could break\n" + "all sorts of walls!\n";
                  }
                  else
                  {
                     _loc5_ = "Up, up, down, down, left,\n" + "right...  Wait, never mind,\n" + "that\'s for some other game.\n";
                  }
                  break;
               case 20:
                  if(!PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "There\'s some kind of secret\n" + "passage to the right, but I\'m\n" + "not sure how to get through...\n";
                  }
                  else if(_loc2_ < 100)
                  {
                     _loc5_ = "I hope you can find all the\n" + "other snails!  They\'re not all\n" + "as brave as me, you know!!\n";
                  }
                  else
                  {
                     _loc5_ = "" + _loc8_ + "!!  Yay!!\n";
                  }
                  break;
               case 21:
                  if(!PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "Yay, " + _loc7_ + ", it\'s you!!\n" + "Take this boomerang and break\n" + "some walls open!!\n";
                  }
                  else
                  {
                     _loc5_ = "By the way, you can switch\n" + "weapons by pressing numbers,\n" + "like \"1\" or \"2\"!\n";
                  }
                  break;
               case 22:
                  if(_loc2_ < 100)
                  {
                     _loc5_ = "I are Cave Snail!\n" + "Thorgle Borgle!!!!\n";
                  }
                  else
                  {
                     _loc5_ = "Thorgle Borgle!!!!!!!\n";
                  }
                  talkedToCaveSnail = true;
                  break;
               case 23:
                  if(_loc2_ < 100 && !talkedToCaveSnail)
                  {
                     _loc5_ = "Cave Snail scares me!\n" + "I\'m staying over here!\n";
                  }
                  else if(_loc2_ < 60)
                  {
                     _loc5_ = "Hey, if you get stuck, just hit\n" + "ESCAPE and load your game from\n" + "town!  You won\'t lose any items!\n";
                  }
                  else
                  {
                     _loc5_ = "Do you think Cave Snail\n" + "is single?\n";
                  }
                  break;
               case 24:
                  if(PlayState.worldMap.spmap.getTile(291,220))
                  {
                     _loc5_ = "Take this Helix Fragment!\n" + "Legend says it is but one\n" + "piece of Iris, the Godsnail!\n";
                  }
                  else
                  {
                     _loc5_ = "" + _loc7_ + ", legend says the\n" + "Shrine of Iris is somewhere\n" + "very close to Snail Town!!\n";
                  }
                  break;
               case 25:
                  if(PlayState.player.hasWeapon(0))
                  {
                     _loc5_ = "Have you tried hitting \"" + Player.MAP_KEY + "\"\n" + "yet?  It makes the map big!  Oh,\n" + "and hit \"ESC\" for the menu!\n";
                  }
                  else if(_loc2_ < 60)
                  {
                     _loc5_ = "" + _loc7_ + ", if you need to see the\n" + "controls again, just press \"F1\"!\n" + "By the way, try hitting \"" + Player.MAP_KEY + "\"!\n";
                  }
                  else
                  {
                     _loc5_ = "Hey " + _loc7_ + ", I\'m hungry!  Know\n" + "any good plants around town?\n";
                  }
                  break;
               case 26:
                  _loc5_ = "With this \"Shell Shield\", you\n" + "won\'t take any damage when you\n" + "hide in your shell!\n";
                  break;
               case 27:
                  if(PlayState.player.hasArmor() || PlayState.player.hasGravityJump())
                  {
                     _loc5_ = "Hey, " + _loc7_ + "!  You came\n" + "back to visit!!  Yay!!\n";
                  }
                  else if(PlayState.player.isIcy())
                  {
                     _loc5_ = "Oh, " + _loc7_ + ", you\'re an Ice " + _loc9_ + "!\n" + "That means the icicles in the\n" + "room ahead won\'t hurt you!\n";
                  }
                  else
                  {
                     _loc5_ = "Watch out, " + _loc7_ + "!  Without the\n" + "\"Ice " + _loc9_ + "\" power, the area\n" + "ahead will be too difficult!\n";
                  }
                  break;
               case 28:
                  if(PlayState.player.hasGravityJump())
                  {
                     _loc5_ = "" + _loc7_ + ", you can gravity jump!\n" + "Jump in the air, then hold any\n" + "direction and press jump again!\n";
                  }
                  else
                  {
                     _loc5_ = "Oh, " + _loc7_ + ", it\'s you!!  I\'m saved!!\n" + "Moon Snail took me here!  He\'s\n" + "gone bad, " + _loc7_ + "!!\n";
                  }
                  break;
               case 29:
                  if(Boolean(PlayState.player) && PlayState.player._insaneMode)
                  {
                     _loc5_ = "Oh, no!! " + _loc7_ + "!! The \"Ice Snail\"\n" + "power-up is missing on insane\n" + "mode! Good luck without it!!\n";
                  }
                  else
                  {
                     _loc5_ = "Don\'t worry about me, " + _loc7_ + "!\n" + "I\'m an Ice Snail, so these ice\n" + "guys and icicles can\'t hurt me!\n";
                  }
                  _loc4_ = true;
                  break;
               case 30:
                  if(!PlayState.player.hasArmor() || !PlayState.player.hasTurbo())
                  {
                     _loc5_ = "Be careful, " + _loc7_ + "!  With only\n" + "the powers you have now, Moon\n" + "Snail will eat you for lunch!!\n";
                  }
                  else if(!PlayState.isBossDead(4))
                  {
                     _loc5_ = "" + _loc7_ + ", Moon Snail\'s just ahead!\n" + "He brought us here!!  He\'s gone\n" + "bad!!  You need to defeat him!!\n";
                  }
                  else if(_loc3_ < 30 || !PlayState.player.hasSeenIsis)
                  {
                     _loc5_ = "" + _loc7_ + ", search for the helix\n" + "fragments!  Maybe Iris can\n" + "still restore Moon Snail!!\n";
                  }
                  else
                  {
                     _loc5_ = "Congratulations, " + _loc7_ + "!!  Moon\n" + "Snail is saved!!  Wait, is he a\n" + "moon snail or a sun snail?\n";
                  }
                  _loc4_ = true;
                  break;
               case 31:
                  if(!PlayState.isBossDead(4))
                  {
                     _loc5_ = "Moon Snail is still a snail!!  He\n" + "was once known as Sun Snail\n" + "and enjoyed nomming on grass!!\n";
                  }
                  else if(_loc3_ < 30 && PlayState.isBossDead(4) || !PlayState.player.hasSeenIsis)
                  {
                     _loc5_ = "I\'ve heard that the Shrine of\n" + "Iris is not marked on any map!\n" + "Have you found it yet?\n";
                  }
                  else
                  {
                     _loc5_ = "Don\'t moon snails live in the\n" + "ocean?  HEY, THIS GAME ISN\'T\n" + "REALISTIC!!  WHAT GIVES??\n";
                  }
                  _loc4_ = true;
                  break;
               case 32:
                  if(!PlayState.player.hasArmor() || !PlayState.player.hasTurbo())
                  {
                     _loc5_ = "Watch out, " + _loc7_ + "!  You\'re not\n" + "strong enough to fight Moon\n" + "Snail yet!!  Turn back!!\n";
                  }
                  else if(_loc3_ < 30 && !PlayState.isBossDead(4))
                  {
                     _loc5_ = "If only you had the power of\n" + "Iris!  She could restore his\n" + "light once he\'s defeated!!\n";
                  }
                  else if(_loc3_ == 30 && !PlayState.isBossDead(4))
                  {
                     _loc5_ = "Use the power of Iris, " + _loc7_ + "!\n" + "Defeat Moon Snail, and restore\n" + "him to his former light!\n";
                  }
                  else if(_loc3_ < 30 || !PlayState.player.hasSeenIsis)
                  {
                     _loc5_ = "There are 30 fragments hidden\n" + "around " + _loc7_ + " World!  Good luck\n" + "finding them, " + _loc7_ + "!!\n";
                  }
                  else
                  {
                     _loc5_ = "Amazing work, " + _loc7_ + "!!  Hey,\n" + "how\'d we get into outer space,\n" + "anyway?\n";
                  }
                  _loc4_ = true;
                  break;
               case 33:
                  if(PlayState.isBossDead(4))
                  {
                     _loc5_ = "Congratulations, " + _loc7_ + "!!  You\n" + "defeated Moon Snail!!  You\'re\n" + "the best " + _loc9_ + " ever!!\n";
                  }
                  else if(PlayState.worldMap.spmap.getTile(34,7))
                  {
                     _loc5_ = "" + _loc7_ + ", take this heart!  You\'ll\n" + "need all the help you can get\n" + "to defeat Moon Snail!\n";
                  }
                  else
                  {
                     _loc5_ = "Good luck, " + _loc7_ + "!!\n";
                  }
                  _loc4_ = true;
                  break;
               case 34:
                  if(_loc3_ < 30 || !PlayState.player.hasSeenIsis)
                  {
                     _loc5_ = "" + _loc7_ + ", search for the Helix\n" + "Fragments!  Once you have them\n" + "all, find the Shrine of Iris!\n";
                  }
                  else
                  {
                     _loc5_ = "Amazing work, " + _loc7_ + "!!  You\'ve\n" + "saved Sun Snail using the power\n" + "of Iris!!\n";
                  }
                  _loc4_ = true;
                  break;
               case 35:
                  _loc5_ = "Wow! You found the secret room\n" + "full of Snelks!! _@_v!!\n";
                  _loc4_ = true;
                  break;
               case 36:
                  _loc5_ = "Heya, " + _loc7_ + "!  Gravity shock\n" + "upgrades your gravity jump!\n" + "Pretty neat, huh?\n";
                  _loc4_ = true;
                  break;
               case 37:
                  _loc5_ = "Where are we, " + _loc7_ + "?  Do you\n" + "think they put this room in\n" + "on purpose?\n";
                  _loc4_ = true;
                  break;
               case 38:
                  _loc5_ = "" + _loc7_ + ", thank you for helping\n" + "me!  Now I can get back to my\n" + "hobby: collecting prime numbers!\n";
                  break;
               case 39:
                  PlayState.player.hasSeenIsis = true;
                  if(!PlayState.isBossDead(4))
                  {
                     if(_loc3_ == 0)
                     {
                        _loc5_ = "Hello, " + _loc7_ + "!  I am Iris, the\n" + "Godsnail.  But without the Helix\n" + "Fragments, I am powerless...\n";
                     }
                     else if(_loc3_ < 25)
                     {
                        _loc5_ = "Hello, " + _loc7_ + "! I am Iris, the\n" + "Godsnail. But with only " + _loc3_.toString() + " Helix\n" + "Fragment" + (_loc3_ == 1 ? "" : "s") + ", I am powerless...\n";
                     }
                     else if(_loc3_ < 29)
                     {
                        _loc5_ = "I can feel my power returning!\n" + "With " + (30 - _loc3_).toString() + " more Helix Fragments,\n" + "perhaps we can save Moon Snail!\n";
                     }
                     else if(_loc3_ < 30)
                     {
                        _loc5_ = "I can feel my power returning!\n" + "With 1 more Helix Fragment,\n" + "perhaps we can save Moon Snail!\n";
                     }
                     else if(_loc3_ == 30)
                     {
                        _loc5_ = "My power has returned!  Now go,\n" + "" + _loc7_ + ", and defeat Moon Snail!\n" + "My power will restore him!\n";
                     }
                  }
                  else if(_loc3_ == 30)
                  {
                     _loc5_ = "Congratulations, " + _loc7_ + "! Thanks\n" + "to you, Moon Snail is restored,\n" + "and is now the Sun Snail!\n";
                  }
                  else
                  {
                     _loc5_ = "Moon Snail rests fitfully\n" + "upon the shrine steps...  Find " + (30 - _loc3_).toString() + "\n" + "more fragment" + (30 - _loc3_ == 1 ? "" : "s") + ", " + _loc8_ + "!\n";
                  }
                  break;
               case 40:
                  if(!PlayState.isBossDead(2))
                  {
                     _loc5_ = "Be careful, " + _loc7_ + "!!  I\'ve heard\n" + "some scary stuff happening in\n" + "the next room!!\n";
                  }
                  else
                  {
                     _loc5_ = "Wow!!  You defeated the evil\n" + "monster??  You\'re my hero,\n" + _loc8_ + "!!\n";
                  }
                  break;
               case 41:
                  if(!PlayState.isBossDead(1))
                  {
                     _loc5_ = "Watch out, " + _loc8_ + "!!\n" + "A fierce monster is hiding\n" + "in the next room!!\n";
                  }
                  else if(!PlayState.player.hasWeapon(1))
                  {
                     _loc5_ = "Oh hey, that grey door below\n" + "and to the left opened up!\n" + "I wonder what\'s inside?\n";
                  }
                  else if(param1._slugMode)
                  {
                     _loc5_ = "Good luck, " + _loc7_ + "!\n";
                  }
                  else if(!PlayState.isBossDead(4))
                  {
                     _loc5_ = "Good luck, " + _loc7_ + "!  I\'ll wait\n" + "here for you!!  Let\'s have lots\n" + "of baby snails later, okay?\n";
                  }
                  else
                  {
                     _loc5_ = _loc8_ + ", you came\n" + "back!!  Yay!!\n";
                  }
                  break;
               case 42:
                  if(!PlayState.player.hasTurbo())
                  {
                     _loc5_ = "Hey, " + _loc7_ + "!  I heard a rumor\n" + "that the next room is too hard\n" + "without \"Rapid Fire\"!!\n";
                  }
                  else if(!PlayState.isBossDead(3))
                  {
                     _loc5_ = "Moon Snail brought me here!\n" + "Isn\'t he nice?  All the pink\n" + "grass I could ever eat!!\n";
                  }
                  else
                  {
                     _loc5_ = "What?  There was a monster\n" + "in the next room??  Are you\n" + "trying to scare me, " + _loc7_ + "??\n";
                  }
                  break;
               case 43:
                  if(!PlayState.player.hasGravityJump())
                  {
                     _loc5_ = "I can\'t seem to crawl around\n" + "these corners!  I wonder if\n" + "I\'ll ever be able to do it...\n";
                  }
                  else
                  {
                     _loc5_ = "Ooh, " + _loc7_ + ", can you crawl\n" + "around ceiling corners now??\n" + "I wish I were a Gravity Snail!\n";
                  }
                  break;
               case 44:
                  if(param1._slugMode)
                  {
                     return;
                  }
                  break;
               case 45:
                  if(!PlayState.player.hasArmor())
                  {
                     _loc5_ = "Hey, " + _loc7_ + "!  If you grab the\n" + "powerup ahead, you\'ll only take\n" + "half damage from enemies!!\n";
                  }
                  else if(!PlayState.player._slugMode)
                  {
                     _loc5_ = "Ooh, a Full Metal Snail!  Now\n" + "you\'re as tough as iron, and as\n" + "quick as Mercury!\n";
                  }
                  else
                  {
                     _loc5_ = "Ooh, a Full Power Slug, the\n" + "fastest slug on earth!!\n";
                  }
                  _loc4_ = true;
                  break;
               case 46:
                  _loc5_ = "Walleyes can\'t hurt you, " + _loc7_ + "!\n" + "You can just crawl right past\n" + "them, right on the same wall!\n";
                  break;
               case 47:
                  _loc5_ = "So many secret snelks!  Have\n" + "you found the other secret\n" + "snelk room yet?  _@_v!!\n";
                  _loc4_ = true;
                  break;
               case 48:
                  if(this._nexted == 0)
                  {
                     _loc5_ = "Hey, " + _loc7_ + ", what\'s up?\n";
                  }
                  else if(this._nexted == 1)
                  {
                     _loc6_ = 3;
                     _loc5_ = "YEEEEEEEEEEEEEEEEEEEEEEEEEE\n" + "EEEEEEEEEEEEEEEEEEEEEEEEEEE\n" + "EEEEEEEEEEEEEEEEEEEEEEEEEEE\n";
                  }
                  else if(this._nexted == 2)
                  {
                     _loc5_ = "Whew!!  That was scary!!\n";
                  }
                  break;
               case 49:
                  _loc5_ = "zzzzz...  4,978,213...  zzzzz...\n" + "7,723,297...  zzzzz...  6,017,093...\n" + "zzzzz...  2,425,991...  zzzzz...\n";
                  break;
               case 50:
                  _loc5_ = "Have you tried hitting the\n" + Player.STRAFE_KEY + " key yet?  It lets you\n" + "shoot while holding still!\n";
            }
            PlayState.dialogue.start(_loc5_,_loc6_,_loc4_,this._speed,this._snailNum);
         }
         this._talkOpen = true;
      }
      
      public function stopTalking() : void
      {
         PlayState.dialogue.stop(this._snailNum);
         this._talkOpen = false;
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(this._snailNum == 39 || this._snailNum == 38)
         {
            this._elapsed += FlxG.elapsed;
            offset.y = Math.sin(this._elapsed * 0.5) * 5;
         }
         if(this._talkOpen)
         {
            switch(this._snailNum)
            {
               case 1:
                  if(PlayState.hasJumped && this._nexted == 0)
                  {
                     this._nexted = 1;
                     this.stopTalking();
                  }
                  break;
               case 4:
                  if(PlayState.worldMap.bgmap.getTile(295,143) == 0 && this._nexted == 0)
                  {
                     this._nexted = 1;
                     this.stopTalking();
                  }
                  break;
               case 8:
                  if(PlayState.worldMap.bgmap.getTile(328,185) == 0 && this._nexted == 0)
                  {
                     this._nexted = 1;
                     this.stopTalking();
                  }
                  break;
               case 16:
                  if(y > 2656 && this._nexted == 0)
                  {
                     this._nexted = 1;
                     this.stopTalking();
                  }
                  break;
               case 48:
                  if(y > 198 * 16 && this._nexted == 0)
                  {
                     this._speed = 2;
                     this._nexted = 1;
                     this.stopTalking();
                  }
                  else if(y > 232 * 16 && velocity.y < 150 && this._nexted == 1)
                  {
                     this._speed = 1;
                     this._nexted = 2;
                     this.stopTalking();
                  }
            }
            _loc1_ = PlayState.player.x - x;
            _loc2_ = PlayState.player.y - y;
            if(_loc1_ * _loc1_ + _loc2_ * _loc2_ > 120 * 120)
            {
               this.stopTalking();
            }
         }
         super.update();
         if(this._snailNum == 44 || this._snailNum == 49)
         {
            facing = RIGHT;
         }
         else
         {
            facing = PlayState.player.x < x ? LEFT : RIGHT;
         }
      }
      
      override public function kill() : void
      {
         super.kill();
         if(this._talkOpen)
         {
            PlayState.dialogue.stop();
         }
      }
   }
}

