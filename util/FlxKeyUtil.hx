package macohi.util;

import flixel.input.keyboard.FlxKey;

using macohi.util.StringUtil;

class FlxKeyUtil
{
	public static function invalidKey(key:Null<FlxKey>)
		return key == null;

	public static function invalidKeys(keys:Array<FlxKey>)
		return keys == null || keys.length == 0;

	public static function keyToString(key:Null<FlxKey>):String
		return (invalidKey(key)) ? null : key.toString();

	public static function stringToKey(key:String):Null<FlxKey>
		return (key.isBlankStr()) ? null : FlxKey.fromString(key);

	public static function keysArrayToStringArray(keys:Array<FlxKey>):Array<String>
	{
		var stringArray:Array<String> = [];

		if (invalidKeys(keys))
			return [];

		for (key in keys)
			if (!keyToString(key).isBlankStr())
				stringArray.push(keyToString(key));

		return stringArray;
	}

	public static function stringArrayToKeysArray(keys:Array<String>):Array<FlxKey>
	{
		var keysArray:Array<FlxKey> = [];

		if (keys.isBlankStrArray())
			return [];

		for (key in keys)
			if (!key.isBlankStr())
				keysArray.push(stringToKey(key));

		return keysArray;
	}

	public static function youCanPressString(keys:Array<FlxKey>):String
	{
		var stringArray:Array<String> = [];

		if (invalidKeys(keys))
			return '';

		var i = 0;
		for (key in keys)
		{
			if (!keyToString(key).isBlankStr())
				stringArray.push(keyToString(key) + ((i < keys.length - 1) ? ',' : ''));
			i++;
		}

		if (stringArray.length > 2)
			stringArray[stringArray.length - 1] = 'or ${stringArray[stringArray.length - 1].substr(0, stringArray[stringArray.length - 1].length - 1)}';

		var ycps:String = stringArray.join(' ');

		return ycps;
	}
}
