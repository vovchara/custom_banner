package core.controller.commands
{
	import core.model.dto.MainAndPollConfigDTO;
	import core.model.proxy.MainAndPollConfigProxy;
	import core.view.components.MainVL;
	import core.view.mediators.LoadingMediator;
	import core.view.mediators.MainMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class MainContentLoadedCommand extends SimpleCommand{
		
		override public function execute(notification:INotification):void{
		facade.removeMediator(LoadingMediator.NAME) as LoadingMediator;
		var quest:String=mainAndPollConfigProxy.nextQuestion();
		var answ:Array=mainAndPollConfigProxy.nextAnswers();
		facade.registerMediator(new MainMediator(new MainVL("scene", quest, answ)));
		}
		private function get mainAndPollConfigProxy():MainAndPollConfigProxy{
			return facade.retrieveProxy(MainAndPollConfigProxy.NAME) as MainAndPollConfigProxy;
		}
		private function get mainAndPollConfigDTO():MainAndPollConfigDTO{
			return (facade.retrieveProxy(MainAndPollConfigProxy.NAME) as MainAndPollConfigProxy).mainAndPollConfigDTO;
		}
	}
}