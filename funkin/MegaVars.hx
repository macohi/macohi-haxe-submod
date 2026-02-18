package macohi.funkin;

import macohi.funkin.koya.backend.AssetPaths;

class MegaVars
{
	public static var VCR_FONT:String = 'vcr.ttf';
	public static var VCR_LIBRARY:String = null;

	public static var SOUND_MENU_SCROLL:String = AssetPaths.sound('scrollMenu', 'ui');
	public static var SOUND_MENU_CONFIRM:String = AssetPaths.sound('confirmMenu', 'ui');
	public static var SOUND_MENU_BACK:String = AssetPaths.sound('cancelMenu', 'ui');

	public static var KOYA_MENUBG_PINK:String->String = function(lib)
	{
		return AssetPaths.image('bg_pink', lib);
	};
	public static var KOYA_MENUBG_DESAT:String->String = function(lib)
	{
		return AssetPaths.image('bg_desat', lib);
	};

	public static var KOYA_MENUITEM_LIBRARY:String = 'ui';
}
