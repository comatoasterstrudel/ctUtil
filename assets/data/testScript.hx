function test(){
    trace("fart");
    
    var spr = new CtSprite().createColorBlock(FlxG.width, FlxG.height, 0xFFFFFFFF);
    spr.screenCenter();
    add(spr);
    
    FlxG.camera.flash(0xFF000000);
}