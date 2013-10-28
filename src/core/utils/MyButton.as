package core.utils{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MyButton extends EventDispatcher{
		static protected const LABEL_UP:String="up";
		static protected const LABEL_DOWN:String="down";
		static protected const LABEL_ROLL_OVER:String="over";
		static protected const LABEL_ROLL_OUT:String="out";
		static protected const LABEL_DISABLE:String="disable";
		
		private var _content:MovieClip;
		private var _hit_zone:SimpleButton;
		private var _is_disabled:Boolean;
		private var _new_text:String=null;
		
		public function MyButton(content:MovieClip, is_disabled:Boolean=false, text:String=null){
			init(content, is_disabled, text);
			_is_disabled ? disable() : setListeners();
		}
		private function init(content:MovieClip, is_disabled:Boolean, text:String):void{
			_content=content;
			_new_text=text;
			_is_disabled=is_disabled;
			_hit_zone=getHitZone();
			_new_text!=null ? setButtonText(_new_text) : null;
		}
	
		private function setListeners():void{
			_hit_zone.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			_hit_zone.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			_hit_zone.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_hit_zone.addEventListener(MouseEvent.CLICK, mouseClickHandler);
		}
		private function removeListeners():void{
			_hit_zone.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			_hit_zone.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			_hit_zone.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_hit_zone.removeEventListener(MouseEvent.CLICK, mouseClickHandler);
		}
		private function setButtonText(newText:String):void{
			(_content.getChildByName("text") as TextField).text=newText;
		}
		public function get buttonText():String{
			return (_content.getChildByName("text") as TextField).text as String;
		}
		private function getHitZone():SimpleButton{
			return _content.getChildByName("hit") as SimpleButton;
		}
		private function mouseOverHandler(event:MouseEvent):void{
			updateState(LABEL_ROLL_OVER);
			dispatchEvent(event);
		}
		private function mouseOutHandler(event:MouseEvent):void{
			updateState(LABEL_ROLL_OUT);
			dispatchEvent(event);
		}
		private function mouseDownHandler(event:MouseEvent):void{
			updateState(LABEL_DOWN);
			dispatchEvent(event);
		}
		private function mouseClickHandler(event:MouseEvent):void{
			updateState(LABEL_UP);
			dispatchEvent(event);
		}
		private function updateState(frame_name:String):void{
			_content.gotoAndPlay(frame_name);
			_new_text!=null ? (_content.getChildByName("text") as TextField).text=_new_text : null;
		}
		public function disable(is_disabled:Boolean=true):void{
			switch (is_disabled){
				case true:
					_hit_zone.hasEventListener(MouseEvent.MOUSE_OVER) ? removeListeners() : null;
					updateState(LABEL_DISABLE);
					_hit_zone.mouseEnabled=false;
					break;
				case false:
					if (!_hit_zone.hasEventListener(MouseEvent.MOUSE_OVER)){
						setListeners();
						updateState(LABEL_UP);
						_hit_zone.mouseEnabled=true;
					}
					break;
			}
		}
		public function destroy():void{
			removeListeners();
		}
	}
}