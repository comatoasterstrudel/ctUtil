package ctUtil.graphic.text;

/**
 * The replacement for FlxText in this project
 */
class CtText extends FlxText
{
    public var lerpManager:CtLerpManager;
     
    public function new(?x:Float, ?y:Float, ?text:String = "", ?font:String, ?size:Int, ?antialiasing = true):Void{
        if(text == null) text = "";
        
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