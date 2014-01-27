package Pacote
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Pacote.Preloader;
	import Pacote.botaoStart;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	
	
	/**
	* @author Diego Lopes & Falme Stramless
	*/
	public class Main extends MovieClip 
	{
		/**
		* Construtor
		* Para a timeline e cria o listener de evento do preloader
		*/
		var preloader:Preloader;
		
		var botao1:botaoStart;
		
		//ALTERAR
		private var botaoStartMenu:botaoStartGameMovieClip;
		
		
		var cameraMC:CameraMovieclip;
		var camera:Camera;
		
		private var caixaDialogoMC:textBoxMovieclip;
		private var botaoDialogo:botaoDialogoMovieclip;
		private var campoDeTexto:TextField;
		private var botaoTrocaFrame:Boolean;
		
		private var playerMC:playerMoviecllip;
		private var player:Player;
		private var pathMC:pathMovieClip;
		private var path:Path;
		
		//private var playerMC2:playerMoviecllip;
		//private var player2:Player;
		//private var pathMC2:pathMovieClip;
		//private var path2:Path;
		
		private var actionZoneMC:Vector.<ActionZoneMovieClip>;
		private var actionNumber:Array = [];
		
		
		private var fadeEfeitoMenu:Fade;
		private var fadeEfeitoIntro:Fade;
		
		private var backgroundMC:BackgroundMovieClip;
		private var luzEfeitoMC:LuzEfeitoMovieclip
		private var tecla:Boolean;
		private var tecla2:Boolean;
		
		private var dataLoucos:Dados;
		private var dataJogo:DadosJogo;
		
		private var diagnosticWindow:DiagnosticWindowMovieClip;
		private var botaoDiagnostic:botaoDiagnosticWindowMovieClip;
		
		
		
		
		
		public function Main() 
		{
			this.stop(); //para a timeline
			
			Global.GameState = 0;
			dataLoucos = new Dados();
			dataJogo = new DadosJogo();
			
			cameraMC = new CameraMovieclip();
			camera = new Camera(cameraMC);
			
			cameraMC.x = 400;
			cameraMC.y = 300;
			cameraMC.width = 800;
			cameraMC.height = 600;
			addChild(cameraMC);
			

			selecionaGameState(Global.GameState);
			
			
		}
		
		private function instanciaTextBox():void
		{
			caixaDialogoMC = new textBoxMovieclip();
			caixaDialogoMC.x = 400;
			caixaDialogoMC.y = 502;
			addChild(caixaDialogoMC);
			caixaDialogoMC.visible = false;
			caixaDialogoMC.alpha = 0;
			
			
			
			
			
			campoDeTexto = new TextField();
			campoDeTexto.name = "texto";
			campoDeTexto.y = 444;
			campoDeTexto.visible = false;
			campoDeTexto.selectable = false;
			campoDeTexto.multiline = true;
			campoDeTexto.wordWrap = true;
			campoDeTexto.width = 610;
			campoDeTexto.height = 114;
			campoDeTexto.text = "Batata";
			addChild(campoDeTexto);
			campoDeTexto.alpha = 0;
			
			botaoDialogo = new botaoDialogoMovieclip();
			//botaoDialogo.x = (this.x - camera.x);
			botaoDialogo.y = 550;
			addChild(botaoDialogo);
			botaoDialogo.visible = false;
			botaoDialogo.addEventListener(MouseEvent.CLICK, cliqueBotaoDialogo);
			botaoDialogo.alpha = 0;

			caixaDialogoMC.addEventListener(Event.ENTER_FRAME, corrigePosicaoTextBox);
			
		}
		
		
		public function corrigePosicaoTextBox(event:Event):void
		{
			caixaDialogoMC.x = cameraMC.x;
			botaoDialogo.x = cameraMC.x + 270;
			campoDeTexto.x = cameraMC.x-340;
			
			
		}
		public function appearBox(e:Boolean):void
		{
			botaoTrocaFrame = e;
			caixaDialogoMC.visible = true;
			botaoDialogo.visible = true;
			campoDeTexto.visible = true;
			
			caixaDialogoMC.addEventListener(Event.ENTER_FRAME, appearEffect);
		}
		
		private function appearEffect(event:Event):void
		{
			if (caixaDialogoMC.alpha < 1)
			{
				caixaDialogoMC.alpha += 0.1;
				botaoDialogo.alpha += 0.1;
				campoDeTexto.alpha += 0.1;
			}
			else
			{
				caixaDialogoMC.removeEventListener(Event.ENTER_FRAME, appearEffect);
			}
		}
		private function desappearBox():void
		{
			caixaDialogoMC.visible = false;
			botaoDialogo.visible = false;
			campoDeTexto.visible = false;
			caixaDialogoMC.addEventListener(Event.ENTER_FRAME, desappearEffect);
		}
		private function desappearEffect(event:Event):void
		{
			if (caixaDialogoMC.alpha > 0)
			{
				caixaDialogoMC.alpha -= 0.1;
				botaoDialogo.alpha -= 0.1;
				campoDeTexto.alpha -= 0.1;
			}
			else
			{
				caixaDialogoMC.removeEventListener(Event.ENTER_FRAME, desappearEffect);
			}
		}
		
		private function cliqueBotaoDialogo(event:Event)
		{
			if (botaoTrocaFrame)
			{
				
				selecionaGameState(3);
			}
			if (Global.fimFase)
			{
				instanciaDiagnosticWindow();
			}
			desappearBox();
			
		}
		
		public function mudarTexto(texto:String):void
		{
			campoDeTexto.text = texto;
		}
		
		public function selecionaGameState(gameStateNum:int):void
		{
			Global.GameState = gameStateNum;
			SelecionarCena();
		}
		
		public function SelecionarCena():void
		{
			switch(Global.GameState)
			{
				case 0:
					instanciaPreloader();
					this.gotoAndPlay("preloader","Preloader");
					camera.setAtiva(false);
					break;
				case 1:
					instanciaMenu();
					this.gotoAndPlay("menu","Menu");
					break;
				case 2:
					instanciaIntro();
					this.gotoAndPlay("intro","Intro");
					break;
				case 3:
					camera.setAtiva(true);
					this.gotoAndPlay("teste","Teste");
					instanciaTeste();
					break;
			}
		}
		
		public function instanciaPreloader():void
		{
			
			preloader = new Preloader();//instância um novo preloader
			preloader.x = 38;
			preloader.y = 308;
			preloader.width = 752;
			preloader.height = 98;
			addChild(preloader);
						
			preloader.addEventListener(Event.ENTER_FRAME, iniciarPreloader);//cria um listener para iniciar o preloader
			
			botao1 = new botaoStart();
			botao1.x = 400;
			botao1.y = 432;
			botao1.width = 121;
			botao1.height = 121;
			addChild(botao1);
			botao1.visibilidade(false);
		}
		
		
		
		//ALTERAR
		public function instanciaMenu():void
		{
			fadeEfeitoMenu = new Fade();
			fadeEfeitoMenu.x = 400;
			fadeEfeitoMenu.y = 300;
			fadeEfeitoMenu.width = 800;
			fadeEfeitoMenu.height = 600;
			this.addChild(fadeEfeitoMenu);
			
			
			botaoStartMenu=new botaoStartGameMovieClip();
			botaoStartMenu.x=400;
			botaoStartMenu.y=300;
			this.addChild(botaoStartMenu);
			botaoStartMenu.addEventListener(MouseEvent.CLICK, cliqueBotaoMenu);
			
			fadeEfeitoMenu.visible = false;
		}
		public function cliqueBotaoMenu(event:Event):void
		{
			botaoStartMenu.visible = false;
			selecionaGameState(2);
			fadeEfeitoMenu.efeitoOut();
			this.addEventListener(Event.ENTER_FRAME, checaFade);
			
			
		}
		
		private function checaFade(event:Event):void
		{
			if (fadeEfeitoMenu.getNext())
			{
				//selecionaGameState(2);
				botaoStartMenu.removeEventListener(MouseEvent.CLICK, cliqueBotaoMenu);
				botaoStartMenu.visible = false;
				this.removeEventListener(Event.ENTER_FRAME, checaFade);
			}
		}
		
		public function instanciaIntro():void
		{
			fadeEfeitoIntro = new Fade();
			fadeEfeitoIntro.x = 400;
			fadeEfeitoIntro.y = 300;
			fadeEfeitoIntro.width = 800;
			fadeEfeitoIntro.height = 600;
			this.addChild(fadeEfeitoIntro);
			fadeEfeitoIntro.efeitoOut();
			instanciaTextBox();
			mudarTexto(dataJogo.getInfoFirstDay());
			appearBox(true);
			
			
			
		}		
		
		public function instanciaTeste():void
		{
			
			
			
			backgroundMC = new BackgroundMovieClip();			
			backgroundMC.x = 400;
			backgroundMC.y = 300;
			this.addChild(backgroundMC);
			
			playerMC = new playerMoviecllip();
			playerMC.x = 368;
			playerMC.y = 498;
			this.addChild(playerMC);
			
			luzEfeitoMC = new LuzEfeitoMovieclip();
			luzEfeitoMC.x = 400;
			luzEfeitoMC.y = 300;
			this.addChild(luzEfeitoMC);
			
			pathMC = new pathMovieClip();
			pathMC.x = 550;
			pathMC.y = 470;
			
			pathMC.width = 1337;
			pathMC.height = 303;
			
			this.addChild(pathMC);
			
			
			path = new Path();
			
			actionZoneMC = new Vector.<ActionZoneMovieClip>;
			//actionZone = new Vector.<ActionZone>;
			
			for (var i:int = 0; i < 8; i++)
			{
				actionZoneMC[i] = new ActionZoneMovieClip();
				
				addChild(actionZoneMC[i]);
				
			}
			//actionZoneMC[0].x = -127;
			//actionZoneMC[0].y = 498;
			
			actionZoneMC[0].x = -104;
			actionZoneMC[0].y = 490;
			actionZoneMC[0].width = 194;
			actionZoneMC[0].height = 142;
			
			
			actionZoneMC[1].x = -232;
			actionZoneMC[1].y = 150;
			actionZoneMC[1].width = 88;
			actionZoneMC[1].height = 308;
			
			
			actionZoneMC[2].x = 62;
			actionZoneMC[2].y = 194;
			actionZoneMC[2].width = 88;
			actionZoneMC[2].height = 159;
			
			
			actionZoneMC[3].x = 246;
			actionZoneMC[3].y = 194;
			actionZoneMC[3].width = 183;
			actionZoneMC[3].height = 283;
			
			actionZoneMC[4].x = 534;
			actionZoneMC[4].y = 273;
			actionZoneMC[4].width = 199;
			actionZoneMC[4].height = 149;
			
			actionZoneMC[5].x = 767;
			actionZoneMC[5].y = 186;
			actionZoneMC[5].width = 153;
			actionZoneMC[5].height = 103;
			
			actionZoneMC[6].x = 976;
			actionZoneMC[6].y = 170;
			actionZoneMC[6].width = 107;
			actionZoneMC[6].height = 159;
			
			actionZoneMC[7].x = 1172;
			actionZoneMC[7].y = 134;
			actionZoneMC[7].width = 130;
			actionZoneMC[7].height = 195;
			
			
			
			
			player = new Player(playerMC, pathMC);
			
			
			
		
			
			//ChangeTextDialog("Other Dialog");
			
			
			//textBoxMC.botanzin.x = 200;
			
			
			
			
			player.addEventListener(Event.ENTER_FRAME, loopCamera);
			
			
			actionZoneMC[0].addEventListener(MouseEvent.CLICK, cliqueAction1);
			actionZoneMC[1].addEventListener(MouseEvent.CLICK, cliqueAction2);
			actionZoneMC[2].addEventListener(MouseEvent.CLICK, cliqueAction3); 
			actionZoneMC[3].addEventListener(MouseEvent.CLICK, cliqueAction4);
			actionZoneMC[4].addEventListener(MouseEvent.CLICK, cliqueAction5);
			actionZoneMC[5].addEventListener(MouseEvent.CLICK, cliqueAction6);
			actionZoneMC[6].addEventListener(MouseEvent.CLICK, cliqueAction7);
			actionZoneMC[7].addEventListener(MouseEvent.CLICK, cliqueAction8);
			
			
			
			instanciaTextBox();
			//instanciaDiagnosticWindow();
	
		}
		
		private function instanciaDiagnosticWindow():void
		{
			diagnosticWindow = new DiagnosticWindowMovieClip;
			diagnosticWindow.x = 400;
			diagnosticWindow.y = 300;
			diagnosticWindow.width = 800;
			diagnosticWindow.height = 600;
			botaoDiagnostic = new botaoDiagnosticWindowMovieClip();
			botaoDiagnostic.x = 400;
			botaoDiagnostic.y = 300;
			botaoDiagnostic.addEventListener(MouseEvent.CLICK, ResetLouco);
			
			
			
			
			diagnosticWindow.visible = true;
			addChild(diagnosticWindow);
			addChild(botaoDiagnostic);
			diagnosticWindow.addEventListener(Event.ENTER_FRAME, corrige);

		}
		
		public function ResetLouco(event:MouseEvent):void
		{
			Global.pickLouco++;
			Global.NumeroRelativo = 0;
			Global.fimFase = false;
			playerMC.x = 368;
			playerMC.y = 498;
			
			player.setPosicaoX(368);
			player.setPosicaoY(498);
			
			for (var qw:int = 0; qw < 8; qw++ )
			{
				Global.RepeatedCoincidence[qw] = false;
			}
			diagnosticWindow.visible = false;
			botaoDiagnostic.visible = false;
		}
		
		
		private function corrige(event:Event):void
		{
			diagnosticWindow.x = cameraMC.x;
			diagnosticWindow.y = cameraMC.y;
			botaoDiagnostic.x = cameraMC.x;
			botaoDiagnostic.y = cameraMC.y;
		}
		
		public function cliqueAction1(event:MouseEvent):void
		{			
			player.setPosicaoX(32);
			player.setPosicaoY(550);
			
			//ANDAR
			if (playerMC.x < player.getPosicaoX())
			{
				
			}
			if (playerMC.x+10 > player.getPosicaoX())
			{
				playerMC.scaleX = 1;
			}
			
			//Interagir
			if (playerMC.x==28)
			{
				mudarTexto(dataLoucos.getReaction(0));
				appearBox(false);
			}
		}
		
		public function cliqueAction2(event:MouseEvent):void
		{
			player.setPosicaoX(-109);
			player.setPosicaoY(352);
			
			playerMC.scaleX = 1;
			
			if (playerMC.x == -112)
			{
				mudarTexto(dataLoucos.getReaction(1));
				appearBox(false);
			}
		}
		
		public function cliqueAction3(event:MouseEvent):void
		{
			player.setPosicaoX(64);
			player.setPosicaoY(347);
			
			if (playerMC.x < player.getPosicaoX())
			{
				playerMC.scaleX = -1;
			}
			if (playerMC.x > player.getPosicaoX())
			{
				playerMC.scaleX = 1;
			}
			
			if (playerMC.x == 63)
			{
				mudarTexto(dataLoucos.getReaction(2));
				appearBox(false);
			}
		}
		
		public function cliqueAction4(event:MouseEvent):void
		{
			player.setPosicaoX(250);
			player.setPosicaoY(342);
			
			if (playerMC.x < player.getPosicaoX())
			{
				playerMC.scaleX = -1;
			}
			if (playerMC.x > player.getPosicaoX())
			{
				playerMC.scaleX = 1;
			}
			
			if (playerMC.x == 248)
			{
				mudarTexto(dataLoucos.getReaction(3));
				appearBox(false);
			}
		}
		
		public function cliqueAction5(event:MouseEvent):void
		{
			player.setPosicaoX(553);
			player.setPosicaoY(392);
			
			if (playerMC.x < player.getPosicaoX())
			{
				playerMC.scaleX = -1;
			}
			if (playerMC.x > player.getPosicaoX())
			{
				playerMC.scaleX = 1;
			}
			
			if (playerMC.x == 553)
			{
				mudarTexto(dataLoucos.getReaction(4));
				appearBox(false);
			}
		}
		
		public function cliqueAction6(event:MouseEvent):void
		{
			player.setPosicaoX(796);
			player.setPosicaoY(335);
			
			if (playerMC.x < player.getPosicaoX())
			{
				playerMC.scaleX = -1;
			}
			if (playerMC.x > player.getPosicaoX())
			{
				playerMC.scaleX = 1;
			}
			
			if (playerMC.x == 793)
			{
				mudarTexto(dataLoucos.getReaction(5));
				appearBox(false);
			}
		}
		
		public function cliqueAction7(event:MouseEvent):void
		{
			player.setPosicaoX(1000);
			player.setPosicaoY(338);
			
			if (playerMC.x < player.getPosicaoX())
			{
				playerMC.scaleX = -1;
			}
			if (playerMC.x > player.getPosicaoX())
			{
				playerMC.scaleX = 1;
			}
			
			if (playerMC.x == 998)
			{
				mudarTexto(dataLoucos.getReaction(6));
				appearBox(false);
			}
		}
		
		public function cliqueAction8(event:MouseEvent):void
		{
			//player.setPosicaoX(actionZoneMC[7].getPosicaoX());
			
			player.setPosicaoX(1189);
			player.setPosicaoY(332);
			if (playerMC.x < player.getPosicaoX())
			{
				playerMC.scaleX = -1;
			}
			if (playerMC.x > player.getPosicaoX())
			{
				playerMC.scaleX = 1;
			}
			
			if (playerMC.x == 1188)
			{
				mudarTexto(dataLoucos.getReaction(7));
				appearBox(false);
			}
		}
		
		
		
		
		
		
		
		public function loopCamera(event:Event):void
		{
			//calcular o deslocamento da camera
			player.setDeslocamentoCameraX(this.x - camera.x);
			
			//player.setDeslocamentoCameraY(this.y - camera.y);
			//trace(player.getDeslocamentoCameraX());
			//trace(this.x);
			actionZoneMC[0].setPosicaoX(this.x - camera.x);
			
		}
		/**
		 * 
		* Inicia o preloader, retira o evento quando o load terminar
		*/
		private function iniciarPreloader(event:Event):void
		{
			
			//se estiver completo
			if (preloader.getComplete())
			{		
				botao1.visibilidade(true);
				//this.nextFrame();//Ir para o próximo frame
				preloader.removeEventListener(Event.ENTER_FRAME, iniciarPreloader);//Remover Listener
				botao1.addEventListener(MouseEvent.CLICK, cliqueBotao);
			}
		}
		
		private function cliqueBotao(event:Event):void
		{
			removeChild(preloader);
			removeChild(botao1);
			//this.nextFrame();
			selecionaGameState(1);
			botao1.removeEventListener(MouseEvent.CLICK, cliqueBotao);
			
		}
		/*
		 * Define um keyframe na timeline principal para ir
		 * */
		public static function gotoLabel(e:String):void
		{
			//this.gotoAndPlay(e);
		}
	}
}