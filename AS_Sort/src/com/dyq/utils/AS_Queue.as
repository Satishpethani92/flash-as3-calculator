package com.dyq.utils
{
	/**
	 * 队列结构
	 * @author duyouqian
	 * @see java.util.queue.java
	 * @version 1.0.0
	 * @since 2012-03-31 14:11
	 */
	public class AS_Queue
	{
		private var elemt : Vector.<Object>;

		public function AS_Queue()
		{
			elemt=new Vector.<Object>();
		}
		
		/**
		 * 入队
		 * @param e
		 * @return
		 */
		public function add(e:Object):Object
		{
			if(elemt==null)throw new Error("队列不存在");
			elemt.push(e);
			return e;
		}
		
		/**
		 * 返回队首元素 并删除队首元素
		 * @return
		 */
		public function remove():Object
		{
			var len:int=size();
			if(len==0)throw new Error("队列为空");
			return elemt.shift();
		}
		
		/**
		 * 返回队首元素 不删除队首元素
		 * @return 
		 */
		public function poll():Object
		{
			var len:int=size();
			if(len==0)throw new Error("栈为空");
			return elemt[0];
		}
		
		/**
		 * 判断队列是否为空 true:为空 false:不为空
		 * @return
		 */
		public function empty():Boolean
		{
			return elemt.length==0;
		}
		
		/**
		 * 搜索队列 从队首开始搜索 返回-1表示没找到
		 * @param o 搜索对象
		 * @return
		 */
		public function search(o:Object):int
		{
			if(o!=null)
			{
				for(var i:int=0;i>=0;i--)
				{
					if(elemt[i]==o)return i;
				}
			}
			return -1;
		}
		
		/**
		 * 队列的大小
		 * @return 
		 */
		public function size():int
		{
			if(elemt==null)throw new Error("队列不存在");
			return elemt.length;
		}

	}
}
