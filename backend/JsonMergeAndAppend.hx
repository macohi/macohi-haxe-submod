package macohi.backend;

import json.JSONData;
import json.patch.JSONPatch;

// yoinked from polymod
class JsonMergeAndAppend
{
	/**
	 * If replacer is given and is not null, it is used to retrieve the actual object to be encoded.
	 * The replacer function takes two parameters, the key and the value being encoded.
	 * Initial key value is an empty string.
	 */
	public static var replacer(default, null):Dynamic->Dynamic->Dynamic;

	/**
	 * If space is given and is not null, the result will be pretty-printed. Successive levels will be indented by this string.
	 */
	public static var space(default, null):String;

	public static function parse(str:String):JSONData
	{
		var result = JSONData.parse(~/(\r|\n|\t)/g.replace(str, ''));
		return result;
	}

	public static function append(baseText:String, appendText:String, id:String):String
	{
		var baseJson:JSONData = parse(baseText);
		var appendJson:JSONData = parse(appendText);

		var patchData = convertJSONToPatches(appendJson);

		trace('Applying patches: ${patchData}');

		var finalJson = JSONPatch.applyPatches(baseJson, patchData);

		return print(finalJson);
	}

	/**
	 * Convert a JSON object to an array of JSON patches, to append this JSON to another.
	 */
	static function convertJSONToPatches(json:Dynamic):Array<JSONData>
	{
		var keys = Reflect.fields(json);

		var patches:Array<JSONData> = [];

		for (key in keys)
		{
			var value = Reflect.field(json, key);
			patches.push({"op": "add", "path": '/${key}', "value": value});
		}

		return patches;
	}

	public static function merge(baseText:String, mergeText:String, id:String):String
	{
		var baseJson:JSONData = parse(baseText);
		var mergeJson:JSONData = parse(mergeText);

		trace('Applying patches: ${mergeJson}');

		var finalJson = JSONPatch.applyPatches(baseJson, mergeJson);

		return print(finalJson);
	}

	public static function print(data:Dynamic):String
	{
		return haxe.Json.stringify(data, replacer, space);
	}
}
