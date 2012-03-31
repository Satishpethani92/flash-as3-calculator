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
		 * 冒泡排序:
		 * 基本思想是:将被排序的数组obj[0...n-1]垂直排成一列,从上到下扫描数组obj.
		 * 根据带比较的obj元素的"轻重"(大小),对相邻两个元素,遵循"轻"者(小的)上浮,"重"者(大的)下沉的原则.
		 * 一遍扫描后,最"重"(大)的已经在最下面.再从最上面开始的n-1个元素进行同样处理.
		 * 直到最后任何两个元素都满足"轻"者在上,"重"者在下为止.
		 * @param obj
		 * @param n
		 * @return
		 */
		public static function Bubble_Sort(obj:Array,n:int):Array
		{
			var permutation:int=1;
			var k:int=n-1;
			var j:int;
			while((k>0)&&(permutation==1))
			{
				permutation=0;
				for(j=0;j<k;j++)
				{
					if(AS_Util.compch(obj, j, j+1))
					{
						AS_Util.exch(obj, j, j+1);
					}
				}
				k=k-1;
			}
			return obj;
		}
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
//				CONFIG::debug{				
//					AS_Util.printf(obj);
//				}
			}
			return obj;
		}	
		
		/**
		 * 树形选择排序之:堆排序
		 * 堆积排序(HeapSort)是指利用堆积树(堆)这种资料结构所设计的一种排序算法,可以利用数组的特点快速定位指定索引的元素.
		 * 堆排序(HeapSort)是一树形选择排序.
		 * 堆排序的特点是:在排序过程中,将R[l..n]看成是一棵完全二叉树的顺序存储结构,
		 * 利用完全二叉树中双亲结点和孩子结点之间的内在关系,在当前无序区中选择关键字最大(或最小)的记录.
		 * 算法分析:
		 * 堆[排序的时间,主要由建立初始]堆和反复重建堆这两部分的时间开销构成,它们均是通过调用Heapify实现的.
		 * 堆排序的最坏时间复杂度为O(nlogn).堆序的平均性能较接近于最坏性能.　　
		 * 由于建初始堆所需的比较次数较多,所以堆排序不适宜于记录数较少的文件.
		 * 堆排序是就地排序,辅助空间为O(1),它是不稳定的排序方法. 　
		 * @param obj 要排序对象
		 * @return obj 一排好序的对象
		 */
		public static function Heap_Sort(obj:Array):Array
		{
			var heap:AS_Heap=new AS_Heap(obj);
			return heap.Heap_Sort(obj, obj.length);
		}
	}
}
