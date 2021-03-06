package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   import com.ankamagames.berilia.types.uiDefinition.UiDefinition;
   
   public class ParsorEvent extends Event
   {
       
      private var _uiDef:UiDefinition;
      
      public function ParsorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, uiDef:UiDefinition = null)
      {
         super(type,bubbles,cancelable);
         this._uiDef = uiDef;
      }
      
      public function get uiDefinition() : UiDefinition
      {
         return this._uiDef;
      }
   }
}
