package core.utils
{
	
	import flash.display.DisplayObjectContainer;
	
	public class Werehouse{
		
		private static var _instance:Werehouse;
		private var _name:Array = new Array;
		private var _content:Array=new Array;
		private var _index:int;
		
		public static function getInstance():Werehouse{
			if (_instance == null){
				_instance = new Werehouse;
			}
			return _instance;
		}
		
		public function setAsset(name:String, content:DisplayObjectContainer):void{
			_name.push(name);
			_content.push(content);
		}
		public function removeAsset(name:String):void{
			for (var z:int=0; z<_name.length; z++){
				if (_name[z]==name){
					_name.splice(z,1);
					_content.splice(z,1);
				}
			}
		}
		public function hasAsset(name:String, nameSpace:String=null):Boolean{
			if (nameSpace == null){
				for each (var item:DisplayObjectContainer in _content){
					if (item.loaderInfo.applicationDomain.hasDefinition(name)){
						return true;
					}
				}
				return false;	
			}
			_index=_name.indexOf(nameSpace);
			if (_index!=-1){
				var is_has_asset:Boolean= _content[_index].loaderInfo.applicationDomain.hasDefinition(name) ? true : false;
				return is_has_asset;
			}
			else {
				return false;
			}
		}
		public function getSkinAsset(name:String, nameSpace:String=null):DisplayObjectContainer{
			if (nameSpace == null){
				for each (var item:DisplayObjectContainer in _content){
					if (item.loaderInfo.applicationDomain.hasDefinition(name)){
						var item_class:Class = item.loaderInfo.applicationDomain.getDefinition(name) as Class;
						var item_DOC:DisplayObjectContainer = new item_class() as DisplayObjectContainer;
						return item_DOC;
					}
				}
				return null;	
			}
			_index=_name.indexOf(nameSpace);
			var skin_class:Class = (_content[_index]).loaderInfo.applicationDomain.getDefinition(name) as Class;
			var skin:DisplayObjectContainer = new skin_class() as DisplayObjectContainer;
			return skin;
		}
		public function getClassAsset(name:String, nameSpace:String=null):Class{
			if (nameSpace == null){
				for each (var item:DisplayObjectContainer in _content){
					if (item.loaderInfo.applicationDomain.hasDefinition(name)){
						var item_class:Class = item.loaderInfo.applicationDomain.getDefinition(name) as Class;
						return item_class;
					}
				}
				return null;	
			}
			_index=_name.indexOf(nameSpace);
			var skin_class:Class = (_content[_index]).loaderInfo.applicationDomain.getDefinition(name) as Class;
			return skin_class;
		}
	}
}