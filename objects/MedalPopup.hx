package macohi.objects;

import macohi.funkin.koya.backend.AssetPaths;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import macohi.overrides.MSprite;
import flixel.FlxBasic;

class MedalPopup extends FlxBasic
{
	public static var medal:MSprite = new MSprite();

	override public function new()
	{
		super();
	}

	public static function displayMedal(mp:String)
	{
		medal.destroy();

		medal = new MSprite().loadGraphic(mp);
		medal.screenCenter();

		medal.y = FlxG.height * 0.75;

		medal.alpha = 1;

		FlxTween.tween(medal, {alpha: 0}, 0.5, {
			startDelay: 1,
		});

		FlxG.sound.playMusic(AssetPaths.sound('medalpopup', 'medals'), 1.0, false, null);
	}

	override function draw()
	{
		super.draw();

		// if (medal != null && medal.graphic != null && medal.alpha > 0)
			// medal.draw();
	}
}
