package macohi.backend;

import flixel.system.debug.log.LogStyle;
import flixel.FlxG;

class WeirdWebAssets
{
	public static function fixThem()
	{
		#if html5
		FlxG.debugger.toggleKeys = [];

		LogStyle.ERROR.openConsole = false;
		LogStyle.ERROR.errorSound = null;
		LogStyle.WARNING.openConsole = false;
		LogStyle.WARNING.errorSound = null;
		#end
	}
}
