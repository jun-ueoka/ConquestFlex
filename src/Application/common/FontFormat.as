package Application.common
{
	import ConquestFlex.common.useful.UtilFont;
	import flash.text.TextFormat;
	
	/**
	 * フォントデータの管理
	 * @author
	 */
	public class FontFormat extends UtilFont
	{
		/** デフォルトフォント */
		public static const FONT_DEFOULT:String	= "ＭＳ ゴシック";
		
		/**
		 * ダメージ表示用のフォーマット取得
		 * @param	in_size
		 * @param	in_color
		 * @param	in_align
		 * @return
		 */
		static public function getTextFormatDefoult(in_size:int, in_color:uint, in_align:String):TextFormat
		{
			return getTextFormat(FONT_DEFOULT, in_size, in_color, in_align);
		}
	}
}