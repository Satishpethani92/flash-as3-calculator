package com.dyq.utils
{
	/**
	 * 辅助类
	 * @author dyq
	 * @version 1.0.0
	 */
	public class AS_Util
	{
		/**
		 * 比较函数
		 * @param obj 比较对象的宿体
		 * @param i 比较的主体在宿体的位置
		 * @param j 比较的主体在宿体的位置
		 * @return boolean true:i>j false j>i
		 */
		public static function compch(obj : Array, i : int, j : int) : Boolean
		{
			return obj[i] > obj[j];
		}

		/**
		 * 交换函数
		 * @param obj 交换对象的宿体
		 * @param i 交换的主体在宿体的位置
		 * @param j 交换的主体在宿体的位置
		 */
		public static function exch(obj : Array, i : int, j : int) : void
		{
			var temp : Object = obj[i];
			obj[i] = obj[j];
			obj[j] = temp;
		}

		/**
		 * 打印函数
		 * @param obj 要打印的对象为数组
		 */
		public static function printf(obj : Array) : void
		{
			var max : int = obj.length;
			var str : String = "";
			for (var i : int = 0;i < max;i++) str += obj[i] + " ";
			trace(str);
		}
		
		/**
		 * 产生一个随机数 [1,value]
		 * @param value 随机数上限
		 * @return int 随机数
		 */
		public static function getRandom(value : int) : int
		{
			return int(Math.random() * value) + 1;
		}
	}
}
