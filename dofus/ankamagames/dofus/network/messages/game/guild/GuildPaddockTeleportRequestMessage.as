package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildPaddockTeleportRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5957;
       
      private var _isInitialized:Boolean = false;
      
      public var paddockId:uint = 0;
      
      public function GuildPaddockTeleportRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5957;
      }
      
      public function initGuildPaddockTeleportRequestMessage(paddockId:uint = 0) : GuildPaddockTeleportRequestMessage
      {
         this.paddockId = paddockId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.paddockId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void
      {
         this.serializeAs_GuildPaddockTeleportRequestMessage(output);
      }
      
      public function serializeAs_GuildPaddockTeleportRequestMessage(output:IDataOutput) : void
      {
         if(this.paddockId < 0)
         {
            throw new Error("Forbidden value (" + this.paddockId + ") on element paddockId.");
         }
         output.writeInt(this.paddockId);
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this.deserializeAs_GuildPaddockTeleportRequestMessage(input);
      }
      
      public function deserializeAs_GuildPaddockTeleportRequestMessage(input:IDataInput) : void
      {
         this.paddockId = input.readInt();
         if(this.paddockId < 0)
         {
            throw new Error("Forbidden value (" + this.paddockId + ") on element of GuildPaddockTeleportRequestMessage.paddockId.");
         }
      }
   }
}
