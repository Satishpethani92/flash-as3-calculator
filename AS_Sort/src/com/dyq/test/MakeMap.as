package com.dyq.test
{
	import flash.events.Event;
	import flash.geom.Point;

	import com.dyq.utils.AS_Stack;

	import flash.display.StageScaleMode;
	import flash.display.StageAlign;

	import com.dyq.utils.AS_Util;

	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * 迷宫地图生成
	 * @author duyouqian
	 * @version 1.0.0
	 * @since 2012-04-04 13:20
	 */
	public class MakeMap extends Sprite
	{
		private static const MAPSIZEX : int = 4;
		private static const MAPSIZEY : int = 4;
		private static const DIRECTION : Array = [[0, 1], [1, 0], [0, -1], [-1, 0]];
		private var map : Array;
		private var mark : Array;
		private var father : Array;
		private var pathStack : AS_Stack;
		private var finalStack : AS_Stack;
		private var speedX : int = 1;
		private var speedY : int = 1;
		private var moveEnd : Point;
		private var dirX : int = 0;
		private var dirY : int = 0;
		private var startPoint : Sprite;
		private var endPoint : Shape;

		public function MakeMap()
		{
			init();
		}

		private function init() : void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			// init_mazeMap();
			build();

			// 起点
			startPoint = drawBlack2(0xff0000);
			startPoint.x = 10;
			startPoint.y = 10;
			this.addChild(startPoint);

			// 终点
			endPoint = drawBlack(0xff0000);
			endPoint.x = (2 * MAPSIZEX + 1) * 10;
			endPoint.y = (2 * MAPSIZEY + 1) * 10;
			this.addChild(endPoint);

			map[1][1] = 2;
			map[2 * MAPSIZEY + 1][2 * MAPSIZEX + 1] = 3;

			for (var i : int = 0;i < 2 * MAPSIZEY + 3;i++)
			{
				AS_Util.printf(map[i]);
			}

			// 搜索
			// dfs();
		}

		/**
		 * 坐标的散列值
		 * @param x
		 * @param y
		 * @param col
		 * @return 坐标的散列值
		 */
		private function hash(x : int, y : int, col : int = 10) : int
		{
			return (x * col + y);
		}

		/**
		 * 引用传值回去
		 * @param val
		 * @param a
		 * @param b
		 */
		private function id(val : int, a : int, b : int) : Array
		{
			a = int(val / MAPSIZEX);
			b = val % MAPSIZEX;
			return [a,b];
		}

		/**
		 * 并查集的初始化过程
		 */
		private function make() : void
		{
			father = new Array(MAPSIZEX * MAPSIZEY + 5);
			for (var i : int = 0;i < MAPSIZEY;i++)
			{
				for (var j : int = 0;j < MAPSIZEX;j++)
				{
					father[hash(i, j, MAPSIZEX)] = hash(i, j, MAPSIZEX);
				}
			}
		}

		/**
		 * 递归时采用了路径压缩
		 * @param x 节点x表示某个点的散列值
		 * @return 节点x的祖先
		 */
		private function findSet(x : int) : int
		{
			if (x != father[x])
			{
				father[x] = findSet(x);
			}
			return father[x];
		}

		/**
		 * 合并两个集合
		 * @param a
		 * @param b
		 */
		private function union(a : int, b : int) : void
		{
			father[a] = b;
		}

		private function build() : void
		{
			make();

			var sx : int,sy : int,ex : int,ey : int,a : int,b : int,i : int,j : int,temp : int,dire : int;
			var rs:Array;
			a = MAPSIZEX + 1;
			b = MAPSIZEX * (MAPSIZEY - 1) - 2;
			rs=id(a, sx, sy);
			sx=rs[0];
			sy=rs[1];
			
			rs=id(b, ex, ey);
			ex=rs[0];
			ey=rs[1];

			map = new Array();
			for (i = 0;i < MAPSIZEY ;i++)
			{
				map[i] = new Array();
				for (j = 0;j < MAPSIZEX ;j++) map[i][j] = 1;
			}

			map[sx][sy] = map[ex][ey] = 0;

			while (findSet(a) != findSet(b))
			{
				temp = AS_Util.getRandom(MAPSIZEX * MAPSIZEY + 1000) % (MAPSIZEX * MAPSIZEY);
				dire = AS_Util.getRandom(100) % 4;
				var tx : int,ty : int,ttx : int,tty : int;
				
				rs=id(temp, tx, ty);
				tx=rs[0];
				ty=rs[1];

				ttx = tx + DIRECTION[dire][0];
				tty = ty + DIRECTION[dire][1];

				if ((map[tx][ty] || map[ttx][tty]))
				{
					map[tx][ty] = (map[tx][ty] == 1 ? 0 : 0);
					map[ttx][tty] = (map[ttx][tty] == 1 ? 0 : 0);
					union(hash(tx, ty, MAPSIZEX), hash(ttx, tty, MAPSIZEX));
				}
			}
			
			
		}

		/**
		 * 构造迷宫图数据
		 */
		private function init_mazeMap() : void
		{
			var i : int,j : int;
			map = new Array();
			for (i = 0;i < 2 * MAPSIZEY + 3;i++)
			{
				map[i] = new Array();
				for (j = 0;j < 2 * MAPSIZEX + 3;j++) map[i][j] = 0;
			}
			make_maze(MAPSIZEY, MAPSIZEX);

			mark = map.slice();

			init_drawMaze();
		}

		/**
		 * 根据map数据 绘制出迷宫图
		 */
		private function init_drawMaze() : void
		{
			var i : int,j : int;
			var s : Shape;
			for (i = 0;i < 2 * MAPSIZEY + 3;i++)
			{
				for (j = 0;j < 2 * MAPSIZEX + 3;j++)
				{
					if (map[i][j])
					{
						s = drawBlack();
						s.x = j * 10;
						s.y = i * 10;
						this.addChild(s);
					}
				}
			}
		}

		/**
		 * 迷宫生成
		 * @param x
		 * @param y
		 * @private
		 */
		private function make_maze(x : int, y : int) : void
		{
			var i : int,j : int;

			for (i = 0,j = 2 * y + 2;i <= 2 * x + 2;i++)
			{
				map[i][0] = 1;
				map[i][j] = 1;
			}

			for (i = 0,j = 2 * x + 2;i <= 2 * y + 2;i++)
			{
				map[0][i] = 1;
				map[j][i] = 1;
			}

			map[1][2] = 1;
			map[2 * x + 1][2 * y] = 1;
			search(AS_Util.getRandom(1000) % x + 1, AS_Util.getRandom(1000) % y + 1);
		}

		/**
		 * 迷宫生成过程
		 * @param x
		 * @param y
		 * @private
		 */
		private function search(x : int = 0, y : int = 0) : void
		{
			var i : int,next : int,trun : int,zx : int,zy : int;
			zx = 2 * x;
			zy = 2 * y;
			map[zx][zy] = 1;
			trun = AS_Util.getRandom(1000) % 2 ? 1 : 3;

			for (i = 0,next = AS_Util.getRandom(1000) % 4;i < 4;i++,next = (next + trun) % 4)
			{
				if (map[zx + 2 * DIRECTION[next][0]][zy + 2 * DIRECTION[next][1]] == 0)
					map[zx + DIRECTION[next][0]][zy + DIRECTION[next][1]] = 1,
				search(x + DIRECTION[next][0], y + DIRECTION[next][1]);
			}
		}

		private function dfs() : void
		{
			// 存储路径信息
			pathStack = new AS_Stack();

			var point : Point = new Point();
			point.x = startPoint.x / 10;
			point.y = startPoint.y / 10;
			pathStack.push(point);

			// 下一个路点
			var next_row : int = 0;
			var next_col : int = 0;

			// 当前方向
			var dir : int = 0;

			// 当前位置
			var row : int = 0;
			var col : int = 0;

			// 是否达到终点
			var found : Boolean = false;

			while (pathStack.size() > 0 && !found)
			{
				point = pathStack.pop() as Point;
				row = point.y;
				col = point.x;

				// 4方向查找
				while (dir < 4 && !found)
				{
					next_row = row;
					next_col = col;
					// 顺时针查找
					switch(dir)
					{
						case 0:
							next_row--;
							break;
						case 1:
							// next_row--;
							next_col++;
							break;
						case 2:
							next_row++;
							break;
						case 3:
							// next_row++;
							next_col--;
							break;
						case 4:
							next_row++;
							break;
						case 5:
							next_row++;
							next_col--;
							break;
						case 6:
							next_col--;
							break;
						case 7:
							next_row--;
							next_col--;
							break;
					}

					// trace("mark[", next_row, ",", next_col, "]=", mark[next_row][next_col]);
					if (mark[next_row][next_col] == 3)
					{
						pathStack.push(new Point(next_col, next_row));
						found = true;
					}
					else
					{
						if (mark[next_row][next_col] == 0 || mark[next_row][next_col] == 2)
						{
							mark[row][col] = 1;
							point.y = next_row;
							point.x = next_col;
							pathStack.push(new Point(next_col, next_row));
							row = next_row;
							col = next_col;
							dir = 0;
							trace(point.toString());
						}
						else dir++;
					}
				}
				dir = 0;
			}

			if (found)
			{
				trace("找到出路", pathStack.size());
				finalStack = new AS_Stack();
				while (pathStack.size() > 0)
				{
					finalStack.push(pathStack.pop());
				}
				dirX = (finalStack.pep() as Point).x - startPoint.x / 10;
				dirY = (finalStack.pep() as Point).y - startPoint.y / 10;
				moveEnd = finalStack.pep() as Point;
				this.addEventListener(Event.ENTER_FRAME, moveBlack);
			}
			else
			{
				trace("没找到出路", pathStack.size());
			}
		}

		private function moveBlack(e : Event) : void
		{
			startPoint.x += dirX * speedX;
			startPoint.y += dirY * speedY;

			if (startPoint.x == endPoint.x && startPoint.y == endPoint.y && finalStack.size() == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, moveBlack);
				return ;
			}

			trace(startPoint.x, startPoint.y, moveEnd.x * 10, moveEnd.y * 10);
			if (startPoint.x == moveEnd.x * 10 && startPoint.y == moveEnd.y * 10)
			{
				moveEnd = finalStack.pop()as Point;
				dirX = moveEnd.x - startPoint.x / 10;
				dirY = moveEnd.y - startPoint.y / 10;
			}
		}

		/**
		 * 画方块
		 * @param w
		 * @param h
		 * @return
		 * @private
		 */
		private function drawBlack(c : uint = 0x000000, w : int = 10, h : int = 10) : Shape
		{
			var s : Shape = new Shape();
			s.graphics.beginFill(c);
			s.graphics.drawRect(0, 0, w, h);
			s.graphics.endFill();
			return s;
		}

		/**
		 * 画方块
		 * @param w
		 * @param h
		 * @return
		 * @private
		 */
		private function drawBlack2(c : uint = 0x000000, w : int = 10, h : int = 10) : Sprite
		{
			var s : Sprite = new Sprite();
			s.graphics.beginFill(c);
			s.graphics.drawRect(0, 0, w, h);
			s.graphics.endFill();
			return s;
		}
	}
}
