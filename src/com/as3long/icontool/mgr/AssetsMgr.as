package com.as3long.icontool.mgr 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * 资源管理
	 * @author 黄龙
	 */
	public class AssetsMgr 
	{
		private var disc:Dictionary = new Dictionary();
		private static var _instance:AssetsMgr;
		public function AssetsMgr() 
		{
			
		}
		
		public function loadBitmap(url:String,rHandler:Function=null):void
		{
			ReadFileMgr.Instance.readFile(url);
			var loader:Loader = new Loader();
			var bytes:ByteArray = ReadFileMgr.Instance.fileData;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
					disc[url] = loader.content as Bitmap;
					if (rHandler!=null)
					{
						rHandler();
					}
				});
			loader.loadBytes(bytes);
		}
		
		public function getBitmap(url:String):Bitmap
		{
			return disc[url];
		}
		
		public static function get instance():AssetsMgr 
		{
			if (!_instance)
			{
				_instance = new AssetsMgr();
			}
			return _instance;
		}
		
	}

}