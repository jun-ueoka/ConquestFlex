package ConquestFlex.common.useful
{
	
	/**
	 * @author jun-ueoka
	 */
	public class FrameCnt
	{
		/** フレームカウンタ */
		public var cnt:int = 0;
		/** 最大フレーム */
		private var max:int = 1;
		/** 最大フレーム到達リピート回数 */
		private var repeat:int = 0;
		
		/**
		 * コンストラクタ
		 * @param	in_max
		 */
		public function FrameCnt(in_max:int):void
		{
			reset(in_max);
		}
		
		/**
		 * リセット
		 * @param	in_cnt
		 * @param	in_max
		 */
		public function reset(in_cnt:int = 0, in_max:int = -1):void
		{
			cnt = in_cnt;
			if (in_max > 0)
			{
				max = in_max;
			}
			repeat = 0;
		}
		
		/**
		 * フレーム更新
		 * @param	in_max_repeat
		 * @return
		 */
		public function cntFrame(in_max_repeat:int = -1):Boolean
		{
			if ((in_max_repeat < 0) || (in_max_repeat > repeat))
			{
				cnt++;
				if (cnt >= max)
				{
					repeat++;
					cnt = 0;
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 最大フレーム到達リピート回数 access
		 * @return
		 */
		public function getRepeat():int
		{
			return repeat;
		}
	}
}