package com.dyq.utils
{
	import com.dyq.mode.DYQ_Point2D;
	/**
	 * 贝塞尔曲线生成算法
	 * mathbf{B}(t)=sum_{i=0}^n {nchoose i}mathbf{P}_i(1-t)^{n-i}t^i =mathbf{P}_0(1-t)^n+{nchoose 1}mathbf{P}_1(1-t)^{n-1}t+cdots+mathbf{P}_nt^n mbox{ , } t in [0,1]
	 * @author duyouqian
	 * @version 1.0.0
	 * @since 2012-03-29 10:23
	 */
	public class AS_Bezier
	{
		/**
		 * 三次贝塞尔曲线
		 * @param cp 关键点集合
		 * @param lenPoint 总共有多少点
		 * @param cure 点的集合
		 */
		public static function cubicBezier(cp:Vector.<DYQ_Point2D>,lenPoint:int,cure:Vector.<DYQ_Point2D>):void
		{
			var dt:Number=1.0/(lenPoint-1);
			
			for(var i:int=0;i<lenPoint;i++)cure.push(PointOnCubicBezier(cp, dt*i));
		}
		/**
		 * 三次贝塞尔曲线
		 * mathbf{B}(t)=mathbf{P}_0(1-t)^3+3mathbf{P}_1t(1-t)^2+3mathbf{P}_2t^2(1-t)+mathbf{P}_3t^3 mbox{ , } t in [0,1]
		 * @param cp cp 在此是四个元素的阵列:
		 * cp[0] 为起始点
		 * cp[1] 为第一个控制点
		 * cp[2] 为第二个控制点
		 * cp[3] 为结束点
		 * @param t t为参数值,0 <= t <= 1
		 * @return
		 */
		public static function PointOnCubicBezier(cp:Vector.<DYQ_Point2D>,t:Number,scale:Number=1):DYQ_Point2D
		{
			var ax:Number,bx:Number,cx:Number;
			var ay:Number,by:Number,cy:Number;
			var result:DYQ_Point2D=new DYQ_Point2D();
			var tSquared:Number,tCubed:Number;
			
			cx=3.0*(cp[1].getX()-cp[0].getX());
			bx=3.0*(cp[2].getX()-cp[1].getX())-cx;
			ax=cp[3].getX()-bx-cx-cp[0].getX();
			
			cy=3.0*(cp[1].getY()-cp[0].getY());
			by=3.0*(cp[2].getY()-cp[1].getY())-cy;
			ay=cp[3].getY()-by-cy-cp[0].getY();
			
			tSquared=t*t;
			tCubed=tSquared*t;
			
			result.setX((tCubed*ax+tSquared*bx+t*cx+cp[0].getX())*scale);
			result.setY((tCubed*ay+tSquared*by+t*cy+cp[0].getY())*scale);
			
			return result;
		}
	}
}
