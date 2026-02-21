package macohi.backend;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr.ExprOf;

class DefineManager
{
	public static var definesAndTheirFunctions:Map<ExprOf<String>, Array<Dynamic->Void>> = [];

	public static macro function getDefine(define:ExprOf<String>)
		return macro $v{Context.definedValue(key)};

	public static function isDefineDefined(define:ExprOf<String>):Bool
		return getDefine(define) != null;

	public static function doesDefineHaveValue(define:ExprOf<String>):Bool
		return isDefineDefined(define) && getDefine(define) != '1';

	public static function areAnyDefinesDefined(defines:Array<ExprOf<String>>):Bool
	{
		for (define in defines)
			if (isDefineDefined(define))
				return true;

		return false;
	}

	public static function runIfDefineDefined(define:ExprOf<String>, toRun:Dynamic->Void)
		if (isDefineDefined(define) && toRun != null)
			toRun(getDefine(define));

	public static function runIfNotDefineDefined(define:ExprOf<String>, toRun:Dynamic->Void)
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
