package com.gogogic.gamejam
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	[Frame(factoryClass="com.gogogic.gamejam.PreloaderFactory")]
	// Movie info
	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="760", height="850", pageTitle="They Came From Facebook")]
	public class Application extends Sprite
	{
		public static const APPLICATION_WIDTH:int = 760;
		public static const APPLICATION_HEIGHT:int = 850;
		
		public static const BULK_LOADER_DEFAULT:String = "Default";
		
		public static const NAME:String = "GameJamProject";
		
		private var facade:ApplicationFacade;
		
		public function Application()
		{
			Security.allowDomain("*");
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function init():void {
			facade = ApplicationFacade.getInstance(NAME);
			facade.sendNotification(ApplicationFacade.STARTUP, this);
		}
	}
}