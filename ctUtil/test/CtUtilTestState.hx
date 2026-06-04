package ctUtil.test;

class CtUtilTestState extends FlxState
{	
	var menuManager:CtMenuManager;
	
	var texts:Array<CtText> = [];
	
	var options:Array<CtMenuOption> = [];

	override public function create()
	{
		CtControls.registerControl({id: "down", inputKey: [DOWN], inputPad: [DPAD_DOWN]});
		CtControls.registerControl({id: "up", inputKey: [UP], inputPad: [DPAD_UP]});
		CtControls.registerControl({id: "accept", inputKey: [Z], inputPad: [A]});

		menuManager = new CtMenuManager(CtControls.getInputFunction("down", JUSTPRESSED), CtControls.getInputFunction("up", JUSTPRESSED), CtControls.getInputFunction("accept", JUSTPRESSED));
		
		var cursor = new CtSprite().createColorBlock(20, 5, FlxColor.GRAY);
		add(cursor);
			
		menuManager.addCursor(cursor, 15, false);
		
		addOption("Test Option", function():Void{
			trace("hi!!");
		});
	
		addOption("Test CtScript", function():Void{
			var script = new CtScript("assets/data/testScript.hx");
			script.executeFunction("test");
		});
		
		menuManager.setMenuOptions([options]);
		menuManager.enable();
		
		super.create();
	}
	
	override function update(elapsed:Float):Void{
		super.update(elapsed);
		
		menuManager.update();
	}
	
	function addOption(name:String, func:Void->Void):Void{
		var text = new CtText(40, 30 * (texts.length + 1), name, FlxAssets.FONT_DEFAULT, 20, false);
		text.color = FlxColor.WHITE;
		add(text);
		texts.push(text);
		
		options.push({sprite: text, cursorDirection: LEFT, clickFunction: function(f):Void{
			func();
		}});
	}
}
