package
{
   import flash.utils.*;
   
   public class Configurable
   {
      [Embed(source = 'data/bin/configXmlFile.txt',mimeType="application/octet-stream")] private var configXmlFile:Class;
      
      private var _xml:XML;
      
      public function destroy() : void
      {
         _xml = null;
         configXmlFile = null;
      }
      
      public function Configurable()
      {
         var _loc1_:ByteArray = new configXmlFile();
         var _loc2_:String = _loc1_.readUTFBytes(_loc1_.length);
         _xml = new XML(_loc2_);
      }
      
      public function getPlayerStartX(areaNum:int=0):int
      {
          if (PlayState.bossRush)
              return 246;
          else
              return 299;
          
		  return _xml.PLAYERSTART.X;  // <-- this code is very sad because it can never be reached
      }

      public function getPlayerStartY(areaNum:int=0):int
      {
          if (PlayState.bossRush)
              return 329;
          else
              return 166;
          
		  return _xml.PLAYERSTART.Y;  // <-- this code is also very sad ):
      }
   }
}

