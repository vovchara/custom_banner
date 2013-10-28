package core.view.components
{
	import core.utils.Werehouse;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	public class UIViewLogic extends EventDispatcher{
		
		private var _content:DisplayObjectContainer;  
		
		public function UIViewLogic(assetName:String, nameSpace:String=null):void{
			_content=Werehouse.getInstance().getSkinAsset(assetName, nameSpace) as DisplayObjectContainer;
		}
		
		public function get content():DisplayObjectContainer{
			return _content as DisplayObjectContainer;
		}
		public function destroy():void{
			while(content.numChildren > 0) content.removeChildAt(0);
			if (content && content.parent)
				content.parent.removeChild(content);
		}
	}
}