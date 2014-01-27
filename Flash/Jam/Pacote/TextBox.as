package Pacote 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Diego Lopes & Falme Stramless
	 */
	public class TextBox extends MovieClip
	{
		private var textBox:MovieClip;
		
		public function TextBox(e:MovieClip) 
		{
			textBox = e;
		}
		public function visibilidade(e:Boolean):void
		{
			textBox.visible = e;
		}
		
	}

}