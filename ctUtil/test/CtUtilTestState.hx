package ctUtil.test;

class CtUtilTestState extends FlxState
{	
	var menuManager:CtMenuManager;
	
	var texts:Array<CtText> = [];
	
	var options:Array<CtMenuOption> = [];

	override public function create()
	{
		super.create();

		CtControls.registerControl({id: "down", inputKey: [DOWN], inputPad: [DPAD_DOWN]});
		CtControls.registerControl({id: "up", inputKey: [UP], inputPad: [DPAD_UP]});
		CtControls.registerControl({id: "left", inputKey: [LEFT], inputPad: [DPAD_LEFT]});
		CtControls.registerControl({id: "right", inputKey: [RIGHT], inputPad: [DPAD_RIGHT]});
		CtControls.registerControl({id: "cancel", inputKey: [ESCAPE], inputPad: [B]});
		CtControls.registerControl({id: "accept", inputKey: [Z], inputPad: [A]});

		menuManager = new CtMenuManager(CtControls.getInputFunction("down", JUSTPRESSED), CtControls.getInputFunction("up", JUSTPRESSED), CtControls.getInputFunction("accept", JUSTPRESSED), CtControls.getInputFunction("cancel", JUSTPRESSED), CtControls.getInputFunction("right", JUSTPRESSED), CtControls.getInputFunction("left", JUSTPRESSED));
		
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
		
		addOption("Test CtCroppedBackdrop", function():Void{
			var croppedBg = new CtCroppedBackdrop("assets/images/testbg.png", 200, 300, 1000, 100);
			croppedBg.backdrop.velocity.set(10, 10);
			add(croppedBg);
		});
		
		var testSmallRack = new CtText(FlxG.width - 200, 30, "Test Small Rack", FlxAssets.FONT_DEFAULT, 20, false);
		testSmallRack.color = FlxColor.WHITE;
		add(testSmallRack);
				
		addOption("Big Fart", function():Void{
			FlxG.sound.play("assets/sounds/dry-fart.ogg");
		});

		addOption("Small Fart", function():Void{
			CtSound.play("assets/sounds/dry-fart.ogg");
		});
		
		menuManager.setMenuOptions([options, [{sprite: testSmallRack, cursorDirection: LEFT}]]);
		menuManager.enable();		
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
