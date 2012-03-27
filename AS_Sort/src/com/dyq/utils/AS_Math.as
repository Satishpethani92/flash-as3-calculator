package com.dyq.utils
{
	/**
	 * 数学类
	 * @author duyouqian
	 * @version 1.0.0
	 */
	public class AS_Math
	{
		/**
		 * 乘方运算(计算value^n的值)的分治法
		 * @param value 自己
		 * @param n 指数
		 * @return value^n
		 */
		public static function pow(value:int,n:int):Number
		{
			if(n==1)return value;
			if(n%2==0)
			{
				return pow(value, n/2)*pow(value, n/2);
			}
			else
			{
				return pow(value, (n-1)/2)*pow(value, (n-1)/2)*value;
			}
		}
		
		/**
		 * 矩阵乘法 a*b(朴树算法)
		 * 若A和B是2个n×n的矩阵,则它们的乘积C=AB同样是一个n×n的矩阵
		 * @param a
		 * @param b
		 * @return a*b
		 */
		public static function matrixMultiplication(a:Array,b:Array):Array
		{
			var c:Array=new Array();
			var temp:Array;
			var i:int,j:int,k:int;
			for(i=0;i<a.length;i++)
			{
				temp=new Array();
				for(j=0;j<b.length;j++)
				{
					temp[j]=0;
					for(k=0;k<b.length;k++)
					{
						temp[j]=temp[j]+a[i][k]*b[k][j];
					}
				}
				c[i]=temp;
			}
			return c;
		}
		
		/**
		 * 矩阵加法 a+b(朴树算法)
		 * @param a
		 * @param b
		 * @return a+b
		 */
		public static function matrixPlus(a:Array,b:Array):Array
		{
			var c:Array=new Array();
			var temp:Array;
			var i:int,j:int;
			for(i=0;i<a.length;i++)
			{
				temp=new Array();
				for(j=0;j<b.length;j++)
				{
					temp[j]=a[i][j]+b[i][j];					
				}
				c[i]=temp;
			}
			return c;
		}
		
		/**
		 * 矩阵乘方(分治法)
		 * @param a
		 * @param n
		 * @return
		 */
		public static function matrix_pow(a:Array,n:int):Array
		{
			var temp:Array;
			if(n==1)return a;
			temp=matrixMultiplication(a, a);
			if(n&1)
			{
				//奇数
				return matrixMultiplication(matrix_pow(temp, (n-1)/2),a);
			}
			else
			{
				return matrix_pow(temp, n/2);
			}
		}
		
		/**
		 * 斐波纳契数列(Fibonacci Sequence)
		 * @param value
		 * @return
		 */
		public static function fibonacci(value:int):Number
		{
			var E:Array=new Array();
			E[0]=[1,1];
			E[1]=[1,0];
			E=matrix_pow(E,value);
			return E[0][1];
		}
	}
}
