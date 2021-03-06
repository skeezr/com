package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSell;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeShopStockStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5910;
       
      private var _isInitialized:Boolean = false;
      
      public var objectsInfos:Vector.<ObjectItemToSell>;
      
      public function ExchangeShopStockStartedMessage()
      {
         this.objectsInfos = new Vector.<ObjectItemToSell>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5910;
      }
      
      public function initExchangeShopStockStartedMessage(objectsInfos:Vector.<ObjectItemToSell> = null) : ExchangeShopStockStartedMessage
      {
         this.objectsInfos = objectsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectsInfos = new Vector.<ObjectItemToSell>();
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
         this.serializeAs_ExchangeShopStockStartedMessage(output);
      }
      
      public function serializeAs_ExchangeShopStockStartedMessage(output:IDataOutput) : void
      {
         output.writeShort(this.objectsInfos.length);
         for(var _i1:uint = 0; _i1 < this.objectsInfos.length; _i1++)
         {
            (this.objectsInfos[_i1] as ObjectItemToSell).serializeAs_ObjectItemToSell(output);
         }
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this.deserializeAs_ExchangeShopStockStartedMessage(input);
      }
      
      public function deserializeAs_ExchangeShopStockStartedMessage(input:IDataInput) : void
      {
         var _item1:ObjectItemToSell = null;
         var _objectsInfosLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectsInfosLen; _i1++)
         {
            _item1 = new ObjectItemToSell();
            _item1.deserialize(input);
            this.objectsInfos.push(_item1);
         }
      }
   }
}
