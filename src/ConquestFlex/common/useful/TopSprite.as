package ConquestFlex.common.useful
{
	import flash.display.Sprite;
	
	/**
	 * @author jun-ueoka
	 */
	public class TopSprite extends Sprite
	{
		/** メインステージ */
		static private var main_stage:Sprite = null;
		
		/**
		 * コンストラクタ
		 */
		public function TopSprite():void
		{
			super();
			main_stage = this;
		}
		
		/**
		 * エラーチェック
		 * @return
		 */
		static public function getMainStage():Sprite
		{
			if (main_stage != null)
			{
				return main_stage;
			}
			else
			{
				throw new Error('No Stage [UtilStage]');
			}
		}
		
		/**
		 * 秒数からフレーム数を取得
		 * @param	in_second
		 * @return
		 */
		static private function getFrameBySecond(in_second:Number):int
		{
			return getMainStage().stage.frameRate * in_second;
		}
	}
}