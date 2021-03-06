package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StorageObjectsRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6035;
       
      private var _isInitialized:Boolean = false;
      
      public var objectUIDList:Vector.<uint>;
      
      public function StorageObjectsRemoveMessage()
      {
         this.objectUIDList = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6035;
      }
      
      public function initStorageObjectsRemoveMessage(objectUIDList:Vector.<uint> = null) : StorageObjectsRemoveMessage
      {
         this.objectUIDList = objectUIDList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUIDList = new Vector.<uint>();
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
         this.serializeAs_StorageObjectsRemoveMessage(output);
      }
      
      public function serializeAs_StorageObjectsRemoveMessage(output:IDataOutput) : void
      {
         output.writeShort(this.objectUIDList.length);
         for(var _i1:uint = 0; _i1 < this.objectUIDList.length; _i1++)
         {
            if(this.objectUIDList[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.objectUIDList[_i1] + ") on element 1 (starting at 1) of objectUIDList.");
            }
            output.writeInt(this.objectUIDList[_i1]);
         }
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this.deserializeAs_StorageObjectsRemoveMessage(input);
      }
      
      public function deserializeAs_StorageObjectsRemoveMessage(input:IDataInput) : void
      {
         var _val1:uint = 0;
         var _objectUIDListLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectUIDListLen; _i1++)
         {
            _val1 = input.readInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of objectUIDList.");
            }
            this.objectUIDList.push(_val1);
         }
      }
   }
}
