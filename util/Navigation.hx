package macohi.util;

/**
	The navigation class.

	I'm serious.
	This class was made to reduce boilerplate inside menus where it would be uneccessary
	to have the same code over and over for everything. 

	Yoinked from https://github.com/SomeGuyWhoLovesCoding/FNF-PeoteView/blob/official/src/data/gameplay/Navigation.hx
**/
@:publicFields
@:noDebug
abstract Navigation(Int)
{
	inline function new() {}

	inline function scroll(amount:Int)
	{
		this += amount;
	}

	inline function reset()
	{
		this = 0;
	}

	inline function resetIfOver(amount:Int)
	{
		if (this >= amount)
		{
			this = 0;
		}
	}

	inline function resetIfUnder(amount:Int, setTo:Int)
	{
		if (this < amount)
		{
			this = setTo;
		}
	}

	inline function resetIfBoth(over:Int, under:Int, setTo:Int)
	{
		resetIfOver(over);
		resetIfUnder(under, setTo);
	}

	inline function value()
		return this;
}
