package ConquestFlex.common.movieclip
{
	import ConquestFlex.common.useful.UtilCalc;
	import ConquestFlex.common.useful.UtilFont;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	/**
	 * @author jun-ueoka
	 */
	public class MovieClipText extends MovieClipObject
	{
		/** ブリンク間隔 */
		private const BLINK_MSEC:Number = 250;
		
		/** テキストデータ */
		private var text_field:TextField = new TextField();
		/** テキストフォーマット */
		private var text_format:TextFormat = new TextFormat();
		/** ポジションフラグ */
		private var position_flag:int = -1;
		/** タイマー */
		private var blink_timer:Timer = null;
		
		/**
		 * コンストラクタ
		 * @param	in_text
		 * @param	in_set
		 * @param	in_width
		 * @param	in_height
		 */
		public function MovieClipText(in_text:String = '', in_set:int = UtilCalc.SET_CENTER, in_width:Number = 1000, in_height:Number = 1000):void
		{
			setText(in_text);
			setTextPosition(new Rectangle(0, 0, in_width, in_height), in_set);
			addChild(text_field);
		}
		
		/**
		 * TextFieldアクセス
		 * @return
		 */
		public function getTextField():TextField
		{
			return text_field;
		}
		
		/**
		 * 文章設定
		 * @param	in_text
		 */
		public function setText(in_text:String = ''):void
		{
			text_field.text = in_text;
			updateTextFormat();
		}
		
		/**
		 * 位置、サイズ設定
		 * @param	in_rect
		 * @param	in_set
		 */
		public function setTextPosition(in_rect:Rectangle, in_set:int = UtilCalc.SET_CENTER):void
		{
			text_field.x = in_rect.x;
			text_field.y = in_rect.y;
			text_field.width = in_rect.width;
			text_field.height = in_rect.height;
			UtilCalc.setPosition(text_field, in_set);
			
			text_format.align = UtilCalc.getTextAllineByPosition(in_set);
			updateTextFormat();
		}
		
		/**
		 * テキストフォーマット設定
		 * @param	in_text_format
		 */
		public function setTextFormat(in_text_format:TextFormat):void
		{
			text_format = UtilFont.copyTextFormat(in_text_format);
			updateTextFormat();
		}
		
		/**
		 * テキストフォーマット更新
		 */
		public function updateTextFormat():void
		{
			text_field.defaultTextFormat = text_format;
			text_field.text = text_field.text;
		}
		
		/**
		 * ブリンク開始
		 */
		public function blinkPlay():void
		{
			blink_timer = new Timer(BLINK_MSEC);
			blink_timer.addEventListener(TimerEvent.TIMER, blinkTimerEvent);
			blink_timer.start();
		}
		
		/**
		 * ブリンク終了
		 */
		public function blinkStop():void
		{
			if (blink_timer != null)
			{
				blink_timer.stop();
				blink_timer = null;
			}
		}
		
		/**
		 * ブリンク処理
		 * @param	e
		 */
		private function blinkTimerEvent(e:TimerEvent):void
		{
			text_field.visible = !text_field.visible;
		}
		
		/**
		 * テキストのカラーを白に変更
		 */
		public function changeTextWhite():void
		{
			text_format.color = 0xFFFFFF;
			updateTextFormat();
		}
		
		/**
		 * テキストのカラーをシアンに変更
		 */
		public function changeTextCyan():void
		{
			text_format.color = 0x00FFFF;
			updateTextFormat();
		}
		
		/**
		 * テキストサイズを変更
		 * @param	in_size
		 */
		public function textSize(in_size:int = 30):void
		{
			text_format.size = in_size;
			updateTextFormat();
		}
		
		/**
		 * テキストカラーを変更
		 * @param	in_color
		 */
		public function textColor(in_color:uint = 0xFFFFFF):void
		{
			text_format.color = in_color;
			updateTextFormat();
		}
		
		/**
		 * テキストフォントを変更
		 * @param	in_font
		 */
		public function textFont(in_font:String = "MS Mincho"):void //MS Gothic ここで全角文字を使うとTimesになってしまうから注意
		{
			text_format.font = in_font;
			updateTextFormat();
		}
		
		/**
		 * テキスト位置を変更
		 * @param	in_align
		 */
		public function textAlign(in_align:String = TextFormatAlign.CENTER):void
		{
			text_format.align = in_align;
			updateTextFormat();
		}
		
		/**
		 * テキスト位置を変更
		 * @param	in_boolean
		 */
		public function textWordWrap(in_boolean:Boolean):void
		{
			text_field.multiline = in_boolean;
			text_field.wordWrap = in_boolean;
			updateTextFormat();
		}
	
	}
}