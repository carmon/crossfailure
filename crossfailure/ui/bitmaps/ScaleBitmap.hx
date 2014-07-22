package ui.basics;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.errors.Error;
import flash.geom.Matrix;
import flash.geom.Rectangle;

/**
 * ...
 * @author Carmon
 */
class ScaleBitmap extends Bitmap
{
	private var _originalBitmap	:BitmapData;
	private var _scale9Grid	:Rectangle = null;

	public function new(bmpData:BitmapData = null, pixelSnapping:PixelSnapping = null, smoothing:Bool = false)
	{
		if (pixelSnapping == null) {
			pixelSnapping = PixelSnapping.AUTO;
		}
		super(bmpData, pixelSnapping, smoothing);
		_originalBitmap = bmpData.clone();
	}
	
	#if flash
	@:setter(bitmapData)
	function set_bitmapData(bmpData:BitmapData):Void
	#else
	override private function set_bitmapData(bmpData:BitmapData):BitmapData
	#end
	{
		_originalBitmap = bmpData.clone();
		if (_scale9Grid != null) {
			if (!validGrid(_scale9Grid)) {
				_scale9Grid = null;
			}
			setSize(bmpData.width, bmpData.height);
		} else {
			assignBitmapData(_originalBitmap.clone());
		}
		#if !flash
		return _originalBitmap;
		#end
	}
	
	#if flash
	@:setter(width)
	function set_width(w:Float):Void
	#else
	override private function set_width(w:Float):Float
	#end
	{
		if (w != width) {
			setSize(w, height);
		}
		#if !flash
		return width;
		#end
	}
	
	#if flash
	@:setter(height)
	function set_height(h:Float):Void
	#else
	override private function set_height(h:Float):Float
	#end
	{
		if (h != height) {
			setSize(width, h);
		}
		#if !flash
		return height;
		#end
	}
		
	private function assignBitmapData(bmp : BitmapData):Void 
	{
		#if flash
		super.bitmapData.dispose();
		super.bitmapData = bmp;
		#else
		if(bitmapData != null) bitmapData.dispose();
		super.set_bitmapData(bmp);
		#end
	}
	
	private function validGrid(r:Rectangle):Bool
	{
		return r.right <= _originalBitmap.width && r.bottom <= _originalBitmap.height;
	}
	
	#if flash
	@:setter(scale9Grid)
	function set_scale9Grid(r:Rectangle):Void
	#else
	override private function set_scale9Grid(r:Rectangle):Rectangle
	#end
	{
		if ((_scale9Grid == null && r != null) || (_scale9Grid != null && !_scale9Grid.equals(r))) {
			if (r == null) {
				var currentWidth:Float = width;
				var currentHeight:Float = height;
				_scale9Grid = null;
				assignBitmapData(_originalBitmap.clone());
				setSize(currentWidth, currentHeight);
			} else {
				if (!validGrid(r)) {
					throw (new Error("#001 - The _scale9Grid does not match the original BitmapData"));
					#if flash
					return;
					#else
					return null;
					#end
				}
				
				_scale9Grid = r.clone();
				resizeBitmap(width, height);
				scaleX = scaleY = 1;
			}
		}		
		#if !flash
		return _scale9Grid;
		#end
	}
	
	#if flash
	@:getter(scale9Grid)
	function get_scale9Grid():Rectangle
	#else 
	override private function get_scale9Grid():Rectangle
	#end
	{
		return _scale9Grid;
	}
	
	public function setSize(w:Float, h:Float):Void 
	{
		if (_scale9Grid == null) {
			super.width = w;
			super.height = h;
		} else {
			w = Math.max(w, _originalBitmap.width - _scale9Grid.width);
			h = Math.max(h, _originalBitmap.height - _scale9Grid.height);
			resizeBitmap(w, h);
		}
	}
	
	public function getOriginalBitmapData():BitmapData 
	{
		return _originalBitmap;
	}
	
	private function resizeBitmap(w:Float, h:Float):Void 
	{			
		var bmpData:BitmapData = new BitmapData(cast(w, Int), cast(h, Int), true, 0x00000000);
		
		var rows:Array<Float> = [0, _scale9Grid.top, _scale9Grid.bottom, _originalBitmap.height];
		var cols:Array<Float> = [0, _scale9Grid.left, _scale9Grid.right, _originalBitmap.width];
		
		var dRows:Array<Float> = [0, _scale9Grid.top, h - (_originalBitmap.height - _scale9Grid.bottom), h];
		var dCols:Array<Float> = [0, _scale9Grid.left, w - (_originalBitmap.width - _scale9Grid.right), w];

		var origin:Rectangle;
		var draw:Rectangle;
		var mat:Matrix = new Matrix();
		
		for (cx in 0...3) {
			for (cy in 0...3) {
				origin = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
				draw = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
				mat.identity();
				mat.a = draw.width / origin.width;
				mat.d = draw.height / origin.height;
				mat.tx = draw.x - origin.x * mat.a;
				mat.ty = draw.y - origin.y * mat.d;
				bmpData.draw(_originalBitmap, mat, null, null, draw, smoothing);
			}
		}
		assignBitmapData(bmpData);
	}
}