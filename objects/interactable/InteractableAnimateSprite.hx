package macohi.objects.interactable;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.util.FlxSignal;

class InteractableAnimateSprite extends AnimateSprite
{
	public var onOverlap:FlxSignal = new FlxSignal();
	public var overlaping:Bool = false;

	public var onLeftClick_justPressed:FlxSignal = new FlxSignal();
	public var onRightClick_justPressed:FlxSignal = new FlxSignal();
	public var onMiddleClick_justPressed:FlxSignal = new FlxSignal();

	public var onLeftClick_justReleased:FlxSignal = new FlxSignal();
	public var onRightClick_justReleased:FlxSignal = new FlxSignal();
	public var onMiddleClick_justReleased:FlxSignal = new FlxSignal();

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(this))
		{
			if (!overlaping)
			{
				onOverlap.dispatch();
				overlaping = true;
			}

			if (FlxG.mouse.justPressed)
				onLeftClick_justPressed.dispatch();
			if (FlxG.mouse.justPressedMiddle)
				onMiddleClick_justPressed.dispatch();
			if (FlxG.mouse.justPressedRight)
				onRightClick_justPressed.dispatch();

			if (FlxG.mouse.justReleased)
				onLeftClick_justReleased.dispatch();
			if (FlxG.mouse.justReleasedMiddle)
				onMiddleClick_justReleased.dispatch();
			if (FlxG.mouse.justReleasedRight)
				onRightClick_justReleased.dispatch();
		}
		else if (overlaping)
			overlaping = false;
	}
}
