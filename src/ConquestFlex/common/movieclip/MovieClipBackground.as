package ConquestFlex.common.movieclip 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ConquestFlex.common.useful.UtilCalc;

	/**
	 * @author jun-ueoka
	 */
	public class MovieClipBackground extends MovieClipObject 
	{
		//ビットマップデータ
		private var background_sprite:Sprite	= null;
		
		//スクロールエリア
		private	var scroll_area:Rectangle		= null;
		//スクロールポジション
		private	var	scroll_pos:Point			= null;
		//スクロール値
		private	var	scroll_value:Point			= null;
		
		//スクロール値変動開始値
		private	var	scroll_value_move_s:Point		= null;
		//スクロール値変動終了値
		private	var	scroll_value_move_e:Point		= null;
		//スクロール値変動フレームカウンタ
		private	var	scroll_value_move_frame_cnt:int	= 0;
		//スクロール値変動最大フレーム
		private	var	scroll_value_move_frame_max:int	= 0;
		
		//コンストラクタ
		public function MovieClipBackground(in_object:MovieClipObject, in_scroll_area:Rectangle) : void
		{
			//基点の決定
			in_object.x = in_object.y = 0;
			var	tmp_rect:Rectangle	= in_object.getRect(this);
			in_object.x	= in_scroll_area.x - tmp_rect.left;
			in_object.y	= in_scroll_area.y - tmp_rect.top;
			scroll_pos	= new Point(in_object.x, in_object.y);
			
			//スクロール範囲の決定
			scroll_area	= new Rectangle(scroll_pos.x - tmp_rect.width, scroll_pos.y - tmp_rect.height, tmp_rect.width, tmp_rect.height);
			
			//背景の生成
			background_sprite	= new Sprite();
			background_sprite.x	= scroll_pos.x;
			background_sprite.y	= scroll_pos.y;
			var	tmp_copy:MovieClipObject	= null;
			for (var y:int = 0; (y < 2) || ((tmp_rect.height * y) < in_scroll_area.height); y++)
			{
				for (var x:int = 0; (x < 2) || ((tmp_rect.width * x) < in_scroll_area.width); x++)
				{
					tmp_copy	= in_object.copyObject(true);
					tmp_copy.x	= scroll_pos.x + (tmp_rect.width  * x);
					tmp_copy.y	= scroll_pos.y + (tmp_rect.height * y);
					background_sprite.addChild(tmp_copy);
				}
			}
			this.addChild(background_sprite);
			
			//スクロール値の設定
			scroll_value	= new Point(0, 0);
			
			//スクロール処理
			this.addEventListener(Event.ENTER_FRAME, scrollEnterFrame);
		}
		
		//スクロール値変動
		public function changeScrollValue(in_scroll_value:Point, in_frame:int = 0) : void
		{
			if (in_frame > 0)
			{
				scroll_value_move_s	= scroll_value;
				scroll_value_move_e	= in_scroll_value;
				scroll_value_move_frame_cnt	= 0;
				scroll_value_move_frame_max	= in_frame;
			}
			else
			{
				scroll_value	= in_scroll_value;
			}
		}
		
		//スクロール処理
		private function scrollEnterFrame(e:Event) : void
		{
			if (scroll_value_move_s != null)
			{
				scroll_value_move_frame_cnt++;
				scroll_value	= UtilCalc.interpolatePtoP(scroll_value_move_s, scroll_value_move_e, scroll_value_move_frame_cnt / scroll_value_move_frame_max);
				if (scroll_value_move_frame_cnt >= scroll_value_move_frame_max)
				{
					scroll_value_move_s	= scroll_value_move_e = null;
				}
			}
			
			background_sprite.x	+= scroll_value.x;
			background_sprite.y += scroll_value.y;
			if		(background_sprite.x <  scroll_area.left)	{	background_sprite.x	+= scroll_area.width;	}
			else if	(background_sprite.x >= scroll_area.right)	{	background_sprite.x	-= scroll_area.width;	}
			if		(background_sprite.y <  scroll_area.top)	{	background_sprite.y	+= scroll_area.height;	}
			else if	(background_sprite.y >= scroll_area.bottom)	{	background_sprite.y	-= scroll_area.height;	}
		}
	}
}