package com.as3long.icontool.mgr 
{
	//import com.greensock.loading.DataLoader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	/**
	 * 管理读取文件
	 * @author 黄龙
	 */
	public class ReadFileMgr 
	{
		protected var fileStream:FileStream;
		private var urlStream:URLStream;
		private var _rHander:Function;
		private var _fHander:Function;
		public var fileData:ByteArray = new ByteArray();
		//private var dataLoader:DataLoader;
		private var file:File;
		public function ReadFileMgr() 
		{
			
		}
		
		public function readFile(path:String, rHander:Function = null,fHander:Function=null):void
		{
			if (rHander != null)
			{
				_rHander = rHander;
			}
			
			if (fHander != null)
			{
				_fHander = fHander;
			}
			/*urlStream = new URLStream();
			fileData = new ByteArray();
			urlStream.addEventListener(Event.COMPLETE, resultHandler);
			urlStream.addEventListener(IOErrorEvent.IO_ERROR, faultHandler);
			if (path.indexOf(File.applicationStorageDirectory.url) == -1)
			{
				path = File.applicationStorageDirectory.url + path;
			}
			urlStream.load(new URLRequest(path));
			trace(path);*/
			file= File.applicationDirectory.resolvePath(path);
			fileStream = new FileStream();
			fileData = new ByteArray();
			try{
				fileStream.open(file, FileMode.READ);
				fileStream.readBytes(fileData);
				fileStream.close();
				if (_rHander!= null)
				{
					_rHander();
				}
			}
			catch (e:Error)
			{
				trace(e);
				if (_fHander != null)
				{
					_fHander();
				}
			}
			//var str:String= fileData.readMultiByte(fileData.length, "UTF-8");
			//trace(str);
		}
		
		private function faultHandler(e:IOErrorEvent):void 
		{
			urlStream.removeEventListener(Event.COMPLETE, resultHandler);
			urlStream.removeEventListener(IOErrorEvent.IO_ERROR, faultHandler);
			if (_fHander != null)
			{
				_fHander();
			}
			trace(e.toString());
			//free();
		}
		
		private function free():void
		{
			_fHander = null;
			_rHander = null;
			urlStream = null;
		}
		
		private function resultHandler(e:Event):void 
		{
			urlStream.removeEventListener(Event.COMPLETE, resultHandler);
			urlStream.removeEventListener(IOErrorEvent.IO_ERROR, faultHandler);
			urlStream.readBytes(fileData);
			if (_rHander != null)
			{
				_rHander();
			}
			//free();
		}
		
		private static var _instance:ReadFileMgr;
		public static function get Instance():ReadFileMgr
		{
			if (_instance == null)
			{
				_instance = new ReadFileMgr();
			}
			return _instance;
		}
	}

}