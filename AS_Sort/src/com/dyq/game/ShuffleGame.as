package com.dyq.game
{
	import com.dyq.utils.AS_Util;
	/**
	 * 洗牌游戏
	 * @author duyouqian
	 * @version 1.0.0
	 */
	public class ShuffleGame
	{
		private var card : Array;
		private static const RANDNUM:int=51;
		private static const SHUFFLENUM:int=100;

		public function ShuffleGame()
		{
			card=new Array();
			for(var i:int=0;i<52;i++)
			{
				card.push(i%13+1);
			}
		}
		
		/**
		 * 开始游戏
		 * @return
		 */
		public function startGame():void
		{
			var ran1:int;
			var ran2:int;
			var ran3:int;
			var tempCardNum:int;
			var i:int;
			//洗牌
			for(i=0;i<ShuffleGame.SHUFFLENUM;i++)
			{
				ran1=AS_Util.getRandom(RANDNUM);
				ran2=AS_Util.getRandom(RANDNUM);
				AS_Util.exch(card, ran1, ran2);
			}
			//观众随机取出一张牌放在第一张
			ran1=AS_Util.getRandom(RANDNUM);
			
			CONFIG::debug{
				trace("牌面:",card[ran1]);
			}
			AS_Util.exch(card, ran1, 0);
			tempCardNum=card[0];
			
			//第二次洗牌 最上面的牌不动
			for(i=0;i<ShuffleGame.SHUFFLENUM;i++)
			{
				ran1=AS_Util.getRandom(RANDNUM-1)+1;
				ran2=AS_Util.getRandom(RANDNUM-1)+1;
				AS_Util.exch(card, ran1, ran2);
			}
			
			//观众说出的一个数
			ran3=AS_Util.getRandom(RANDNUM);
			CONFIG::debug{
				trace("观众说的数:",ran3);
				AS_Util.printfByIndex(card, 0, ran3-1);
			}
			//发现第十张牌不是刚才那张牌
			if(card[0]!=card[ran3-1])
			{
				//洗牌 前面ran3-1张不动
				for(i=0;i<ShuffleGame.SHUFFLENUM;i++)
				{
					ran1=AS_Util.getRandom(RANDNUM-ran3)+ran3;
					ran2=AS_Util.getRandom(RANDNUM-ran3)+ran3;
					AS_Util.exch(card, ran1, ran2);
				}
				AS_Util.batchExch(card, 0, ran3-2);
				CONFIG::debug{
					AS_Util.printfByIndex(card, 0, ran3-1);
				}
				//把刚才那张牌插入前面ran3张中
				ran1=AS_Util.getRandom(ran3-2);
				AS_Util.insertIndex(card, ran1, ran3-1);
			}
			CONFIG::debug{
				AS_Util.printfByIndex(card, 0, ran3-1);
			}
		}

	}
}
