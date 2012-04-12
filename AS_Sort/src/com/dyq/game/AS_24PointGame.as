package com.dyq.game
{
	/**
	 * 24点游戏算法
	 * @author duyouqian
	 * @version 1.0.0
	 * @since 2012-04-13 01:02
	 */
	public class AS_24PointGame
	{
		private static const THRESHOLD : Number = 1E-6;
		private static const CARDSNUMBER : int = 4;
		private static const RESULTVALUE : int = 24;
		private var number : Vector.<Number>;
		private var result : Vector.<String>;

		public function AS_24PointGame()
		{
			number = new Vector.<Number>(CARDSNUMBER);
			result = new Vector.<String>(CARDSNUMBER);
		}

		/**
		 * 开始游戏
		 * @param _number
		 * @param _result
		 * @return
		 */
		public function startGame(_number : Vector.<Number>, _result : Vector.<String>) : Boolean
		{
			number = _number;
			result = _result;
			return pointGame(CARDSNUMBER);
		}

		private function pointGame(n : int) : Boolean
		{
			if (n == 1)
			{
				if (Math.abs(number[0] - RESULTVALUE) < AS_24PointGame.THRESHOLD)
				{
					//trace(result[0]);
					return true;
				}
				else
				{
					return false;
				}
			}

			for (var i : int = 0;i < n;i++)
			{
				for (var j : int = i + 1;j < n;j++)
				{
					var expa : String,expb : String;
					var a : Number,b : Number;

					a = number[i];
					b = number[j];
					number[j] = number[n - 1];

					expa = result[i];
					expb = result[j];
					result[j] = result[n - 1];

					result[i] = "(" + expa + "+" + expb + ")";
					number[i] = a + b;
					if (pointGame(n - 1)) return true;

					result[i] = "(" + expa + "-" + expb + ")";
					number[i] = a - b;
					if (pointGame(n - 1)) return true;

					result[i] = "(" + expb + "-" + expa + ")";
					number[i] = b - a;
					if (pointGame(n - 1)) return true;

					result[i] = "(" + expa + "*" + expb + ")";
					number[i] = a * b;
					if (pointGame(n - 1)) return true;

					if (b != 0)
					{
						result[i] = "(" + expa + "/" + expb + ")";
						number[i] = a / b;
						if (pointGame(n - 1)) return true;
					}

					if (a != 0)
					{
						result[i] = "(" + expb + "/" + expa + ")";
						number[i] = b / a;
						if (pointGame(n - 1)) return true;
					}

					number[i] = a;
					number[j] = b;
					result[i] = expa;
					result[j] = expb;
				}
			}
			return false;
		}
	}
}
