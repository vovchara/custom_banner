package core.view.components{
	
	import core.utils.EventTrans;
	import core.utils.Werehouse;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MainVL extends UIViewLogic{
		public static const EVENT_ANSWER_SELECTED:String="event_answer_selected";
		public static const EVENT_EMAIL_ENTERED:String="event_email_entered";
		private var _question:String;
		private var _answers:Array;
		private var _questionTextField:TextField;
		private var _answersTextFArray:Array;
		private var _buttonsArray:Array;
		private var _okBtn:SimpleButton;
		private var _inputTF:TextField;
		
		public function MainVL(assetName:String, question:String, answers:Array, nameSpace:String=null){
			super(assetName, nameSpace);
			_question=question;
			_answers=answers;
			initVars();
			initTextFields(_question, _answers);
			initButtons(0, _answers);
		}
		private function initVars():void{
			_answersTextFArray=[];
			_questionTextField=content['question'] as TextField;
			for (var z:int=0; z<4; z++){
				_answersTextFArray.push(content['answer'+z.toString()] as TextField);
			}
		}
		public function initTextFields(question:String, answers:Array):void{
			_questionTextField.text=question;
			for (var k:int=0; k<4; k++){
				if (k<answers.length){
					(_answersTextFArray[k] as TextField).text=answers[k];
				}
				else{
					(_answersTextFArray[k] as TextField).text='';
				}
			}
		}
		public function initButtons(questionNumber:int, answers:Array):void{
			_buttonsArray=[];
			for (var i:int=0; i<answers.length; i++){
				var buttonClass:Class=Werehouse.getInstance().getClassAsset('answ'+questionNumber.toString()+i.toString());
				var button:SimpleButton=new buttonClass() as SimpleButton;
				button.name='answ'+questionNumber.toString()+i.toString();
				button.addEventListener(MouseEvent.CLICK, buttonClicked);
				((content['btn_place'+i.toString()]) as MovieClip).addChild(button);
				_buttonsArray.push(button);
			}
		}
		private function buttonClicked(event:MouseEvent):void{
			for (var g:int=0; g<_buttonsArray.length; g++){
				(_buttonsArray[g] as SimpleButton).removeEventListener(MouseEvent.CLICK, buttonClicked);
				(_buttonsArray[g] as SimpleButton).parent.removeChild(_buttonsArray[g] as SimpleButton);
			}
			var buttonIndex:int=int(event.target.name.substr(5,1));
			dispatchEvent(new EventTrans(EVENT_ANSWER_SELECTED, buttonIndex));
		}
		public function showInputEmail():void{
			(content as MovieClip).gotoAndStop(2);
			_inputTF=content['input'] as TextField;
			_okBtn=content['ok_btn'] as SimpleButton;
			_okBtn.addEventListener(MouseEvent.CLICK, okBtnClicked);
		}
		private function okBtnClicked(event:MouseEvent):void{
			_okBtn.addEventListener(MouseEvent.CLICK, okBtnClicked);
			dispatchEvent(new EventTrans(EVENT_EMAIL_ENTERED, 0, _inputTF.text));
		}
	}
}