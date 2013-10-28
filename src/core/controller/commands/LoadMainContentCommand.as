package core.controller.commands
{
	import br.com.stimuli.loading.BulkLoader;
	
	import core.configs.GeneralNotifications;
	import core.model.dto.MainAndPollConfigDTO;
	import core.model.proxy.MainAndPollConfigProxy;
	import core.utils.Werehouse;
	
	import flash.events.Event;
	import flash.text.TextField;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadMainContentCommand extends SimpleCommand{
		
		private var _loader:BulkLoader;
		private var _xmlLoader:BulkLoader;
		private var _mainConfigXML:XML;
		private const _mainConfigPath:String="res/xml/MainConfig.xml";
		
		override public function execute(notification:INotification):void{
			_loader= new BulkLoader;
			_xmlLoader = new BulkLoader;
			mainLoaderStart();
		}
		private function mainLoaderStart():void{
			_loader.add(_mainConfigPath, {id:"MainConfig"});
			_loader.addEventListener(BulkLoader.COMPLETE, onMainConfigLoaded);
			_loader.addEventListener(BulkLoader.ERROR, onError);
			_loader.start();
		}
		private function onMainConfigLoaded(event:Event):void{
			_loader.removeEventListener(BulkLoader.COMPLETE, onMainConfigLoaded);
			_mainConfigXML=_loader.getContent("MainConfig") as XML;
			for (var i:int=0; i<_mainConfigXML.conf.length(); i++){
				var asset_title:String=_mainConfigXML.conf[i].@TITLE;
				var asset_type:String=_mainConfigXML.conf[i].@TYPE;
				var asset_url:String=_mainConfigXML.conf[i].@URL;
				if (asset_type=="Email"){
					mainAndPollConfigProxy.setAdminEmail(asset_url);
				}
				else if (asset_type=="MailTitle"){
					mainAndPollConfigProxy.setMailTitle(asset_url);
				}
				else{
					_loader.add(asset_url, {id:asset_title}); 
				}
			}
			_loader.addEventListener(BulkLoader.COMPLETE, onLoaderParseComplete);
			_loader.addEventListener(BulkLoader.ERROR, onError);
		}
		public function onLoaderParseComplete(event:Event):void{
			for (var i:int=0; i<_mainConfigXML.conf.length();i++){
				var asset_type:String=_mainConfigXML.conf[i].@TYPE;
				var asset_title:String=_mainConfigXML.conf[i].@TITLE;
				switch (asset_type){
					case "MovieClip":
						Werehouse.getInstance().setAsset(asset_title, _loader.getContent(asset_title));
						break;
					case "XML":
						var asset_url:String=_mainConfigXML.conf[i].@URL;
						_xmlLoader.add(asset_url, {id:_mainConfigXML.conf[i].@TITLE});
						_xmlLoader.addEventListener(BulkLoader.COMPLETE, onGamesXmlLoaded);
						_xmlLoader.addEventListener(BulkLoader.ERROR, onError);
						_xmlLoader.start();
						break;
				}
			}
		}
		public function onGamesXmlLoaded(event:Event):void{
			_xmlLoader.removeEventListener(BulkLoader.COMPLETE, onGamesXmlLoaded);
			var pollConfigXML:XML=_xmlLoader.getContent("PollConfig");
			
			mainAndPollConfigProxy.parsePollConfig(pollConfigXML);
		}
		public function onError(event:Event):void{
			_loader.removeEventListener(BulkLoader.ERROR, onError);
			var text_field:TextField=new TextField;
			text_field.text="error in loading files...";
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, text_field);
		}
		private function get mainAndPollConfigProxy():MainAndPollConfigProxy{
			return facade.retrieveProxy(MainAndPollConfigProxy.NAME) as MainAndPollConfigProxy;
		}
	}
}
