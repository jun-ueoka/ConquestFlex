package ConquestFlex.scene
{
	
	/**
	 * @author jun-ueoka
	 */
	public interface SceneFactoryBase
	{
		function createScene(in_scene_id:int):SceneBase;
	}

}