package macohi.util;

import lime.app.Application;

/**
	Utility for Windows

	_Last edit date_: 2026-02-09
	@since 2026-02-09
**/
class WindowUtil
{
	public static function alert(title:String, msg:String)
	{
		Application.current.window.alert(msg, title);
	}
}
