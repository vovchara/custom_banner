package core.controller.commands{
	import core.configs.GeneralNotifications;
	import core.model.proxy.MainAndPollConfigProxy;
	import core.model.proxy.UserInfoProxy;
	
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class UserInfoReadyCommand extends SimpleCommand{
		private var _resultString:String="";
		private var _mailTitle:String="";
		private var _user_email:String="";
		
		override public function execute(notification:INotification):void{
			_user_email=notification.getBody() as String;
			var user_answersArray:Array=(facade.retrieveProxy(UserInfoProxy.NAME) as UserInfoProxy).userInfoDTO.userAnswersArray;
			//_resultString=_resultString.concat(user_email + " \r \r ");
			for (var i:int=0; i<user_answersArray.length; i++){
				_resultString=_resultString.concat(user_answersArray[i] + " \r ");
			}
			_mailTitle=(facade.retrieveProxy(MainAndPollConfigProxy.NAME) as MainAndPollConfigProxy).mainAndPollConfigDTO.mailTitle;
			trace(_resultString);
			sendEmail();
			sendNotification(GeneralNotifications.SHOW_FINISH_FRAME);
		}
		private function sendEmail():void{
			var my_vars:URLVariables = new URLVariables();
			my_vars.senderName = "noob";
			my_vars.senderEmail = _user_email;
			my_vars.senderMsg = _resultString; 
			
			var my_url:URLRequest = new URLRequest("mail.php");
			my_url.method = URLRequestMethod.POST;
			my_url.data = my_vars;
			
			var my_loader:URLLoader = new URLLoader();
			my_loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			my_loader.load(my_url);
		}
	}
}