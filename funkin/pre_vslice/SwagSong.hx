package macohi.funkin.pre_vslice;

/**
	FNF 0.2.8 SwagSong

	_Last edit date_: 2026-02-09
	@since 2026-02-09
**/
typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var validScore:Bool;
}
