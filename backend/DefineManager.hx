package macohi.backend;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Expr;

class DefineManager
{
	public static var definesAndTheirFunctions:Map<String, Array<Dynamic->Void>> = [];

	public static macro function getDefine(define:String)
		return macro $v{Context.definedValue(key)};

	public static function isDefineDefined(define:String):Bool
		return getDefine(define) != null;

	public static function doesDefineHaveValue(define:String):Bool
		return isDefineDefined() && getDefine(define) != '1';

	public static function areAnyDefinesDefined(defines:Array<String>):Bool
	{
		for (define in defines)
			if (isDefineDefined(define))
				return true;

		return false;
	}

	public static function runIfDefineDefined(define:String, toRun:Dynamic->Void)
		if (isDefineDefined(define) && toRun != null)
			toRun(getDefine(define));

	public static function runIfNotDefineDefined(define:String, toRun:Dynamic->Void)
		if (!isDefineDefined(define) && toRun != null)
			toRun(getDefine(define));

	public static function parseDefinesAndTheirFunctions()
		for (define => toRun in definesAndTheirFunctions)
		{
			if (toRun == null)
				continue;
			if (define == null)
				continue;
			runIfDefineDefined(define, toRun[0] ?? null);
			runIfNotDefineDefined(define, toRun[1] ?? null);
		}
}
