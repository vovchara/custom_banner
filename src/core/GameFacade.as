package core
{
	import core.configs.GeneralNotifications;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class GameFacade extends Facade
	{
		//Singleton GameFacade Factory Method
		public static function getInstance():GameFacade
		{
			if (instance==null)
			{
				instance=new GameFacade();
			}
			return instance as GameFacade;
		}
		
		//Broadcast the STARTUP Notification
		public function startup(command:Class, root:Sprite):void
		{
			registerCommand(GeneralNotifications.STARTUP, command);
			sendNotification(GeneralNotifications.STARTUP, root);
		}
		
	}
}