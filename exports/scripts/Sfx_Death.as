package
{
   import flash.display.DisplayObject;
   import mx.core.SoundAsset;
   
   [Embed(source="/_assets/63_death_Sfx_Death.mp3")]
   public class Sfx_Death extends SoundAsset
   {
      public var adMask:DisplayObject;
      
      public var background:DisplayObject;
      
      public var ngLinkButton:DisplayObject;
      
      public function Sfx_Death()
      {
         super();
      }
   }
}

