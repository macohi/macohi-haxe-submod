package macohi.overrides;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.util.typeLimit.NextState;

class MSubState extends FlxSubState
{
	public function switchState(state:NextState)
	{
		FlxG.switchState(state);
	}
}
