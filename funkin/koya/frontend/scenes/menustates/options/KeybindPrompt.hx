package macohi.funkin.koya.frontend.scenes.menustates.options;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import macohi.save.Save;
import macohi.save.SaveField;

using StringTools;

class KeybindPrompt extends Prompt
{
	var keybind:String;

	public var pauseTick:Int = 0;

	public var keyNum:Int = 0;
	public var maxKeyNum:Int = 2;

	var keybindField:SaveField<Array<String>>;

	override public function new(keybind:String, ?leaveMethod:Bool->Void)
	{
		super(leaveMethod);

		this.keybind = keybind;

		keybindField = Reflect.getProperty(Save, keybind);
		maxKeyNum = keybindField.get().length;
	}

	override function create()
	{
		super.create();

		if (keybindField == null)
		{
			promptText.text = 'Not allowing binding\n\nKeybind save field not found';
			deny();
		}
	}

	public static dynamic function keybinds():Array<SaveField<Array<String>>>
	{
		return [];
	}

	override function handleControls()
	{
		super.handleControls();

		if (pauseTick < 1)
			this.prompt = 'Binding: ' + '“${this.keybind}”' + '\nKey number: $keyNum\n\nESCAPE TO CANCEL';
		else
			pauseTick--;

		if (!FlxG.keys.justPressed.ESCAPE)
			return;
		if (!FlxG.keys.justPressed.ANY)
			return;
		if (keyNum >= maxKeyNum)
			accept();

		var invalids:Array<FlxKey> = [ESCAPE];

		for (keybindList in keybinds())
			for (key in keybindList.get())
				invalids.push(FlxKey.fromString(key));

		var key:FlxKey = cast FlxG.keys.firstJustReleased();

		if (invalids.contains(key))
		{
			promptText.text = 'Not bound\n\nKey already bound';
			return;
		}

		var keyString = key.toString();

		keybindField.get()[keyNum] = keyString;
		promptText.text = 'Bound key #$keyNum to “$keyString”';

		keyNum++;
		pauseTick = 400;
	}
}
