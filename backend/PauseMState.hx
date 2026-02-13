package macohi.backend;

import flixel.util.FlxColor;
import macohi.overrides.MSprite;
import flixel.FlxG;
import macohi.overrides.MState;

class PauseMState extends MState
{
	public var paused:Bool = true;
	public var pauseBG:MSprite;

	override function create()
	{
		super.create();

		pauseBG = new MSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		pauseBG.alpha = 0.6;
		add(pauseBG);

		togglePaused();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (getPauseBoolean())
			togglePaused();
	}

	public function getPauseBoolean():Bool
	{
		return FlxG.keys.anyJustReleased([ESCAPE]);
	}

	public function togglePaused()
	{
		paused = !paused;

		pauseBG.visible = paused;
	}
}
