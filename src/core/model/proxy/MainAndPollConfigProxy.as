package core.model.proxy{
	import core.configs.GeneralNotifications;
	import core.model.dto.MainAndPollConfigDTO;
	
	import org.as3commons.collections.iterators.ArrayIterator;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class MainAndPollConfigProxy extends Proxy{
		public static const NAME:String = "MainAndPollConfigProxy";
		private var _mainAndPollConfigDTO:MainAndPollConfigDTO;
		private var _questionsArrayIterator:ArrayIterator;
		private var _answersArrayIterator:ArrayIterator;
		
		public function MainAndPollConfigProxy(mainAndPollConfigDTO:MainAndPollConfigDTO){
			super(NAME, mainAndPollConfigDTO);
			_mainAndPollConfigDTO=mainAndPollConfigDTO;
		}
		public function get mainAndPollConfigDTO():MainAndPollConfigDTO{
			return _mainAndPollConfigDTO;
		}
		public function setAdminEmail(email:String):void{
			_mainAndPollConfigDTO.adminEmail=email;
		}
		public function setMailTitle(mailTitle:String):void{
			_mainAndPollConfigDTO.mailTitle=mailTitle;
		}
		public function parsePollConfig(pollConfigXML:XML):void{
			var questionsArray:Array=[];
			var answersArray:Array=[];
			for (var i:int = 0; i<pollConfigXML.*.length(); i++){
				var question:String=pollConfigXML.question[i].@TITLE;
				questionsArray.push(question);
				var answArray:Array=[];
				for (var j:int=0; j<pollConfigXML.question[i].*.length(); j++){
					var answer:String=pollConfigXML.question[i].property[j].@NAME;
					answArray.push(answer);
				}
				answersArray.push(answArray);
			}	
			_mainAndPollConfigDTO.questionsArray=questionsArray;
			_mainAndPollConfigDTO.answersArray=answersArray;
			_questionsArrayIterator= new ArrayIterator(questionsArray);
			_answersArrayIterator=new ArrayIterator(answersArray);
			
			sendNotification(GeneralNotifications.MAIN_CONTENT_LOADED);
		}
		public function nextQuestion():String{
			var quest:String=null;
			if (_questionsArrayIterator.hasNext()){
				quest=_questionsArrayIterator.next();
			}
			else{
				sendNotification(GeneralNotifications.SHOW_INPUT_EMAIL);
			}
			return quest;
		}
		public function getQuestionIndex():int{
			return _questionsArrayIterator.index;
		}
		public function nextAnswers():Array{
			var answ:Array=null;
			if (_answersArrayIterator.hasNext()){
				answ=_answersArrayIterator.next();
			}
			return answ;
		}
		public function getCurrentQuestion():String{
			return _questionsArrayIterator.current as String;
		}
		public function getAnswerByIndex(index:int):String{
			return _answersArrayIterator.current[index] as String;
		}
	}
}