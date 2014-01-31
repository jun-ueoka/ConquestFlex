package Application
{
	import Application.ApplicationData;
	import Application.common.SceneFactory;
	import ConquestFlex.common.event.KeyEventController;
	import ConquestFlex.common.event.MouseEventController;
	import ConquestFlex.common.useful.TopSprite;
	import ConquestFlex.common.useful.UtilFont;
	import ConquestFlex.graphics.GraphicShape;
	import ConquestFlex.scene.SceneBase;
	import ConquestFlex.scene.SceneControler;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import ConquestFlex.Environment;
	
	/**
	 * ...
	 * @author Unknown
	 */
	public class ApplicationMain extends TopSprite
	{
		//シーンコントローラ
		private var scene_controler:SceneControler = SceneControler.createInstance(new SceneFactory());
		//マウスコントローラー
		private var mouse_event:MouseEventController = null;
		//キーコントローラー
		private var key_event:KeyEventController = null;
		//エラーメッセージ
		public var error_msg:Error = null;
		//マスク
		public var mask_shape:Shape = null;
		
		public function ApplicationMain():void
		{
			//上記クラス初期化
			super();
			//初期化処理
			start();
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function start():void
		{
			
			//マスク設定
			mask_shape = GraphicShape.createSquare(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			mask = mask_shape;
			this.addChild(mask_shape);
			
			//外部値保持
			var flash_vars:Object = loaderInfo.parameters;
			if (flash_vars['xurl'] != null)
			{
			}
			
			//マウスイベント設定
			mouse_event = MouseEventController.createInstance(ApplicationData.MOUSE_EVENT_KEY_MAIN, stage);
			mouse_event.addMouseEvent(MouseEventController.MOUSE_EVENT_TYPE_CLICK);
			
			//キーイベント設定
			//	key_event	= KeyEventController.createInstance(GameData.MOUSE_EVENT_KEY_MAIN, stage);
			
			//メインループ
			addEventListener(Event.ENTER_FRAME, loop);
			
			//初期シーン設置
			scene_controler.push(SceneFactory.SCENE_MAIN);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
		private function loop(e:Event = null):void
		{
			try
			{
				var scene:SceneBase = scene_controler.getScene(this);
				scene.execute(this);
			}
			catch (err:Error)
			{
				error_msg = err;
				removeEventListener(Event.ENTER_FRAME, loop);
				addEventListener(Event.ENTER_FRAME, error);
			}
		}
		
		//エラー発生時に定期的に行う処理
		public function error(e:Event):void
		{
			if (error_msg != null)
			{
				var text_field:TextField = new TextField();
				text_field.defaultTextFormat = UtilFont.getTextFormat("ＭＳ　ゴシック", 12, 0xFFFFFF);
				text_field.text = error_msg.getStackTrace();
				//text_field.text				=	m_flash_vars;
				text_field.background = true;
				text_field.backgroundColor = 0x0000000;
				text_field.x = 0;
				text_field.y = 0;
				text_field.width = 760;
				text_field.height = 510;
				text_field.multiline = true;
				text_field.wordWrap = true;
				this.addChild(text_field);
				error_msg = null;
			}
		}
		
		//ゲームエフェクトの再生速度をセットする
		private function setPlaySpeed():void
		{
			var skip_type:Array = [1.0, 1.3, 1.5, Environment.SPEED_DEFOULT];
		}
	}
}

