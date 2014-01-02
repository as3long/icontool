package com.as3long.core 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import com.as3long.core.vo.BindEventVO;
	
	/**
	 * ...
	 * @author 黄龙
	 */
	public class As3longMVC 
	{
		private var actionDict:Dictionary = new Dictionary();
		private var modelDict:Dictionary = new Dictionary();
		private var modelEventDict:Dictionary = new Dictionary();
		private var _stage:Stage;
		public function As3longMVC() 
		{
			
		}
		
		/**
		 * 初始化
		 * @param	$stage
		 */
		public function init($stage:Stage):void
		{
			_stage = $stage;
		}
		
		/**
		 * 注册类
		 * @param	...args
		 */
		public function registClass(...args):void
		{
			
		}
		
		private static var _instance:As3longMVC;
		public static function getInstance():As3longMVC
		{
			if (!_instance)
			{
				_instance = new As3longMVC();
			}
			return _instance;
		}
		
		public function get stage():Stage 
		{
			return _stage;
		}
		
		public function getModel(name:String):EventDispatcher
		{
			if (!modelDict[name])
			{
				var _class:Class=getDefinitionByName(name) as Class;
				modelDict[name] = new _class() as EventDispatcher;
			}
			return modelDict[name];
		}
		
		/**
		 * 绑定模型
		 * @param	className 模型类字符串
		 * @param	str 绑定关键字
		 * @param	func 回调方法
		 */
		public function bindModel(name:String,str:String,func:Function):void
		{
			if (!modelEventDict[name])
			{
				var modelEventVector:Vector.<BindEventVO> = new Vector.<BindEventVO>();
				modelEventDict[name] = modelEventVector;
			}
			var bindEventVO:BindEventVO = new BindEventVO(name, str, func);
			modelEventDict[name].push(bindEventVO);
			if (!modelDict[name])
			{
				var _class:Class=getDefinitionByName(name) as Class;
				modelDict[name] = new _class() as EventDispatcher;
				
			}
			
			if (!(modelDict[name] as EventDispatcher).hasEventListener(str))
			{
				(modelDict[name] as EventDispatcher).addEventListener(str, bindEvent)
			}
			
			function bindEvent(e:Event):void
			{
				modelEventVector = modelEventDict[name];
				for (var i:int = 0; i < modelEventVector.length; i++)
				{
					if (e.type == modelEventVector[i].eventStr)
					{
						trace("回调",e.type);
						modelEventVector[i].callBack(e);
					}
				}
			}
			
		}
		
		/**
		 * 移除模型绑定事件
		 * @param	str 绑定关键字
		 * @param	func 回调方法
		 */
		public function unBindModel(name:String,str:String, func:Function):void
		{
			if (!modelDict[name])
			{
				var _class:Class=getDefinitionByName(name) as Class;
				modelDict[name] = new _class() as EventDispatcher;
			}
			(modelDict[name] as EventDispatcher).removeEventListener(str, func);
		}
		
		public function getAction(name:String):IAction
		{
			/*if (!_stage)
			{
				throw new Event("请调用AD.init(stage);");
			}*/
			
			if (!actionDict[name])
			{
				actionDict[name] = getDefinitionByName(name) as Class;
			}
			return new actionDict[name]() as IAction;
		}
	}

}