package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.GradientType;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.display.ColorUtils;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.messages.ColorChangeMessage;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.messages.Message;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   
   public class ColorPicker extends GraphicContainer implements FinalizableUIComponent
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ColorPicker));
       
      private var _nWidth:uint;
      
      private var _nHeight:uint;
      
      private var _nColor:uint = 16711680;
      
      private var _nGradientColor:uint = 16711680;
      
      private var _texCursorSlider:com.ankamagames.berilia.components.Texture;
      
      private var _texCursorGradient:com.ankamagames.berilia.components.Texture;
      
      private var _nSliderWidth:uint = 20;
      
      private var _nSeparationWidth:uint = 10;
      
      private var _nGradientWidth:uint;
      
      private var _sprGradient:Sprite;
      
      private var _sprSliderInf:Sprite;
      
      private var _sprSliderSup:Sprite;
      
      private var _nLoadedSum:uint = 0;
      
      private var _bMouseDown:Boolean = false;
      
      private var _bFixedColor:Boolean = false;
      
      private var _nSliderY:int;
      
      private var _nGradientX:int;
      
      private var _nGradientY:int;
      
      private var _mMatrixGradient:Matrix;
      
      private var _mMatrixSaturation:Matrix;
      
      private var _mMatrixSlider:Matrix;
      
      private var _aColorsHue:Array;
      
      private var _aAlphasHue:Array;
      
      private var _aRatiosHue:Array;
      
      private var _aColorsSat:Array;
      
      private var _aAlphasSat:Array;
      
      private var _aRatiosSat:Array;
      
      private var _aColorsBri:Array;
      
      private var _aAlphasBri:Array;
      
      private var _aRatiosBri:Array;
      
      private var _bFinalized:Boolean = false;
      
      public function ColorPicker()
      {
         super();
      }
      
      override public function set width(nW:Number) : void
      {
         this._nWidth = nW;
         if(this.finalized)
         {
            this.updatePicker();
         }
      }
      
      override public function set height(nH:Number) : void
      {
         this._nHeight = nH;
         this._nSliderY = int(this._nHeight / 2);
         if(this.finalized)
         {
            this.updatePicker();
         }
      }
      
      public function set sliderTexture(uri:Uri) : void
      {
         this._texCursorSlider = new com.ankamagames.berilia.components.Texture();
         this._texCursorSlider.x = 0;
         this._texCursorSlider.y = 0;
         this._texCursorSlider.width = 20;
         this._texCursorSlider.height = 16;
         this._texCursorSlider.uri = uri;
      }
      
      public function get sliderTexture() : Uri
      {
         return this._texCursorSlider.uri;
      }
      
      public function set gradientTexture(uri:Uri) : void
      {
         this._texCursorGradient = new com.ankamagames.berilia.components.Texture();
         this._texCursorGradient.x = 0;
         this._texCursorGradient.y = 0;
         this._texCursorGradient.width = 16;
         this._texCursorGradient.height = 16;
         this._texCursorGradient.uri = uri;
      }
      
      public function get gradientTexture() : Uri
      {
         return this._texCursorGradient.uri;
      }
      
      public function get color() : uint
      {
         return this._nColor;
      }
      
      public function set color(nValue:uint) : void
      {
         this._nColor = nValue;
         this._bFixedColor = true;
         this.getCurrentPos();
      }
      
      public function get finalized() : Boolean
      {
         return this._bFinalized;
      }
      
      public function set finalized(b:Boolean) : void
      {
         this._bFinalized = b;
      }
      
      public function finalize() : void
      {
         this._sprGradient = new Sprite();
         this._sprSliderInf = new Sprite();
         this._sprSliderSup = new Sprite();
         this._nGradientWidth = this._nWidth - this._nSeparationWidth - this._nSliderWidth;
         this._mMatrixGradient = new Matrix();
         this._mMatrixGradient.createGradientBox(this._nGradientWidth,this._nHeight,0,0,0);
         this._aColorsHue = new Array(16711680,16776960,65280,65535,255,16711935,16711680);
         this._aAlphasHue = new Array(100,100,100,100,100,100,100);
         this._aRatiosHue = new Array(0,1 * 255 / 6,2 * 255 / 6,3 * 255 / 6,4 * 255 / 6,5 * 255 / 6,255);
         this._mMatrixSaturation = new Matrix();
         this._mMatrixSaturation.createGradientBox(this._nGradientWidth,this._nHeight,90 / 180 * Math.PI,0,0);
         this._aColorsSat = new Array(8421504,8421504);
         this._aAlphasSat = new Array(0,100);
         this._aRatiosSat = new Array(0,255);
         this._sprGradient.graphics.lineStyle();
         this._sprGradient.graphics.beginGradientFill(GradientType.LINEAR,this._aColorsHue,this._aAlphasHue,this._aRatiosHue,this._mMatrixGradient);
         this._sprGradient.graphics.drawRect(0,0,this._nGradientWidth,this._nHeight);
         this._sprGradient.graphics.endFill();
         this._sprGradient.graphics.beginGradientFill(GradientType.LINEAR,this._aColorsSat,this._aAlphasSat,this._aRatiosSat,this._mMatrixSaturation);
         this._sprGradient.graphics.drawRect(0,0,this._nGradientWidth,this._nHeight);
         this._sprGradient.graphics.endFill();
         addChild(this._sprGradient);
         this._sprSliderInf.x = this._nGradientWidth + this._nSeparationWidth;
         addChild(this._sprSliderInf);
         this._mMatrixSlider = new Matrix();
         this._mMatrixSlider.createGradientBox(this._nSliderWidth,this._nHeight,90 / 180 * Math.PI,0,0);
         this._aAlphasBri = new Array(1,0,0,1);
         this._aRatiosBri = new Array(0,127.5,127.5,255);
         this._aColorsBri = new Array(16777215,16777215,0,0);
         this._sprSliderSup.graphics.beginGradientFill(GradientType.LINEAR,this._aColorsBri,this._aAlphasBri,this._aRatiosBri,this._mMatrixSlider);
         this._sprSliderSup.graphics.drawRect(0,0,this._nSliderWidth,this._nHeight);
         this._sprSliderSup.graphics.endFill();
         this._sprSliderSup.x = this._nGradientWidth + this._nSeparationWidth;
         addChild(this._sprSliderSup);
         this._texCursorGradient.dispatchMessages = true;
         this._texCursorSlider.dispatchMessages = true;
         this._texCursorSlider.addEventListener(Event.COMPLETE,this.onTextureSliderLoaded);
         this._texCursorSlider.finalize();
         this._texCursorGradient.addEventListener(Event.COMPLETE,this.onTextureGradientLoaded);
         this._texCursorGradient.finalize();
         this._bFinalized = true;
         getUi().iAmFinalized(this);
      }
      
      public function updatePicker() : void
      {
         var hsl:Object = ColorUtils.rgb2hsl(this._nColor);
         this._texCursorGradient.x = hsl.h * this._nGradientWidth - this._texCursorGradient.width / 2;
         this._texCursorGradient.y = hsl.s * this._nHeight - this._texCursorGradient.height / 2;
         this._texCursorSlider.x = this._sprSliderSup.x;
         this._texCursorSlider.y = hsl.l * this._nHeight - this._texCursorSlider.height / 2;
         addChild(this._texCursorGradient);
         addChild(this._texCursorSlider);
         this._texCursorGradient.addEventListener(Event.CHANGE,this.onMoveGradientCursor);
         this._texCursorSlider.addEventListener(Event.CHANGE,this.onMoveSliderCursor);
      }
      
      override public function remove() : void
      {
         super.remove();
         this._texCursorSlider.remove();
         this._texCursorGradient.remove();
         this._texCursorSlider = null;
         this._texCursorGradient = null;
      }
      
      public function getCurrentPos() : void
      {
         var hsl:Object = ColorUtils.rgb2hsl(this._nColor);
         this._texCursorGradient.x = hsl.h * this._nGradientWidth - this._texCursorGradient.width / 2;
         this._texCursorGradient.y = hsl.s * this._nHeight - this._texCursorGradient.height / 2;
         this._texCursorSlider.y = hsl.l * this._nHeight - this._texCursorSlider.height / 2;
         this._nGradientX = this._texCursorGradient.x + this._texCursorGradient.width / 2;
         this._nGradientY = this._texCursorGradient.y + this._texCursorGradient.height / 2;
         this._nSliderY = this._texCursorSlider.y + this._texCursorSlider.height / 2;
         this.updateSlider();
         this.getCurrentColor();
      }
      
      public function getGradientColor() : uint
      {
         var colorPoint1:Number = NaN;
         var colorPoint2:Number = NaN;
         var r1:Number = NaN;
         var g1:Number = NaN;
         var b1:Number = NaN;
         var r2:Number = NaN;
         var g2:Number = NaN;
         var b2:Number = NaN;
         var c1:Number = NaN;
         var c2:Number = NaN;
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         if(this._nGradientX >= this._nGradientWidth)
         {
            this._nGradientX = this._nGradientWidth - 1;
         }
         colorPoint1 = this._nGradientX / this._nGradientWidth;
         var i:Number = Math.floor(colorPoint1 * (this._aRatiosHue.length - 1));
         colorPoint1 = colorPoint1 * 255;
         colorPoint2 = 255 - (this._aRatiosHue[i + 1] - colorPoint1) / (this._aRatiosHue[i + 1] - this._aRatiosHue[i]) * 255;
         c1 = this._aColorsHue[i];
         c2 = this._aColorsHue[i + 1];
         r1 = c1 & 16711680;
         g1 = c1 & 65280;
         b1 = c1 & 255;
         r2 = c2 & 16711680;
         g2 = c2 & 65280;
         b2 = c2 & 255;
         if(r1 != r2)
         {
            r = Math.round(r1 > r2?Number(255 - colorPoint2):Number(colorPoint2));
         }
         else
         {
            r = r1 >> 16;
         }
         if(g1 != g2)
         {
            g = Math.round(g1 > g2?Number(255 - colorPoint2):Number(colorPoint2));
         }
         else
         {
            g = g1 >> 8;
         }
         if(b1 != b2)
         {
            b = Math.round(b1 > b2?Number(255 - colorPoint2):Number(colorPoint2));
         }
         else
         {
            b = b1;
         }
         colorPoint1 = this._nGradientY / this._nHeight * 255;
         r = r + (127 - r) * colorPoint1 / 255;
         g = g + (127 - g) * colorPoint1 / 255;
         b = b + (127 - b) * colorPoint1 / 255;
         this._nGradientColor = Math.round((r << 16) + (g << 8) + b);
         return this._nGradientColor;
      }
      
      public function updateSlider() : void
      {
         var gColor:uint = this.getGradientColor();
         this._sprSliderInf.graphics.beginFill(gColor);
         this._sprSliderInf.graphics.drawRect(0,0,this._nSliderWidth,this._nHeight);
         this._sprSliderInf.graphics.endFill();
      }
      
      private function getCurrentColor() : uint
      {
         var colorPoint:Number = NaN;
         var r1:Number = NaN;
         var g1:Number = NaN;
         var b1:Number = NaN;
         var r2:Number = NaN;
         var g2:Number = NaN;
         var b2:Number = NaN;
         if(!this._bFixedColor)
         {
            this.getGradientColor();
            colorPoint = 255 - this._nSliderY / this._nHeight * 510;
            r1 = (this._nGradientColor & 16711680) >> 16;
            g1 = (this._nGradientColor & 65280) >> 8;
            b1 = this._nGradientColor & 255;
            if(colorPoint >= 0)
            {
               r2 = colorPoint * (255 - r1) / 255 + r1;
               g2 = colorPoint * (255 - g1) / 255 + g1;
               b2 = colorPoint * (255 - b1) / 255 + b1;
            }
            else
            {
               colorPoint = colorPoint * -1;
               r2 = Math.round(r1 - r1 * colorPoint / 255);
               g2 = Math.round(g1 - g1 * colorPoint / 255);
               b2 = Math.round(b1 - b1 * colorPoint / 255);
            }
            this._nColor = Math.round((r2 << 16) + (g2 << 8) + b2);
         }
         Berilia.getInstance().handler.process(new ColorChangeMessage(InteractiveObject(this)));
         return this._nColor;
      }
      
      override public function process(msg:Message) : Boolean
      {
         switch(true)
         {
            case msg is MouseDownMessage:
               this._bFixedColor = false;
               switch(MouseDownMessage(msg).target)
               {
                  case this._sprGradient:
                  case this._texCursorGradient:
                     this._bMouseDown = true;
                     this._texCursorGradient.x = mouseX - this._texCursorGradient.width / 2;
                     this._texCursorGradient.y = mouseY - this._texCursorGradient.height / 2;
                     this._nGradientX = mouseX;
                     this._nGradientY = mouseY;
                     this._texCursorGradient.startDrag(false,new Rectangle(this._sprGradient.x - this._texCursorGradient.width / 2,this._sprGradient.y - this._texCursorGradient.height / 2,this._sprGradient.width,this._sprGradient.height));
                     EnterFrameDispatcher.addEventListener(this.onMoveGradientCursor,"ColorPickerGradient");
                     break;
                  case this._sprSliderSup:
                  case this._texCursorSlider:
                     this._bMouseDown = true;
                     this._texCursorSlider.x = mouseX;
                     this._texCursorSlider.y = mouseY - this._texCursorSlider.height / 2;
                     this._texCursorSlider.startDrag(false,new Rectangle(this._sprSliderSup.x,this._sprSliderSup.y - this._texCursorSlider.height / 2,0,this._sprSliderSup.height));
                     this._nSliderY = mouseY;
                     EnterFrameDispatcher.addEventListener(this.onMoveSliderCursor,"ColorPickerSlider");
               }
               return true;
            case msg is MouseUpMessage:
               switch(MouseUpMessage(msg).target)
               {
                  case this._sprGradient:
                  case this._texCursorGradient:
                     this._bMouseDown = false;
                     this._texCursorGradient.stopDrag();
                     EnterFrameDispatcher.removeEventListener(this.onMoveGradientCursor);
                     this.updateSlider();
                     this.getCurrentColor();
                     break;
                  case this._sprSliderSup:
                  case this._texCursorSlider:
                     this._bMouseDown = false;
                     this._texCursorSlider.stopDrag();
                     EnterFrameDispatcher.removeEventListener(this.onMoveSliderCursor);
                     this.getCurrentColor();
               }
               return true;
            case msg is MouseReleaseOutsideMessage:
               switch(MouseReleaseOutsideMessage(msg).target)
               {
                  case this._sprGradient:
                  case this._texCursorGradient:
                     this._bMouseDown = false;
                     this._texCursorGradient.stopDrag();
                     EnterFrameDispatcher.removeEventListener(this.onMoveGradientCursor);
                     this.updateSlider();
                     this.getCurrentColor();
                     break;
                  case this._sprSliderSup:
                  case this._texCursorSlider:
                     this._bMouseDown = false;
                     this._texCursorSlider.stopDrag();
                     EnterFrameDispatcher.removeEventListener(this.onMoveSliderCursor);
                     this.getCurrentColor();
               }
               return true;
            default:
               return false;
         }
      }
      
      public function onMoveGradientCursor(e:Event) : void
      {
         if(this._nGradientX != mouseX || this._nGradientY != mouseY)
         {
            this._nGradientX = mouseX;
            if(this._nGradientX < 0)
            {
               this._nGradientX = 0;
            }
            if(this._nGradientX > this._nGradientWidth)
            {
               this._nGradientX = this._nGradientWidth;
            }
            this._nGradientY = mouseY;
            if(this._nGradientY < 0)
            {
               this._nGradientY = 0;
            }
            if(this._nGradientY > this._nHeight)
            {
               this._nGradientY = this._nHeight;
            }
            this.updateSlider();
            this.getCurrentColor();
         }
      }
      
      public function onMoveSliderCursor(e:Event) : void
      {
         if(this._nSliderY != mouseY)
         {
            this._nSliderY = mouseY;
            if(this._nSliderY < 0)
            {
               this._nSliderY = 0;
            }
            if(this._nSliderY > this._nHeight)
            {
               this._nSliderY = this._nHeight;
            }
            this._nColor = this.getCurrentColor();
         }
      }
      
      public function onTextureSliderLoaded(e:Event) : void
      {
         this._nLoadedSum++;
         this._texCursorSlider.removeEventListener(Event.COMPLETE,this.onTextureSliderLoaded);
         if(this._nLoadedSum >= 2)
         {
            this.updatePicker();
         }
      }
      
      public function onTextureGradientLoaded(e:Event) : void
      {
         this._nLoadedSum++;
         this._texCursorGradient.removeEventListener(Event.COMPLETE,this.onTextureGradientLoaded);
         if(this._nLoadedSum >= 2)
         {
            this.updatePicker();
         }
      }
   }
}
