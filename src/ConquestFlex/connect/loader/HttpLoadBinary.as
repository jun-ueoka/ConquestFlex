package ConquestFlex.connect.loader
{
	import ConquestFlex.Debug;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	/**
	 * @author jun-ueoka
	 */
	public class HttpLoadBinary extends HttpConnectionLoader
	{
		/* URLローダー */
		private var url_loader:URLLoader	= null;
		/* イベント登録確認 */
		private var event_on:Boolean		= false;
		
		/**
		 * コンストラクタ
		 */
		public function HttpLoadBinary():void
		{
			super();
		}
		
		/**
		 * override関数　読み込み開始処理
		 */
		override protected function load():void
		{
			url_loader = new URLLoader();
			url_loader.dataFormat = URLLoaderDataFormat.BINARY;
			
			addEventListeners();
			
			Debug.dTrace("BINARY LOAD:" + request.url);
			url_loader.load(request);
		}
		
		/**
		 * override関数　読み込み再開処理
		 */
		override protected function retry():void
		{
			removeEventListeners();
			
			url_loader = new URLLoader();
			url_loader.dataFormat = URLLoaderDataFormat.BINARY;
			
			addEventListeners();
			
			Debug.dTrace("BINARY RETRY:" + request.url);
			url_loader.load(request);
		}
		
		/**
		 * override関数　読み込み切断処理
		 */
		override protected function close():void
		{
			url_loader.close();
			removeEventListeners();
		}
		
		/**
		 * override関数　読み込み終了後処理
		 */
		override protected function finish():void
		{
			removeEventListeners();
		}
		
		/**
		 * override関数　読み込み再開処理
		 * @return
		 */
		override public function getData():Object
		{
			return (url_loader.data as ByteArray)
		}
		
		/**
		 * override関数　リスナー追加実行
		 */
		override protected function addEventListeners():void
		{
			if (!event_on)
			{
				url_loader.addEventListener(Event.OPEN, connectOpenHandler, false, 0, true);
				url_loader.addEventListener(ProgressEvent.PROGRESS, connectProgressHandler, false, 0, true);
				url_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, connectHttpStatusHandler, false, 0, true);
				url_loader.addEventListener(Event.ACTIVATE, connectActivateHandler, false, 0, true);
				url_loader.addEventListener(Event.DEACTIVATE, connectDeactivateHandler, false, 0, true);
				url_loader.addEventListener(Event.COMPLETE, connectCompleteHandler, false, 0, true);
				url_loader.addEventListener(IOErrorEvent.IO_ERROR, connectIOErrorHandler, false, 0, true);
				url_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, connectSecurityErrorHandler, false, 0, true);
				
				event_on = true;
			}
		}
		
		/**
		 * override関数　リスナー破棄実行
		 */
		override protected function removeEventListeners():void
		{
			if (event_on)
			{
				url_loader.removeEventListener(Event.OPEN, connectOpenHandler);
				url_loader.removeEventListener(ProgressEvent.PROGRESS, connectProgressHandler);
				url_loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, connectHttpStatusHandler);
				url_loader.removeEventListener(Event.ACTIVATE, connectActivateHandler);
				url_loader.removeEventListener(Event.DEACTIVATE, connectDeactivateHandler);
				url_loader.removeEventListener(Event.COMPLETE, connectCompleteHandler);
				url_loader.removeEventListener(IOErrorEvent.IO_ERROR, connectIOErrorHandler);
				url_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, connectSecurityErrorHandler);
				
				event_on = false;
			}
		}
	}
}