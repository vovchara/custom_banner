package
{
	import core.GameFacade;
	import core.controller.commands.StartupCommand;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	[SWF (width = '800', height = '600', framerate ='24', background = '0xFFFFF1')]
	public class Main extends Sprite
	{
		public function Main()
		{
			Security.allowDomain("*");
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			GameFacade.getInstance().startup(StartupCommand, this);
		}
	}
}


