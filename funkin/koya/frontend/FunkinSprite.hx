package macohi.funkin.koya.frontend;

import macohi.objects.AnimateSprite;
import flixel.FlxSprite;
import flixel.FlxG;
import macohi.funkin.koya.backend.AssetPaths;
import animate.FlxAnimate;

class FunkinSprite extends AnimateSprite
{
	public var cameraOffsets:Array<Float> = [0, 0];

	public function parseAnimationOffsetFile(offsetFile:Array<String>)
	{
		for (line in offsetFile)
		{
			var splitLine = line.split(' ');

			var anim = splitLine[0] ?? null;
			var x = splitLine[1] ?? '0';
			var y = splitLine[2] ?? '0';

			if (anim != null)
				addOffset(anim, Std.parseFloat(x), Std.parseFloat(y));
		}
	}
}
