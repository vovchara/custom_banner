package core.utils
{
	import flash.events.Event;
	
	public class EventTrans extends Event{
		private var _additionalData:Object;
		private var _buttonIndex:int;
		
		public function EventTrans(type:String, buttonIndex:int, additionalData:Object=null, bubbles:Boolean=false, cancelable:Boolean=false){
			_additionalData=additionalData;
			_buttonIndex=buttonIndex;
			super(type, bubbles, cancelable);
		}
		public function getAdditionalData():Object{
			return _additionalData;
		}
		public function getButtonIndex():int{
			return _buttonIndex;
		}
	}
}