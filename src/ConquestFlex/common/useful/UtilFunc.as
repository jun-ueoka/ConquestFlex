package ConquestFlex.common.useful
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * @author jun-ueoka
	 */
	public class UtilFunc
	{
		/**
		 * Vectorデータに登録されたデータをremoveChildする
		 * @param	in_obj
		 * @param	in_vec
		 */
		static public function removeChildByVector(in_obj:DisplayObjectContainer, in_vec:Object):void
		{
			for (var i:String in in_vec)
			{
				if (in_obj.getChildIndex(in_vec[i]) > -1)
				{
					in_obj.removeChild(in_vec[i]);
				}
			}
		}
		
		/**
		 * 一斉removeChildする
		 * @param	in_obj
		 */
		static public function removeChildAll(in_obj:DisplayObjectContainer):void
		{
			for (var i:int = 0; i < in_obj.numChildren; i++)
			{
				in_obj.removeChildAt(i);
			}
		}
		
		/**
		 * ランダム値を取得する
		 * @param	in_min
		 * @param	in_max
		 * @return
		 */
		static public function getRandom(in_min:int = 0, in_max:int = 1):int
		{
			var min:int = Math.min(in_min, in_max);
			var max:int = Math.max(in_min, in_max);
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}
		
		/**
		 * DisplayObjectからサイズのPoint取得
		 * @param	in_obj
		 * @return
		 */
		static public function getSizeByObj(in_obj:DisplayObject):Point
		{
			return new Point(in_obj.width, in_obj.height);
		}
		
		/**
		 * DisplayObjectから矩形を取得
		 * @param	in_obj
		 * @return
		 */
		static public function getRectByObj(in_obj:DisplayObject):Rectangle
		{
			return new Rectangle(in_obj.x, in_obj.y, in_obj.width, in_obj.height);
		}
		
		/**
		 * 矩形からサイズのPoint取得
		 * @param	in_rect
		 * @return
		 */
		static public function getSizeByRect(in_rect:Rectangle):Point
		{
			return new Point(in_rect.width, in_rect.height);
		}
		
		/**
		 * 指定したObjectに対するIndexの値が正しいか確認
		 * @param	in_obj
		 * @param	in_index
		 * @return
		 */
		static public function checkIndexToObject(in_obj:Object, in_index:int):Boolean
		{
			return ((0 <= in_index) && (in_index < in_obj.length));
		}
	}
}