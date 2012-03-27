package com.dyq.test
{
	import com.dyq.utils.AS_Math;
	import com.dyq.game.ShuffleGame;
	import flash.utils.getTimer;
	import com.dyq.utils.AS_Stack;
	import com.dyq.utils.AS_Util;
	import com.dyq.utils.AS_Sort;

	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author dyq
	 */
	public class Test extends Sprite
	{
		private static const TOTAL : int = 10;
		private static const RANDOMVALUE : int = 50000;
		private var sort_tag : Array;

		public function Test()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e : Event = null) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			sort_tag = new Array();
			initSort();
		}

		/**
		 * 产生一个要排序的数组(随机)
		 */
		private function initSort() : void
		{
			var stack:AS_Stack=new AS_Stack();
			var i : int;
			var temp:int;
			for ( i = 0;i < TOTAL;i++)
			{
				temp=AS_Util.getRandom(RANDOMVALUE);
				sort_tag.push(temp);
				stack.push(temp);
			}
			
			CONFIG::debug
			{
				trace("原始数据:");
				AS_Util.printf(sort_tag);
				// 选择排序
				trace("选择排序:");
				var temparr:Array;
				var time:Number=getTimer();
				temparr=AS_Sort.Selection_Sort(sort_tag, 0, sort_tag.length - 1);
				var time2:Number=getTimer();
				trace("选择排序耗时:",time2-time);
				AS_Util.printf(temparr);
				temparr=null;
				// 堆排序
				trace("堆排序:");
				time=getTimer();
				temparr=AS_Sort.Heap_Sort(sort_tag);
				time2=getTimer();
				trace("堆排序耗时:",time2-time);
				AS_Util.printf(temparr);
				//栈的应用
				trace("栈的应用:");
				var str:String="";
				for(i=0;i<TOTAL;i++)
				{
					str+=stack.pop()+" ";
				}
				trace(str);
				AS_Util.insertIndex(sort_tag, 4, 1);
				AS_Util.printf(sort_tag);
				var card:ShuffleGame=new ShuffleGame();
				card.startGame();
				trace(AS_Math.pow(2, 9));
				trace(AS_Math.pow(2, 10));				
				for(i=1;i<11;i++)
				{
					trace(AS_Math.fibonacci(i));
				}
				
			}
		}		
	}
}
