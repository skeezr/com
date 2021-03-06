package com.ankamagames.jerakine.sequencer
{
   import flash.events.IEventDispatcher;
   
   public interface ISequencer extends ISequencableListener, IEventDispatcher
   {
       
      function addStep(param1:ISequencable) : void;
      
      function start() : void;
      
      function toString() : String;
      
      function get length() : uint;
      
      function get steps() : Array;
      
      function clear() : void;
   }
}
