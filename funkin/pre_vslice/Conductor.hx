package macohi.funkin.pre_vslice;

/**
	FNF 0.2.8 Conductor

	_Last edit date_: 2026-02-09
	@since 2026-02-09
**/
class Conductor
{
	public static var bpm:Float = 100;

	/** beats in milliseconds **/
	public static var crochet:Float = ((60 / bpm) * 1000);

	/** steps in milliseconds **/
	public static var stepCrochet:Float = crochet / 4;

	/** Should be set to the current song position obviously **/
	public static var songPosition:Float;

	/** This one was only used in gameplay so it's pretty un-needed **/
	public static var lastSongPos:Float;

	/** Latency **/
	public static var offset:Float = 0;

	public static var safeFrames:Int = 10;

	/** safeFrames in milliseconds **/
	public static var safeZoneOffset:Float = (safeFrames / 60) * 1000;

	public static var bpmChangeMap:Array<BPMChangeEvent> = [];

	public function new() {}

	public static function mapBPMChanges(song:SwagSong)
	{
		bpmChangeMap = [];

		var curBPM:Float = song.bpm;
		var totalSteps:Int = 0;
		var totalPos:Float = 0;
		for (i in 0...song.notes.length)
		{
			if (song.notes[i].changeBPM && song.notes[i].bpm != curBPM)
			{
				curBPM = song.notes[i].bpm;
				var event:BPMChangeEvent = {
					stepTime: totalSteps,
					songTime: totalPos,
					bpm: curBPM
				};
				bpmChangeMap.push(event);
			}

			var deltaSteps:Int = song.notes[i].lengthInSteps;
			totalSteps += deltaSteps;
			totalPos += ((60 / curBPM) * 1000 / 4) * deltaSteps;
		}
		trace("new BPM map BUDDY " + bpmChangeMap);
	}

	public static function changeBPM(newBpm:Float)
	{
		bpm = newBpm;

		crochet = ((60 / bpm) * 1000);
		stepCrochet = crochet / 4;
	}
}
