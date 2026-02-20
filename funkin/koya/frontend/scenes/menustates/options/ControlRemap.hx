package macohi.funkin.koya.frontend.scenes.menustates.options;

import flixel.FlxG;

using StringTools;


class ControlRemap extends OptionsMenuState
{
	public var altMod:Bool = false;

	public function altControls():Bool
	{
		
		// valueText.text += '\n\n( Toggle alts via UI_LEFT or UI_RIGHT )';

		return false;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (subState == null && altControls())
		{
			FlxG.sound.play(MegaVars.SOUND_MENU_SCROLL);

			altMod = !altMod;

			reloadItems();
			reloadMenuItems();
		}
		
		valueText.y = valueBG.getGraphicMidpoint().y - (valueText.height / 2);
	}

	override function addItems()
	{
		addItem('Leave', 'Select this to return to the regular options menu', back);

		var stringKeybinds:Array<String> = [];
		for (keybind in KeybindPrompt.keybinds())
			if (keybind != null)
				stringKeybinds.push(keybind.field);

		for (keybind in KeybindPrompt.keybinds())
		{
			if (keybind == null)
			{
				addItem(null, null, null);
				continue;
			}

			if (stringKeybinds.contains('${keybind.field}_alt')
				|| stringKeybinds.contains(keybind.field.substr(0, keybind.field.length - 4)))
			{
				if (keybind.field.endsWith('_alt') && !altMod)
					continue;
				if (!keybind.field.endsWith('_alt') && altMod)
					continue;
			}

			addItemBasedOnSaveField(keybind, function()
			{
				persistentUpdate = true;
				openSubState(new KeybindPrompt(keybind.field, function(confirm:Bool)
				{
					reloadItems();
					// controls.setKeyboardScheme(Custom);
				}));
			});
		}
	}

	override function back()
	{
		FlxG.switchState(() -> new OptionsMenuState());
	}
}
