package com.dyq.utils
{
	/**
	 * 堆数据结构
	 * @author dyq
	 */
	public class AS_Heap
	{
		private var headArray : Array;

		public function AS_Heap(arr : Array)
		{
			this.headArray = arr;
			//build_Max_Heap(this.headArray);
		}

		/**
		 * 建最大堆
		 * @param arr
		 */
		private function build_Max_Heap(arr : Array) : void
		{
			var len : int = arr.length;
			for (var i : int = (len - 1) / 2;i >= 0;i--)
			{
				max_heapify(arr, i, len);
			}
		}

		/**
		 * 单一节点最大堆调整
		 * @param arr
		 * @param i
		 * @param head_size
		 */
		private function max_heapify(arr : Array, i : int, heap_size : int) : void
		{
			var l : int = getLeft(i);
			var r : int = getRight(i);
			var largest : int;
			var temp : int;
			if (l < heap_size && arr[l] > arr[i])
			{
				largest = l;
			}
			else
			{
				largest = i;
			}
			if (r < heap_size && arr[r] > arr[largest])
			{
				largest = r;
			}
			if (largest != i)
			{
				temp = arr[i];
				arr[i] = arr[largest];
				arr[largest] = temp;
				max_heapify(arr, largest, heap_size);
			}
		}
		
		/**
		 * 堆排序
		 * @param arr
		 * @param heap_size
		 */
		public function Heap_Sort(arr:Array,heap_size : int):Array
		{
			CONFIG::debug{				
				AS_Util.printf(arr);
			}
			build_Max_Heap(arr);
			var temp:int;
			for(var i:int=heap_size-1;i>0;i--)
			{
				temp=arr[0];
				arr[0]=arr[i];
				arr[i]=temp;
				max_heapify(arr, 0, i);
			}
			CONFIG::debug{				
				AS_Util.printf(arr);
			}
			return arr;
		}

		/**
		 * 获取节点i的父节点
		 * @param i
		 * @return 父节点
		 */
		private function getParent(i : int) : int
		{
			return int(Math.floor(i / 2));
		}

		/**
		 * 获取父节点i的左子节点
		 * @param i 父节点
		 * @return 左子节点
		 */
		private function getLeft(i : int) : int
		{
			return 2 * i;
		}

		/**
		 * 获取父节点i的右子节点
		 * @param i 父节点
		 * @return 右子节点
		 */
		private function getRight(i : int) : int
		{
			return 2 * i + 1;
		}
	}
}
