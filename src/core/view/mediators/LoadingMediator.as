package core.view.mediators
{
	
	import core.configs.GeneralNotifications;
	import core.view.components.LoadingViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LoadingMediator extends Mediator{
		
		static public const NAME:String = "LoadingMediator";
		private var _viewLogic:LoadingViewLogic;
		
		public function LoadingMediator(){
			_viewLogic= new LoadingViewLogic();
			super(NAME, _viewLogic);
		}
		override public function onRegister():void{
			super.onRegister();
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, (viewComponent as LoadingViewLogic).loading);
		}
		override public function onRemove():void{
			_viewLogic.destroy();
			super.onRemove();
		}
	}
}