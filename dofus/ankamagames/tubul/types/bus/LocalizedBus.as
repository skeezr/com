package com.ankamagames.tubul.types.bus
{
   import flash.geom.Point;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.sounds.LocalizedSound;
   
   public class LocalizedBus extends AudioBus
   {
       
      public function LocalizedBus(id:int, name:String)
      {
         super(id,name);
      }
      
      public function updateObserverPosition(point:Point) : void
      {
         var isound:ISound = null;
         for each(isound in _soundVector)
         {
            if(isound is LocalizedSound)
            {
               (isound as LocalizedSound).updateObserverPosition(point);
            }
         }
      }
   }
}
