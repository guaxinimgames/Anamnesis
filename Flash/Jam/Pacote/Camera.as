package Pacote 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Diego Lopes & Falme Stramless
	 */
	public class Camera extends MovieClip
	{
		
		private var camera:MovieClip;
		
		
		private var ativar:Boolean;
		
		
		public function Camera(cameraArg:MovieClip) 
		{
			camera = cameraArg;
			
			camera.addEventListener(Event.ENTER_FRAME, looping);
		}
		
		public function looping(event:Event):void
		{

			if (ativar)
			{
				if (mouseX > 770 && camera.x < 840)
				{
					camera.x += 10;
				}
				if (mouseX < 30 && camera.x > 0)
				{
					camera.x -= 10;
				}
			}
			
			
			
		}
		
		public function setAtiva(e:Boolean):void
		{
			ativar = e;
		}
		
	}

}