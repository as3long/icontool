package com.as3long.icontool 
{
	 import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import flash.desktop.NativeDragManager;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filesystem.File;
    import flash.net.URLRequest;
    
    /**
    * ...
    * @author Jaja as-max.cn
    */
    public class ImageFileContainer extends Sprite
    {
        private var theFile:File;
        private var loader:Loader;
        
        public function ImageFileContainer(imagefile:File) :void
        {
            theFile = imagefile;
            loader = new Loader;
            loader.load(new URLRequest(imagefile.url));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
            addChild(loader);
            
            this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        }
        
        private function loaded(event:Event):void {
            if (loader.width > 80) {
                loader.width = 80;
                loader.scaleY = loader.scaleX;
            }
            if (loader.height > 60) {
                loader.height = 60;
                loader.scaleX = loader.scaleY;
            }
        }
        
        private function onMouseDown(event:MouseEvent):void {
            var theClip:Clipboard = new Clipboard;
            theClip.setData(ClipboardFormats.FILE_LIST_FORMAT, [theFile], false);
            
            NativeDragManager.doDrag(this, theClip);
        }
        
    }

}