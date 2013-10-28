package core.model.dto{
	public class UserInfoDTO{
		public var userEmail:String="";
		public var userName:String="";
		public var userAnswersArray:Array;
		
		public function UserInfoDTO(){
			userAnswersArray=[];
		}
	}
}