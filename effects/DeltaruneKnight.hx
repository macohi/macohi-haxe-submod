package macohi.effects;

import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class DeltaruneKnight
{
	/**
	 * Creates a trail similar to that of the roaring knight from Deltarune
	 *
	 * Yoinked from kivers9k
	 *
	 * @param sprite the sprite you wish to have this effect
	 * @param xEnd when the trail sprites get deleted
	 * @param delay how long until each trail sprite spawns
	 * @param speed How fast the trail sprites go
	 * @param max how many trail sprites you want
	 */
	public static function createXTrail(sprite:FlxSprite, xEnd:Float, delay:Float, speed:Float, max:Int)
	{
		var trails = new FlxSpriteGroup(0, 0, max);

		new FlxTimer().start(delay, function(timer:FlxTimer)
		{
			var trail = sprite.clone();
			trail.setPosition(sprite.x, sprite.y);
			trail.alpha = 0.7;
			trails.add(trail);

			FlxTween.tween(trail, {x: sprite.x + xEnd, alpha: 0}, speed, {
				onComplete: tween ->
				{
					trails.remove(trail);
				}
			});

			timer.reset(delay);
		});
		return trails;
	}

	/**
	 * Creates a trail similar to that of the roaring knight from Deltarune but now vertical
	 *
	 * @param sprite the sprite you wish to have this effect
	 * @param yEnd when the trail sprites get deleted
	 * @param delay how long until each trail sprite spawns
	 * @param speed How fast the trail sprites go
	 * @param max how many trail sprites you want
	 */
	public static function createYTrail(sprite:FlxSprite, yEnd:Float, delay:Float, speed:Float, max:Int)
	{
		var trails = new FlxSpriteGroup(0, 0, max);

		new FlxTimer().start(delay, function(timer:FlxTimer)
		{
			var trail = sprite.clone();
			trail.setPosition(sprite.x, sprite.y);
			trail.alpha = 0.7;
			trails.add(trail);

			FlxTween.tween(trail, {y: sprite.y + yEnd, alpha: 0}, speed, {
				onComplete: tween ->
				{
					trails.remove(trail);
				}
			});

			timer.reset(delay);
		});
		return trails;
	}
}
