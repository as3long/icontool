package com.as3long.icontool.view 
{
	import com.as3long.icontool.mgr.AssetsMgr;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 黄龙
	 */
	public class MainView extends Sprite 
	{
		private var labelBitmap:Bitmap;
		public function MainView() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			AssetsMgr.instance.loadBitmap("assets/label.png", onLoaded);
		}
		
		public function onLoaded():void 
		{
			labelBitmap = AssetsMgr.instance.getBitmap("assets/label.png");
			addChild(labelBitmap);
		}
		
	}

}