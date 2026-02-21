package macohi.funkin.koya.frontend.ui.menustate;

import flixel.FlxG;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import macohi.funkin.koya.backend.AssetPaths;
import macohi.funkin.pre_vslice.Conductor;
import macohi.funkin.pre_vslice.MusicBeatState;
import macohi.util.Navigation;

using StringTools;
using macohi.util.StringUtil;

enum MenuType
{
	Vertical;
	Horizontal;
}

class MenuState extends MusicBeatState
{
	public var pinkBG:MenuBG = new MenuBG(true);
	public var flashBG:MenuBG = new MenuBG(false);

	public var itemList:Array<String> = [];
	public var itemsSpriteGroup:FlxTypedGroup<MenuItem>;

	public var itemsAtlasTextGroup:FlxTypedGroup<AtlasText>;
	public var itemsFlxTextGroup:FlxTypedGroup<FlxText>;

	public var currentSelection:Navigation = new Navigation();

	public var menuType:MenuType = Vertical;
	public var menuItemPathPrefix:String = '';
	public var text:Bool = false;
	public var atlasText:Bool = true;

	public var itemStartingPos:Float = 240;
	public var itemIncOffset:Float = 320;

	override public function new(menuItemPathPrefix:String, menuType:MenuType = Vertical)
	{
		super();

		this.menuType = menuType;
		this.menuItemPathPrefix = menuItemPathPrefix;
	}

	override function create()
	{
		super.create();

		flashBG.color = 0x645B9A;
		add(flashBG);
		add(pinkBG);

		flashBG.scale.set(.75, .75);
		pinkBG.scale.set(.75, .75);

		flashBG.updateHitbox();
		pinkBG.updateHitbox();

		itemsSpriteGroup = new FlxTypedGroup<MenuItem>();
		add(itemsSpriteGroup);

		itemsAtlasTextGroup = new FlxTypedGroup<AtlasText>();
		add(itemsAtlasTextGroup);

		itemsFlxTextGroup = new FlxTypedGroup<FlxText>();
		add(itemsFlxTextGroup);

		reloadMenuItems();

		pinkBG.reloadBG();
		flashBG.reloadBG();
	}

	public function reloadMenuItems()
	{
		atlasText = false;

		itemsFlxTextGroup.clear();
		// itemsAtlasTextGroup.clear();
		itemsSpriteGroup.clear();

		var i = 0;
		for (item in itemList)
		{
			if (!text)
				makeSprite(item, i);
			if (text && atlasText)
				makeAtlasText(item, i);
			if (text && !atlasText)
				makeFlxText(item, i);

			i++;
		}

		select();
	}

	public function makeAtlasText(item:String, i:Int)
	{
		var menuItem = new AtlasText((menuType == Horizontal) ? -640 : 0, (menuType == Vertical) ? -640 : 0, item, BOLD);

		if (menuType == Horizontal)
			menuItem.screenCenter(Y);
		if (menuType == Vertical)
			menuItem.screenCenter(X);

		menuItem.ID = i;
		itemsAtlasTextGroup.add(menuItem);
	}

	public function makeFlxText(item:String, i:Int)
	{
		var menuItem = new FlxText((menuType == Horizontal) ? -640 : 0, (menuType == Vertical) ? -640 : 0, 0, item);
		menuItem.setFormat(AssetPaths.font(MegaVars.VCR_FONT, MegaVars.VCR_LIBRARY), 48, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		menuItem.setBorderStyle(OUTLINE, FlxColor.BLACK, 4);

		if (menuType == Horizontal)
			menuItem.screenCenter(Y);
		if (menuType == Vertical)
			menuItem.screenCenter(X);

		menuItem.ID = i;
		itemsFlxTextGroup.add(menuItem);
	}

	public function makeSprite(item:String, i:Int)
	{
		var menuItem = new MenuItem(item, menuItemPathPrefix, (menuType == Horizontal) ? -640 : 0, (menuType == Vertical) ? -640 : 0);

		menuItem.scale.set(.5, .5);
		menuItem.updateHitbox();
		menuItem.makeOffsets();

		menuItem.playAnim('idle');

		if (menuType == Horizontal)
			menuItem.screenCenter(Y);
		if (menuType == Vertical)
			menuItem.screenCenter(X);

		menuItem.ID = i;
		itemsSpriteGroup.add(menuItem);
	}

	public var transitioning:Bool = false;

	public function acceptFunction()
	{
		if (text && !atlasText)
			accepted(itemsFlxTextGroup.members[currentSelection.value()].text);
		if (text && atlasText)
			accepted(itemsAtlasTextGroup.members[currentSelection.value()].text);

		if (!text)
			accepted(itemsSpriteGroup.members[currentSelection.value()].item);
	}

	public function controlsAll()
	{
		if (menuType == Vertical)
			controlsMoveVertical();

		if (menuType == Horizontal)
			controlsMoveHorizontal();

		controlsOther();
	}

	public function controlsMoveVertical() {}

	public function controlsMoveHorizontal() {}

	public function controlsOther() {}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (subState == null)
			controlsAll();

		for (obj in members)
			obj.active = obj.visible && Reflect.field(obj, 'alpha') ?? 1 > 0;

		if (menuType == Vertical)
		{
			pinkBG.screenCenter(X);
			pinkBG.y = FlxMath.lerp(pinkBG.y, (FlxG.height - pinkBG.height) / 2 - (currentSelection.value() * 2), .1);
		}
		else
		{
			pinkBG.screenCenter(Y);
			pinkBG.x = FlxMath.lerp(pinkBG.x, (FlxG.width - pinkBG.width) / 2 - (currentSelection.value() * 2), .1);
		}
		flashBG.setPosition(pinkBG.x, pinkBG.y);

		if (!text)
			for (menuItem in itemsSpriteGroup.members)
			{
				if (menuType == Horizontal)
					menuItem.x = FlxMath.lerp(menuItem.x, itemStartingPos + (itemIncOffset * (menuItem.ID - currentSelection.value())), .1);
				if (menuType == Vertical)
					menuItem.y = FlxMath.lerp(menuItem.y, itemStartingPos + (itemIncOffset * (menuItem.ID - currentSelection.value())), .1);
			}

		if (text && atlasText)
			for (menuItem in itemsAtlasTextGroup.members)
			{
				if (menuType == Horizontal)
					menuItem.x = FlxMath.lerp(menuItem.x, itemStartingPos + (itemIncOffset * (menuItem.ID - currentSelection.value())), .1);
				if (menuType == Vertical)
					menuItem.y = FlxMath.lerp(menuItem.y, itemStartingPos + (itemIncOffset * (menuItem.ID - currentSelection.value())), .1);
			}

		if (text && !atlasText)
			for (menuItem in itemsFlxTextGroup.members)
			{
				if (menuType == Horizontal)
					menuItem.x = FlxMath.lerp(menuItem.x, itemStartingPos + (itemIncOffset * (menuItem.ID - currentSelection.value())), .1);
				if (menuType == Vertical)
					menuItem.y = FlxMath.lerp(menuItem.y, itemStartingPos + (itemIncOffset * (menuItem.ID - currentSelection.value())), .1);
			}

		// if ((FlxG.sound.music == null || !FlxG.sound.music.playing) && !transitioning)
		// {
		// 	FlxG.sound.playMusic(AssetPaths.music('freakyMenu'), 0.7, false);
		// 	Conductor.changeBPM(102);
		// }

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
	}

	public function back()
	{
		// FlxG.switchState(() -> new TitleState());
	}

	public function select(change:Int = 0)
	{
		currentSelection.scroll(change);

		currentSelection.resetIfBoth(itemList.length, itemList.length - 1, 0, 0);

		if (change != 0)
			if (itemList[currentSelection.value()].isBlankStr())
				select(change);

		if (!text)
			for (menuItem in itemsSpriteGroup.members)
			{
				if (menuType == Horizontal)
					menuItem.screenCenter(Y);
				if (menuType == Vertical)
					menuItem.screenCenter(X);
				menuItem.playAnim('idle');

				if (menuItem.ID == currentSelection.value())
					menuItem.playAnim('selected');
			}
		if (text && atlasText)
			for (menuItem in itemsAtlasTextGroup.members)
			{
				if (menuType == Horizontal)
					menuItem.screenCenter(Y);
				if (menuType == Vertical)
					menuItem.screenCenter(X);

				menuItem.alpha = (menuItem.ID == currentSelection.value()) ? 1.0 : 0.6;
			}
		if (text && !atlasText)
			for (menuItem in itemsFlxTextGroup.members)
			{
				if (menuType == Horizontal)
					menuItem.screenCenter(Y);
				if (menuType == Vertical)
					menuItem.screenCenter(X);

				menuItem.alpha = (menuItem.ID == currentSelection.value()) ? 1.0 : 0.6;
			}

		if (change != 0)
			if (!MegaVars.SOUND_MENU_SCROLL.isBlankStr())
				FlxG.sound.play(MegaVars.SOUND_MENU_SCROLL);
	}

	public function accepted(item:String)
	{
		if (item.isBlankStr())
			return;

		trace('selected: $item');

		transitioning = true;

		var confirmMenu = new FlxSound();
		if (!MegaVars.SOUND_MENU_CONFIRM.isBlankStr())
			confirmMenu.loadEmbedded(MegaVars.SOUND_MENU_CONFIRM);

		confirmMenu.play();

		acceptedFlicker(confirmMenu, item);
	}

	public function acceptedFlicker(confirmMenu:FlxSound, item:String)
	{
		if (pinkBG.visible)
			FlxFlicker.flicker(pinkBG, (confirmMenu.length / 2) / 1000, .1);
		if (!text)
			FlxFlicker.flicker(itemsSpriteGroup.members[currentSelection.value()], (confirmMenu.length / 2) / 500, .05);
		if (text && atlasText)
			FlxFlicker.flicker(itemsAtlasTextGroup.members[currentSelection.value()], (confirmMenu.length / 2) / 500, .05);
		if (text && !atlasText)
			FlxFlicker.flicker(itemsFlxTextGroup.members[currentSelection.value()], (confirmMenu.length / 2) / 500, .05);

		FlxTimer.wait((confirmMenu.length / 2) / 1000, function()
		{
			transitioning = false;
			accept(item);
		});
	}

	public function accept(item:String)
	{
		if (item.isBlankStr())
			return;
	}
}
