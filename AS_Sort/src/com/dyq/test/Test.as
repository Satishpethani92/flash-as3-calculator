package com.dyq.test
{
	import com.dyq.utils.AS_Bezier;
	import com.dyq.mode.DYQ_Point2D;
	import com.dyq.utils.AS_Math;
	import com.dyq.game.ShuffleGame;
	import flash.utils.getTimer;
	import com.dyq.utils.AS_Stack;
	import com.dyq.utils.AS_Util;
	import com.dyq.utils.AS_Sort;

	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author dyq
	 */
	public class Test extends Sprite
	{
		private static const TOTAL : int = 10000;
		private static const RANDOMVALUE : int = 500;
		private static const NUMBEROFPOINT:int=1000;
		private var sort_tag : Array;
		private var cp:Vector.<DYQ_Point2D>;
		private var cure:Vector.<DYQ_Point2D>;

		public function Test()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e : Event = null) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			sort_tag = new Array();
			initSort();
			cp=new Vector.<DYQ_Point2D>();
			cure=new Vector.<DYQ_Point2D>();
			for(var i:int=0;i<TOTAL;i++)
			{
				cp.push(new DYQ_Point2D(AS_Util.getRandom(RANDOMVALUE), AS_Util.getRandom(RANDOMVALUE)));
			}
			AS_Bezier.cubicBezier(cp, NUMBEROFPOINT, cure);
			drawImg(cure);
		}

		/**
		 * 产生一个要排序的数组(随机)
		 */
		private function initSort() : void
		{
			var stack:AS_Stack=new AS_Stack();
			var i : int;
			var temp:int;
			for ( i = 0;i < TOTAL;i++)
			{
				temp=AS_Util.getRandom(RANDOMVALUE);
				sort_tag.push(temp);
				stack.push(temp);
			}
			
			CONFIG::debug
			{
				trace("原始数据:");
				AS_Util.printf(sort_tag);
				// 选择排序
				trace("选择排序:");
				var temparr:Array;
				var time:Number=getTimer();
				temparr=AS_Sort.Selection_Sort(sort_tag, 0, sort_tag.length - 1);
				var time2:Number=getTimer();
				trace("选择排序耗时:",time2-time);
				//AS_Util.printf(temparr);
				temparr=null;
				// 堆排序
				trace("堆排序:");
				time=getTimer();
				temparr=AS_Sort.Heap_Sort(sort_tag);
				time2=getTimer();
				trace("堆排序耗时:",time2-time);
				//AS_Util.printf(temparr);
				//栈的应用
				trace("栈的应用:");
				var str:String="";
				for(i=0;i<TOTAL;i++)
				{
					str+=stack.pop()+" ";
				}
				//trace(str);
				AS_Util.insertIndex(sort_tag, 4, 1);
				//AS_Util.printf(sort_tag);
				var card:ShuffleGame=new ShuffleGame();
				card.startGame();
				trace(AS_Math.pow(2, 65));
				trace(AS_Math.pow(2, 64));				
				for(i=1;i<11;i++)
				{
					trace(AS_Math.fibonacci(i));
				}
				
				trace(AS_Math.isPrime(1));
				trace(AS_Math.isPrime(2));
				trace(AS_Math.isPrime(20));
				
			}
		}	
			
		private function drawImg(c:Vector.<DYQ_Point2D>):void
		{
			trace(c.length);
			addChild(createShape(100,200));
			graphics.lineStyle(1,0x00ff00);
			graphics.moveTo(c[0].getX(), c[0].getY());
			for(var i:int=1;i<NUMBEROFPOINT;i++)
			{
				graphics.lineTo(c[i].getX(), c[i].getY());
			}
		}
		
		private function createShape(x:int,y:int,w:int=40,h:int=40):Sprite
		{
			var s:Sprite=new Sprite();
			s.x=x;
			s.y=y;
//			s.width=w;
//			s.height=h;
			s.graphics.beginFill(0xff0000);
			s.graphics.drawRect(0, 0, w, h);
			return s;
		}
	}
}
