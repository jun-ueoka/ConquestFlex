package ConquestFlex.common.event
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * @author jun-ueoka
	 */
	public class MouseEventController
	{
		/** マウスイベント管理キー */
		static private const EVENT_KEY:Vector.<String> = new Vector.<String>;
		/** マウスイベント管理リスト */
		static private const EVENT_LIST:Vector.<MouseEventController> = new Vector.<MouseEventController>;
		
		/** マウスイベントタイプ定数 */
		static public const MOUSE_EVENT_TYPE_CLICK:String		= MouseEvent.CLICK;
		static public const MOUSE_EVENT_TYPE_DOUBLE:String		= MouseEvent.DOUBLE_CLICK;
		static public const MOUSE_EVENT_TYPE_MOUSE_UP:String	= MouseEvent.MOUSE_UP;
		static public const MOUSE_EVENT_TYPE_MOUSE_DOWN:String	= MouseEvent.MOUSE_DOWN;
		
		/** イベント設定対象 */
		private var target_event:EventDispatcher = null;
		/** クリック状態 */
		private var on_click:Boolean = false;
		
		/**
		 * クリック状態の確認
		 * @return
		 */
		public function isOnClick():Boolean
		{
			return on_click;
		}
		
		/**
		 * インスタンス生成
		 * @param	in_key
		 * @param	in_event
		 * @return
		 */
		static public function createInstance(in_key:String, in_event:EventDispatcher = null):MouseEventController
		{
			var index:int = EVENT_KEY.indexOf(in_key);
			if (index < 0)
			{
				//初期生成時は対象イベント管理インスタンス必須
				if (in_event != null)
				{
					EVENT_KEY.push(in_key);
					EVENT_LIST.push(new MouseEventController(in_event));
				}
				else
				{
					throw new Error('No EventDispatcher MouseEventController:createInstance');
				}
			}
			return EVENT_LIST[EVENT_KEY.indexOf(in_key)];
		}
		
		/**
		 * コンストラクタ
		 * @param	in_event
		 */
		public function MouseEventController(in_event:EventDispatcher):void
		{
			target_event = in_event;
			target_event.addEventListener(Event.EXIT_FRAME, resetExitFrameHandler);
		}
		
		/**
		 * フレーム最後にマウス操作情報初期化
		 * @param	e
		 */
		private function resetExitFrameHandler(e:Event):void
		{
			if (on_click)
			{
				on_click = false;
			}
		}
		
		/**
		 * override関数	クリックイベント
		 * @param	me
		 */
		public function clickEventHandler(me:MouseEvent):void
		{
			on_click = true;
		}
		
		/**
		 * マウスイベント管理設定
		 * @param	in_mouse_event
		 */
		public function addMouseEvent(in_mouse_event:String):void
		{
			switch (in_mouse_event)
			{
				case MOUSE_EVENT_TYPE_CLICK: 
					target_event.addEventListener(in_mouse_event, clickEventHandler);
					break;
			}
		}
	}
}