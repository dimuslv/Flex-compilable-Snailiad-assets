package
{
   import flash.utils.*;
   import org.flixel.*;
   
   public class SaveData extends FlxSave
   {
      public var xml:XML;
      
      public function SaveData() : void
      {
         super();
         bind("Snailiad");
         if(this.xml == null)
         {
            this.loadAll();
         }
      }
      
      public function destroy() : void
      {
         xml = null;
      }
      
      public function isVarSet(param1:String) : Boolean
      {
         return this.xml.vars.child(param1).length();
      }
      
      public function isVarTrue(param1:String) : Boolean
      {
         return this.xml.vars.child(param1).length() && this.xml.vars.child(param1) == true;
      }
      
      public function eraseAll() : void
      {
         erase();
         forceSave();
      }
      
      public function initVars() : XML
      {
         var _loc1_:Boolean = this.isVarTrue("hasWonGame");
         var _loc2_:Boolean = this.isVarTrue("hasSeenHelp");
         var _loc3_:Boolean = this.isVarTrue("hasWonHardMode");
         var _loc4_:Boolean = this.isVarTrue("hasWonInsaneMode");
         var _loc5_:Boolean = this.isVarTrue("hasWonBossRush");
         var _loc6_:Boolean = this.isVarTrue("hasFullClear");
         var _loc7_:Boolean = this.isVarTrue("hideTab");
         var _loc8_:Boolean = this.isVarTrue("hideMiniMap");
         var _loc9_:Number = this.xml.vars.bestBossRushTime;
         var _loc10_:Number = this.xml.vars.bestMainTime;
         var _loc11_:Number = this.xml.vars.bestHardTime;
         var _loc12_:Number = this.xml.vars.bestInsaneTime;
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
         if(this.isVarSet("mapKey"))
         {
            _loc13_.appendChild(this.xml.vars.mapKey);
         }
         if(this.isVarSet("jumpKey"))
         {
            _loc13_.appendChild(this.xml.vars.jumpKey);
         }
         if(this.isVarSet("shootKey"))
         {
            _loc13_.appendChild(this.xml.vars.shootKey);
         }
         if(this.isVarSet("strafeKey"))
         {
            _loc13_.appendChild(this.xml.vars.strafeKey);
         }
         if(this.isVarSet("upKey"))
         {
            _loc13_.appendChild(this.xml.vars.upKey);
         }
         if(this.isVarSet("downKey"))
         {
            _loc13_.appendChild(this.xml.vars.downKey);
         }
         if(this.isVarSet("leftKey"))
         {
            _loc13_.appendChild(this.xml.vars.leftKey);
         }
         if(this.isVarSet("rightKey"))
         {
            _loc13_.appendChild(this.xml.vars.rightKey);
         }
         if(this.isVarSet("jumpAltKey"))
         {
            _loc13_.appendChild(this.xml.vars.jumpAltKey);
         }
         if(this.isVarSet("shootAltKey"))
         {
            _loc13_.appendChild(this.xml.vars.shootAltKey);
         }
         if(this.isVarSet("strafeAltKey"))
         {
            _loc13_.appendChild(this.xml.vars.strafeAltKey);
         }
         if(this.isVarSet("upAltKey"))
         {
            _loc13_.appendChild(this.xml.vars.upAltKey);
         }
         if(this.isVarSet("downAltKey"))
         {
            _loc13_.appendChild(this.xml.vars.downAltKey);
         }
         if(this.isVarSet("leftAltKey"))
         {
            _loc13_.appendChild(this.xml.vars.leftAltKey);
         }
         if(this.isVarSet("rightAltKey"))
         {
            _loc13_.appendChild(this.xml.vars.rightAltKey);
         }
         if(this.isVarSet("weap1Key"))
         {
            _loc13_.appendChild(this.xml.vars.weap1Key);
         }
         if(this.isVarSet("weap2Key"))
         {
            _loc13_.appendChild(this.xml.vars.weap2Key);
         }
         if(this.isVarSet("weap3Key"))
         {
            _loc13_.appendChild(this.xml.vars.weap3Key);
         }
         if(this.isVarSet("weapNextKey"))
         {
            _loc13_.appendChild(this.xml.vars.weapNextKey);
         }
         if(this.isVarSet("weapPrevKey"))
         {
            _loc13_.appendChild(this.xml.vars.weapPrevKey);
         }
         return _loc13_;
      }
      
      public function eraseMostHard() : void
      {
         this.loadAll();
         var _loc1_:XML = this.initVars();
         _loc1_.appendChild(<hardMode>true</hardMode>);
         xml = new XML(<SaveData/>);
         this.xml.appendChild(_loc1_);
         this.saveAll();
      }
      
      public function eraseMostInsane() : void
      {
         this.loadAll();
         var _loc1_:XML = this.initVars();
         _loc1_.appendChild(<hardMode>true</hardMode>);
         _loc1_.appendChild(<insaneMode>true</insaneMode>);
         xml = new XML(<SaveData/>);
         this.xml.appendChild(_loc1_);
         this.saveAll();
      }
      
      public function eraseMostEasy() : void
      {
         this.loadAll();
         var _loc1_:XML = this.initVars();
         _loc1_.appendChild(<easyMode>true</easyMode>);
         xml = new XML(<SaveData/>);
         this.xml.appendChild(_loc1_);
         this.saveAll();
      }
      
      public function eraseMost() : void
      {
         this.loadAll();
         var _loc1_:XML = this.initVars();
         xml = new XML(<SaveData/>);
         this.xml.appendChild(_loc1_);
         this.saveAll();
      }
      
      public function saveAll() : void
      {
         var _loc1_:String = Cipher.cipherString(Cipher.compress(this.xml.toString()));
         var _loc2_:String = Cipher.MD5(this.xml.toString());
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
            this.xml.appendChild(<vars/>);
            return;
         }
         var checksumdata:Object = read("y");
         if(checksumdata == null || !(checksumdata is String) || !checksumdata.length)
         {
            xml = new XML(<SaveData/>);
            this.xml.appendChild(<vars/>);
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
               this.xml.appendChild(<vars/>);
               return;
            }
            xml = new XML(Cipher.uncompress(Cipher.cipherString(ba.toString())));
            if(!this.xml.hasOwnProperty("vars"))
            {
               this.xml.appendChild(<vars/>);
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

