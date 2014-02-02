package ConquestFlex.common.event
{
	import ConquestFlex.Debug;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * @author jun-ueoka
	 */
	public class KeyEventController
	{
		/** キーイベント管理キー */
		static private const EVENT_KEY:Vector.<String>				= new Vector.<String>;
		/** キーイベント管理リスト */
		static private const EVENT_LIST:Vector.<KeyEventController>	= new Vector.<KeyEventController>;
		
		/** チェックキー一覧 */
		static public const KEY_F1:uint		= Keyboard.F1;
		static public const KEY_F2:uint		= Keyboard.F2;
		static public const KEY_F3:uint		= Keyboard.F3;
		static public const KEY_F4:uint		= Keyboard.F4;
		static public const KEY_F5:uint		= Keyboard.F5;
		static public const KEY_F6:uint		= Keyboard.F6;
		static public const KEY_F7:uint		= Keyboard.F7;
		static public const KEY_F8:uint		= Keyboard.F8;
		static public const KEY_F9:uint		= Keyboard.F9;
		static public const KEY_F10:uint	= Keyboard.F10;
		static public const KEY_F11:uint	= Keyboard.F11;
		static public const KEY_F12:uint	= Keyboard.F12;
		
		/** イベント設定対象 */
		private var target_event:EventDispatcher		= null;
		/** キー押下判定リスト */
		private var check_key_code_list:Vector.<uint>	= new Vector.<uint>();
		private var check_key_list:Vector.<Boolean>		= new Vector.<Boolean>();
		
		/**
		 * クリック状態
		 * @param	in_check_key
		 * @return
		 */
		public function isCheckKey(in_check_key:uint):Boolean
		{
			var index:int = check_key_code_list.indexOf(in_check_key);
			return (index > -1 ? check_key_list[index] : false);
		}
		
		/**
		 * インスタンス生成
		 * @param	in_key
		 * @param	in_event
		 * @return
		 */
		static public function createInstance(in_key:String, in_event:EventDispatcher = null):KeyEventController
		{
			var index:int = EVENT_KEY.indexOf(in_key);
			if (index < 0)
			{
				//初期生成時は対象イベント管理インスタンス必須
				if (in_event != null)
				{
					EVENT_KEY.push(in_key);
					EVENT_LIST.push(new KeyEventController(in_event));
				}
				else
				{
					throw new Error('No EventDispatcher KeyEventController:createInstance');
				}
			}
			return EVENT_LIST[EVENT_KEY.indexOf(in_key)];
		}
		
		/**
		 * コンストラクタ
		 * @param	in_event
		 */
		public function KeyEventController(in_event:EventDispatcher):void
		{
			target_event = in_event;
			target_event.addEventListener(KeyboardEvent.KEY_DOWN, keyDownEventHandler);
			target_event.addEventListener(KeyboardEvent.KEY_UP, keyUpEventHandler);
			target_event.addEventListener(Event.DEACTIVATE, deactiveEventHandler);
		}
		
		/**
		 * キーダウンイベント
		 * @param	e
		 */
		private function keyDownEventHandler(e:KeyboardEvent):void
		{
			Debug.dTrace('KEY DOWN:' + e.keyCode);
			var index:int = check_key_code_list.indexOf(e.keyCode);
			if (index > -1)
			{
				check_key_list[index] = true;
			}
			else
			{
				check_key_code_list.push(e.keyCode);
				check_key_list.push(true);
			}
		}
		
		/**
		 * キーアップイベント
		 * @param	e
		 */
		private function keyUpEventHandler(e:KeyboardEvent):void
		{
			Debug.dTrace('KEY UP:' + e.keyCode);
			var index:int = check_key_code_list.indexOf(e.keyCode);
			if (index > -1)
			{
				check_key_list[index] = false;
			}
			else
			{
				check_key_code_list.push(e.keyCode);
				check_key_list.push(false);
			}
		}
		
		/**
		 * 非アクティブイベント(Flashが非アクティブになったら押下状態をリセットする)
		 * @param	e
		 */
		private function deactiveEventHandler(e:Event):void
		{
			for (var key:String in check_key_list)
			{
				check_key_list[key] = false;
			}
		}
	}
}