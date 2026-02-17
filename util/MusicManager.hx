package macohi.util;

import flixel.FlxBasic;
import flixel.FlxG;
import macohi.funkin.koya.backend.AssetPaths;

class MusicManager extends FlxBasic
{
	public static var tracks:Array<String> = [];

	public static function getRandomTrackPath():String
	{
		return getTrackPath(getRandomTrack());
	}

	public static function getRandomTrack():String
	{
		return tracks[FlxG.random.int(0, tracks.length - 1)];
	}

	public static function getTrackPath(track:String):String
	{
		return AssetPaths.music(track);
	}

	// _% chance for it to play
	public static var MUSIC_FREQUENCY:Float = 15.0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!FlxG.sound.music?.playing || FlxG.sound.music == null)
		{
			trace('Music Attempt');

			if (FlxG.random.bool(MUSIC_FREQUENCY))
				FlxG.sound.playMusic(getRandomTrackPath(), 1);
		}
	}
}
