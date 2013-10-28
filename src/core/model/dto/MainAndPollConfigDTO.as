package core.model.dto{
	public class MainAndPollConfigDTO{
		public var adminEmail:String="";
		public var mailTitle:String="";
		public var questionsArray:Array;
		public var answersArray:Array;
		
		public function MainAndPollConfigDTO(){
			questionsArray=[];
			answersArray=[];
		}
	}
}