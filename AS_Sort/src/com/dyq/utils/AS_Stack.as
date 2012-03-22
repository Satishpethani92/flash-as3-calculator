package com.dyq.utils
{
	/**
	 * 栈结构
	 * @author dyq
	 * @see java.util.Steak.java
	 * @version 1.0.0
	 */
	public class AS_Stack extends Object
	{
		private var elemt:Vector.<Object>;
		
		public function AS_Stack()
		{
			elemt=new Vector.<Object>();
		}
		
		/**
		 * 入栈
		 * @param e
		 * @return e
		 */
		public function push(e:Object):Object
		{
			if(elemt==null)throw new Error("栈不存在");
			elemt.push(e);
			return e;
		}
		
		/**
		 * 返回栈顶元素 并删除栈顶元素
		 * @return
		 */
		public function pop():Object
		{
			var len:int=size();
			if(len==0)throw new Error("栈为空");
			return elemt.pop();
		}
		
		/**
		 * 返回栈顶元素 不删除栈顶元素
		 * @return 
		 */
		public function pep():Object
		{
			var len:int=size();
			if(len==0)throw new Error("栈为空");
			return elemt[len-1];
		}
		
		/**
		 * 判断栈是否为空 true:为空 false:不为空
		 * @return
		 */
		public function empty():Boolean
		{
			return elemt.length==0;
		}
		
		/**
		 * 搜索栈 从栈顶开始搜索 返回-1表示没找到
		 * @param o 搜索对象
		 * @return
		 */
		public function search(o:Object):int
		{
			if(o!=null)
			{
				for(var i:int=size()-1;i>=0;i--)
				{
					if(elemt[i]==o)return i;
				}
			}
			return -1;
		}
		
		public function size():int
		{
			if(elemt==null)throw new Error("栈不存在");
			return elemt.length;
		}
	}
}
