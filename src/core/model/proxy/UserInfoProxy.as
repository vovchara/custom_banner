package core.model.proxy{
	import core.model.dto.UserInfoDTO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class UserInfoProxy extends Proxy{
		public static const NAME:String = "UserInfoProxy";
		private var _userInfoDTO:UserInfoDTO;
		
		public function UserInfoProxy(userInfoDTO:UserInfoDTO){
			super(NAME, userInfoDTO);
			_userInfoDTO=userInfoDTO;
		}
		public function get userInfoDTO():UserInfoDTO{
			return _userInfoDTO;
		}
		public function pushAnswerToArray(question:String, answer:String):void{
			_userInfoDTO.userAnswersArray.push(question);
			_userInfoDTO.userAnswersArray.push(answer);
		}
	}
}