package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightDropCharacterMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5826;
       
      private var _isInitialized:Boolean = false;
      
      public var targetId:int = 0;
      
      public var cellId:int = 0;
      
      public function GameActionFightDropCharacterMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return Boolean(super.isInitialized) && Boolean(this._isInitialized);
      }
      
      override public function getMessageId() : uint
      {
         return 5826;
      }
      
      public function initGameActionFightDropCharacterMessage(actionId:uint = 0, sourceId:int = 0, targetId:int = 0, cellId:int = 0) : GameActionFightDropCharacterMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.cellId = 0;
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
      
      override public function serialize(output:IDataOutput) : void
      {
         this.serializeAs_GameActionFightDropCharacterMessage(output);
      }
      
      public function serializeAs_GameActionFightDropCharacterMessage(output:IDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
         if(this.cellId < -1 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeShort(this.cellId);
      }
      
      override public function deserialize(input:IDataInput) : void
      {
         this.deserializeAs_GameActionFightDropCharacterMessage(input);
      }
      
      public function deserializeAs_GameActionFightDropCharacterMessage(input:IDataInput) : void
      {
         super.deserialize(input);
         this.targetId = input.readInt();
         this.cellId = input.readShort();
         if(this.cellId < -1 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of GameActionFightDropCharacterMessage.cellId.");
         }
      }
   }
}
