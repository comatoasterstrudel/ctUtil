package ctUtil.test;

class CtUtilTestState extends FlxState
{	
	var menuManager:CtMenuManager;
	
	override public function create()
	{
		CtControls.registerControl({id: "down", inputKey: DOWN, inputPad: DPAD_DOWN});
		CtControls.registerControl({id: "up", inputKey: UP, inputPad: DPAD_UP});
		CtControls.registerControl({id: "accept", inputKey: Z, inputPad: A});

		menuManager = new CtMenuManager(CtControls.getInputFunction("down", JUSTPRESSED), CtControls.getInputFunction("up", JUSTPRESSED), CtControls.getInputFunction("accept", JUSTPRESSED));
		
		var options:Array<CtMenuOption> = [];
		
		var cursor = new CtSprite().createColorBlock(20, 5, FlxColor.GRAY);
		add(cursor);
			
		menuManager.addCursor(cursor, 30, false);
		
		for(i in 0...5){
			var sprite = new CtSprite(0, 50 * i).createColorBlock(10, 10, FlxColor.WHITE);
			add(sprite);
			
			options.push({sprite: sprite, cursorDirection: RIGHT});
		}
		
		menuManager.setMenuOptions([options]);
		menuManager.enable();
		
		super.create();
	}
	
	override function update(elapsed:Float):Void{
		super.update(elapsed);
		
		menuManager.update();
	}
}
