package core.controller.commands{
	import core.configs.GeneralNotifications;
	import core.model.proxy.MainAndPollConfigProxy;
	import core.model.proxy.UserInfoProxy;
	
	import flash.events.Event;
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
		private var _loader:URLLoader;
		
		override public function execute(notification:INotification):void{
			_user_email=notification.getBody() as String;
			var user_answersArray:Array=(facade.retrieveProxy(UserInfoProxy.NAME) as UserInfoProxy).userInfoDTO.userAnswersArray;
			//_resultString=_resultString.concat(user_email + " \r \r ");
			for (var i:int=0; i<user_answersArray.length; i++){
				_resultString=_resultString.concat(user_answersArray[i] + " \r ");
			}
			_mailTitle=(facade.retrieveProxy(MainAndPollConfigProxy.NAME) as MainAndPollConfigProxy).mainAndPollConfigDTO.mailTitle;
			trace(_resultString);
			_loader = new URLLoader();
			sendEmail();
		}
		private function sendEmail():void{
			var variables:URLVariables = new URLVariables();
			variables.to = "vovchara913@gmail.com";
			variables.message = "text";
			variables.subject = "subject";
			
			var request:URLRequest = new URLRequest( "mail.php" );
			request.method = URLRequestMethod.POST;
			request.data = variables;
			
			_loader.addEventListener(Event.COMPLETE, onComplete );
			_loader.load( request );
		}
		private function onComplete( e:Event ) : void{
			_loader.removeEventListener(Event.COMPLETE, onComplete );
			trace( URLLoader( e.target ).data.toString() );
			sendNotification(GeneralNotifications.SHOW_FINISH_FRAME);
		}

	}
}