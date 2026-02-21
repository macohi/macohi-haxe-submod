package macohi.overrides;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.util.typeLimit.NextState;

class MState extends FlxState
{
	public function switchState(state:NextState)
	{
		FlxG.switchState(state);
	}

	public var leftWatermark:MText = new MText(10, 10, FlxG.width, 'left watermark', 8);
	public var rightWatermark:MText = new MText(-10, 10, FlxG.width, 'right watermark', 8);

	override function create()
	{
		super.create();

		leftWatermark.alignment = LEFT;
		rightWatermark.alignment = RIGHT;

		for (watermark in [leftWatermark, rightWatermark])
		{
			watermark.fieldWidth = FlxG.width - Math.abs(watermark.x);
			watermark.setBorderStyle(OUTLINE, FlxColor.BLACK, 2);
			watermark.visible = false;
			add(watermark);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		for (obj in members)
			obj.active = obj.visible && Reflect.field(obj, 'alpha') ?? 1 > 0;
	}
}
