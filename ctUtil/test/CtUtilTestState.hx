package ctUtil.test;

class CtUtilTestState extends FlxState
{	
	var menuManager:CtMenuManager;
	
	override public function create()
	{
		menuManager = new CtMenuManager(function():Bool{
			return FlxG.keys.justPressed.DOWN;
		}, function():Bool{
			return FlxG.keys.justPressed.UP;
		}, function():Bool{
			return FlxG.keys.justPressed.Z;
		});
		
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
