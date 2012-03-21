package com.dyq.test
{
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
		private static const RANDOMVALUE : int = 5000;
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
			for (var i : int = 0;i < TOTAL;i++)
			{
				sort_tag.push(AS_Util.getRandom(RANDOMVALUE));
			}
			// 选择排序
			//AS_Sort.Selection_Sort(sort_tag, 0, sort_tag.length - 1);
			// 堆排序
			AS_Sort.Heap_Sort(sort_tag);
		}		
	}
}
