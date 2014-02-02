package ConquestFlex.graphics
{
	import ConquestFlex.common.useful.UtilCalc;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * @author jun-ueoka
	 */
	public class GraphicShape
	{
		/**
		 * 四角のシェイプを矩形情報で生成
		 * @param	in_rect
		 * @param	in_color
		 * @param	in_alpha
		 * @return
		 */
		static public function createSquare(in_rect:Rectangle, in_color:uint = 0x000000, in_alpha:Number = 1):Shape
		{
			//マスク用シェープ
			var tmp:Shape = new Shape();
			tmp.graphics.beginFill(in_color, in_alpha);
			tmp.graphics.moveTo(in_rect.left, in_rect.top);
			tmp.graphics.lineTo(in_rect.right, in_rect.top);
			tmp.graphics.lineTo(in_rect.right, in_rect.bottom);
			tmp.graphics.lineTo(in_rect.left, in_rect.bottom);
			tmp.graphics.lineTo(in_rect.left, in_rect.top);
			tmp.graphics.endFill();
			return tmp;
		}
		
		/**
		 * 四角のビットマップを矩形情報で生成
		 * @param	in_rect
		 * @param	in_color
		 * @param	in_alpha
		 * @return
		 */
		static public function createBitmapSquare(in_rect:Rectangle, in_color:uint = 0x000000, in_alpha:Number = 1):Bitmap
		{
			//マスク用シェープ
			var tmp_shape:Shape = GraphicShape.createSquare(in_rect, in_color, in_alpha);
			var tmp_bitmap:BitmapData = new BitmapData(tmp_shape.width, tmp_shape.height, true, 0xFFFFFF);
			tmp_bitmap.draw(tmp_shape);
			return new Bitmap(tmp_bitmap);
		}
		
		/**
		 * MovieClipからgraphic情報を取り出し、シェイプとする
		 * @param	in_sprite
		 * @return
		 */
		static public function pickOutShapeBySprite(in_sprite:Sprite):Shape
		{
			var tmp:Shape = new Shape();
			tmp.graphics.copyFrom(in_sprite.graphics);
			return tmp;
		}
		
		/**
		 * シェープの複製
		 * @param	in_shape
		 * @return
		 */
		static public function copyShape(in_shape:Shape):Shape
		{
			var tmp:Shape = new Shape();
			tmp.graphics.copyFrom(in_shape.graphics);
			return tmp;
		}
		
		/**
		 * グラデーション付き円シェイプ作成
		 * @param	in_diameter
		 * @param	in_color
		 * @return
		 */
		static public function createCircle(in_diameter:Number, in_color:Array):Shape
		{
			var tmp:Shape = new Shape();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(in_diameter, in_diameter, 0, -(in_diameter / 2), -(in_diameter / 2));
			tmp.graphics.beginGradientFill(GradientType.RADIAL, in_color, createAlphaArrayByColor(in_color), createColorPositionArrayByColor(in_color), matrix);
			tmp.graphics.drawCircle(0, 0, in_diameter);
			tmp.graphics.endFill();
			return tmp;
		}
		
		/**
		 * 色の配列から均等にアルファを設定した配列を生成(グラデーション用)
		 * @param	in_color
		 * @return
		 */
		static public function createAlphaArrayByColor(in_color:Array):Array
		{
			return UtilCalc.createRatioArray(in_color.length).reverse();
		}
		
		/**
		 * 色の配列から均等に色配置した配列を生成(グラデーション用)
		 * @param	in_color
		 * @return
		 */
		static public function createColorPositionArrayByColor(in_color:Array):Array
		{
			return UtilCalc.createRatioArrayMinToMax(in_color.length, 0, 255);
		}
	}
}