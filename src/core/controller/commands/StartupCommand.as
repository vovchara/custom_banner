package core.controller.commands
{
	import core.configs.GeneralNotifications;
	import core.model.dto.MainAndPollConfigDTO;
	import core.model.dto.UserInfoDTO;
	import core.model.proxy.MainAndPollConfigProxy;
	import core.model.proxy.UserInfoProxy;
	import core.view.mediators.LoadingMediator;
	import core.view.mediators.RootMediator;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			
			//application initialization
			var root:Sprite=notification.getBody() as Sprite;
					
			//reg Command
			facade.registerCommand(GeneralNotifications.LOAD_MAIN_RESOURCES, LoadMainContentCommand);
			facade.registerCommand(GeneralNotifications.MAIN_CONTENT_LOADED, MainContentLoadedCommand);
			facade.registerCommand(GeneralNotifications.USER_MADE_CHOISE, UserMadeChoiseCommand);
			facade.registerCommand(GeneralNotifications.USER_INFO_READY, UserInfoReadyCommand);
			
			//reg Mediators
			facade.registerMediator(new RootMediator(root));
			facade.registerMediator(new LoadingMediator());
			
			//reg Proxies
			facade.registerProxy(new MainAndPollConfigProxy(new MainAndPollConfigDTO()));
			facade.registerProxy(new UserInfoProxy(new UserInfoDTO()));
			
			//sendNotification about startApplication
			sendNotification(GeneralNotifications.LOAD_MAIN_RESOURCES);
		}
	}
}