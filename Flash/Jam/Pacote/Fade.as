package Pacote {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Fade extends MovieClip {
		
		private var next:Boolean;
		public function Fade() 
		{
			// constructor code
		}
		public function efeitoInn():void
		{
			this.alpha = 0;
			this.visible = true;
			this.addEventListener(Event.ENTER_FRAME, efeito);
		}
		private function efeito(event:Event):void
		{
			//trace(this.alpha);
			if (this.alpha < 1)
			{
				this.alpha += 0.05;
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME, efeito);
				//this.visible = false;
				//this.alpha = 0;
			}
		}
		
		public function efeitoOut():void
		{
			this.alpha = 1;
			//this.visible = true;
			this.addEventListener(Event.ENTER_FRAME, efeito2);
		}
		private function efeito2(event:Event):void
		{
			//trace(this.alpha);
			
			if (this.alpha > 0)
			{
				this.alpha -= 0.05;
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME, efeito2);
				this.visible = false;
				next = true;
			}
		}
		
		
		public function getNext():Boolean
		{
			return next;
		}
	}
	
}
