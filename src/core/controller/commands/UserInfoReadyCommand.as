package core.controller.commands{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class UserInfoReadyCommand extends SimpleCommand{
		override public function execute(notification:INotification):void{
			var user_email:String=notification.getBody() as String;
			var a:String='';
		}
	}
}