package core.controller.commands{
	import core.configs.GeneralNotifications;
	import core.model.proxy.MainAndPollConfigProxy;
	import core.model.proxy.UserInfoProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class UserMadeChoiseCommand extends SimpleCommand{
		override public function execute(notification:INotification):void{
			var answerIndex:int=notification.getBody() as int;
			var question:String=mainAndPollConfigProxy.getCurrentQuestion();
			var answer:String=mainAndPollConfigProxy.getAnswerByIndex(answerIndex);
			(facade.retrieveProxy(UserInfoProxy.NAME) as UserInfoProxy).pushAnswerToArray(question, answer);
			
			var nextQuestion:String=mainAndPollConfigProxy.nextQuestion();
			var nextAnswers:Array=mainAndPollConfigProxy.nextAnswers();
			if (nextQuestion!=null && nextAnswers!=null){
				var indexAndQuestionAndAnswers:Array=[];
				indexAndQuestionAndAnswers.push(mainAndPollConfigProxy.getQuestionIndex(), nextQuestion, nextAnswers);
				sendNotification(GeneralNotifications.SHOW_NEXT_QUESTION, indexAndQuestionAndAnswers);
			}

		}
		private function get mainAndPollConfigProxy():MainAndPollConfigProxy{
			return facade.retrieveProxy(MainAndPollConfigProxy.NAME) as MainAndPollConfigProxy;
		}
	}
}