package Pacote 
{
	import flash.events.DRMAuthenticationCompleteEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Diego Lopes & Falme Stramless
	 */
	public class Dados
	{
		private var myXml:XML;//variável que trabalha com o XML
		
		
		
		var xmlLoader:URLLoader;//Carrega o XML
		
		var DiagnosticoEncontrado:Vector.<Vector.<String>> = new Vector.<Vector.<String>>(8);
		
		
		
		//private var timer:Timer;
		
		public function Dados () 
		{
			//timer = new Timer(30000, 1);
			//timer.addEventListener(TimerEvent.TIMER, ChangeLouco);
			//timer.start();
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, carregarXml);
			Global.NumeroRelativo = 0;
			xmlLoader.load(new URLRequest("databaseLoucos.xml"));
			//Carrega o arquivo xml
			
			for (var q:int = 0; q < 8; q++ )
			{
				Global.RepeatedCoincidence[q] = false;
			}
			
			DiagnosticoEncontrado[0] = new Vector.<String>(8);
			DiagnosticoEncontrado[1] = new Vector.<String>(8);
			
			DiagnosticoEncontrado[2] = new Vector.<String>(8);
			DiagnosticoEncontrado[3] = new Vector.<String>(8);
			
			DiagnosticoEncontrado[4] = new Vector.<String>(8);
			
			
			
		}
		private function carregarXml(event:Event):void
		{
			myXml = new XML(event.target.data);
			//trace(myXml.louco1[0].reactions[0].gramofone);
		}
		public function getReaction(e:uint):String
		{
			var retorno:String;
			switch(e)
			{
				case 0:
					retorno = myXml.louco[Global.pickLouco].reactions[0].jogos
						
						AdicionarMovelState(e);
					
					
					DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					break;
					
				case 1:
					retorno = myXml.louco[Global.pickLouco].reactions[0].janela
					
					AdicionarMovelState(e);
					
					DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					break;
					
				case 2:
					retorno = myXml.louco[Global.pickLouco].reactions[0].gramofone
					AdicionarMovelState(e);
					DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					break;
					
				case 3:
					retorno = myXml.louco[Global.pickLouco].reactions[0].livros
					AdicionarMovelState(e);
					DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					break;
					
				case 4:
					retorno = myXml.louco[Global.pickLouco].reactions[0].remedio
					AdicionarMovelState(e);
					DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					break;
					
				case 5:
					retorno = myXml.louco[Global.pickLouco].reactions[0].lousa
					AdicionarMovelState(e);
					DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					break;
					
				case 6:
					if (Global.pickLouco != 0)
					{
						retorno = myXml.louco[Global.pickLouco].reactions[0].casaco
						AdicionarMovelState(e);
						DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					}
					
					else
					{
						retorno = myXml.louco[Global.pickLouco].erro[0].erroDiagnostico1
						AdicionarMovelState(e);
						DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					}
					
				break;
					
				case 7:
					retorno = myXml.louco[Global.pickLouco].reactions[0].quadro
					AdicionarMovelState(e);
					DiagnosticoEncontrado[Global.pickLouco][e] = retorno;
					break;
			}
			return retorno;
		}
		public function setLouco(e:uint):void
		{
			Global.pickLouco = e;
		}
		
		public function AdicionarMovelState(eve:int)
		{
			
			if (Global.RepeatedCoincidence[eve] == false)
						{
							Global.NumeroRelativo++;
							Global.RepeatedCoincidence[eve] = true;
							
						}
						
						for (var x:int = 0; x < 8; x++ )
						{
							//trace(Global.RepeatedCoincidence[x]);
						}
						
						if (Global.NumeroRelativo == 5) 
						{ 
							Global.fimFase = true;
						}
		}
		
		
		public function ChangeLouco():void
		{
			//Global.pickLouco++;
			
			
			/*for (var t:int = 0; t < 8; t++ )
			{
				trace(DiagnosticoEncontrado[Global.pickLouco][t]);
			}*/
			
		}
		
		
	}

}