package ConquestFlex.common.useful
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * @author jun-ueoka
	 */
	public class UtilFont
	{
		/** アラインフラグ */
		/** 左寄り */
		static public const ALIGN_LEFT:String		= TextFormatAlign.LEFT;
		/** 右寄り */
		static public const ALIGN_RIGHT:String		= TextFormatAlign.RIGHT;
		/** 中心寄り */
		static public const ALIGN_CENTER:String		= TextFormatAlign.CENTER;
		/** 均等 */
		static public const ALIGN_JUSTIFY:String	= TextFormatAlign.JUSTIFY;
		
		/**
		 * フォーマット取得
		 * @param	in_font
		 * @param	in_size
		 * @param	in_color
		 * @param	in_align
		 * @return
		 */
		static public function getTextFormat(in_font:String = "ＭＳ　ゴシック", in_size:int = 12, in_color:uint = 0x000000, in_align:String = null):TextFormat
		{
			var format:TextFormat = new TextFormat();
			format.font = in_font;
			format.size = in_size;
			format.color = in_color;
			if (in_align != null)
			{
				format.align = in_align;
			}
			return format;
		}
		
		/**
		 * テキストフォーマット複製
		 * @param	in_text_format
		 * @return
		 */
		static public function copyTextFormat(in_text_format:TextFormat):TextFormat
		{
			return new TextFormat(in_text_format.font, in_text_format.size, in_text_format.color, in_text_format.bold, in_text_format.italic, in_text_format.underline, in_text_format.url, in_text_format.target, in_text_format.align, in_text_format.leftMargin, in_text_format.rightMargin, in_text_format.indent, in_text_format.leading);
		}
	}
}