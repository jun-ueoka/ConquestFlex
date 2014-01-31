package Application
{
	import adobe.utils.CustomActions;
	
	/**
	 * @author
	 */
	public class ApplicationData
	{
		/** 共通インスタンス */
		static private var instance:ApplicationData = null;
		
		/** マウスイベント共通キー */
		static public const MOUSE_EVENT_KEY_MAIN:String = 'main';
		
		/**
		 * インスタンス生成
		 * @return
		 */
		static public function createInstance():ApplicationData
		{
			if (instance == null)
			{
				instance = new ApplicationData();
			}
			return instance;
		}
		
		/**
		 * コンストラクタ
		 */
		public function ApplicationData():void
		{
		
		}
	}
}

