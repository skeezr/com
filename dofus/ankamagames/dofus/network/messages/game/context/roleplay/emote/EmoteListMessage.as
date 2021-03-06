package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class EmoteListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5689;
       
      private var _isInitialized:Boolean = false;
      
      public var emoteIds:Vector.<uint>;
      
      public function EmoteListMessage()
      {
         this.emoteIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5689;
      }
      
      public function initEmoteListMessage(emoteIds:Vector.<uint> = null) : EmoteListMessage
      {
         this.emoteIds = emoteIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.emoteIds = new Vector.<uint>();
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
         this.serializeAs_EmoteListMessage(output);
      }
      
      public function serializeAs_EmoteListMessage(output:IDataOutput) : void
      {
         output.writeShort(this.emoteIds.length);
         for(var _i1:uint = 0; _i1 < this.emoteIds.length; _i1++)
         {
            if(this.emoteIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.emoteIds[_i1] + ") on element 1 (starting at 1) of emoteIds.");
            }
            output.writeByte(this.emoteIds[_i1]);
         }
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this.deserializeAs_EmoteListMessage(input);
      }
      
      public function deserializeAs_EmoteListMessage(input:IDataInput) : void
      {
         var _val1:uint = 0;
         var _emoteIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _emoteIdsLen; _i1++)
         {
            _val1 = input.readByte();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of emoteIds.");
            }
            this.emoteIds.push(_val1);
         }
      }
   }
}
