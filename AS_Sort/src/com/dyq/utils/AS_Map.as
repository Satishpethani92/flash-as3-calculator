package com.dyq.utils
{
	/**
	 * 图论相关
	 * @author duyouqian
	 * @version 1.0.0
	 * @since 2012-03-30 11:26
	 */
	public class AS_Map
	{
		/**
		 * 深度优先搜索
		 * @param mapArray 地图邻接矩阵
		 * @param pev 地图顶点
		 * @param len 地图顶点长度
		 * @param start
		 * @param end
		 * @return 路径
		 */
		public static function dfs(mapArray : Array, pev : Array, len : int, start : int, end : int) : Array
		{
			var steak : AS_Stack = new AS_Stack();
			pev[start] = 1;
			steak.push(start);
			var path : Array = new Array();
			// var str1:String="";
			// str1 += start + ",";
			path.push(start);
			while (!steak.empty())
			{
				var i : int = getUnvisitedVertex(mapArray, pev, len, int(steak.pep()), end);
				// AS_Util.printf(mapArray[int(steak.pep())]);
				if (i == -1)
				{
					AS_Util.deleteValueByArray(path, steak.pop());
				}
				else
				{
					// str1 += i + ",";
					path.push(i);
					pev[i] = 1;
					steak.push(i);
				}
				if (i == end) break;
			}
			return path;
			// trace("深度优先搜索:", str1);
		}

		/**
		 * 广度优先搜索
		 * @param mapArray 地图邻接矩阵
		 * @param pev 地图顶点
		 * @param len 地图顶点长度
		 * @param start 起始点
		 * @param end 终点
		 * @return 路径
		 */
		public static function bfs(mapArray : Array, pev : Array, len : int, start : int, end : int) : Array
		{
			var queue : AS_Queue = new AS_Queue();
			pev[start] = 1;
			var path : Array = new Array();
			path.push(start);
			// var str1:String="";
			// str1 += start + ",";
			queue.add(start);
			var v : int;
			while (!queue.empty())
			{
				var i : int = int(queue.remove());
				while ((v = getUnvisitedVertex(mapArray, pev, len, i, end)) != -1)
				{
					pev[v] = 1;
					path.push(v);
					// str1 += v + ",";
					queue.add(v);					
					if (v == end)
					{
						// trace("广度优先搜索:", str1);
						return path;
					}
				}
			}
			return null;
		}

		/**
		 * 查找没有访问过的邻接点 
		 * @param mapArray 地图邻接矩阵
		 * @param pev 地图顶点
		 * @param len 地图顶点长度
		 * @param x 当前搜索顶点
		 * @param end 要搜索的目标点
		 * @return 关键点的ID -1:表示没有搜索到关键点
		 */
		private static function getUnvisitedVertex(mapArray : Array, pev : Array, len : int, x : int, end : int) : int
		{
			var i : int,j : int,k : int;
			// 先搜索当前关键点的路径是否已经包含目标点 如果已经包含目标点 就返回该目标点
			for (k = 0;k < len;k++)
			{
				if (k == end && mapArray[x][k] == 1 && pev[k] == -1)
				{
					return k;
				}
			}
			// 从x点向两边搜索
			for (i = x,j = x;i >= 0 && j < len;i--,j++)
			{
				if (mapArray[x][j] == 1 && pev[j] == -1)
				{
					return j;
				}
				if (mapArray[x][i] == 1 && pev[i] == -1)
				{
					return i;
				}
			}
			// 向左边到尽头
			if (i < 0)
			{
				for (; j < len; j++)
				{
					if (mapArray[x][j] == 1 && pev[j] == -1)
					{
						return j;
					}
				}
			}
			// 向右边到尽头
			else if (j >= len)
			{
				for (; i >= 0; i--)
				{
					if (mapArray[x][i] == 1 && pev[i] == -1)
					{
						return i;
					}
				}
			}
			return -1;
		}

		/**
		 * 顶点都置为false(-1)
		 * @param pev
		 * @param len
		 */
		public static function reset(pev : Array, len : int) : void
		{
			for (var i : int = 0; i < len; i++)
			{
				pev[i] = -1;
			}
		}
	}
}
