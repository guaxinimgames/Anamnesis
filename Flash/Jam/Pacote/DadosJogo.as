package Pacote 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Diego Lopes
	 */
	public class DadosJogo 
	{
		private var myXml:XML;//variável que trabalha com o XML
		
		var xmlLoader:URLLoader;//Carrega o XML
		
		public function DadosJogo() 
		{
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, carregarXML);
			
			xmlLoader.load(new URLRequest("DadosJogo.xml"));
			//Carrega o arquivo xml
		}
		public function carregarXML(event:Event):void
		{
			myXml = new XML(event.target.data);
		}
		public function getInfoFirstDay():String
		{
			return myXml.firstDay;
		}
		
	}

}