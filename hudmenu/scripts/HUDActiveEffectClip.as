package
{
   import Shared.AS3.BSUIComponent;
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol487")]
   public class HUDActiveEffectClip extends BSUIComponent
   {
      
      private static const DEFAULT_STACK_WIDTH:Number = 19;
      
      private static const STACK_WITH_PADDING:Number = 12;
      
      private static const STACK_SHADOW_AMOUNT:Number = 1;
      
      public var Icon_mc:MovieClip;
      
      public var Stack_mc:MovieClip;
      
      public var FillInternal_mc:MovieClip;
      
      private const COLOR_GREEN:uint = 0;
      
      private const COLOR_RED:uint = 1;
      
      private var m_IconFrame:String;
      
      private var m_IconColor:uint = 0;
      
      private var m_IconID:String = "";
      
      private var m_StackAmount:uint = 0;
      
      private const TWEEN_END_Y:Number = 0;
      
      private var m_DefaultFillY:Number = 14.5;
      
      private var m_RemainingDuration:uint = 0;
      
      private var m_TotalDuration:uint = 0;
      
      private var m_StartingY:Number = 0;
      
      private var m_TweenProgress:Number = 0;
      
      private var m_FillTween:Tween = null;
      
      public function HUDActiveEffectClip()
      {
         addFrameScript(0,this.frame1,1,this.frame2);
         super();
         if(Boolean(this.FillInternal_mc) && Boolean(this.FillInternal_mc.Fill_mc))
         {
            this.m_DefaultFillY = this.FillInternal_mc.Fill_mc.y;
         }
      }
      
      public function set iconID(param1:String) : void
      {
         this.m_IconID = param1;
      }
      
      public function set IconFrame(param1:String) : void
      {
         if(this.m_IconFrame != param1)
         {
            this.m_IconFrame = param1;
            SetIsDirty();
         }
      }
      
      public function set IconColor(param1:uint) : *
      {
         var _loc2_:* = param1 == this.COLOR_GREEN ? this.COLOR_GREEN : this.COLOR_RED;
         if(this.m_IconColor != _loc2_)
         {
            this.m_IconColor = _loc2_;
            SetIsDirty();
         }
      }
      
      public function set StackAmount(param1:uint) : void
      {
         if(this.m_StackAmount != param1)
         {
            this.m_StackAmount = param1;
            SetIsDirty();
         }
      }
      
      public function get StackAmount() : uint
      {
         return this.m_StackAmount;
      }
      
      public function setEffect(param1:String, param2:uint, param3:uint) : void
      {
         this.m_RemainingDuration = param2;
         this.m_TotalDuration = param3;
         this.m_TweenProgress = param2;
         if(!this.FillInternal_mc || !this.FillInternal_mc.Fill_mc)
         {
            return;
         }
         this.clearTween();
         if(this.m_RemainingDuration < this.m_TotalDuration && this.m_TotalDuration > 0)
         {
            this.m_StartingY = this.m_DefaultFillY + (1 - this.m_RemainingDuration / this.m_TotalDuration) * (this.TWEEN_END_Y - this.m_DefaultFillY);
            this.FillInternal_mc.Fill_mc.y = this.m_StartingY;
            this.m_FillTween = new Tween(this.FillInternal_mc.Fill_mc,"y",None.easeIn,this.m_StartingY,this.m_DefaultFillY,this.m_RemainingDuration / 1000,true);
            this.m_FillTween.addEventListener(TweenEvent.MOTION_CHANGE,this.onTweenChange);
            this.m_FillTween.addEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish);
            this.m_FillTween.start();
         }
         else
         {
            this.FillInternal_mc.Fill_mc.y = this.m_DefaultFillY;
         }
      }
      
      private function clearTween() : void
      {
         if(this.m_FillTween)
         {
            this.m_FillTween.removeEventListener(TweenEvent.MOTION_CHANGE,this.onTweenChange);
            this.m_FillTween.removeEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish);
            this.m_FillTween.stop();
            this.m_FillTween = null;
         }
      }
      
      private function onTweenChange(param1:TweenEvent) : void
      {
         this.m_TweenProgress = this.m_RemainingDuration - param1.time * 1000;
      }
      
      private function onTweenFinish(param1:TweenEvent) : void
      {
         this.m_TweenProgress = 0;
      }
      
      override public function redrawUIComponent() : void
      {
         if(this.m_IconColor == this.COLOR_RED)
         {
            gotoAndStop("negative");
         }
         else
         {
            gotoAndStop("positive");
         }
         this.Icon_mc.gotoAndStop(this.m_IconFrame);
         this.Stack_mc.visible = false;
         if(this.m_StackAmount != 0)
         {
            this.Stack_mc.StackAmount_tf.text = this.m_StackAmount.toString();
            this.Stack_mc.BG_mc.width = DEFAULT_STACK_WIDTH + (this.Stack_mc.StackAmount_tf.text.length - 1) * STACK_WITH_PADDING;
            this.Stack_mc.StackAmount_tf.width = this.Stack_mc.BG_mc.width - STACK_SHADOW_AMOUNT * 2;
            this.Stack_mc.StackAmount_tf.x = this.Stack_mc.BG_mc.x + STACK_SHADOW_AMOUNT;
            this.Stack_mc.visible = true;
         }
         visible = this.m_IconFrame != null && this.m_IconFrame.length > 0;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}

