package com.dyq.utils
{
	/**
	 * 排序类
	 * @author dyq
	 * @version 1.0.0
	 */
	public class AS_Sort
	{
		/**
		 * 选择排序法之:选择排序
		 * 选择排序(Selection sort)是一种简单直观的排序算法
		 * 它的工作原理如下:
		 * 首先在未排序序列中找到最小元素,存放到排序序列的起始位置,
		 * 然后,再从剩余未排序元素中继续寻找最小元素,然后放到排序序列末尾
		 * 以此类推,直到所有元素均排序完毕.
		 * 最差时间复杂度 	О(n²)
		 * 最优时间复杂度 	О(n²)
		 * 平均时间复杂度 	О(n²)
		 * 最差空间复杂度 	О(n) total, O(1) auxiliary
		 * 最佳算法 	偶尔出现
		 * @param obj 要排序对象
		 * @param l 排序起始点
		 * @param r 排序终点
		 * @return obj 一排好序的对象
		 */
		public static function Selection_Sort(obj : Array, l : int, r : int) : Array
		{
			var min : int,j : int,i : int;
			for (i = l;i < r;i++)
			{
				min = i;
				for (j = i + 1;j <= r;j++)
				{
					if (AS_Util.compch(obj, min, j)) min = j;
				}
				if (min != i) AS_Util.exch(obj, i, min);
				AS_Util.printf(obj);
			}
			return obj;
		}	
		
		public static function Heap_Sort(obj:Array):Array
		{
			var heap:AS_Heap=new AS_Heap(obj);
			return heap.Heap_Sort(obj, obj.length);
		}
	}
}
