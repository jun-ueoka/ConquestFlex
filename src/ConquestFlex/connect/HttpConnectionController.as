package ConquestFlex.connect
{
	import flash.utils.ByteArray;
	import ConquestFlex.connect.loader.HttpConnectionLoader;
	import ConquestFlex.connect.loader.HttpLoadBinary;
	import ConquestFlex.connect.loader.HttpLoadImage;
	
	/**
	 * @author jun-ueoka
	 */
	public class HttpConnectionController
	{
		//ローダー識別フラグ
		public static const LOAD_BINARY:int = 1; //バイナリ(テキスト)読み込み
		public static const LOAD_IMAGE:int = 2; //画像読み込み
		public static const LOAD_SOUND:int = 3; //音源読み込み
		
		//インスタンス
		private static var instance:HttpConnectionController = null;
		
		//通信識別子
		private static var request_key:Vector.<String> = new Vector.<String>;
		//通信インスタンス
		private static var request_loader:Vector.<HttpConnectionLoader> = new Vector.<HttpConnectionLoader>;
		
		//バイナリ読み込み識別子
		private static var request_key_binary:Vector.<String> = new Vector.<String>;
		//画像読み込み識別子
		private static var request_key_image:Vector.<String> = new Vector.<String>;
		//音源読み込み識別子
		private static var request_key_sound:Vector.<String> = new Vector.<String>;
		
		public function getTotalRequestCount():int
		{
			return request_loader.length;
		}
		
		//画像読み込み識別子
		public function getRequestKyeImage():Vector.<String>
		{
			return request_key_image;
		}
		
		public function resetRequestKeyImage():void
		{
			request_key_image = new Vector.<String>();
		}
		
		//通信要求発行
		static public function createLoader(in_url:String, in_data_type:int, in_retry_count:int, in_param:ByteArray, in_method:String):HttpConnectionLoader
		{
			var new_loader:HttpConnectionLoader = createLoaderClass(in_data_type);
			new_loader.loadStart(in_url, in_retry_count, in_param, in_method);
			return new_loader;
		}
		
		//通信要求発行
		static public function createLoaderClass(in_data_type:int):HttpConnectionLoader
		{
			var new_loader:HttpConnectionLoader = null;
			switch (in_data_type)
			{
				case LOAD_BINARY: 
					new_loader = new HttpLoadBinary();
					break;
				case LOAD_IMAGE: 
					new_loader = new HttpLoadImage();
					break;
				default: 
					throw new Error('Fatal Loader');
					break;
			}
			
			return new_loader;
		}
		
		//インスタンス取得
		static public function getInstance():HttpConnectionController
		{
			if (instance == null)
			{
				instance = new HttpConnectionController();
			}
			return instance;
		}
		
		//通信要求発行
		public function pushRequest(in_key:String, in_url:String, in_data_type:int, in_retry_count:int = 0, in_param:ByteArray = null, in_method:String = null):Boolean
		{
			//すでに登録されているキーのロードは発行しない
			var index:int = request_key.indexOf(in_key);
			if (!(index >= 0))
			{
				if (in_method == null)
				{
					in_method = HttpConnectionLoader.METHOD_POST;
				}
				request_key.push(in_key);
				request_loader.push(createLoader(in_url, in_data_type, in_retry_count, in_param, in_method));
				return true;
			}
			return false;
		}
		
		//通信要求取得
		public function getRequest(in_key:String):Object
		{
			var index:int = getIndex(in_key);
			if (checkErrorByIndex(index))
			{
				return request_loader[index].getData();
			}
			return null;
		}
		
		//通信要求エラー取得
		public function getError(in_key:String):int
		{
			var index:int = getIndex(in_key);
			return request_loader[index].getError();
		}
		
		//通信要求エラーテキスト取得
		public function getErrorText(in_key:String):String
		{
			var index:int = getIndex(in_key);
			return request_loader[index].getErrorText();
		}
		
		//通信要求結果判定
		public function checkError(in_key:String):Boolean
		{
			var index:int = getIndex(in_key);
			return checkErrorByIndex(index);
		}
		
		//通信要求キー存在判定
		public function checkKey(in_key:String):Boolean
		{
			var index:int = getIndex(in_key, false);
			if (index < 0)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		//通信要求結果判定(インデックス参照)
		public function checkErrorByIndex(in_index:int):Boolean
		{
			if (request_loader[in_index].isComplete())
			{
				if (request_loader[in_index].getError() == HttpConnectionLoader.ERROR_NONE)
				{
					return true;
				}
				else
				{
					throw request_loader[in_index].getError();
				}
			}
			return false;
		}
		
		//通信要求キーによりインデックス値を取得
		public function getIndex(in_key:String, in_throw:Boolean = true):int
		{
			var index:int = request_key.indexOf(in_key);
			if (index >= 0)
			{
				return index;
			}
			if (in_throw)
			{
				throw new Error('No Key HttpConnectionController: key = ' + in_key);
			}
			else
			{
				return -1;
			}
		}
		
		//画像読み込み通信要求発行
		public function pushRequestLoadImage(in_key:String, in_url:String, in_retry_count:int = 0, in_param:ByteArray = null, in_method:String = null):Boolean
		{
			if (in_method == null)
			{
				in_method = HttpConnectionLoader.METHOD_POST;
			}
			if (pushRequest(in_key, in_url, LOAD_IMAGE, in_retry_count, in_param, in_method))
			{
				request_key_image.push(in_key);
				return true;
			}
			return false;
		}
	}

}