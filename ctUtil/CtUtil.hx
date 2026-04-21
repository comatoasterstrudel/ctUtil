package ctUtil;

/**
 * A class full of utilities I use in a lot of my projects.
 */
class CtUtil{
	/**
	 * Call this to lerp two values together
	 * @param initialnum The number you want to lerp
	 * @param target Where you want the initial number to lerp to
	 * @param elapsed The tiem since last frame (in ms)
	 * @param speed How fast you want it to lerp. Defaults to 15
	 * @param roundNum When you want it to be rounded (defaults to 0.001)
	 * @return Float
	 */
    public static function lerpThing(initialnum:Float, target:Float, elapsed:Float, speed:Float = 15, ?roundNum:Float = 0.001):Float
	{
		var num = FlxMath.lerp(target, initialnum, FlxMath.bound(1 - (elapsed * speed), 0, 1));
		
		if(num + roundNum >= target && initialnum < target || num - roundNum <= target && initialnum > target) num = target;
		 
		return num;
	}
	/**
	 * Call this to get the average of a list of floats
	 * @param data The floats you want to get the average of
	 * @return Float
	 */
	public static function getAverage(data:Array<Float>):Float
	{
		var sum:Float = 0;
		for (value in data)
		{
			sum += value;
		}
		return (sum / data.length);
	} 
	/**
	 * Call this to center a sprites X values evenly, around a certain point
	 * @param sprites An array of FlxSprite to center
	 * @param spacing How much space you want between the sprites
	 * @param xpos Where you want them to be centered around. Defaults to the middle of the screen
	 */
	public static function centerGroup(sprites:Array<FlxSprite>, spacing:Float, ?xpos:Float):Void
	{
		if (xpos == null) {
			xpos = FlxG.width / 2;
		}

		var totalWidth:Float = 0;

		for (i in sprites)
		{
			totalWidth += i.width;
		}
		totalWidth += spacing * (sprites.length - 1);

		var startX:Float = (xpos) - (totalWidth / 2);

		var currentX:Float = startX;
		for (sprite in sprites)
		{
			sprite.x = currentX;
			currentX += sprite.width + spacing;
		}
	}

	/**
	 * Call this to split a string to an array of strings
	 * @param text The text you want to split
	 * @return Array<String>
	 */
	public static function stringToArray(text:String):Array<String> {
		var thing = new StringIteratorUnicode(text);

		var returnthis:Array<String> = [];

		for (i in thing) {
			returnthis.push(String.fromCharCode(i));
		}

		return returnthis;
	}
	
	/**
	 * Call this to center an FlxSprite on another FlxSprite
	 * @param sprite1 The first FlxSprite
	 * @param sprite2 The second FlxSprite
	 * @param x Should it center on the X axis?
	 * @param y Should it center on the Y axis?
	 */
	public static function centerSpriteOnSprite(sprite1:FlxSprite, sprite2:FlxSprite, x:Bool, y:Bool):Void{
		if(x){
			sprite1.x = sprite2.x + sprite2.width / 2 - sprite1.width / 2;
		}

		if(y){
			sprite1.y = sprite2.y + sprite2.height / 2 - sprite1.height / 2;
		}
	}
	
	/**
	 * call this to check if two FlxPoints positions are the same
	 * @param point1 The first FlxPoint
	 * @param point2 The first FlxPoint
	 * @return If they're equal
	 */
	public static function compareFlxPoints(point1, point2):Bool{
		return point1.x == point2.x && point1.y == point2.y;
	}
	
	/**
	 * Call this to get an array of paths to files in a certain folder
	 * @param path The path to the folder you want to obtain the files from
	 * @param extns the extensions of files you want. example: [".png", ".jpeg"] will return images
	 * @param filePath if you want the full path for the file or just the file name
	 * @param deepSearch should the search go deeper into folders inside of the folder
	 * @return the list of files or paths
	 */
	public static function findFilesInPath(path:String, extns:Array<String>, ?filePath:Bool = false, ?deepSearch:Bool = true):Array<String>
	{
		var files:Array<String> = [];

		if (FileSystem.exists(path))
		{
			for (file in FileSystem.readDirectory(path))
			{
				var path = haxe.io.Path.join([path, file]);
				if (!FileSystem.isDirectory(path))
				{
					for (extn in extns)
					{
						if (file.endsWith(extn))
						{
							if (filePath)
								files.push(path);
							else
								files.push(file);
						}
					}
				}
				else if (deepSearch) // ! YAY !!!! -lunar
				{
					var pathsFiles:Array<String> = findFilesInPath(path, extns, deepSearch);

					for (_ in pathsFiles)
						files.push(_);
				}
			}
		}
		return files;
	}
	
	/**
	 * Call this function to destroy an array of sprites, then clear the array
	 * @param sprites the array of sprites to destroy
	 * @return the empty array
	 */
	public static function destroyArrayOfSprites(sprites:Array<FlxSprite>):Array<FlxSprite>{
		for(sprite in sprites){
			sprite.destroy();
		}
		
		sprites = [];
		
		return sprites;
	}
	
	/**
	 * Call this function to remove a list certain strings from a list of strings
	 * @param text The list of strings you want to edit
	 * @param strip The strings you want to remove from those texts
	 * @return The edited texts
	 */
	public static function stripTextFromStrings(text:Array<String>, strip:Array<String>):Array<String>{
		for(curText in 0...text.length){
			for(curStrip in strip){
				text[curText] = StringTools.replace(text[curText], curStrip, "");			
			}
		}
		return text;
	}
}