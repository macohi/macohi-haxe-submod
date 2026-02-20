package macohi.funkin.koya.frontend.scenes.menustates.options;

import flixel.FlxG;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import macohi.funkin.pre_vslice.MusicBeatSubstate;

using StringTools;


class Prompt extends MusicBeatSubstate
{
	public var promptText:FlxText;
	public var bg:FunkinSprite = new FunkinSprite();
	public var colorShit:FunkinSprite = new FunkinSprite();

	public var leaveMethod:Bool->Void;

	public var prompt:String = 'Unknown Prompt';

	override public function new(?leaveMethod:Bool->Void)
	{
		super();

		this.leaveMethod = leaveMethod;
	}

	override function create()
	{
		super.create();

		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		colorShit.makeGraphic(FlxG.width, FlxG.height, FlxColor.fromString('#FF99CC'));
		colorShit.scale.set(0.9, 0.9);
		colorShit.updateHitbox();
		colorShit.screenCenter();
		colorShit.alpha = 0;
		colorShit.scrollFactor.set();
		add(colorShit);

		promptText = new FlxText(colorShit.x, colorShit.y, colorShit.width, prompt, 16);
		add(promptText);

		promptText.x += 10;
		promptText.y += 10;

		promptText.alpha = 0;
		promptText.color = FlxColor.WHITE;

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(colorShit, {alpha: 1}, 0.6, {ease: FlxEase.quartInOut});
		FlxTween.tween(promptText, {alpha: 1}, 0.8, {ease: FlxEase.quartInOut});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		handleControls();
	}

	function handleControls() {}

	function accept()
	{
		confirmMenu.play(true);

		// this working feels wrong
		fade(true);
	}

	function deny()
	{
		cancelMenu.play(true);

		fade(1.0, false);
	}

	var cancelMenu = new FlxSound().loadEmbedded(MegaVars.SOUND_MENU_BACK);
	var confirmMenu = new FlxSound().loadEmbedded(MegaVars.SOUND_MENU_CONFIRM);

	function fade(longer:Float = 0, ?confirm:Bool = false)
	{
		if (leaveMethod != null)
			leaveMethod(confirm);

		FlxTween.tween(bg, {alpha: 0}, 0.75 + longer, {ease: FlxEase.quartInOut});
		FlxTween.tween(colorShit, {alpha: 0}, 0.5 + longer, {ease: FlxEase.quartInOut});
		FlxTween.tween(promptText, {alpha: 0}, 0.25 + longer, {ease: FlxEase.quartInOut});

		FlxTimer.wait(1.0 + longer, () ->
		{
			confirmMenu.stop();
			cancelMenu.stop();
			close();
		});
	}
}
