package org.flixel.data
{
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   import org.flixel.FlxText;
   
   public class FlxPause extends FlxGroup
   {
      private var ImgKeyMinus:Class;
      
      private var ImgKeyPlus:Class;
      
      private var ImgKey0:Class;
      
      private var ImgKeyP:Class;
      
      public function FlxPause()
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:FlxSprite = null;
         _loc1_ = 0;
         _loc2_ = 0;
         _loc3_ = null;
         this.ImgKeyMinus = FlxPause_ImgKeyMinus;
         this.ImgKeyPlus = FlxPause_ImgKeyPlus;
         this.ImgKey0 = FlxPause_ImgKey0;
         this.ImgKeyP = FlxPause_ImgKeyP;
         super();
         scrollFactor.x = 0;
         scrollFactor.y = 0;
         _loc1_ = 80;
         _loc2_ = 92;
         x = (FlxG.width - _loc1_) / 2;
         y = (FlxG.height - _loc2_) / 2;
         _loc3_ = new FlxSprite().createGraphic(_loc1_,_loc2_,2852126720,true);
         _loc3_.solid = false;
         add(_loc3_,true);
         (add(new FlxText(0,0,_loc1_,"this game is"),true) as FlxText).alignment = "center";
         add(new FlxText(0,10,_loc1_,"PAUSED").setFormat(null,16,16777215,"center"),true);
         _loc3_ = new FlxSprite(4,36,this.ImgKeyP);
         _loc3_.solid = false;
         add(_loc3_,true);
         add(new FlxText(16,36,_loc1_ - 16,"Pause Game"),true);
         _loc3_ = new FlxSprite(4,50,this.ImgKey0);
         _loc3_.solid = false;
         add(_loc3_,true);
         add(new FlxText(16,50,_loc1_ - 16,"Mute Sound"),true);
         _loc3_ = new FlxSprite(4,64,this.ImgKeyMinus);
         _loc3_.solid = false;
         add(_loc3_,true);
         add(new FlxText(16,64,_loc1_ - 16,"Sound Down"),true);
         _loc3_ = new FlxSprite(4,78,this.ImgKeyPlus);
         _loc3_.solid = false;
         add(_loc3_,true);
         add(new FlxText(16,78,_loc1_ - 16,"Sound Up"),true);
      }
   }
}

