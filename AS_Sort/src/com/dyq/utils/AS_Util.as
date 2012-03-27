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
		 * 交换函数(vector版)
		 * @param obj 交换对象的宿体
		 * @param i 交换的主体在宿体的位置
		 * @param j 交换的主体在宿体的位置
		 */
		public static function exchByVector(obj : Vector, i : int, j : int) : void
		{
			var temp : Object = obj[i];
			obj[i] = obj[j];
			obj[j] = temp;
		}

		/**
		 * 批量互换函数
		 * @param obj 交换对象的宿体
		 * @param i 交换的主体在宿体的起始位置
		 * @param j 交换的主体在宿体的结束位置
		 */
		public static function batchExch(obj : Array, i : int, j : int) : void
		{
			var mid : int = (i + j) / 2;
			var temp : int;
			for (var k : int = i;k <= mid;k++)
			{
				temp = j - k;
				if (k != temp) exch(obj, k, temp);
			}
		}

		/**
		 * 原对象中的一个元素要插入本对象中的另外一个位置
		 * @param obj 对象
		 * @param i 要插入的位置
		 * @param j 现在的位置
		 * @return 
		 */
		public static function insertIndex(obj : Array, i : int, j : int) : Array
		{
			var temp : Object = obj[j];
			var k : int;
			if (j < i)
			{
				for (k = j + 1;k <= i;k++)
				{
					obj[k - 1] = obj[k];
				}
				obj[i] = temp;
			}
			else
			{
				for (k = j - 1;k >= i;k--)
				{
					obj[k + 1] = obj[k];
				}
				obj[i] = temp;
			}

			return obj;
		}
		
		/**
		 * 洗牌
		 * @param obj 洗牌主体
		 * @param shuffleCount 洗牌次数
		 * @param randNum 洗牌范围
		 * @return
		 */
		public static function shuffleByArray(obj : Array, shuffleCount : int, randNum : int) : Array
		{
			var ran1 : int;
			var ran2 : int;
			for (var i : int = 0;i < shuffleCount;i++)
			{
				ran1 = getRandom(randNum);
				ran2 = getRandom(randNum);
				exch(obj, ran1, ran2);
			}
			return obj;
		}
		
		/**
		 * 洗牌
		 * @param obj 洗牌主体
		 * @param shuffleCount 洗牌次数
		 * @param randNum 洗牌范围
		 * @return
		 */
		public static function shuffleByVector(obj : Vector, shuffleCount : int, randNum : int) : Vector
		{
			var ran1 : int;
			var ran2 : int;
			for (var i : int = 0;i < shuffleCount;i++)
			{
				ran1 = getRandom(randNum);
				ran2 = getRandom(randNum);
				exchByVector(obj, ran1, ran2);
			}
			return obj;
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
		 * 打印函数(选择打印)
		 * @param obj 要打印的对象为数组
		 * @param startIndex 起点位置
		 * @param endIndex 结束位置
		 */
		public static function printfByIndex(obj : Array, startIndex : int, endIndex : int) : void
		{
			if (startIndex > endIndex) throw new Error("起点位置不能大于结束位置");
			if (startIndex < 0) throw new Error("起点位置不能小于0");
			if (endIndex > obj.length - 1) throw new Error("结束位置不能大于打印对象的长度");
			var str : String = "";
			for (var i : int = startIndex;i <= endIndex;i++) str += obj[i] + " ";
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
		
		/**
		 * 判断一个字符串是否有周期性
		 * @param value
		 * @return 最小周期 -1:表示没有周期性 
		 */
		public static function cycle(value:String):int
		{
			var len:int=value.length;
			var ok:int=1;
			for(var i:int=1;i<=len;i++)
			{
				if(len%i==0)
				{
					ok=1;
					for(var j:int=i;j<len;j++)
					{
						if(value.charAt(j)!=value.charAt(j%i))
						{
							ok=0;
							break;
						}
					}
					if(ok)return i;
				}
			}
			return -1;
		}
	}
}
