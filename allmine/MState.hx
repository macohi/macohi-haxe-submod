package macohi.allmine;

import flixel.util.typeLimit.NextState;
import flixel.FlxG;
import flixel.FlxState;

class MState extends FlxState
{
	public function switchState(state:NextState)
	{
		FlxG.switchState(state);
	}
}
