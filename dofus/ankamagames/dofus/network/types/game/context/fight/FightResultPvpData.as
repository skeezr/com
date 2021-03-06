package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightResultPvpData extends FightResultAdditionalData implements INetworkType
   {
      
      public static const protocolId:uint = 190;
       
      public var grade:uint = 0;
      
      public var minHonorForGrade:uint = 0;
      
      public var maxHonorForGrade:uint = 0;
      
      public var honor:uint = 0;
      
      public var honorDelta:int = 0;
      
      public var dishonor:uint = 0;
      
      public var dishonorDelta:int = 0;
      
      public function FightResultPvpData()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 190;
      }
      
      public function initFightResultPvpData(grade:uint = 0, minHonorForGrade:uint = 0, maxHonorForGrade:uint = 0, honor:uint = 0, honorDelta:int = 0, dishonor:uint = 0, dishonorDelta:int = 0) : FightResultPvpData
      {
         this.grade = grade;
         this.minHonorForGrade = minHonorForGrade;
         this.maxHonorForGrade = maxHonorForGrade;
         this.honor = honor;
         this.honorDelta = honorDelta;
         this.dishonor = dishonor;
         this.dishonorDelta = dishonorDelta;
         return this;
      }
      
      override public function reset() : void
      {
         this.grade = 0;
         this.minHonorForGrade = 0;
         this.maxHonorForGrade = 0;
         this.honor = 0;
         this.honorDelta = 0;
         this.dishonor = 0;
         this.dishonorDelta = 0;
      }
      
      override public function serialize(output:IDataOutput) : void
      {
         this.serializeAs_FightResultPvpData(output);
      }
      
      public function serializeAs_FightResultPvpData(output:IDataOutput) : void
      {
         super.serializeAs_FightResultAdditionalData(output);
         if(this.grade < 0 || this.grade > 255)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         output.writeByte(this.grade);
         if(this.minHonorForGrade < 0 || this.minHonorForGrade > 18000)
         {
            throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element minHonorForGrade.");
         }
         output.writeShort(this.minHonorForGrade);
         if(this.maxHonorForGrade < 0 || this.maxHonorForGrade > 18000)
         {
            throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element maxHonorForGrade.");
         }
         output.writeShort(this.maxHonorForGrade);
         if(this.honor < 0 || this.honor > 18000)
         {
            throw new Error("Forbidden value (" + this.honor + ") on element honor.");
         }
         output.writeShort(this.honor);
         output.writeShort(this.honorDelta);
         if(this.dishonor < 0 || this.dishonor > 500)
         {
            throw new Error("Forbidden value (" + this.dishonor + ") on element dishonor.");
         }
         output.writeShort(this.dishonor);
         output.writeShort(this.dishonorDelta);
      }
      
      override public function deserialize(input:IDataInput) : void
      {
         this.deserializeAs_FightResultPvpData(input);
      }
      
      public function deserializeAs_FightResultPvpData(input:IDataInput) : void
      {
         super.deserialize(input);
         this.grade = input.readUnsignedByte();
         if(this.grade < 0 || this.grade > 255)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of FightResultPvpData.grade.");
         }
         this.minHonorForGrade = input.readUnsignedShort();
         if(this.minHonorForGrade < 0 || this.minHonorForGrade > 18000)
         {
            throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element of FightResultPvpData.minHonorForGrade.");
         }
         this.maxHonorForGrade = input.readUnsignedShort();
         if(this.maxHonorForGrade < 0 || this.maxHonorForGrade > 18000)
         {
            throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element of FightResultPvpData.maxHonorForGrade.");
         }
         this.honor = input.readUnsignedShort();
         if(this.honor < 0 || this.honor > 18000)
         {
            throw new Error("Forbidden value (" + this.honor + ") on element of FightResultPvpData.honor.");
         }
         this.honorDelta = input.readShort();
         this.dishonor = input.readUnsignedShort();
         if(this.dishonor < 0 || this.dishonor > 500)
         {
            throw new Error("Forbidden value (" + this.dishonor + ") on element of FightResultPvpData.dishonor.");
         }
         this.dishonorDelta = input.readShort();
      }
   }
}
