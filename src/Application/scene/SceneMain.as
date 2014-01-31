package Application.scene
{
	import Application.ApplicationData;
	import ConquestFlex.common.movieclip.MovieClipText;
	import ConquestFlex.scene.SceneBase;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * @author
	 */
	public class SceneMain extends SceneBase
	{
		/** アクションフラグ定数 */
		/** アクション無し */
		private static const ACT_NO:int		= -1;
		/** 準備 */
		private static const ACT_INIT:int	= 10;
		/** 開始 */
		private static const ACT_START:int	= 20;
		/** メインループ */
		private static const ACT_MAIN:int	= 30;
		/** 終了 */
		private static const ACT_END:int	= 100;
		
		/** 中枢データ */
		public var game_data:ApplicationData = null;
		
		/** Hallo World　テキスト */
		private var hallo_world:MovieClipText = null;
		
		/**
		 * コンストラクタ
		 */
		public function SceneMain():void
		{
		}
		
		/**
		 * シーン実行
		 * @param	in_canvas
		 */
		public override function action(in_canvas:Sprite):void
		{
			try
			{
				switch (getActionFlag())
				{
					case ACT_INIT: 
						this.actInit(in_canvas);
						break;
					case ACT_START: 
						this.actStart(in_canvas);
						break;
					case ACT_MAIN: 
						this.actMain(in_canvas);
						break;
					case ACT_END: 
						this.actEnd(in_canvas);
						break;
				}
			}
			catch (e:Error)
			{
				throw e;
			}
		}
		
		/**
		 * シーン初期化
		 * @param	in_canvas
		 * @param	obj
		 */
		public override function initialize(in_canvas:Sprite, obj:Object):void
		{
			//キャンバス登録
			setCanvas(in_canvas);
			//中枢データ取得
			game_data = ApplicationData.createInstance();
			
			hallo_world = new MovieClipText();
			hallo_world.setTextPosition(new Rectangle(in_canvas.stage.stageWidth - 100, in_canvas.stage.stageHeight - 40, in_canvas.stage.stageWidth / 2, 25));
			hallo_world.x = in_canvas.stage.stageWidth - 90;
			hallo_world.y = in_canvas.stage.stageHeight - 40;
			hallo_world.setText('Hallo World!');
			hallo_world.textColor(0x000000);
			hallo_world.textSize(18);
			hallo_world.textFont();
			this.addChild(hallo_world);
			
			setActionFlag(ACT_INIT);
		}
		
		/**
		 * シーン解放
		 * @param	in_canvas
		 */
		public override function finalize(in_canvas:Sprite):void
		{
		}
		
		/**
		 * 準備
		 * @param	in_canvas
		 */
		private function actInit(in_canvas:Sprite):void
		{
		}
		
		/**
		 * 開始
		 * @param	in_canvas
		 */
		private function actStart(in_canvas:Sprite):void
		{
		}
		
		/**
		 * メインループ
		 * @param	in_canvas
		 */
		private function actMain(in_canvas:Sprite):void
		{
		}
		
		/**
		 * 終了
		 * @param	in_canvas
		 */
		private function actEnd(in_canvas:Sprite):void
		{
		}
	}
}
