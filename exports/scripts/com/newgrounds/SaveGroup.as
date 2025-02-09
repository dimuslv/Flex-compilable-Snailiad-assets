package com.newgrounds
{
   public class SaveGroup
   {
      public static const TYPE_SYSTEM:uint = 0;
      
      public static const TYPE_PRIVATE:uint = 1;
      
      public static const TYPE_PUBLIC:uint = 2;
      
      public static const TYPE_MODERATED:uint = 3;
      
      public static const KEY_TYPES:Array = [null,"float","integer","string","boolean"];
      
      public static const TYPES:Object = {
         "SYSTEM":0,
         "PRIVATE":1,
         "PUBLIC":2,
         "MODERATED":3
      };
      
      private var _name:String;
      
      private var _id:uint;
      
      private var _type:uint;
      
      private var _keys:Array;
      
      private var _ratings:Array;
      
      private var _files:Array;
      
      private var _query:SaveGroupQuery;
      
      public function SaveGroup(param1:uint, param2:String, param3:uint)
      {
         super();
         this._name = param2;
         this._id = param1;
         this._type = param3;
         this._ratings = [];
         this._keys = [];
         this._files = [];
         this._query = new SaveGroupQuery(this);
      }
      
      public static function createFromObject(param1:Object) : SaveGroup
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:SaveGroup = new SaveGroup(param1.group_id,param1.group_name,param1.group_type);
         var _loc5_:uint = 0;
         while(_loc5_ < param1.keys.length)
         {
            _loc2_ = param1.keys[_loc5_];
            _loc4_.addKey(new SaveKey(_loc2_.id,_loc2_.name,_loc2_.type));
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.ratings.length)
         {
            _loc3_ = param1.ratings[_loc5_];
            _loc4_.addRating(new SaveRating(_loc3_.id,_loc3_.name,_loc3_.float,_loc3_.min,_loc3_.max));
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
      
      public function get keys() : Array
      {
         return this._keys;
      }
      
      public function get ratings() : Array
      {
         return this._ratings;
      }
      
      public function get group_id() : uint
      {
         return this._id;
      }
      
      public function get group_name() : String
      {
         return this._name;
      }
      
      public function addRating(param1:SaveRating) : void
      {
         this._ratings.push(param1);
      }
      
      internal function getRating(param1:*) : SaveRating
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._ratings.length)
         {
            if((param1 is uint || param1 is int || param1 is Number) && this._ratings[_loc2_].rating_id == param1)
            {
               return this._ratings[_loc2_];
            }
            if(this._ratings[_loc2_].name == param1)
            {
               return this._ratings[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getRatingID(param1:uint) : SaveRating
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._ratings.length)
         {
            if(this._ratings[_loc2_].id == param1)
            {
               return this._ratings[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getRatingName(param1:String) : SaveRating
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._ratings.length)
         {
            if(this._ratings[_loc2_].name == param1)
            {
               return this._ratings[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function addKey(param1:SaveKey) : void
      {
         this._keys.push(param1);
      }
      
      public function getKey(param1:*) : SaveKey
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._keys.length)
         {
            if((param1 is Number || param1 is uint || param1 is int) && this._keys[_loc2_].key_id == param1)
            {
               return this._keys[_loc2_];
            }
            if(this._keys[_loc2_].key_name == param1)
            {
               return this._keys[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getKeyID(param1:uint) : SaveKey
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._keys.length)
         {
            if(this._keys[_loc2_].id == param1)
            {
               return this._keys[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getKeyType(param1:String, param2:Boolean = false) : *
      {
         var _loc3_:SaveKey = this.getKey(param1);
         if(_loc3_)
         {
            return param2 ? KEY_TYPES[_loc3_.key_type] : _loc3_.key_type;
         }
         return null;
      }
      
      public function getKeyName(param1:String) : SaveKey
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._keys.length)
         {
            if(this._keys[_loc2_].name == param1)
            {
               return this._keys[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function isType(param1:String) : Boolean
      {
         return TYPES[this._type] == param1;
      }
      
      public function getID() : uint
      {
         return this._id;
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getQuery(param1:Boolean = false) : *
      {
         return param1 ? this._query.toObject() : this._query;
      }
      
      public function newQuery() : SaveGroupQuery
      {
         return new SaveGroupQuery(this);
      }
      
      public function newFile() : SaveFile
      {
         return new SaveFile(this);
      }
      
      public function toString() : String
      {
         return "SaveGroup { name: " + this._name + ", id: " + this._id + ", keys: " + this._keys + "}";
      }
   }
}

