package ConquestFlex.connect.loader
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import ConquestFlex.Debug;
	
	/**
	 * @author jun-ueoka
	 */
	public class HttpConnectionLoader
	{
		
		//状態フラグ
		static public const STATUS_INIT:int = 0; //待機
		static public const STATUS_CONNECTING:int = 1; //通信中
		static public const STATUS_COMPLETE:int = 2; //通信終了
		
		//エラーフラグ
		static public const ERROR_NOCHECK:int = -1; //チェック無し
		static public const ERROR_NONE:int = 0; //エラー無し
		static public const ERROR_NORMAL:int = 1; //通信エラー
		static public const ERROR_SECURITY:int = 2; //セキュリティエラー
		
		//通信タイプフラグ
		static public const METHOD_GET:String = URLRequestMethod.GET; //GET通信
		static public const METHOD_POST:String = URLRequestMethod.POST; //POST通信
		
		//URLリクエスト
		protected var request:URLRequest = null;
		//再試行回数
		protected var max_retry_count:int = 0;
		//再試行実行回数
		protected var retry_count:int = 0;
		
		//エラーコード
		protected var error:int = ERROR_NOCHECK;
		//エラーチェック有効・無効
		protected var b_error_check:Boolean = true;
		//状態
		protected var status:int = STATUS_INIT;
		
		//受信データ合計
		protected var bytes_total:int = 0;
		//受信済みデータ量
		protected var bytes_loaded:int = 0;
		//エラー文字列
		protected var text_error:String = '';
		
		//URLリクエスト生成
		public static function createUrlRequest(in_url:String, in_param:ByteArray = null, in_method:String = "POST"):URLRequest
		{
			var new_request:URLRequest = new URLRequest(in_url);
			new_request.data = in_param;
			new_request.method = in_method;
			return new_request;
		}
		
		//コンストラクタ
		public function HttpConnectionLoader():void
		{
		}
		
		//override関数　リスナー追加実行
		protected function addEventListeners():void
		{
			throw new Error('Unimplemented ' + this + '.addEventListeners');
		}
		
		//override関数　リスナー破棄実行
		protected function removeEventListeners():void
		{
			throw new Error('Unimplemented ' + this + '.removeEventListeners');
		}
		
		//読み込み開始
		public function loadStart(in_url:String = null, in_retry_count:int = 0, in_param:ByteArray = null, in_method:String = "POST"):void
		{
			if (in_url != null)
			{
				initialize(in_url, in_retry_count, in_param, in_method);
			}
			load();
		}
		
		//初期化
		public function initialize(in_url:String, in_retry_count:int = 0, in_param:ByteArray = null, in_method:String = "POST"):void
		{
			request = createUrlRequest(in_url, in_param, in_method);
			retry_count = 0;
			max_retry_count = in_retry_count;
		}
		
		//読み込み開始時イベントハンドラー
		protected function connectOpenHandler(e:Event):void
		{
			Debug.dTrace("OPEN:" + request.url + ":" + e.target);
		}
		
		//読み込み中イベントハンドラー
		protected function connectProgressHandler(e:ProgressEvent):void
		{
			Debug.dTrace("PROGRESS:" + request.url + ":" + e.bytesLoaded + " / " + e.bytesTotal);
			bytes_loaded = e.bytesLoaded;
			bytes_total = e.bytesTotal;
		}
		
		public function getLoadRate():int
		{
			return bytes_loaded / bytes_total;
		}
		
		//読み込みステータスイベントハンドラー
		protected function connectHttpStatusHandler(e:HTTPStatusEvent):void
		{
			Debug.dTrace("HTTP_STATUS:" + e.status);
		}
		
		//読み込みアクティブ時イベントハンドラー
		protected function connectActivateHandler(e:Event):void
		{
			Debug.dTrace("ACTIVATE:" + e.target);
		}
		
		//読み込み非アクティブ時イベントハンドラー
		protected function connectDeactivateHandler(e:Event):void
		{
			Debug.dTrace("DEACTIVATE:" + e.target);
		}
		
		//読み込み完了イベントハンドラー
		protected function connectCompleteHandler(e:Event):void
		{
			Debug.dTrace("COMPLETE:" + request.url + ":" + e.target);
			complete(ERROR_NONE);
		}
		
		//読み込みエラーイベントハンドラー
		protected function connectIOErrorHandler(e:IOErrorEvent):void
		{
			//再読み込み実行
			if (retry_count < max_retry_count)
			{
				retry_count++
				retry();
				return;
			}
			
			text_error = "IOERROR:" + request.url + ":" + e.target;
			Debug.dTrace(text_error);
			if (b_error_check)
			{
				complete(ERROR_NORMAL);
			}
			else
			{
				complete(ERROR_NONE);
			}
		}
		
		//読み込みセキュリティエラーイベントハンドラー
		protected function connectSecurityErrorHandler(e:SecurityErrorEvent):void
		{
			Debug.dTrace("ERROR_SECURITY:" + request.url + ":" + e.target);
			complete(ERROR_SECURITY);
		}
		
		//読み込み終了ステータス変更
		private function complete(in_error:int):void
		{
			status = STATUS_COMPLETE;
			error = in_error;
			finish();
		}
		
		//読み込み終了確認
		public function isComplete():Boolean
		{
			if (status == STATUS_COMPLETE)
			{
				return true;
			}
			return false;
		}
		
		//エラー取得
		public function getError():int
		{
			return error;
		}
		
		//エラーテキスト取得
		public function getErrorText():String
		{
			return text_error;
		}
		
		//override関数　読み込み開始処理
		protected function load():void
		{
			throw new Error('Unimplemented ' + this + '.load');
		}
		
		//override関数　読み込み切断処理
		protected function close():void
		{
			throw new Error('Unimplemented ' + this + '.close');
		}
		
		//override関数　読み込み終了後処理
		protected function finish():void
		{
			throw new Error('Unimplemented ' + this + '.finish');
		}
		
		//override関数　読み込み再開処理
		protected function retry():void
		{
			throw new Error('Unimplemented ' + this + '.retry');
		}
		
		//override関数　読み込み再開処理
		public function getData():Object
		{
			throw new Error('Unimplemented ' + this + '.getData');
		}
	}
}