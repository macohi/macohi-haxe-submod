package macohi.funkin.koya.frontend.scenes.menustates;

import flixel.FlxG;
import flixel.effects.FlxFlicker;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import macohi.funkin.koya.backend.AssetPaths;
import macohi.funkin.koya.frontend.ui.menustate.MenuState;
import macohi.save.SaveField;

using StringTools;

class OptionsMenuState extends MenuState
{
	public static var inGameplay:Bool = false;

	public var itemListValues:Map<String, Dynamic> = [];
	public var itemListFunctions:Map<String, Dynamic> = [];

	public function addItemBasedOnSaveField(savefield:SaveField<Any>, method:Dynamic)
	{
		addItem(savefield.display ?? savefield.field, savefield.get(), method);
	}

	public function addItem(item:String, value:Dynamic, method:Dynamic)
	{
		this.itemList.push(item);

		if (item != null && value != null)
			this.itemListValues.set(item, value);
		if (item != null && method != null)
			this.itemListFunctions.set(item, method);
	}

	override public function new()
	{
		super('', Vertical);

		this.itemIncOffset = 80;

		reloadItems();

		this.text = true;
	}

	var valueBG:FunkinSprite;
	var valueText:FlxText;

	override function create()
	{
		super.create();

		valueBG = new FunkinSprite();
		valueBG.makeGraphic(FlxG.width, Math.round(FlxG.height / 4), FlxColor.BLACK);
		add(valueBG);

		valueBG.screenCenter();
		valueBG.y = FlxG.height - valueBG.height;

		valueBG.alpha = 0.6;

		valueText = new FlxText(valueBG.x, valueBG.y, valueBG.width, 'Lorem', 32);
		add(valueText);
		valueText.setFormat(AssetPaths.font(MegaVars.VCR_FONT, MegaVars.VCR_LIBRARY), 32, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,
			FlxColor.BLACK);
		valueText.borderSize = 3;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		valueText.text = '${this.itemList[currentSelection.value()]} : ${this.itemListValues.get(this.itemList[currentSelection.value()])}';
		valueText.y = valueBG.getGraphicMidpoint().y - (valueText.height / 2);
	}

	override function accept(item:String)
	{
		super.accept(item);

		runMethods(item);
	}

	function runMethods(item:String)
	{
		if (itemListFunctions.exists(item))
		{
			itemListFunctions.get(item)();
			reloadItems();
		}
	}

	function reloadItems()
	{
		this.itemList = [];
		this.itemListValues = [];

		addItems();
	}

	function addItems() {}

	override function acceptedFlicker(confirmMenu:FlxSound, item:String)
	{
		if (pinkBG.visible)
			FlxFlicker.flicker(pinkBG, (confirmMenu.length / 4) / 1000, .1);
		if (!text)
			FlxFlicker.flicker(itemsSpriteGroup.members[currentSelection.value()], (confirmMenu.length / 4) / 500, .05);
		if (text && atlasText)
			FlxFlicker.flicker(itemsAtlasTextGroup.members[currentSelection.value()], (confirmMenu.length / 4) / 500, .05);
		if (text && !atlasText)
			FlxFlicker.flicker(itemsFlxTextGroup.members[currentSelection.value()], (confirmMenu.length / 4) / 500, .05);

		FlxTimer.wait((confirmMenu.length / 4) / 1000, function()
		{
			transitioning = false;
			accept(item);
		});
	}

	override function back()
	{
		transitioning = true;
	}
}
