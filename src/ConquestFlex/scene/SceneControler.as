package ConquestFlex.scene
{
	import flash.display.Sprite;
	
	/**
	 * @author jun-ueoka
	 */
	public class SceneControler
	{
		//共通インスタンス
		static private var instance:SceneControler = null;
		
		//
		private var scene_factory:SceneFactoryBase = null;
		//
		private var v_scene_ids:Vector.<int> = new Vector.<int>;
		//
		private var v_scene_params:Vector.<Object> = new Vector.<Object>;
		//
		private var now_scene:SceneBase = null;
		//
		private var b_update:Boolean = false;
		
		//コンストラクタ
		public function SceneControler(in_scene_factory:SceneFactoryBase):void
		{
			scene_factory = in_scene_factory;
		}
		
		//インスタンス生成
		static public function createInstance(in_scene_factory:SceneFactoryBase = null):SceneControler
		{
			if (instance == null)
			{
				instance = new SceneControler(in_scene_factory);
			}
			return instance;
		}
		
		//シーン挿入
		public function push(in_scene_id:int, obj:Object = null):void
		{
			b_update = true; //スタックの状況が変更した
			v_scene_ids.push(in_scene_id);
			v_scene_params.push(obj);
		}
		
		//シーン破棄
		public function pop(obj:Object = null):void
		{
			b_update = true; //スタックの状況が変更した
			v_scene_ids.pop();
			v_scene_params.pop();
			if (obj != null)
			{
				v_scene_params.pop();
				v_scene_params.push(obj);
			}
		}
		
		//シーン取得
		public function getScene(in_canvas:Sprite):SceneBase
		{
			if (b_update)
			{
				if (now_scene != null)
				{
					now_scene.finalize(in_canvas);
					in_canvas.removeChild(now_scene);
				}
				
				var scene_id:int = v_scene_ids[v_scene_ids.length - 1];
				var obj:Object = v_scene_params[v_scene_ids.length - 1];
				now_scene = scene_factory.createScene(scene_id);
				now_scene.initialize(in_canvas, obj);
				in_canvas.addChild(now_scene);
				
				b_update = false;
			}
			
			return now_scene;
		}
	
	}
}