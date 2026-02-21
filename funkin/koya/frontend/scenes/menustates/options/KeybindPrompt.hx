package macohi.funkin.koya.frontend.scenes.menustates.options;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import macohi.save.Save;
import macohi.save.SaveField;

using StringTools;

class KeybindPrompt extends Prompt
{
	public var keybind:String;

	public var pauseTick:Int = 0;

	public var keyNum:Int = 0;
	public var maxKeyNum:Int = 2;

	public var keybindField:SaveField<Array<String>>;

	public var invalids:Array<String> = [];

	override public function new(keybind:String, ?leaveMethod:Bool->Void)
	{
		super(leaveMethod);

		this.keybind = keybind;

		keybindField = getKeybind(keybind, getSave());

		if (keybindField == null || keybindField.get() == null)
		{
			prompt = 'Not allowing binding\n\nKeybind save field not found';
			deny();
		}

		maxKeyNum = keybindField?.get()?.length - 1 ?? 0;
	}

	public static dynamic function getSave():Dynamic
		return Save;

	public static dynamic function getKeybind(keybind:String, getSave:Void->Dynamic):SaveField<Array<String>>
	{
		return null;
	}

	public static dynamic function keybinds():Array<SaveField<Array<String>>>
	{
		return [];
	}

	public static dynamic function getBack():Bool
	{
		return false;
	}

	public static dynamic function extraControls():String
	{
		return '';
	}

	public static dynamic function extraControlFunctions(prompt:KeybindPrompt):Bool
	{
		return true;
	}

	override function handleControls()
	{
		super.handleControls();

		// your problem
		invalids = ['BACKSPACE'];
		for (keybindList in keybinds())
			for (key in keybindList.get())
				if (FlxKey.fromString(key) != NONE)
					invalids.push(key);

		FlxG.watch.addQuick('invalids', invalids);

		if (pauseTick < 1)
			promptText.text = 'Binding: '
				+ '“${this.keybind}”'
				+ '\nKey index: ${keyNum + 1}\n\nCurrent Binds: ${getKeybind(keybind, getSave()).get()}${extraControls()}';
		else
			pauseTick--;

		if (getBack())
		{
			promptText.text = 'Bye :3';
			pauseTick = 10000;
			deny();
			return;
		}

		if (!FlxG.keys.justPressed.ANY)
			return;
		if (keyNum >= maxKeyNum)
			accept();

		var ecf = extraControlFunctions(this);
		if (!ecf)
			return;

		var key:FlxKey = cast FlxG.keys.firstJustPressed();

		if (key == NONE)
		{
			promptText.text = 'Not bound\n\nNONE?';
			pauseTick = 100;
			return;
		}

		if (invalids.contains(key.toString()))
		{
			promptText.text = 'Not bound\n\nKey already bound';
			pauseTick = 100;
			keyNum++;
			return;
		}

		var keyString = key.toString();

		keybindField.get()[keyNum] = keyString;
		promptText.text = 'Bound key #${keyNum + 1} to “$keyString”';

		keyNum++;
		pauseTick = 100;
	}
}
