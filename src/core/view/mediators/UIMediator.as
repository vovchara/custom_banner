package core.view.mediators
{
	import core.configs.GeneralNotifications;
	import core.view.components.UIViewLogic;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class UIMediator extends Mediator
	{
		static public const NAME:String="UIMediator";
		private static var _name:String;
		
		public function UIMediator(name:String, viewComponent:UIViewLogic){
			_name=name;
			super(_name, viewComponent);
		}
		
		override public function onRegister():void{
			super.onRegister();
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewLogic.content);
		}
		override public function onRemove():void{
			viewLogic.destroy();
			super.onRemove();
		}
		
		public function get viewLogic():UIViewLogic{
			return viewComponent as UIViewLogic;
		} 
	}
}