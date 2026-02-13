package macohi.save;

import lime.app.Application;
import flixel.FlxG;

using macohi.funkin.vslice.util.AnsiUtil;

class Save
{
	public function new() {}

	public var SAVE_VERSION:Null<Int> = 0;

	public var version:SaveField<Null<Int>>;

	function initFields()
	{
		trace(' SAVE '.bg_bright_blue() + ' | Initalizing Save fields');
		version = new SaveField<Null<Int>>('version', SAVE_VERSION);
	}

	var toobig:Array<String> = [];

	public function init(project:String, ?company:String)
	{
		trace(' SAVE '.bg_bright_blue() + ' | Initalizing Save');
		FlxG.save.bind(project, company ?? Application.current.meta.get('company'));

		initFields();

		upgradeVersion(() ->
		{
			flush();
			for (field in Reflect.fields(FlxG.save.data))
			{
				if (!Reflect.fields(Save).contains(field))
					continue;
				if (toobig.contains(field))
					continue;

				trace(' SAVE '.bg_bright_blue() + ' | Save.${field} : ${Reflect.field(FlxG.save.data, field)}');
			}
		});

		Application.current.onExit.add(function(l)
		{
			flush();
		});
	}

	public function upgradeVersion(?onComplete:Void->Void)
	{
		// upgrade code will go before super.upgradeVersion(onComplete)

		version.set(version.get() + 1);
		if (version.get() < SAVE_VERSION)
		{
			upgradeVersion(onComplete);
		}
		else
		{
			trace(' SAVE '.bg_bright_blue() + ' | Upgraded Save to $SAVE_VERSION');
			if (onComplete != null)
				onComplete();
		}
	}

	public function flush()
	{
		version.set(SAVE_VERSION);
		FlxG.save.flush();
	}
}
