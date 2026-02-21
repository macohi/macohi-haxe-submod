package macohi.funkin.koya.frontend.ui.menustate;

import macohi.funkin.koya.backend.AssetPaths;
import macohi.funkin.koya.backend.KoyaAssets;

class MenuItem extends FunkinSprite
{
	public var item(default, null):String;

	override public function new(item:String, pathPrefix:String, ?x:Float, ?y:Float)
	{
		super(x, y);

		this.item = item;

		if (KoyaAssets.exists(AssetPaths.xml('images/$pathPrefix$item', MegaVars.KOYA_MENUITEM_LIBRARY)))
		{
			frames = AssetPaths.fromSparrow('$pathPrefix$item', MegaVars.KOYA_MENUITEM_LIBRARY);

			addPrefixAnim('idle', '$item idle');
			addPrefixAnim('selected', '$item selected');
			makeOffsets();
			updateHitbox();

			playAnim('idle');
			updateHitbox();
		}
	}

	public function makeOffsets()
	{
		playAnim('idle');
		centerOffsets();
		addOffset('idle', offset.x, offset.y);

		playAnim('selected');
		centerOffsets();
		addOffset('selected', offset.x, offset.y);
	}
}
