package ctUtil.graphic;

class CtCroppedBackdrop extends CtSprite{
    public var backdrop:FlxBackdrop;
    public var bgCamera:FlxCamera;
    
    var cropWidth:Int;
    var cropHeight:Int;
    
    var testSprite:CtSprite;
    
    public function new(graphicPath:String, x:Int, y:Int, cropWidth:Int, cropHeight:Int):Void{
        super(x, y);
        
        this.cropWidth = cropWidth;
        this.cropHeight = cropHeight;
        
        createColorBlock(cropWidth, cropHeight, FlxColor.BLUE);
        
        bgCamera = new FlxCamera(0, 0, cropWidth, cropHeight);
        bgCamera.bgColor = FlxColor.TRANSPARENT;
        FlxG.cameras.list.insert(0, bgCamera);     
        
        backdrop = new FlxBackdrop(graphicPath);
        backdrop.camera = bgCamera;
        FlxG.state.add(backdrop);
    }
    
    override function update(elapsed:Float):Void{          
        backdrop.drawComplex(bgCamera);
        loadGraphic(CtUtil.renderFlxCameraToBitmapData(bgCamera));

        super.update(elapsed);
    }
    
    override function destroy():Void{
        if(FlxG.cameras.list.contains(bgCamera)){
            FlxG.cameras.remove(bgCamera, true);
        }

        super.destroy();            
    }
}