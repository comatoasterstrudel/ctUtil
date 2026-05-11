package ctUtil.extensions;

/**
 * The replacement for FlxText in this project
 */
class CtSprite extends FlxText
{
    public var lerpManager:CtLerpManager;
     
    public function new(?x:Float, ?y:Float, ?text:String, ?font:String, size:Int, ?antialiasing = true):Void{
        super(x,y);
        
        this.text = text;
        this.font = font;
        this.size = size;
	    this.antialiasing = antialiasing;
        
        lerpManager = new CtLerpManager(this);
    }
    
    override function update(elapsed:Float):Void{
		super.update(elapsed);

        lerpManager.updateLerps(elapsed);		
	}
}