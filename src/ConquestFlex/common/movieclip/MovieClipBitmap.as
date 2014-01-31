package ConquestFlex.common.movieclip 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import ConquestFlex.common.useful.UtilCalc;

	/**
	 * @author jun-ueoka
	 */
	public class MovieClipBitmap extends MovieClipObject 
	{
		//ビットマップデータ
		private var bitmap:Bitmap		= new Bitmap();
		
		//ポジションフラグ
		private	var position_flag:int	= -1;
		
		//コンストラクタ
		public function MovieClipBitmap(in_bitmap:Bitmap = null, in_set:int = UtilCalc.SET_CENTER) : void {
			if (in_bitmap != null) {
				setBitmapData(in_bitmap.bitmapData, in_set);
			}
		}
		
		//ビットマップアクセス
		public function getBitmap() : Bitmap	{	return	bitmap;			}
		public function setBitmap(in_bitmap:Bitmap, in_set:int = -1) : void	{
			bitmap					= in_bitmap;
			this.addChild(bitmap);
			this.setBitmapPosition(in_set);
		}
		
		//ビットマップデータアクセス
		public function getBitmapData() : BitmapData	{	return	bitmap.bitmapData;	}
		public function setBitmapData(in_bitmap_data:BitmapData, in_set:int = -1) : void	{
			bitmap.bitmapData		= in_bitmap_data;
			this.addChild(bitmap);
			this.setBitmapPosition(in_set);
		}
		public function setBitmapDataByBitmap(in_bitmap:Bitmap, in_set:int = -1) : void	{
			setBitmapData(in_bitmap.bitmapData, in_set);
		}
		
		//override関数　オブジェクトベース複製
		protected override function copyBase() : MovieClipObject {
			return	new MovieClipBitmap(this.bitmap, position_flag);
		}
		
		//画像のポジション指定
		public function setBitmapPosition(in_set:int) : void {
			if (in_set >= 0) {
				position_flag	= in_set;
			}
			UtilCalc.setPosition(bitmap, position_flag);
		}
	}
}