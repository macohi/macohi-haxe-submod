package macohi.util;

import flixel.math.FlxMath;

class TimeUtil
{
	public static function round(time:Float):Float
		return FlxMath.roundDecimal(time, 2);

	public static function convert_ms_to_s(milliseconds:Float):Float
		return milliseconds / 1000;

	public static function convert_s_to_ms(seconds:Float):Float
		return seconds * 1000;
}
