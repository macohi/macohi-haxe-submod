package macohi.overrides;

import flixel.text.FlxText;

/**
	Override of `flixel.text.FlxText` to apply
	custom functionality to it.

	_Last edit date_: 2/9/2026
	@since 2/9/2026
**/
class MText extends FlxText
{
	/** Quickly generate a new Text Object with text and size parameters **/
	public function makeText(text:String, size:Int):MText
	{
		this.text = text;
		this.size = size;

		return this;
	}
}
