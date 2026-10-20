package ctUtil.sound;

/**
 * thanks fnf devs .
 * this is from ocrpg mostly
 */
class CtConductor
{
	var bpm:Float;
	var beatInterval:Float;

	var onBeat = new FlxTypedSignal<Int -> Void>();
	var onStep = new FlxTypedSignal<Int -> Void>();

	public var curBeat:Int = 0;
	public var curStep:Int = 0;

	public var crochet:Float = 0; // beats in milliseconds
	public var stepCrochet:Float = 0; // steps in milliseconds

	public var songPosition:Float;
	var lastSongPosition:Float = 0;

	public var totalBeats:Int = 0;
	public var lastBeat:Float = 0;

	public var totalSteps:Int = 0;
	public var lastStep:Float = 0;

	public static var safeFrames:Int = 10;
	public static var safeZoneOffset:Float = (safeFrames / 60) * 1000; // is calculated in create(), is safeFrames in milliseconds

	public static var globalCurBeat:Int = 0;
	
	var theSound:FlxSound;
	
	public function new(newbpm:Float, ?sound:FlxSound)
	{
		bpm = newbpm; 

		if(sound != null) theSound = sound; else theSound = FlxG.sound.music;
        
		crochet = ((60 / bpm) * 1000);
		stepCrochet = crochet / 4;

		initialize();

		curBeat = 0;
	}

	public function start():Void{
		onBeat.dispatch(curBeat);
		onStep.dispatch(curStep);
	}

	function initialize():Void{
		beatInterval = 60 / bpm;
		curBeat = 0;
	}

	public function update(elapsed:Float):Void{
		if(theSound == null) return; //oh no

		lastSongPosition = songPosition;
		songPosition = theSound.time;

		if(songPosition < lastSongPosition){
			lastBeat = 0;
			lastStep = 0;
		}

		updateCurStep();

		everyStep();

		curBeat = Math.round(curStep / 4);

		CtConductor.globalCurBeat = curBeat;
	}

	private function everyStep():Void
	{
		if (songPosition > lastStep + stepCrochet - safeZoneOffset || songPosition < lastStep + safeZoneOffset)
		{
			if (songPosition > lastStep + stepCrochet)
			{
				stepHit();
			}
		}
	}

	private function updateCurStep():Void
	{
		curStep = Math.floor(songPosition / stepCrochet);
	}

	public function stepHit():Void
	{
		totalSteps += 1;
		lastStep += stepCrochet;

		if (totalSteps % 4 == 0)
			beatHit();

        onStep.dispatch(curStep);
	}

	public function beatHit():Void
	{
		lastBeat += crochet;
		totalBeats += 1;
		
        onBeat.dispatch(curBeat);
	}
}