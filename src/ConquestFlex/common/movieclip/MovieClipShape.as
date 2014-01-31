package ConquestFlex.common.movieclip 
{
	import flash.display.Shape;
	import flash.display.MovieClip;
	import ConquestFlex.common.useful.UtilCalc;

	/**
	 * @author jun-ueoka
	 */
	public class MovieClipShape extends MovieClipObject 
	{
		//シェープデータ
		private var shape:Shape	= null;
		
		//ポジションフラグ
		private	var position_flag:int	= -1;
		
		//コンストラクタ
		public function MovieClipShape(in_shape:Shape, in_set:int = UtilCalc.SET_CENTER) : void	{
			if (in_shape != null) {
				setShape(in_shape, in_set);
			}
		}
		
		//シェープアクセス
		public function getShape() : Shape		{	return	shape;			}
		public function setShape(in_shape:Shape, in_set:int = -1) : void	{
			shape	= in_shape;
			this.addChild(shape);
			if (in_set >= 0) {
				position_flag	= in_set;
			}
			UtilCalc.setPosition(shape, position_flag);
		}
		
		//override関数　オブジェクトベース複製
		protected override function copyBase() : MovieClipObject
		{
			return	new MovieClipShape(this.shape, position_flag);
		}
	}
}