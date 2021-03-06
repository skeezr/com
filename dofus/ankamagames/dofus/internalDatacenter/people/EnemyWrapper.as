package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredOnlineInformations;
   
   public class EnemyWrapper
   {
       
      private var _item:IgnoredInformations;
      
      public var name:String = "";
      
      public var state:int = 1;
      
      public var lastConnection:uint = 0;
      
      public var online:Boolean = false;
      
      public var type:String = "Enemy";
      
      public var playerName:String = "";
      
      public var breed:uint = 0;
      
      public var sex:uint = 2;
      
      public var level:int = 0;
      
      public var alignmentSide:int = -1;
      
      public var guildName:String = "";
      
      public function EnemyWrapper(o:IgnoredInformations)
      {
         super();
         this._item = o;
         this.name = o.name;
         if(o is IgnoredOnlineInformations)
         {
            this.playerName = IgnoredOnlineInformations(o).playerName;
            this.breed = IgnoredOnlineInformations(o).breed;
            this.sex = !!IgnoredOnlineInformations(o).sex?uint(1):uint(0);
            this.online = true;
         }
      }
   }
}
