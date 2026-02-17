package macohi.funkin.koya.frontend.ui.menustate;

using macohi.util.StringUtil;

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
		{
			if (!MegaVars.KOYA_MENUBG_PINK(lib).isBlankStr())
				loadGraphic(MegaVars.KOYA_MENUBG_PINK(lib));
		}
		else if (!MegaVars.KOYA_MENUBG_DESAT(lib).isBlankStr())
			loadGraphic(MegaVars.KOYA_MENUBG_DESAT(lib));

		visible = (graphic != null);
	}
}
