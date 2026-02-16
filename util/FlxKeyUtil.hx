package macohi.util;

import flixel.input.keyboard.FlxKey;

using macohi.util.StringUtil;

class FlxKeyUtil
{
	public static function keyToString(key:FlxKey):String
		return key.toString();

	public static function keysArrayToStringArray(keys:Array<FlxKey>):Array<String>
	{
		var stringArray:Array<String> = [];

		for (key in keys)
			if (!keyToString(key).isBlank())
				stringArray.push(keyToString(key));

		return stringArray;
	}
}
