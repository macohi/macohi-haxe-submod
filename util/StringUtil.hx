package macohi.util;

import macohi.funkin.koya.backend.KoyaAssets;

/**
	Utility for Strings

	_Last edit date_: 2026-02-09
	@since 2026-02-09
**/
class StringUtil
{
	public static function splitStringByNewlines(str:String):Array<String>
	{
		if (str == null)
			return [];

		return str.split('\n');
	}

	public static function splitTextAssetByNewlines(txt:String)
	{
		if (!KoyaAssets.exists(txt))
		{
			WindowUtil.alert('Missing Path: $txt', '$txt is a missing path\nand thus cannot be split by newlines');
			return [];
		}

		return splitStringByNewlines(KoyaAssets.getText(txt));
	}
}
