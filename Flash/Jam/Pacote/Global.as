package Pacote 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Diego Lopes & Falme Stramless
	 */
	public class Global extends MovieClip
	{
		public static var labelName:String;
		public static var sceneName:String;
		public static var GameState:int;
		public static var botaozinho:botaoDialogoMovieclip;
		public static var fimFase:Boolean;
		public static var pickLouco:uint;//Escolher um louco da database (COMEÇA EM ZERO)
		public static var NumeroRelativo:Number;
		public static var RepeatedCoincidence:Array = [];
		
		public static var andando:Boolean;
		
		
		public function Global() 
		{
			
		}
		
		
	}

}