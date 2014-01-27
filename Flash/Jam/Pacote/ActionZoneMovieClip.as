package Pacote {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	
	public class ActionZoneMovieClip extends SimpleButton {
		
		
		private var posicaoX:Number;
		private var posicaoY:Number;
		
		public function ActionZoneMovieClip() 
		{
			this.addEventListener(MouseEvent.CLICK, cliqueBotao);
			this.alpha = 0.0;
		}
		
		private function cliqueBotao(event:MouseEvent):void
		{
			posicaoX = this.x;
			posicaoY = this.y;
			
		}
		
		public function setPosicaoX(e:Number):void
		{
			posicaoX = e;
		}
		public function getPosicaoX():Number
		{
			return posicaoX;
		}
		
		public function setPosicaoY(e:Number):void
		{
			posicaoY = e;
		}
		public function getPosicaoY():Number
		{
			return posicaoY;
		}
	}
	
}
