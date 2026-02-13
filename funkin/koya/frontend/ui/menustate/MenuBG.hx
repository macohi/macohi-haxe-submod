package macohi.funkin.koya.frontend.ui.menustate;

import macohi.funkin.koya.backend.AssetPaths;

class MenuBG extends FunkinSprite
{
	public var lib:String = 'ui';

	override public function new(pink:Bool = false, ?x:Float, ?y:Float)
	{
		super(x, y);

		reloadBG(pink);
	}

	public dynamic function reloadBG(pink:Bool = false)
	{
		if (pink)
			loadGraphic(AssetPaths.image('bg_pink', lib));
		else
			loadGraphic(AssetPaths.image('bg_desat', lib));
	}
}
