package core.view.mediators{
	import core.configs.GeneralNotifications;
	import core.utils.EventTrans;
	import core.view.components.MainVL;
	import core.view.components.UIViewLogic;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class MainMediator extends UIMediator{
		static public const NAME:String="MainMediator";
		private var _viewLogic:MainVL;
		
		public function MainMediator(viewComponent:MainVL){
			super(NAME, viewComponent);
			_viewLogic=viewComponent;
			registerListeners();
		}
		private function registerListeners():void{
			_viewLogic.addEventListener (MainVL.EVENT_ANSWER_SELECTED, answerSelected);
			_viewLogic.addEventListener (MainVL.EVENT_EMAIL_ENTERED, emailEntered);
		}
		private function answerSelected(event:EventTrans):void{
			var buttonIndex:int=event.getButtonIndex();
			sendNotification(GeneralNotifications.USER_MADE_CHOISE, buttonIndex);
		}
		private function emailEntered(event:EventTrans):void{
			sendNotification(GeneralNotifications.USER_INFO_READY, event.getAdditionalData() as String);
		}
		override public function listNotificationInterests():Array{
			return [GeneralNotifications.SHOW_NEXT_QUESTION,
				GeneralNotifications.SHOW_INPUT_EMAIL,
				GeneralNotifications.SHOW_FINISH_FRAME
			];
		}
		override public function handleNotification(notification:INotification):void{
			switch (notification.getName()){
				case GeneralNotifications.SHOW_NEXT_QUESTION:
					var indexAndQuestionAndAnswers:Array=notification.getBody() as Array;
					_viewLogic.initButtons(indexAndQuestionAndAnswers[0] as int, indexAndQuestionAndAnswers[2] as Array);
					_viewLogic.initTextFields(indexAndQuestionAndAnswers[1] as String, indexAndQuestionAndAnswers[2] as Array);
					break;
				case GeneralNotifications.SHOW_INPUT_EMAIL:
					_viewLogic.showInputEmail();
					break;
				case GeneralNotifications.SHOW_FINISH_FRAME:
					_viewLogic.showFinishFrame();
					break;
			}
		}
		override public function onRemove():void{
		//	_viewLogic.removeEventListener (LobbyViewLogic.EVENT_LEVEL_SELECTED, levelSelected);
		//	_viewLogic.removeEventListener(LobbyViewLogic.EVENT_TUTORIAL_CLICKED, tutorialClickedHandler);
			super.onRemove();
		}
	}
}