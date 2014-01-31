package ConquestFlex.common.movieclip 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import ConquestFlex.common.useful.UtilCalc;

	/**
	 * @author jun-ueoka
	 */
	public class MovieClipDisplayObject extends MovieClipObject 
	{
		//ビットマップデータ
		private var display_object:DisplayObject	= null;
		//ポジションフラグ
		private	var position_flag:int				= -1;
		
		//コンストラクタ
		public function MovieClipDisplayObject(in_display_object:DisplayObject = null, in_set:int = UtilCalc.SET_CENTER) : void {
			if (in_display_object != null) {
				setDisplayObject(in_display_object, in_set);
			}
		}
		
		//ビットマップアクセス
		public function getDisplayObject() : DisplayObject	{	return	display_object;			}
		public function setDisplayObject(in_display_object:DisplayObject, in_set:int = -1) : void	{
			display_object	= in_display_object;
			this.addChild(display_object);
			if (in_set >= 0) {
				position_flag	= in_set;
			}
			UtilCalc.setPosition(display_object, position_flag);
		}
		
		//override関数　オブジェクトベース複製
		protected override function copyBase() : MovieClipObject {
			return	new MovieClipDisplayObject(display_object, position_flag);
		}
	}
}