package ConquestFlex.common.useful
{
	import ConquestFlex.common.useful.UtilCalc;
	import ConquestFlex.Environment;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	 * @author jun-ueoka
	 */
	public class AutoPoint extends Point
	{
		/** 親オブジェクト */
		private var parent_event:EventDispatcher	= null;
		/** 移動前位置 */
		private var prev_pos:Point					= null;
		/** 移動先位置 */
		private var next_pos:Point					= null;
		/** イージング値 */
		private var easing_value:Number				= 0;
		
		/** 動作経過時間 */
		private var move_frame:int					= 0;
		/** 動作時間 */
		private var max_move_frame:int				= 0;
		/** 動作中確認 */
		private var b_move:Boolean					= false;
		
		/**
		 * コンストラクタ
		 * @param	in_parent_event
		 * @param	in_x
		 * @param	in_y
		 */
		public function AutoPoint(in_parent_event:EventDispatcher, in_x:Number, in_y:Number):void
		{
			this.parent_event = in_parent_event;
			this.x = in_x;
			this.y = in_y;
		}
		
		/**
		 * 動作開始(移動処理)
		 * @param	in_next_pos
		 * @param	in_move_frame
		 * @param	in_easing_value
		 */
		public function moveNextPos(in_next_pos:Point, in_move_frame:int = 0, in_easing_value:Number = 0):void
		{
			//移動先指定
			prev_pos = new Point(x, y);
			next_pos = in_next_pos;
			easing_value = UtilCalc.clampNumber(in_easing_value, -100.0, 100.0) / 100;
			move_frame = 0;
			max_move_frame = in_move_frame * Environment.SPEED_DEFOULT;
			b_move = true;
			parent_event.addEventListener(Event.ENTER_FRAME, moveExecute);
		}
		
		/**
		 * 動作処理実行
		 * @param	e
		 */
		private function moveExecute(e:Event):void
		{
			move_frame += Environment.SPEED_DEFOULT;
			if (max_move_frame < move_frame)
			{
				move_frame = max_move_frame;
			}
			
			var rate:Number = move_frame / max_move_frame;
			var now:Point = UtilCalc.interpolatePtoP(prev_pos, next_pos, rate * ((easing_value * (1 - rate)) + 1.0));
			this.x = now.x;
			this.y = now.y;
			if (move_frame >= max_move_frame)
			{
				b_move = false;
				parent_event.removeEventListener(Event.ENTER_FRAME, moveExecute);
			}
		}
		
		/**
		 * 動作中確認
		 * @return
		 */
		public function checkMove():Boolean
		{
			return b_move;
		}
	}
}