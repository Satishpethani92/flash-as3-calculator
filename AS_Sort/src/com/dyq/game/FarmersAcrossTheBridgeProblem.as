package com.dyq.game
{
	/**
	 * 农夫过桥问题
	 * 农夫带着自家的狼到菜市场买了菜和一只羊
	 * 现在要过一座桥回到自己的家中
	 * 回桥只能带一件东西
	 * 但是在农夫不在的情况下
	 * 狼会吃掉羊 羊会吃掉菜
	 * @author duyouqian
	 * @version 1.0.0
	 */
	public class FarmersAcrossTheBridgeProblem
	{
		//农夫,狼,羊,菜
		private var dp : Array;
		private var beforeDp:Array;
		public static const WOLF:int=0x000001;
		public static const SHEEP:int=0x000002;
		public static const VEGETABLES:int=0x000003;

		public function FarmersAcrossTheBridgeProblem()
		{			
			dp  = [true, true, true, true];
			beforeDp=[false,false,false,false];
		}
		
		/**
		 * 农夫离开桥
		 * @param goods 农夫携带的物品类型 -1表示不携带
		 * @return true:表现当前这边安全 false:表示当前这边不安全
		 */
		public function accrossBridgeByLeave(goods:int):Boolean
		{
			//农夫在桥这边
			if(dp[0])
			{
				//dp[0]=!dp[0];
				if(goods!=-1)dp[goods]=!dp[goods];
				if((dp[1] && dp[1]==dp[2]) || (dp[2] && dp[2]==dp[3]))return false;
				else return true;
			}
			//农夫在桥另外一边
			else if(beforeDp[0])
			{
				//beforeDp[0]=!beforeDp[0];
				if(goods!=-1)beforeDp[goods]=!beforeDp[goods];
				if((beforeDp[1] && beforeDp[1]==beforeDp[2]) || (beforeDp[2] && beforeDp[2]==beforeDp[3]))return false;
				else return true;
			}
			return false;
		}
		
		/**
		 * 农夫到达桥
		 * @param goods 农夫携带的物品类型 -1表示不携带
		 * @return
		 */
		public function accrossBridgeByArrive(goods:int):void
		{
			//农夫达到桥这边
			if(!dp[0])
			{
				dp[0]=!dp[0];
				beforeDp[0]=!beforeDp[0];
				if(goods!=-1)dp[goods]=!dp[goods];
			}
			//农夫到达桥另外一边
			else if(!beforeDp[0])
			{
				dp[0]=!dp[0];
				beforeDp[0]=!beforeDp[0];
				if(goods!=-1)beforeDp[goods]=!beforeDp[goods];
			}
		}
		
		/**
		 * 判断游戏是否已经结束 
		 * @return 
		 * 
		 */		
		public function getGameOver():Boolean
		{
			for(var i:int=0;i<beforeDp.length;i++)
			{
				if(!beforeDp[i])return false;
			}
			return true;
		}

	}
}
