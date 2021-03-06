package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.enums.BreedEnum;
   
   public class CharacterCreationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 160;
       
      private var _isInitialized:Boolean = false;
      
      public var name:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var colors:Vector.<int>;
      
      public function CharacterCreationRequestMessage()
      {
         this.colors = new Vector.<int>(6,true);
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 160;
      }
      
      public function initCharacterCreationRequestMessage(name:String = "", breed:int = 0, sex:Boolean = false, colors:Vector.<int> = null) : CharacterCreationRequestMessage
      {
         this.name = name;
         this.breed = breed;
         this.sex = sex;
         this.colors = colors;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.name = "";
         this.breed = 0;
         this.sex = false;
         this.colors = new Vector.<int>(6,true);
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
         this.serializeAs_CharacterCreationRequestMessage(output);
      }
      
      public function serializeAs_CharacterCreationRequestMessage(output:IDataOutput) : void
      {
         output.writeUTF(this.name);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         for(var _i4:uint = 0; _i4 < 6; _i4++)
         {
            output.writeInt(this.colors[_i4]);
         }
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this.deserializeAs_CharacterCreationRequestMessage(input);
      }
      
      public function deserializeAs_CharacterCreationRequestMessage(input:IDataInput) : void
      {
         this.name = input.readUTF();
         this.breed = input.readByte();
         if(this.breed < BreedEnum.Feca || this.breed > BreedEnum.Pandawa)
         {
            throw new Error("Forbidden value (" + this.breed + ") on element of CharacterCreationRequestMessage.breed.");
         }
         this.sex = input.readBoolean();
         for(var _i4:uint = 0; _i4 < 6; _i4++)
         {
            this.colors[_i4] = input.readInt();
         }
      }
   }
}
