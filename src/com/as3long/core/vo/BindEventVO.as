package com.as3long.core.vo 
{
	/**
	 * ...
	 * @author 黄龙
	 */
	public class BindEventVO 
	{
		
		public var name:String;
		
		public var eventStr:String;
		
		public var callBack:Function;
		
		public function BindEventVO($name:String,$eventStr:String,$callBack:Function) 
		{
			name = $name;
			eventStr = $eventStr;
			callBack = $callBack;
		}
		
	}

}