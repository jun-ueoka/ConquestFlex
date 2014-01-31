package ConquestFlex.scene
{
	import flash.display.Sprite;
	import ConquestFlex.Environment;
	
	/**
	 * @author jun-ueoka
	 */
	public class SceneBase extends Sprite
	{
		//キャンバス
		private var canvas:Sprite = null;
		
		//アクションフラグ
		private var act_flag:int = -1;
		//次アクションフラグ
		private var next_flag:int = -1;
		//アクションステップ
		private var act_step:int = -1;
		//次アクションステップ
		private var next_step:int = -1;
		//待機カウンタ
		private var wait_cnt:int = 0;
		
		//待機準備処理
		public function wait(in_wait_cnt:int, in_next_flag:int = -1, in_next_step:int = -1):void
		{
			//待機処理が0指定なら、アクションフラグ変更のみ
			if (in_wait_cnt < 1)
			{
				in_wait_cnt = 1;
			}
			//待機中に次のアクションフラグへ移行するか確認
			if (in_next_flag > -1)
			{
				next_flag = in_next_flag;
			}
			if (in_next_step > -1)
			{
				next_step = in_next_step;
			}
			//待機フレーム更新
			wait_cnt = in_wait_cnt;
		}
		
		//フレーム毎に行う処理(待機処理込み)
		public function execute(in_canvas:Sprite):void
		{
			if (wait_cnt > 0)
			{
				
				wait_cnt -= Environment.SPEED_DEFOULT;
				
				if (wait_cnt <= 0)
				{
					//アクションフラグ変更
					if (next_flag > -1)
					{
						act_flag = next_flag;
					}
					//ステップフラグ変更
					if (next_step > -1)
					{
						act_step = next_step;
					}
					else
					{
						act_step = 0;
					}
				}
			}
			else
			{
				action(in_canvas);
			}
		}
		
		//override関数	フレーム毎に行う処理
		public function action(in_canvas:Sprite):void
		{
			throw new Error("No Implementation");
		}
		
		//override関数	生成時に行う処理
		public function initialize(in_canvas:Sprite, obj:Object):void
		{
			throw new Error("No Implementation");
		}
		
		//override関数	破棄時に行う処理
		public function finalize(in_canvas:Sprite):void
		{
			throw new Error("No Implementation");
		}
		
		//フラグaccess
		protected function getActionFlag():int
		{
			return act_flag;
		}
		
		protected function getStepFlag():int
		{
			return act_step;
		}
		
		protected function setActionFlag(in_act_flag:int, in_step_flag:int = -1):void
		{
			act_flag = next_flag = in_act_flag;
			if (in_step_flag > -1)
			{
				setStepFlag(in_step_flag);
			}
		}
		
		protected function setStepFlag(in_step_flag:int):void
		{
			act_step = next_step = in_step_flag;
		}
		
		//キャンバスaccess
		public function setCanvas(in_canvas:Sprite):void
		{
			canvas = in_canvas;
		}
		
		public function getCnavas():Sprite
		{
			return canvas;
		}
	}

}