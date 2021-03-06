package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectGroundRemovedMultipleMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5944;
       
      private var _isInitialized:Boolean = false;
      
      public var cells:Vector.<uint>;
      
      public function ObjectGroundRemovedMultipleMessage()
      {
         this.cells = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5944;
      }
      
      public function initObjectGroundRemovedMultipleMessage(cells:Vector.<uint> = null) : ObjectGroundRemovedMultipleMessage
      {
         this.cells = cells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.cells = new Vector.<uint>();
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
         this.serializeAs_ObjectGroundRemovedMultipleMessage(output);
      }
      
      public function serializeAs_ObjectGroundRemovedMultipleMessage(output:IDataOutput) : void
      {
         output.writeShort(this.cells.length);
         for(var _i1:uint = 0; _i1 < this.cells.length; _i1++)
         {
            if(this.cells[_i1] < 0 || this.cells[_i1] > 559)
            {
               throw new Error("Forbidden value (" + this.cells[_i1] + ") on element 1 (starting at 1) of cells.");
            }
            output.writeShort(this.cells[_i1]);
         }
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this.deserializeAs_ObjectGroundRemovedMultipleMessage(input);
      }
      
      public function deserializeAs_ObjectGroundRemovedMultipleMessage(input:IDataInput) : void
      {
         var _val1:uint = 0;
         var _cellsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _cellsLen; _i1++)
         {
            _val1 = input.readShort();
            if(_val1 < 0 || _val1 > 559)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of cells.");
            }
            this.cells.push(_val1);
         }
      }
   }
}
