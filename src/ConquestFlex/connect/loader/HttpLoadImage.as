package ConquestFlex.connect.loader
{
	import ConquestFlex.Debug;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 * @author jun-ueoka
	 */
	public class HttpLoadImage extends HttpConnectionLoader
	{
		/* URLローダー */
		private var img_loader:Loader	= null;
		/* イベント登録確認 */
		private var event_on:Boolean	= false;
		
		/**
		 * コンストラクタ
		 */
		public function HttpLoadImage():void
		{
			super();
			super.b_error_check = false; //TODO 画像が読み込めて無くても空画像で続行
		}
		
		/**
		 * override関数　読み込み開始処理
		 */
		override protected function load():void
		{
			img_loader = new Loader();
			
			addEventListeners();
			
			Debug.dTrace("IMAGE LOAD:" + request.url);
			img_loader.load(request);
		}
		
		/**
		 * override関数　読み込み再開処理
		 */
		override protected function retry():void
		{
			removeEventListeners();
			
			img_loader = new Loader();
			
			addEventListeners();
			
			Debug.dTrace("IMAGE RETRY:" + request.url);
			img_loader.load(request);
		}
		
		/**
		 * override関数　読み込み切断処理
		 */
		override protected function close():void
		{
			img_loader.close();
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
			if (img_loader.content)
			{
				return (img_loader.content as Bitmap)
			}
			else
			{
				return new Bitmap();
			}
		}
		
		/**
		 * override関数　リスナー追加実行
		 */
		override protected function addEventListeners():void
		{
			if (!event_on)
			{
				img_loader.contentLoaderInfo.addEventListener(Event.OPEN, connectOpenHandler, false, 0, true);
				img_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, connectProgressHandler, false, 0, true);
				img_loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, connectHttpStatusHandler, false, 0, true);
				img_loader.contentLoaderInfo.addEventListener(Event.ACTIVATE, connectActivateHandler, false, 0, true);
				img_loader.contentLoaderInfo.addEventListener(Event.DEACTIVATE, connectDeactivateHandler, false, 0, true);
				img_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, connectCompleteHandler, false, 0, true);
				img_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, connectIOErrorHandler, false, 0, true);
				
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
				img_loader.contentLoaderInfo.removeEventListener(Event.OPEN, connectOpenHandler);
				img_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, connectProgressHandler);
				img_loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, connectHttpStatusHandler);
				img_loader.contentLoaderInfo.removeEventListener(Event.ACTIVATE, connectActivateHandler);
				img_loader.contentLoaderInfo.removeEventListener(Event.DEACTIVATE, connectDeactivateHandler);
				img_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, connectCompleteHandler);
				img_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, connectIOErrorHandler);
				
				event_on = false;
			}
		}
	}
}