package macohi.debugging;

import haxe.PosInfos;

using StringTools;
using macohi.funkin.vslice.util.AnsiUtil;
using macohi.util.ArrayUtil;
using macohi.util.FileUtil;

class CustomTrace
{
	public static var tracesList:Array<String> = [];

	public static var ALLOW_ANSI:Bool = true;

	public static var formatWordOptions:Map<String, (String, String) -> String> = [
		'<warning>' => function(key:String, v:String)
		{
			if (ALLOW_ANSI)
				return v?.replace(key, ' WARNING '.warning());

			return v?.replace(key, ' [WARNING] ');
		},
		'<error>' => function(key:String, v:String)
		{
			if (ALLOW_ANSI)
				return v?.replace(key, ' ERROR '.error());

			return v?.replace(key, ' [ERROR] ');
		},
		'<reset>' => function(key:String, v:String)
		{
			if (ALLOW_ANSI)
				return v?.replace(key, AnsiCode.RESET);

			return v?.replace(key, '');
		},
	];

	public static dynamic function formatOutput(v:Dynamic, ?pos:PosInfos):String
	{
		var nv:String = Std.string(v);

		if (nv == null)
			nv = '<error> null input';

		var posInfos:String = '';

		if (pos != null)
		{
			posInfos += '${pos.fileName}:${pos.lineNumber} ';

			nv = ' : $nv';
		}

		nv = '${posInfos}${nv}';

		if (nv != null)
		{
			for (key => value in formatWordOptions)
				if (nv.contains(key))
					if (value != null)
						nv = value(key, nv);
		}

		return nv;
	}

	public static var logDirectory:String = 'logs/';
	public static var logTime:Null<Dynamic> = null;

	public static dynamic function newTrace(v:Dynamic, ?pos:PosInfos)
	{
		var str:String = formatOutput(v, pos);

		tracesList.push(str);

		#if sys
		if (!sys.FileSystem.exists(logDirectory))
		{
			sys.FileSystem.createDirectory(logDirectory);
			Sys.println('Created log directory: $logDirectory');
		}
		else if (logTime == null)
		{
			#if CLEAR_LOGS
			for (file in sys.FileSystem.readDirectory(logDirectory))
				sys.FileSystem.deleteFile(logDirectory + file);
			Sys.println('Cleared log directory: $logDirectory');
			#end
		}

		if (logTime == null)
		{
			logTime = Date.now().toString().fixPath();
			Sys.println('Log file name: ${logTime}.txt');
		}

		sys.io.File.saveContent('${logDirectory}${logTime}.txt', tracesList.convertStrArrayToStrNL());
		#end

		#if js
		if (js.Syntax.typeof(untyped console) != "undefined" && (untyped console).log != null)
			(untyped console).log(str);
		#elseif lua
		untyped __define_feature__("use._hx_print", _hx_print(str));
		#elseif sys
		Sys.println(str);
		#else
		throw new haxe.exceptions.NotImplementedException()
		#end
	}
}
