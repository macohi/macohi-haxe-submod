package macohi.util;

import flixel.input.keyboard.FlxKey;

using macohi.util.StringUtil;

class ArrayUtil
{
	public static function convertStringToFlxKey(strA:Array<String>):Array<FlxKey>
	{
		var flxKeyA:Array<FlxKey> = [];

		if (strA != null)
			for (str in strA)
				if (!str.isBlank())
					flxKeyA.push(FlxKey.fromString(str));

		return flxKeyA;
	}
}
