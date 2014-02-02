package ConquestFlex
{
	/**
	 * @author jun-ueoka
	 */
	public class Debug
	{
		/* デバッグON/OFF */
		public static var on:Boolean = true;
		
		/**
		 * trace出力
		 * @param	in_obj
		 */
		public static function dTrace(in_obj:Object):void
		{
			if (on)
			{
				trace(in_obj);
			}
		}
		
		/**
		 * error出力
		 * @param	in_obj
		 */
		public static function dError(in_obj:Object):void
		{
			if (on)
			{
				throw new Error(in_obj);
			}
		}
	}

}