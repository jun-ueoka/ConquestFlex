package ConquestFlex.common.useful
{
	import flash.geom.ColorTransform;
	
	/**
	 * @author jun-ueoka
	 */
	public class UtilColor
	{
		/**
		 * 明度調整
		 * @param	cTf
		 * @param	rate
		 * @return
		 */
		static public function adjustColor(cTf:ColorTransform, rate:Number):ColorTransform
		{
			cTf.redMultiplier = rate;
			cTf.greenMultiplier = rate;
			cTf.blueMultiplier = rate;
			return cTf;
		}
		
		/**
		 * colorTransformを複製
		 * @param	cTf
		 * @return
		 */
		static public function copyColor(cTf:ColorTransform):ColorTransform
		{
			return new ColorTransform(cTf.redMultiplier, cTf.greenMultiplier, cTf.blueMultiplier, cTf.alphaMultiplier, cTf.redOffset, cTf.greenOffset, cTf.blueOffset, cTf.alphaOffset);
		}
		
		/**
		 * RGBA値を指定したcolorTransformを生成
		 * @param	in_red
		 * @param	in_green
		 * @param	in_blue
		 * @param	in_alpha
		 * @return
		 */
		static public function createColorByRGBA(in_red:Number = 0, in_green:Number = 0, in_blue:Number = 0, in_alpha:Number = 0):ColorTransform
		{
			return new ColorTransform(1, 1, 1, 1, in_red, in_green, in_blue, in_alpha);
		}
		
		/**
		 * 明度の比率を指定してcolorTransformを生成
		 * @param	in_bright_rate
		 * @param	in_alpha_bright_rate
		 * @return
		 */
		static public function createColorByBright(in_bright_rate:Number, in_alpha_bright_rate:Number = 0):ColorTransform
		{
			in_bright_rate = UtilCalc.clampNumber(in_bright_rate, -1, 1);
			in_alpha_bright_rate = UtilCalc.clampNumber(in_alpha_bright_rate, -1, 1);
			
			return new ColorTransform(1, 1, 1, 1, 255 * in_bright_rate, 255 * in_bright_rate, 255 * in_bright_rate, 255 * in_alpha_bright_rate);
		}
	}
}