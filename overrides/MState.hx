package macohi.overrides;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.typeLimit.NextState;

class MState extends FlxState
{
	public function switchState(state:NextState)
	{
		FlxG.switchState(state);
	}
}
