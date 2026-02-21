package macohi.backend.polymod;

import polymod.format.ParseRules.JSONParseFormat;

class JsonMergeAndAppend
{
	public static function append(baseText:String, mergeText:String, id:String):String
	{
		return new JSONParseFormat().append(baseText, mergeText, id);
	}

	public static function merge(baseText:String, mergeText:String, id:String):String
	{
		return new JSONParseFormat().merge(baseText, mergeText, id);
	}
}
