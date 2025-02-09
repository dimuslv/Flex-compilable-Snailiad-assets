package
{
   import flash.utils.ByteArray;
   
   public class Configurable
   {
      private var configXmlFile:Class;
      
      private var _xml:XML;
      
      public function Configurable()
      {
         this.configXmlFile = Configurable_configXmlFile;
         super();
         var _loc1_:ByteArray = new this.configXmlFile();
         var _loc2_:String = _loc1_.readUTFBytes(_loc1_.length);
         this._xml = new XML(_loc2_);
      }
      
      public function destroy() : void
      {
         this._xml = null;
         this.configXmlFile = null;
      }
      
      public function getPlayerStartX(param1:int = 0) : int
      {
         if(PlayState.bossRush)
         {
            return 246;
         }
         return 299;
      }
      
      public function getPlayerStartY(param1:int = 0) : int
      {
         if(PlayState.bossRush)
         {
            return 329;
         }
         return 166;
      }
   }
}

