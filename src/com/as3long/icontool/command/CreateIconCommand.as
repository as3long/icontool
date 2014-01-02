package com.as3long.icontool.command
{
	import com.as3long.core.IAction;
	import com.as3long.icontool.mgr.AssetsMgr;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import org.libspark.betweenas3.BetweenAS3;
	
	/**
	 * ...
	 * @author 黄龙
	 */
	public class CreateIconCommand implements IAction
	{
		private var url:String;
		private var png:PNGEncoderOptions = new PNGEncoderOptions();
		private var fileForder:File;
		
		public function CreateIconCommand()
		{
		
		}
		
		/* INTERFACE com.as3long.core.IAction */
		
		public function run(... args):void
		{
			var file:File = args[0] as File;
			if (args[1] != 0)
			{
				fileForder = file.resolvePath("../icons" + args[1]);
			}
			else
			{
				fileForder = file.resolvePath("../icons");
			}
			fileForder.createDirectory();
			url = file.url;
			AssetsMgr.instance.loadBitmap(url, rHandler);
		}
		
		private function rHandler():void
		{
			var bmp:Bitmap = AssetsMgr.instance.getBitmap(url);
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 1024]), 0.1).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 512]), 0.2).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 152]), 0.3).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 144]), 0.4).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 128]), 0.5).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 120]), 0.6).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 114]), 0.7).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 100]), 0.8).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 80]), 0.9).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 76]), 1).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 72]), 1.1).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 58]), 1.2).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 57]), 1.3).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 50]), 1.4).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 48]), 1.5).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 40]), 1.6).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 36]), 1.7).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 32]), 1.8).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 29]), 1.9).play();
			BetweenAS3.delay(BetweenAS3.func(createImage, [bmp.bitmapData, 16]), 2).play();
			compress2();
		/*createImage(bmp.bitmapData, 1024);
		   createImage(bmp.bitmapData, 512);
		   createImage(bmp.bitmapData, 152);
		   createImage(bmp.bitmapData, 144);
		   createImage(bmp.bitmapData, 128);
		   createImage(bmp.bitmapData, 120);
		   createImage(bmp.bitmapData, 114);
		   createImage(bmp.bitmapData, 100);
		   createImage(bmp.bitmapData, 80);
		   createImage(bmp.bitmapData, 76);
		   createImage(bmp.bitmapData, 72);
		   createImage(bmp.bitmapData, 58);
		   createImage(bmp.bitmapData, 57);
		   createImage(bmp.bitmapData, 50);
		   createImage(bmp.bitmapData, 48);
		   createImage(bmp.bitmapData, 40);
		   createImage(bmp.bitmapData, 36);
		   createImage(bmp.bitmapData, 32);
		   createImage(bmp.bitmapData, 29);
		 createImage(bmp.bitmapData, 16);*/
		}
		
		private function compress():void
		{
			var file:File = fileForder.resolvePath("拖到这里压缩.bat");
			var str:String="@echo off \n"+
				"set path=%~d0%~p0 \n"+
				':start\n"'+
				File.applicationDirectory.nativePath+'\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  %1\n'+
				"shift\n"+
				"if NOT x%1==x goto start";
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(str);
			fileStream.close();
		}
		
		private function compress2():void
		{
			var file:File = fileForder.resolvePath("png24转png8会有损失.bat");
			var str:String = '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_1024.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_512.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_152.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_144.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_128.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_120.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_114.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_100.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_80.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_76.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_72.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_58.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_57.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_50.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_48.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_40.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_36.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_32.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_29.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngquant.exe" --force --verbose --ext .png --ordered --speed=1 --quality=50-90  icon_16.png\n';
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(str);
			fileStream.close();
			
			file = fileForder.resolvePath("pngout压缩.bat");
			str = '"' + File.applicationDirectory.nativePath + '\\pngout.exe" icon_1024.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_512.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_152.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_144.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_128.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_120.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_114.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_100.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_80.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_76.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_72.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_58.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_57.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_50.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_48.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_40.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_36.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_32.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_29.png\n';
			str += '"' + File.applicationDirectory.nativePath + '\\pngout.exe"  icon_16.png\n';
			fileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(str);
			fileStream.close();
		}
		
		public function createImage(bmpData:BitmapData, width:Number):void
		{
			var bdWidth:Number = bmpData.width;
			var bdHeigh:Number = bmpData.height;
			var scaleX:Number = width / bdWidth;
			var scaleY:Number = width / bdHeigh;
			
			var bd:BitmapData = scaleBitmapData(bmpData, scaleX, scaleY,width,width);
			var rect:Rectangle = new Rectangle(0, 0, width, width);
			var byteArrar:ByteArray = bd.encode(rect, png);
			var file:File = fileForder.resolvePath("icon_" + width + ".png");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(byteArrar);
			fileStream.close();
			bd.dispose();
			byteArrar.clear();
		}
		
		public function scaleBitmapData(bmpData:BitmapData, scaleX:Number, scaleY:Number,width:Number,height:Number):BitmapData
		{
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleX, scaleY);
			var bmpData_:BitmapData = new BitmapData(width, height, true, 0);
			bmpData_.draw(bmpData, matrix, null, null, null, true);
			return bmpData_;
		}
	}

}