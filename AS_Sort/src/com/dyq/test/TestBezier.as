package com.dyq.test
{
	import com.dyq.utils.AS_Util;
	import com.dyq.utils.AS_Math;
	import org.aswing.JLabel;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.JButton;
	import com.dyq.utils.AS_Bezier;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.events.Event;
	import com.dyq.mode.DYQ_Point2D;
	import flash.display.Sprite;

	/**
	 * 贝塞尔曲线测试
	 * @author duyouqian
	 * @version1.0.0
	 * @since 2012-03-29 13:05
	 */
	public class TestBezier extends Sprite
	{
		private static const NUMBEROFPOINT:int=100;
		private static const STEP:Number=100;
		private var cp:Vector.<DYQ_Point2D>;
		private var cure:Vector.<DYQ_Point2D>;
		private var tempPoint:DYQ_Point2D;
		private var index:int=0;
		private var scale:Number=1;
		
		
		private var startPoint:Sprite;
		private var inflectionPoint_1:Sprite;
		private var inflectionPoint_2:Sprite;
		private var endPoint:Sprite;
		
		private var btn_start:JButton;
		private var btn_zoom:JButton;
		private var lab_tag:JLabel;
		
		//private var timer:Timer;
				
		public function TestBezier()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e : Event = null) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			cp=new Vector.<DYQ_Point2D>();
			cure=new Vector.<DYQ_Point2D>();
			tempPoint=new DYQ_Point2D();
			
			startPoint=createShape("起点",100,200);
			startPoint.name="startPoint";
			addChild(startPoint);
			cp.push(new DYQ_Point2D(startPoint.x, startPoint.y));
			
			inflectionPoint_1=createShape("拐点_1",50,100);
			inflectionPoint_1.name="inflectionPoint_1";
			addChild(inflectionPoint_1);
			cp.push(new DYQ_Point2D(inflectionPoint_1.x, inflectionPoint_1.y));
			
			inflectionPoint_2=createShape("拐点_2",150,50);
			inflectionPoint_2.name="inflectionPoint_2";
			addChild(inflectionPoint_2);
			cp.push(new DYQ_Point2D(inflectionPoint_2.x, inflectionPoint_2.y));
			
			endPoint=createShape("终点",400,300);
			endPoint.name="endPoint";
			addChild(endPoint);
			cp.push(new DYQ_Point2D(endPoint.x, endPoint.y));
			
			btn_start=new JButton("开始");
			btn_start.name="btn_start";
			btn_start.setLocation(new IntPoint(0,0));
			btn_start.setSize(new IntDimension(60,30));
			addChild(btn_start);
			
			btn_zoom=new JButton("缩放");
			btn_zoom.name="btn_zoom";
			btn_zoom.setLocation(new IntPoint(65,0));
			btn_zoom.setSize(new IntDimension(60,30));
			addChild(btn_zoom);
			
			lab_tag=new JLabel();
			lab_tag.setLocation(new IntPoint(0,35));
			lab_tag.setSize(new IntDimension(150,30));
			addChild(lab_tag);
			
			//timer=new Timer(500);
			//timer.addEventListener(TimerEvent.TIMER, timerHandler);
						
			this.addEventListener(MouseEvent.MOUSE_DOWN, onStartPointDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onStartPoint);
			btn_start.addEventListener(MouseEvent.CLICK, onClick);
			btn_zoom.addEventListener(MouseEvent.CLICK, onClick2);
			
			cure.splice(0, cure.length);
			AS_Bezier.cubicBezier(cp, NUMBEROFPOINT, cure);
			drawPoint(cure);			
		}
		
		/**
		 * @param x
		 * @param y
		 * @param w
		 * @param h
		 * @return
		 */
		private function createShape(title:String,x:int,y:int,w:int=20,h:int=20):Sprite
		{
			var s:Sprite=new Sprite();
			s.x=x;
			s.y=y;
			s.graphics.beginFill(0xff0000);
			s.graphics.drawRect(0, 0, w, h);
			var t:TextField=new TextField();
			var tf:TextFormat=new TextFormat();
			tf.size=10;
			t.selectable=false;
			t.width=s.width;
			t.height=s.height;
			t.text=title;
			t.y=s.height;
			t.setTextFormat(tf);
			s.addChild(t);
			return s;
		}
		
		/**
		 * @param c
		 */
		private function drawPoint(c:Vector.<DYQ_Point2D>):void
		{
			graphics.clear();
			graphics.lineStyle(1,0x00ff00);
			graphics.moveTo(c[0].getX(), c[0].getY());
			for(var i:int=1;i<NUMBEROFPOINT;i++)
			{
				graphics.lineTo(c[i].getX(), c[i].getY());
			}
		}
		
		private function drawPointByPoint(c:DYQ_Point2D):void
		{
			graphics.lineTo(c.getX(), c.getY());
		}
		
		private function onStartPointDown(e:MouseEvent):void
		{
//			startPoint.startDrag();
			switch(e.target.name)
			{
				case "startPoint":
					startPoint.startDrag();
					break;
				case "inflectionPoint_1":
					inflectionPoint_1.startDrag();
					break;
				case "inflectionPoint_2":
					inflectionPoint_2.startDrag();
					break;
				case "endPoint":
					endPoint.startDrag();
					break;
			}
		}
		
		private function onStartPoint(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "startPoint":
					startPoint.stopDrag();
					cp[0].setX(startPoint.x);
					cp[0].setY(startPoint.y);
					trace(startPoint.x,startPoint.y);
					break;
				case "inflectionPoint_1":
					inflectionPoint_1.stopDrag();
					cp[1].setX(inflectionPoint_1.x);
					cp[1].setY(inflectionPoint_1.y);
					trace(inflectionPoint_1.x,inflectionPoint_1.y);
					break;
				case "inflectionPoint_2":
					inflectionPoint_2.stopDrag();
					cp[2].setX(inflectionPoint_2.x);
					cp[2].setY(inflectionPoint_2.y);
					trace(inflectionPoint_2.x,inflectionPoint_2.y);
					break;
				case "endPoint":
					endPoint.stopDrag();
					cp[3].setX(endPoint.x);
					cp[3].setY(endPoint.y);
					trace(endPoint.x,endPoint.y);
					break;
			}
			cure.splice(0, cure.length);
			AS_Bezier.cubicBezier(cp, NUMBEROFPOINT, cure);
			drawPoint(cure);
		}
		
		private function onClick(e:MouseEvent):void
		{
			graphics.clear();
			graphics.lineStyle(1,0x00ff00);			
			tempPoint=AS_Bezier.PointOnCubicBezier(cp, index/STEP);
			graphics.moveTo(tempPoint.getX(), tempPoint.getY());
			//timer.start();
			this.addEventListener(Event.ENTER_FRAME, timerHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onStartPointDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onStartPoint);
			btn_start.setEnabled(false);
		}
		
		private function onClick2(e:MouseEvent):void
		{
			graphics.clear();
			graphics.lineStyle(1,0x00ff00);	
			var a1:Array=[
			[1.5,0,0],
			[0,1.5,0],
			[0,0,1]
			];
			var b1:Array=[
			cp[1].getX(),cp[1].getY(),1
			];
			var c1:Array=new Array();
			c1=AS_Math.matrixMultiplication(b1, a1);
			AS_Util.printf(c1);
			cp[1].setX(c1[0][0]);	
			cp[1].setY(c1[1][0]);	
			var a2:Array=[
			[1.5,0,0],
			[0,1.5,0],
			[0,0,1]
			];
			var b2:Array=[
			cp[2].getX(),cp[2].getY(),1
			];
			var c2:Array=new Array();
			c2=AS_Math.matrixMultiplication(b2, a2);
			AS_Util.printf(c2);
			cp[2].setX(c2[0][0]);	
			cp[2].setY(c2[1][0]);	
			tempPoint=AS_Bezier.PointOnCubicBezier(cp, index/STEP,scale);
			graphics.moveTo(tempPoint.getX(), tempPoint.getY());
			//timer.start();
			this.addEventListener(Event.ENTER_FRAME, timerHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onStartPointDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onStartPoint);
			btn_start.setEnabled(false);
		}
		
		private function timerHandler(e:Event):void
		{
			index++;
			if(index>=STEP)
			{
				//timer.stop();
				index=STEP;
				lab_tag.setText("t:"+index/STEP);
				tempPoint=AS_Bezier.PointOnCubicBezier(cp, index/STEP,scale);
				drawPointByPoint(tempPoint);
				index=0;
				this.removeEventListener(Event.ENTER_FRAME, timerHandler);
				this.addEventListener(MouseEvent.MOUSE_DOWN, onStartPointDown);
				this.addEventListener(MouseEvent.MOUSE_UP, onStartPoint);
				btn_start.setEnabled(true);
				return ;
			}
			lab_tag.setText("t:"+index/STEP);
			tempPoint=AS_Bezier.PointOnCubicBezier(cp, index/STEP,scale);
			drawPointByPoint(tempPoint);
		}
	}
}
