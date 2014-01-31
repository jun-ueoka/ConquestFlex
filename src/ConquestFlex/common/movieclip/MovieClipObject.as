package ConquestFlex.common.movieclip 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ConquestFlex.common.useful.AutoPoint;
	import ConquestFlex.common.useful.UtilCalc;
	import ConquestFlex.common.useful.UtilColor;

	/**
	 * @author jun-ueoka
	 */
	public class MovieClipObject extends MovieClip 
	{
		//==========================================================================
		//	属性
		//==========================================================================
		
		//自動移動値
		private	var	auto_position:AutoPoint	= null;
		//自動移動確認
		private	var	b_auto_position:Boolean	= false;



		//==========================================================================
		//	メソッド
		//==========================================================================
		
		//override関数	フレーム毎に行う処理
		public function action() : void								{	throw new Error("No Implementation");	}
		//override関数	生成時に行う処理
		public function initialize(in_parent:Sprite = null) : void	{	throw new Error("No Implementation");	}
		//override関数	破棄時に行う処理
		public function finalize() : void							{	throw new Error("No Implementation");	}
		
		//動作開始(移動処理)
		public function moveNextPos(in_next_pos:Point, in_move_frame:int = 0, in_easing_value:Number = 0) : void {
			//移動先指定
			auto_position	= new AutoPoint(this, this.x, this.y);
			auto_position.moveNextPos(in_next_pos, in_move_frame, in_easing_value);
			b_auto_position	= true;
			moveExecuteStart();
			addEventListener(Event.ENTER_FRAME, moveExecute);
		}
		
		//動作処理実行
		protected function moveExecute(e:Event) : void {
			this.x	= auto_position.x;
			this.y	= auto_position.y;
			if (!auto_position.checkMove()) {
				b_auto_position	= false;
				moveExecuteEnd();
				removeEventListener(Event.ENTER_FRAME, moveExecute);
			}
		}
		
		//動作処理開始継承処理
		protected function moveExecuteStart() : void	{		}
		//動作処理終了継承処理
		protected function moveExecuteEnd() : void		{		}
		
		//オブジェクト複製
		public function copyObject(in_param_copy:Boolean = false) : MovieClipObject {
			var	new_copy:MovieClipObject	= copyBase();
			if (in_param_copy) {
				new_copy.x			= this.x;
				new_copy.y			= this.y;
				new_copy.z			= this.z;
				new_copy.scaleX		= this.scaleX;
				new_copy.scaleY		= this.scaleY;
				new_copy.scaleZ		= this.scaleZ;
				new_copy.rotationX	= this.rotationX;
				new_copy.rotationY	= this.rotationY;
				new_copy.rotationZ	= this.rotationZ;
				new_copy.transform	= this.transform;
			}
			return	new_copy;
		}
		
		//オブジェクトベース複製
		protected function copyBase() : MovieClipObject {
			return	new MovieClipObject();
		}
		
		//明度調整
		public function setBrightness(in_bright_rate:Number) : void {
			this.transform.colorTransform	= UtilColor.createColorByBright(in_bright_rate);
		}
		
		//動作中確認
		public function checkAutoPosition() : Boolean {
			return	b_auto_position;
		}
		
		//詳細色設定
		public function setColor(in_red:int, in_green:int, in_blue:int, in_alpha:int = 0) : void {
			this.transform.colorTransform	= UtilColor.createColorByRGBA(in_red, in_green, in_blue, in_alpha);
		}
		
		//位置設定
		public function setPositionByPoint(in_position:Point) : void {
			this.x	= in_position.x;
			this.y	= in_position.y;
		}
		
		//スケーリング設定
		public function setScaleByPoint(in_scale:Point) : void {
			this.scaleX	= in_scale.x;
			this.scaleY	= in_scale.y;
		}
		public function setScaleByNumber(in_scale:Number) : void {
			this.scaleX = this.scaleY = in_scale;
		}
		
		//サイズ設定
		public function setSizeByRectangle(in_rectangle:Rectangle) : void {
			this.width		=	in_rectangle.width;
			this.height		=	in_rectangle.height;
		}
		
		//グローフィルター
		public function setGlowFilter(
			in_color:uint = 0xFFFFFF, in_alpha:Number = 1, in_blurX:Number = 6, in_blurY:Number = 6,
			in_strength:Number = 2, in_quality:int = 1, in_inner:Boolean = false, in_knockout:Boolean = false) : void {
			setBitmapFilter(new GlowFilter(in_color, in_alpha, in_blurX, in_blurY, in_strength, in_quality, in_inner, in_knockout));
		}
		//ドロップシャドウフィルター
		public function setDropShadowFilter(
			in_distance:Number = 4.0, in_angle:Number = 45, in_color:uint = 0, in_alpha:Number = 1.0, in_blurX:Number = 4.0,
			in_blurY:Number = 4.0, in_strength:Number = 1.0, in_quality:int = 1, in_inner:Boolean = false,
			in_knockout:Boolean = false, in_hideObject:Boolean = false) : void {
				setBitmapFilter(new DropShadowFilter(in_distance, in_angle, in_color, in_alpha, in_blurX, in_blurY, in_strength, in_quality, in_inner, in_knockout, in_hideObject));
		}
		//ブラーフィルター
		public function setBlurFilter(
			in_blurX:Number = 4.0, in_blurY:Number = 4.0, in_quality:int = 1) : void {
				setBitmapFilter(new BlurFilter(in_blurX, in_blurY, in_quality));
			}
		//フィルター追加
		public function setBitmapFilter(in_filter:BitmapFilter) : void {
			if (filters == null) {
				filters  = new Array();
			}
			filters	= [in_filter];
		}
		
		
				

		
		
	}
}