package
{
   import flash.display.DisplayObject;
   import mx.core.SoundAsset;
   
   [Embed(source="/_assets/55_opendoor_Sfx_OpenDoor.mp3")]
   public class Sfx_OpenDoor extends SoundAsset
   {
      public var adMask:DisplayObject;
      
      public var background:DisplayObject;
      
      public var ngLinkButton:DisplayObject;
      
      public function Sfx_OpenDoor()
      {
         super();
      }
   }
}

