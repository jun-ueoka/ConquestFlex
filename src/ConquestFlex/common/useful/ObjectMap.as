package ConquestFlex.common.useful
{
	import flash.display.DisplayObject;
	
	/**
	 * @author jun-ueoka
	 */
	public class ObjectMap
	{
		/** オブジェクトマップ */
		protected var obj_map:Object = new Object();
		
		/**
		 * オブジェクト取得
		 * @param	key
		 * @return
		 */
		public function getObj(key:String):DisplayObject
		{
			return (obj_map[key] != undefined ? obj_map[key] : null);
		}
		
		/**
		 * オブジェクトセット
		 * @param	obj
		 * @param	key
		 * @return
		 */
		public function setObj(obj:Object, key:String):DisplayObject
		{
			var ret:DisplayObject = null;
			if (obj_map[key] != undefined)
			{
				ret = obj_map[key];
			}
			obj_map[key] = obj;
			return ret;
		}
		
		/**
		 * オブジェクト削除
		 * @param	key
		 * @return
		 */
		public function removeObj(key:String):Boolean
		{
			if (obj_map[key] != undefined)
			{
				obj_map[key] = null;
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}