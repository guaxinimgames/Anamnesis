package Pacote 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Diego Lopes & Falme Stramless
	 */
	public class Player extends MovieClip 
	{
		private var jogador:MovieClip;
		private var velocidade:Number;
		
		public var jogadorX:Number;
		public var jogadorY:Number;
		
		private var posicaoX:Number;
		private var posicaoY:Number;
		
		private var cam:Camera;
		private var deslocamentoCameraX:Number;
		private var deslocamentoCameraY:Number;
		
		private var curva:Boolean;
		private var curvaVolta:Boolean;
		private var curvaTorta:Boolean;
		private var curvaTortaVolta:Boolean;
		
		private var path:MovieClip;
		
		private var lado:Boolean;
		
		public function Player(jogadorMC:MovieClip,pathMC:MovieClip) 
		{
			jogador = jogadorMC;
			velocidade = 5;
			path = pathMC;
			
			path.addEventListener(MouseEvent.CLICK, cliqueMouse);
			//path2.addEventListener(MouseEvent.CLICK, cliqueMouse);
			jogador.addEventListener(Event.ENTER_FRAME, Loop);
			
			lado = false;
		}
		
		/*public function GetArea():Stage
		{
			
			return STANT;
		}
		
		public function SetArea(moi:Stage):void
		{
			STANT = moi;
		}*/
		
		private function cliqueMouse(event:MouseEvent):void
		{
			if (!Global.fimFase)
			{
			posicaoX = mouseX-deslocamentoCameraX;
			posicaoY = mouseY;
			}
			if (jogador.x < posicaoX)
			{
				jogador.scaleX = -1;
			}
			else
			{
				jogador.scaleX = 1;
			}
			
			//jogador.addEventListener(Event.ENTER_FRAME, Loop);
			//jogador.removeEventListener(MouseEvent.CLICK,cliqueMouse);
		}

		private function Loop(event:Event):void
		{
			trace(jogador.y-posicaoY);
			//if (jogador.x<posicaoX || jogador.x>posicaoX)
			if((jogador.x-posicaoX>-5 && jogador.x-posicaoX<=0))
			{
				Global.andando = false;
			}
			else 
			{
				Global.andando = true;
			}
			
			if (jogador.x > 40 && jogador.x < 375 && 
				jogador.y > 335 && jogador.y < 460 && 
				posicaoX > 556 && posicaoX < 907 && 
				posicaoY >  325 && posicaoY < 590)
			{
				curva = true;
			}
			
			if (posicaoX < 40 && posicaoX > 375 && 
				posicaoY > 335 && posicaoY < 460 && 
				jogador.x > 556 && jogador.x < 907 && 
				jogador.y > 325 && jogador.y < 460)
			{
				curvaVolta = true;
			}
			
			if (jogador.x < -5 && jogador.y > 335 && 
				jogador.y < 400 && posicaoX > 300 && 
				posicaoY > 335 && posicaoY < 460)
			{
				curvaTorta = true;
			}
			
			if (jogador.x < 310 && jogador.x > 95 && 
				jogador.y > 471 && jogador.y < 630 && 
				posicaoX > 40 && posicaoX < 230 && 
				posicaoY > 395 && posicaoY < 465)
			{
				curvaTortaVolta = true;
			}
			
			
			if (!curvaVolta && !curva && !curvaTorta && !curvaTortaVolta)
			{
			
				if (jogador.x < posicaoX)
				{
					jogador.x += velocidade;
					
					lado = true;
				}
				if (jogador.x > posicaoX)
				{
					jogador.x -= velocidade;
					lado = false;
				}
				if (jogador.y < posicaoY)
				{
					jogador.y += velocidade;
				}	
				if (jogador.y > posicaoY)
				{
					jogador.y -= velocidade;
				}
			
			}
			
			else if(curva) 
			{ 
				EndOfShape(); 
				//EndOfShapeTwo(); 
			}
			
			else if(curvaVolta)
			{ 
				EndOfShapeTwo(); 
			}
			
			else if(curvaTorta)
			{ 
				EndOfShapeTree(); 
			}
			
			else if(curvaTortaVolta)
			{ 
				EndOfShapeFor(); 
			}
			
		}
		
		private function EndOfShape():void
		{
			
			if (jogador.y < 500 && jogador.x > 230)
			{
				jogador.y += velocidade; 
				
			}
			
			if (jogador.x < 570) 
			{
				jogador.x += velocidade;
				lado = true;
			}
			
			else 
			{ 
				curva = false; 
			}
				
			
		}
		
		private function EndOfShapeTwo():void
		{
			
			if (jogador.y < 500)
			{
				jogador.y += velocidade; 
			}
			
			if (jogador.x > 370) 
			{
				jogador.x -= velocidade;
				lado = false;
			}
			
			else 
			{ 
				curvaVolta = false; 
			}
				
			
		}
		
		private function EndOfShapeTree():void
		{
			

			if (jogador.x < 250) 
			{
				jogador.x += velocidade;
				lado = true;
			}
			
			else 
			{ 
				curvaTorta = false; 
			}
			
		}
		
		private function EndOfShapeFor():void
		{
			

			if (jogador.y > 400) 
			{
				jogador.y -= velocidade;
			}
			if (jogador.x < 230)
			{
				jogador.x += velocidade;
				lado = true;
			}
			
			else 
			{ 
				curvaTortaVolta = false; 
			}
				
			
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
		
		public function getDeslocamentoCameraX():Number
		{
			return deslocamentoCameraX;
		}
		
		public function setDeslocamentoCameraX(e:Number):void
		{
			deslocamentoCameraX = e;
		}
		
	}

}