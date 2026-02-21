package macohi.util;

import flixel.FlxG;

enum abstract Direction(Int) from Int to Int
{
	var LEFT = 0;
	var DOWN = 1;
	var UP = 2;
	var RIGHT = 3;

	public static function randomDirection():Direction
		return FlxG.random.int(0, 3);

	public static function forEachDirectional(f:Int->Void)
		for (i in 0...4)
		{
			f(i);
		}
}
