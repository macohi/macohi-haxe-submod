package macohi.allmine.macros;

#if !display
#if macro
@:nullSafety
class FlxBasicStringID
{
	// yoinked from FNF FlxMacro and modified for my purposes
	public static macro function buildFlxBasic():Array<haxe.macro.Expr.Field>
	{
		var pos:haxe.macro.Expr.Position = haxe.macro.Context.currentPos();
		var cls:haxe.macro.Type.ClassType = haxe.macro.Context.getLocalClass().get();
		var fields:Array<haxe.macro.Expr.Field> = haxe.macro.Context.getBuildFields();

		var hasField = false;
		var field:String = 'ni_ID'; // non integer ID

		for (f in fields)
		{
			if (f.name == field)
			{
				hasField = true;
				break;
			}
		}

		if (!hasField)
		{
			// Here, we add the zIndex attribute to all FlxBasic objects.
			// This has no functional code tied to it, but it can be used as a target value
			// for the FlxTypedGroup.sort method, to rearrange the objects in the scene.
			fields.push({
				name: field, // Field name.
				access: [haxe.macro.Expr.Access.APublic], // Access level
				kind: haxe.macro.Expr.FieldType.FVar(macro :Dynamic, macro $v{0}), // Variable type and default value
				pos: pos, // The field's position in code.
			});
		}

		return fields;
	}
}
#end
#end
