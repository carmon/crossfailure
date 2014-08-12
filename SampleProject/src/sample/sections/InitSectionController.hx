package sample.sections;

import crossfailure.controllers.AbstractController;
import crossfailure.models.AbstractModel;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import sample.SampleModel;

/**
 * ...
 * @author Carmon
 */
class InitSectionController extends AbstractController
{
	private var _block		:Sprite;
	private var _textfield	:TextField;

	public function new(model:AbstractModel) 
	{
		super(model);
		
		_textfield = new TextField();
		_textfield.textColor = 0xFFFFFF;
		_textfield.autoSize = TextFieldAutoSize.CENTER;
		#if android
		_textfield.text = "Tap anywhere to continue";
		#else
		_textfield.text = "Click anywhere to continue";
		#end
		_textfield.x = SampleModel.GAME_WIDTH * .5 - _textfield.width * .5;
		_textfield.y = SampleModel.GAME_HEIGHT * .5;
		_graphic.addChild(_textfield);
		
		_block = new Sprite();
		_block.graphics.beginFill(0x00, 0);
		_block.graphics.drawRect(0, 0, SampleModel.GAME_WIDTH, SampleModel.GAME_HEIGHT);
		_block.graphics.endFill();
		_block.useHandCursor = _block.buttonMode = true;
		_block.addEventListener(MouseEvent.CLICK, onClickBlock);
		_graphic.addChild(_block);
	}
	
	private function onClickBlock(e:MouseEvent):Void
	{
		_model.goto('../game');
	}
	
	override public function end():Void 
	{		
		_graphic.removeChild(_block);
		_block.removeEventListener(MouseEvent.CLICK, onClickBlock);
		_block = null;
		
		_graphic.removeChild(_textfield);
		_textfield = null;
		
		super.end();
	}
	
}