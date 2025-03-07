package
{
   import flash.utils.ByteArray;
   import org.flixel.*;
   
   public class SaveData extends FlxSave
   {
      public var xml:XML;
      
      public function destroy() : void
      {
         xml = null;
      }
      
      public function SaveData() : void
      {
         bind("Snailiad");
         if(xml == null)
         {
            loadAll();
         }
      }
      
      public function isVarSet(param1:String) : Boolean
      {
         return xml.vars.child(param1).length();
      }
      
      public function isVarTrue(param1:String) : Boolean
      {
         return xml.vars.child(param1).length() && xml.vars.child(param1) == true;
      }
      
      public function eraseAll() : void
      {
         erase();
         forceSave();
      }
      
      public function initVars() : XML
      {
         var _loc1_:Boolean = isVarTrue("hasWonGame");
         var _loc2_:Boolean = isVarTrue("hasSeenHelp");
         var _loc3_:Boolean = isVarTrue("hasWonHardMode");
         var _loc4_:Boolean = isVarTrue("hasWonInsaneMode");
         var _loc5_:Boolean = isVarTrue("hasWonBossRush");
         var _loc6_:Boolean = isVarTrue("hasFullClear");
         var _loc7_:Boolean = isVarTrue("hideTab");
         var _loc8_:Boolean = isVarTrue("hideMiniMap");
         var _loc9_:Number = xml.vars.bestBossRushTime;
         var _loc10_:Number = xml.vars.bestMainTime;
         var _loc11_:Number = xml.vars.bestHardTime;
         var _loc12_:Number = xml.vars.bestInsaneTime;
         var _loc13_:XML = new XML(<vars/>);
         if(Player.firingMode == Player.FIRING_MODE_TOGGLE)
         {
            _loc13_.appendChild(<toggleFire>true</toggleFire>);
         }
         if(_loc8_)
         {
            _loc13_.appendChild(<hideMiniMap>{_loc8_}</hideMiniMap>);
         }
         if(_loc7_)
         {
            _loc13_.appendChild(<hideTab>{_loc7_}</hideTab>);
         }
         if(_loc1_)
         {
            _loc13_.appendChild(<hasWonGame>{_loc1_}</hasWonGame>);
         }
         if(_loc3_)
         {
            _loc13_.appendChild(<hasWonHardMode>{_loc3_}</hasWonHardMode>);
         }
         if(_loc4_)
         {
            _loc13_.appendChild(<hasWonInsaneMode>{_loc4_}</hasWonInsaneMode>);
         }
         if(_loc6_)
         {
            _loc13_.appendChild(<hasFullClear>{_loc6_}</hasFullClear>);
         }
         if(_loc5_)
         {
            _loc13_.appendChild(<hasWonBossRush>{_loc5_}</hasWonBossRush>);
         }
         _loc13_.appendChild(<bestBossRushTime>{_loc9_}</bestBossRushTime>);
         _loc13_.appendChild(<bestMainTime>{_loc10_}</bestMainTime>);
         _loc13_.appendChild(<bestHardTime>{_loc11_}</bestHardTime>);
         _loc13_.appendChild(<bestInsaneTime>{_loc12_}</bestInsaneTime>);
         if(isVarSet("mapKey"))
         {
            _loc13_.appendChild(xml.vars.mapKey);
         }
         if(isVarSet("jumpKey"))
         {
            _loc13_.appendChild(xml.vars.jumpKey);
         }
         if(isVarSet("shootKey"))
         {
            _loc13_.appendChild(xml.vars.shootKey);
         }
         if(isVarSet("strafeKey"))
         {
            _loc13_.appendChild(xml.vars.strafeKey);
         }
         if(isVarSet("upKey"))
         {
            _loc13_.appendChild(xml.vars.upKey);
         }
         if(isVarSet("downKey"))
         {
            _loc13_.appendChild(xml.vars.downKey);
         }
         if(isVarSet("leftKey"))
         {
            _loc13_.appendChild(xml.vars.leftKey);
         }
         if(isVarSet("rightKey"))
         {
            _loc13_.appendChild(xml.vars.rightKey);
         }
         if(isVarSet("jumpAltKey"))
         {
            _loc13_.appendChild(xml.vars.jumpAltKey);
         }
         if(isVarSet("shootAltKey"))
         {
            _loc13_.appendChild(xml.vars.shootAltKey);
         }
         if(isVarSet("strafeAltKey"))
         {
            _loc13_.appendChild(xml.vars.strafeAltKey);
         }
         if(isVarSet("upAltKey"))
         {
            _loc13_.appendChild(xml.vars.upAltKey);
         }
         if(isVarSet("downAltKey"))
         {
            _loc13_.appendChild(xml.vars.downAltKey);
         }
         if(isVarSet("leftAltKey"))
         {
            _loc13_.appendChild(xml.vars.leftAltKey);
         }
         if(isVarSet("rightAltKey"))
         {
            _loc13_.appendChild(xml.vars.rightAltKey);
         }
         if(isVarSet("weap1Key"))
         {
            _loc13_.appendChild(xml.vars.weap1Key);
         }
         if(isVarSet("weap2Key"))
         {
            _loc13_.appendChild(xml.vars.weap2Key);
         }
         if(isVarSet("weap3Key"))
         {
            _loc13_.appendChild(xml.vars.weap3Key);
         }
         if(isVarSet("weapNextKey"))
         {
            _loc13_.appendChild(xml.vars.weapNextKey);
         }
         if(isVarSet("weapPrevKey"))
         {
            _loc13_.appendChild(xml.vars.weapPrevKey);
         }
         return _loc13_;
      }
      
      public function eraseMostHard() : void
      {
         loadAll();
         var _loc1_:XML = initVars();
         _loc1_.appendChild(<hardMode>true</hardMode>);
         xml = new XML(<SaveData/>);
         xml.appendChild(_loc1_);
         saveAll();
      }
      
      public function eraseMostInsane() : void
      {
         loadAll();
         var _loc1_:XML = initVars();
         _loc1_.appendChild(<hardMode>true</hardMode>);
         _loc1_.appendChild(<insaneMode>true</insaneMode>);
         xml = new XML(<SaveData/>);
         xml.appendChild(_loc1_);
         saveAll();
      }
      
      public function eraseMostEasy() : void
      {
         loadAll();
         var _loc1_:XML = initVars();
         _loc1_.appendChild(<easyMode>true</easyMode>);
         xml = new XML(<SaveData/>);
         xml.appendChild(_loc1_);
         saveAll();
      }
      
      public function eraseMost() : void
      {
         loadAll();
         var _loc1_:XML = initVars();
         xml = new XML(<SaveData/>);
         xml.appendChild(_loc1_);
         saveAll();
      }
      
      public function saveAll() : void
      {
         var _loc1_:String = Cipher.cipherString(Cipher.compress(xml.toString()));
         var _loc2_:String = Cipher.MD5(xml.toString());
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(_loc1_);
         write("z",_loc3_);
         write("y",_loc2_);
         forceSave();
      }
      
      public function loadAll() : void
      {
         var data:Object = read("z");
         if(data == null || !(data is ByteArray) || !data.length)
         {
            xml = new XML(<SaveData/>);
            xml.appendChild(<vars/>);
            return;
         }
         var checksumdata:Object = read("y");
         if(checksumdata == null || !(checksumdata is String) || !checksumdata.length)
         {
            xml = new XML(<SaveData/>);
            xml.appendChild(<vars/>);
            return;
         }
         var oldsum:String = checksumdata as String;
         try
         {
            var ba:ByteArray = data as ByteArray;
            var xmlStr:String = Cipher.uncompress(Cipher.cipherString(ba.toString()));
            var newsum:String = Cipher.MD5(xmlStr);
            if(newsum != oldsum)
            {
               FlxG.log("Checksum failure");
               xml = new XML(<SaveData/>);
               xml.appendChild(<vars/>);
               return;
            }
            xml = new XML(Cipher.uncompress(Cipher.cipherString(ba.toString())));
            if(!xml.hasOwnProperty("vars"))
            {
               xml.appendChild(<vars/>);
            }
         }
         catch(error:Error)
         {
            xml = new XML(<SaveData/>);
            xml.appendChild(<vars/>);
            FlxG.log("Caught error \"" + error.message + "\", creating new empty XML " + xml.toString());
         }
      }
   }
}

