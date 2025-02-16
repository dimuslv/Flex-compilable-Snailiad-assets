package
{
   public class Fonts
   {
      [Embed(source='data/fonts/Snailplanes.ttf',
      fontName="Snailplanes",
      fontFamily="Snailplanes",
      mimeType="application/x-font",
      fontWeight="normal",
      fontStyle="normal",
      unicodeRange="U+0020-007E,U+00A1-00A1",
      advancedAntiAliasing="false",
      embedAsCFF="false"
      )] public static const normalFont:Class;
      
      public static const normal:String = "Snailplanes";
      
      public function Fonts()
      {
         super();
      }
   }
}

