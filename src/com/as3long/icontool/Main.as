package com.as3long.icontool
{
	import com.as3long.icontool.command.CreateIconCommand;
	import com.as3long.icontool.view.MainView;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Sprite;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import org.libspark.betweenas3.BetweenAS3;
	
	/**
	 * ...
	 * @author 黄龙
	 */
	public class Main extends Sprite 
	{
		private var fileNum:int = 0;
		public function Main():void 
		{
			$A.init(stage);
			addChild(new MainView());
			this.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, dragFileHandler);
			this.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, dragFileHandler);
			this.stage.nativeWindow.alwaysInFront = true;
			registHandler();
		}
		
		private function registHandler():void
		{
			$A.registClass(CreateIconCommand);
		}
		
		private function dragFileHandler(event:NativeDragEvent):void 
		{
			 try{
                var fileArr:Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
                switch(event.type) {
                    case NativeDragEvent.NATIVE_DRAG_ENTER:
                        if(canAccept(fileArr)){
                            NativeDragManager.acceptDragDrop(this);
                        }
                        break;
                    case NativeDragEvent.NATIVE_DRAG_DROP:
                        for (var i:int = 0; i < fileArr.length; i++) {
                            var file:File = fileArr[i] as File;
                           /* var container:ImageFileContainer = new ImageFileContainer(file);
                            container.x = (fileNum % 6) * 90;
                            container.y = Math.floor(fileNum / 6) * 70;
                            addChild(container);*/
							$A.getAction("com.as3long.icontool.command::CreateIconCommand").run(file,i.toString());
							fileNum++;
                        }
                        break;
                }
            }catch (error:Error) {
                //不是文件
            }
		}
		
		 private function canAccept(fileArr:Array):Boolean {
            for (var i:int = 0; i < fileArr.length; i++) {
                var file:File = fileArr[i] as File;
                switch(file.extension) {
                    case "jpg":
                    case "JPG":
                    case "png":
                    case "PNG":
                    case "gif":
                    case "GIF":
                    case "jpeg":
                    case "JPEG":
                    case "swf":
                    case "SWF":
                        break;
                    default:
                        return false;
                }
            }
            return true;
        }
		
	}
	
}