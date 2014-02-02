package Application.common
{
	import ConquestFlex.common.useful.ObjectMap;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * @author
	 */
	public class ShapeMap extends ObjectMap
	{
		/** 共通インスタンス */
		static private var instance:ShapeMap	= null;
		
		/** アクセスキー：黒シェープ */
		static public const KEY_BLACK1:String	= "black1";
		/** アクセスキー：グラデーションシェープ*/
		static public const KEY_GRAD1:String	= "grad1";
		
		/**
		 * コンストラクタ
		 */
		public function ShapeMap():void
		{
			//----------固有宣言----------
			
			var gradient_box_matrix:Matrix = null;
			var tmp:Shape = null;
			
			//黒マスクシェープ
			tmp = new Shape();
			tmp.graphics.beginFill(0x000000);
			tmp.graphics.moveTo(0, 0);
			tmp.graphics.lineTo(0, 50);
			tmp.graphics.lineTo(50, 50);
			tmp.graphics.lineTo(50, 0);
			tmp.graphics.lineTo(0, 0);
			tmp.graphics.endFill();
			this.setObj(tmp, KEY_BLACK1);
			
			//グラデーションシェープ
			tmp = new Shape();
			gradient_box_matrix = new Matrix();
			gradient_box_matrix.createGradientBox(50, 50, Math.PI * 0.5, 0, -25);
			tmp.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0xFFFF00, 0xFFFF00, 0xFF0000], [0, 1, 1, 0], [0, 80, 175, 255], gradient_box_matrix);
			tmp.graphics.moveTo(0, -25);
			tmp.graphics.lineTo(0, 25);
			tmp.graphics.lineTo(50, 25);
			tmp.graphics.lineTo(50, -25);
			tmp.graphics.lineTo(0, -25);
			tmp.graphics.endFill();
			this.setObj(tmp,　KEY_GRAD1);
		
		}
		
		/**
		 * インスタンス生成
		 * @return
		 */
		static public function createInstance():ShapeMap
		{
			if (instance == null)
			{
				instance = new ShapeMap();
			}
			return instance;
		}
		
		/**
		 * override関数　シェープを複製してオブジェクト取得
		 * @param	key
		 * @return
		 */
		override public function getObj(key:String):DisplayObject
		{
			var copy_shape:Shape = new Shape();
			copy_shape.graphics.copyFrom(Shape(super.getObj(key)).graphics);
			return copy_shape;
		}
	}
}