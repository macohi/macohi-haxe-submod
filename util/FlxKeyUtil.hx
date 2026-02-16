package macohi.util;

import flixel.input.keyboard.FlxKey;

using macohi.util.StringUtil;

class FlxKeyUtil
{
	public static function keyToString(key:FlxKey):String
		return key.toString();

	public static function stringToKey(key:String):FlxKey
		return FlxKey.fromString(key);

	public static function keysArrayToStringArray(keys:Array<FlxKey>):Array<String>
	{
		var stringArray:Array<String> = [];

		for (key in keys)
			if (!keyToString(key).isBlank())
				stringArray.push(keyToString(key));

		return stringArray;
	}

	public static function stringArrayToKeysArray(keys:Array<String>):Array<FlxKey>
	{
		var keysArray:Array<FlxKey> = [];

		for (key in keys)
			if (!key.isBlank())
				keysArray.push(stringToKey(key));

		return keysArray;
	}

	public static function youCanPressString(keys:Array<FlxKey>):String
	{
		var stringArray:Array<String> = [];

		for (key in keys)
			if (!keyToString(key).isBlank())
				stringArray.push(keyToString(key) + ',');

		stringArray[stringArray.length - 1] = 'or ${stringArray[stringArray.length - 1].substr(0, stringArray[stringArray.length - 1].length - 1)}';

		return stringArray.join(' ');
	}
}
