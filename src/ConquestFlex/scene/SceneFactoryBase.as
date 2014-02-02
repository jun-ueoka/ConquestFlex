package ConquestFlex.scene
{
	/**
	 * @author jun-ueoka
	 */
	public interface SceneFactoryBase
	{
		/**
		 * シーン発行(継承先のクラスでオーバーライトし、シーンのインスタンス生成を行わせる)
		 * @param	in_scene_id
		 * @return
		 */
		function createScene(in_scene_id:int):SceneBase;
	}

}