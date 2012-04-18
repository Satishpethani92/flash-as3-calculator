package com.dyq.game
{
	import com.dyq.utils.AS_Util;

	/**
	 * 数独(9*9)生成算法
	 * @author duyouqian
	 * @since 2012-04-18 23:35
	 * @version 1.0.0
	 */
	public class AS_Sudoku
	{
		private var b1 : Array;
		private var b2 : Array;
		private var b3 : Array;
		private var b4 : Array;
		private var b5 : Array;
		private var b6 : Array;
		private var b7 : Array;
		private var b8 : Array;
		private var b9 : Array;
		private var b : Array;
		private var state : Array;

		public function AS_Sudoku()
		{
			b1 = new Array(3);
			b2 = new Array(3);
			b3 = new Array(3);
			b4 = new Array(3);
			b5 = new Array(3);
			b6 = new Array(3);
			b7 = new Array(3);
			b8 = new Array(3);
			b9 = new Array(3);
			b = new Array(9);
			state = new Array();

			crateB5();

			crateB4();
			crateB6();

			crateB2();
			crateB8();

			crateB1();
			crateB7();

			crateB3();
			crateB9();

			b=setB(b1, b2, b3, b4, b5, b6, b7, b8, b9);
		}

		/**
		 * 随机生成一个3*3的矩阵
		 */
		private function crateB5() : void
		{
			var t : int;
			for (var i : int = 0;i < 3;i++)
			{
				b5[i] = new Array(3);
				for (var j : int = 0;j < 3;j++)
				{
					do
					{
						t = AS_Util.getRandom(9);
					}
					while (state.indexOf(t) != -1);
					state.push(t);
					b5[i][j] = t;
				}
			}
			state = null;
		}

		/**
		 * 有b5矩阵行转换而来(平移)
		 * b5的第一行为b3的第二行以此类推
		 */
		private function crateB4() : void
		{
			changeCol(b4, b5, false);
		}

		/**
		 * 有b5矩阵行转换而来(平移)
		 * b5的第一行为b6的第三行以此类推
		 */
		private function crateB6() : void
		{
			changeCol(b6, b5, true);
		}

		/**
		 * 有b5矩阵列转换而来(平移)
		 * b5的第一列为b2的第二列以此类推
		 */
		private function crateB2() : void
		{
			changeRow(b2, b5, false);
		}

		/**
		 * 有b5矩阵列转换而来(平移)
		 * b5的第二列为b2的第三列以此类推
		 */
		private function crateB8() : void
		{
			changeRow(b8, b5, true);
		}

		/**
		 * 有b4矩阵列转换而来(平移)
		 * b4的第一列为b1的第二列以此类推
		 */
		private function crateB1() : void
		{
			changeRow(b1, b4, false);
		}

		/**
		 * 有b4矩阵列转换而来(平移)
		 * b4的第二列为b7的第三列以此类推
		 */
		private function crateB7() : void
		{
			changeRow(b7, b4, true);
		}

		/**
		 * 有b6矩阵列转换而来(平移)
		 * b6的第一列为b3的第二列以此类推
		 */
		private function crateB3() : void
		{
			changeRow(b3, b6, false);
		}

		/**
		 * 有b6矩阵列转换而来(平移)
		 * b6的第二列为b9的第三列以此类推
		 */
		private function crateB9() : void
		{
			changeRow(b9, b6, true);
		}

		/**
		 * 列交换
		 * @param _b1 要转换的矩阵
		 * @param _b2 根据此矩阵转换
		 * @param bol 转换模式 ture表示第二列转为的第三列 fasle表示第一列转为的第二列
		 */
		private function changeRow(_b1 : Array, _b2 : Array, bol : Boolean) : void
		{
			for (var i : int = 0;i < 3;i++)
			{
				_b1[i] = new Array(3);
				for (var j : int = 0;j < 3;j++)
				{
					_b1[i][j] = _b2[i][bol ? (j + 1) % 3 : (j + 2) % 3];
				}
			}
		}

		/**
		 * 行交换
		 * @param _b1 要转换的矩阵
		 * @param _b2 根据此矩阵转换
		 * @param bol 转换模式 ture表示第二行转为的第三行 fasle表示第一行转为的第二行
		 */
		private function changeCol(_b1 : Array, _b2 : Array, bol : Boolean) : void
		{
			for (var i : int = 0;i < 3;i++)
			{
				_b1[i] = new Array(3);
				for (var j : int = 0;j < 3;j++)
				{
					_b1[i][j] = _b2[bol ? (i + 1) % 3 : (i + 2) % 3][j];
				}
			}
		}

		/**
		 * 构建数独数据
		 * @param bb 要求要9个参数
		 */
		private function setB(...bb) : Array
		{
			var r:Array=new Array(9);
			var temp : Array;
			var i : int;
			var j : int;

			for (i = 0;i < 9;i++)
			{
				temp = new Array(9);
				for (j = 0;j < 3;j++)
				{
					temp[j] = bb[int(i / 3) * 3][i % 3][j];
				}
				for (j = 3;j < 6;j++)
				{
					temp[j] = bb[int(i / 3) * 3 + 1][i % 3][j % 3];
				}
				for (j = 6;j < 9;j++)
				{
					temp[j] = bb[int(i / 3) * 3 + 2][i % 3][j % 3];
				}
				r[i] = temp;
				temp = null;
			}

			for (i = 0;i < 9;i++)
			{
				AS_Util.printf(r[i]);
			}
			
			return r;
		}

		/**
		 * @return 获取数独数据
		 */
		public function getData() : Array
		{
			return b;
		}
	}
}
