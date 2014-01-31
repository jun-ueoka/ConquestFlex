package Application.common
{
	import Application.scene.SceneMain;
	import ConquestFlex.scene.SceneBase;
	import ConquestFlex.scene.SceneFactoryBase;
	
	/**
	 * @author
	 */
	public class SceneFactory implements SceneFactoryBase
	{
		/** メインシーン */
		public static const SCENE_MAIN:int = 1;
		
		/**
		 * シーンクラス生成
		 * @param	in_scene_id
		 * @return
		 */
		public function createScene(in_scene_id:int):SceneBase
		{
			switch (in_scene_id)
			{
				case SCENE_MAIN: 
					return new SceneMain();
			}
			throw new Error('Unknown Scene!');
		}
	}

}