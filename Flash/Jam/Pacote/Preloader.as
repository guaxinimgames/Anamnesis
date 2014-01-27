package Pacote
{
	import flash.display.Sprite;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	
	/**
	* @author Diego Lopes & Falme Stramless
	*/
	public class Preloader extends Sprite
	{
		private var informacaoLoader:LoaderInfo;//Variável responsável pela informação de load
		private var porcentagemLoad:Number = 0;//porcentagem carregada
		private var complete:Boolean;//variável de controle
		
		
		/**
		* Constructor
		* Listen for when the preloader has been added to the stage 
		* so that the progress of the remaining load can be monitored.
		*/
		public function Preloader()
		{
			this.addEventListener(Event.ADDED_TO_STAGE , iniciar );
		}		
		/**
		* Inicializa as variáveis
		* Seta a largura da barra de load em 0
		*/
		private function iniciar(evt:Event):void
		{
			informacaoLoader = stage.loaderInfo;			
			progBar.scaleX = 0;
			
			this.removeEventListener(Event.ADDED_TO_STAGE , iniciar);
			this.addEventListener(Event.ENTER_FRAME, checarLoader);
		}
		
		/**
		* Checa o status do loader, quando completo, muda o estado da variável complete e se romove
		*/
		private function checarLoader(evt:Event):void 
		{
			porcentagemLoad = (Math.round((informacaoLoader.bytesLoaded / informacaoLoader.bytesTotal)*100));
			progBar.scaleX = (porcentagemLoad/100);
			
			if (porcentagemLoad == 100)
			{
				complete = true;
				complete = true;
				this.removeEventListener(Event.ENTER_FRAME, checarLoader);
				
				
			}
		}
		public function getComplete():Boolean
		{
			return complete
		}
		public function setComplete(e:Boolean):void
		{
			complete = e;
		}
	}	
}