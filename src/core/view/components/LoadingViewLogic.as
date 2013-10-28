package core.view.components
{
	import core.utils.LoadingComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class LoadingViewLogic extends Sprite
	{
		public var loading:DisplayObjectContainer;
		private var _scene:Sprite=new Sprite;
		
		public function LoadingViewLogic(){
			super();
			loading=new LoadingComponent(_scene, 275, 200, 25, 15, 5, 5, 0xF00000, 1) as DisplayObjectContainer;
		}
		public function destroy():void{
			(loading as LoadingComponent).destroy();
		}
	}
}