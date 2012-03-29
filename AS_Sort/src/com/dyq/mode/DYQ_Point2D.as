package com.dyq.mode
{
	/**
	 * 二维图形的点坐标类
	 * @author duyouqian
	 * @version 1.0.0
	 * @since 2012-03-29 10:22
	 */
	public class DYQ_Point2D
	{
		private var _x:Number;
		private var _y : Number;

		public function DYQ_Point2D(x:Number=0,y:Number=0)
		{
			this._x=x;
			this._y=y;
		}
		
		public function setX(x:Number):void
		{
			this._x=x;
		}
		
		public function setY(y:Number):void
		{
			this._y=y;
		}
		
		public function getX():Number
		{
			return this._x;
		}
		
		public function getY():Number
		{
			return this._y;
		}

	}
}
