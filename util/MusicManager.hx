package macohi.util;

import flixel.FlxBasic;
import flixel.FlxG;
import macohi.funkin.koya.backend.AssetPaths;

using macohi.util.TimeUtil;

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

	public static var lastAttemptTime:Date;

	public static var secondsUntilCanPlayMusicAgain:Float = 15.0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!FlxG.sound.music?.playing || FlxG.sound.music == null)
		{

			if (lastAttemptTime != null)
				if (Date.now().getTime() - lastAttemptTime.getTime() < secondsUntilCanPlayMusicAgain.convert_s_to_ms())
					return;

			trace('Valid Music Attempt');
			lastAttemptTime = Date.now();

			if (FlxG.random.bool(MUSIC_FREQUENCY))
				FlxG.sound.playMusic(getRandomTrackPath(), 1);
		}
	}
}
