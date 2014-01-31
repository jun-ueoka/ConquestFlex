package ConquestFlex.common.useful
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	/**
	 * @author jun-ueoka
	 */
	public class UtilCalc
	{
		/** 配置タイプ定数 */
		static public const SET_NO:int				= -1;
		static public const SET_LEFT_TOP:int		= 0;
		static public const SET_TOP:int				= 1;
		static public const SET_RIGHT_TOP:int		= 2;
		static public const SET_LEFT:int			= 10;
		static public const SET_CENTER:int			= 11;
		static public const SET_RIGHT:int			= 12;
		static public const SET_LEFT_BOTTOM:int		= 20;
		static public const SET_BOTTOM:int			= 21;
		static public const SET_RIGHT_BOTTOM:int	= 22;
		
		/**
		 * 値の不正値確認
		 * @param	in_value
		 * @param	in_min
		 * @param	in_max
		 * @return
		 */
		static public function checkInvalidValue(in_value:Number, in_min:Number, in_max:Number):Boolean
		{
			return ((in_min <= in_value) && (in_value <= in_max));
		}
		
		/**
		 * 値の上限・下限補正
		 * @param	in_value
		 * @param	in_min
		 * @param	in_max
		 * @return
		 */
		static public function clampNumber(in_value:Number, in_min:Number, in_max:Number):Number
		{
			return in_value < in_min ? in_min : (in_max < in_value ? in_max : in_value);
		}
		
		/**
		 * 開始・終了値　補間
		 * @param	in_begin
		 * @param	in_end
		 * @param	in_rate
		 * @param	in_easing
		 * @return
		 */
		static public function interpolateLinear(in_begin:Number, in_end:Number, in_rate:Number, in_easing:Number = 0):Number
		{
			return in_begin + ((clampNumber(in_rate, 0, 1) * ((in_easing * (1 - in_rate)) + 1.0)) * (in_end - in_begin));
		}
		
		/**
		 * 開始・終了座標　補間
		 * @param	in_begin
		 * @param	in_end
		 * @param	in_rate
		 * @param	in_easing
		 * @return
		 */
		static public function interpolatePtoP(in_begin:Point, in_end:Point, in_rate:Number, in_easing:Number = 0):Point
		{
			return new Point(interpolateLinear(in_begin.x, in_end.x, in_rate, in_easing), interpolateLinear(in_begin.y, in_end.y, in_rate, in_easing));
		}
		
		/**
		 * 数値を目標値まで変動(int)
		 * @param	in_now_value
		 * @param	in_target_value
		 * @param	in_move
		 * @return
		 */
		static public function valueToValueMoveInt(in_now_value:int, in_target_value:int, in_move:int):int
		{
			return int(valueToValueMove(Number(in_now_value), Number(in_target_value), Number(in_move)));
		}

		/**
		 * 数値を目標値まで変動(Number)
		 * @param	in_now_value
		 * @param	in_target_value
		 * @param	in_move
		 * @return
		 */
		static public function valueToValueMove(in_now_value:Number, in_target_value:Number, in_move:Number):Number
		{
			return in_now_value + valueToValueMoveValue(in_now_value, in_target_value, in_move);
		}
		
		/**
		 * 数値を目標値まで変動する際の変動値を取得
		 * @param	in_now_value
		 * @param	in_target_value
		 * @param	in_move
		 * @return
		 */
		static public function valueToValueMoveValue(in_now_value:Number, in_target_value:Number, in_move:Number):Number
		{
			if (in_now_value > in_target_value)
			{
				if ((in_now_value - in_move) > in_target_value)
				{
					return -in_move;
				}
				else
				{
					return in_target_value - in_now_value;
				}
			}
			else
			{
				if ((in_now_value + in_move) < in_target_value)
				{
					return in_move;
				}
				else
				{
					return in_target_value - in_now_value;
				}
			}
			return 0;
		}
		
		/**
		 * オブジェクトポジショニング
		 * @param	in_obj
		 * @param	in_set
		 * @param	in_base
		 */
		static public function setPosition(in_obj:DisplayObject, in_set:int = SET_CENTER, in_base:DisplayObject = null):void
		{
			if (in_set >= 0)
			{
				var tmp_rect:Rectangle = null;
				if (in_base != null)
				{
					tmp_rect = in_obj.getRect(in_base);
				}
				else
				{
					tmp_rect = in_obj.getRect(in_obj);
				}
				in_obj.x = -(tmp_rect.left + ((tmp_rect.width / 2) * (Math.floor(in_set % 10))));
				in_obj.y = -(tmp_rect.top + ((tmp_rect.height / 2) * (Math.floor(in_set / 10))));
			}
		}
		
		/**
		 * TextFormatAlignをポジションフラグから取得
		 * @param	in_set
		 * @return
		 */
		static public function getTextAllineByPosition(in_set:int):String
		{
			switch (Math.floor(in_set % 10))
			{
				case 0: 
					return TextFormatAlign.LEFT;
				case 1: 
					return TextFormatAlign.CENTER;
				case 2: 
					return TextFormatAlign.RIGHT;
				default: 
					return TextFormatAlign.LEFT;
			}
		}
		
		/**
		 * オブジェクトのリサイズ後サイズを取得
		 * @param	in_obj
		 * @param	in_scale
		 * @return
		 */
		static public function getObjectSize(in_obj:DisplayObject, in_scale:Number = 1):Point
		{
			return new Point(in_obj.width * in_scale, in_obj.height * in_scale);
		}
		
		/**
		 * 要素数を指定して0～1の比率を持つ配列を生成する(5を指定した場合[0,0.25,0.5,0.75,1]となる)
		 * @param	in_count
		 * @return
		 */
		static public function createRatioArray(in_count:int):Array
		{
			var tmp_array:Array = new Array();
			if (in_count > 0)
			{
				for (var i:int = 1; i < in_count; i++)
				{
					tmp_array.push((i - 1) / (in_count - 1));
				}
				tmp_array.push(1);
			}
			return tmp_array;
		}
		
		/**
		 * 要素数を指定してmin～maxの比率を持つ配列を生成する(要素数=5,min=-10,max=10を指定した場合[-10,-5,0.5,10]となる)
		 * @param	in_count
		 * @param	in_min
		 * @param	in_max
		 * @return
		 */
		static public function createRatioArrayMinToMax(in_count:int, in_min:Number, in_max:Number):Array
		{
			var tmp_array:Array = new Array();
			var ratio_array:Array = createRatioArray(in_count);
			for (var i:int = 0; i < in_count; i++)
			{
				tmp_array.push(interpolateLinear(in_min, in_max, ratio_array[i]))
			}
			return tmp_array;
		}
	}
}