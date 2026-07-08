package ctUtil.camera;

class CtCamera extends FlxCamera
{
    public var lerpManager:CtLerpManager;

    public function new(x:Float = 0.0, y:Float = 0.0, width:Int = 0, height:Int = 0, zoom:Float = 0.0):Void{
        super(x, y, width, height, zoom);
        
        lerpManager = new CtLerpManager();
    }
    
    override function update(elapsed:Float) {
        super.update(elapsed);
        
        lerpManager.updateLerps(elapsed);
        
        if(lerpManager.lerpX) scroll.x = lerpManager.x;
        if(lerpManager.lerpY) scroll.y = lerpManager.y;
        if(lerpManager.lerpScaleX) scaleX = lerpManager.scaleX;
        if(lerpManager.lerpScaleY) scaleY = lerpManager.scaleY;
        if(lerpManager.lerpAlpha) alpha = lerpManager.alpha;
    }
}