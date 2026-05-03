package ctUtil.controls;

class CtControls
{
    public static var controls:Map<String, CtControlData> = [];
    
    public static function registerControl(controlData:CtControlData):CtControlData
    {
        if(controls.exists(controlData.id)){
            FlxG.log.error("[CtControls] Control " + controlData.id + " already exists! Overwriting.");
        } else {
            controls.set(controlData.id, controlData);  
        }
        
        if(controlData.inputKey == null && controlData.inputPad == null){
            FlxG.log.error("[CtControls] Input " + controlData.id + " has no inputs atattched! This control won't work!");
        }
        
        return controlData;
    }
    
    public static function removeControl(id:String):Void{
        if(controls.exists(id)){
            controls.remove(id);   
        } else {
            FlxG.log.error("[CtControls] Input " + id + " doesn't exist, so it can't be removed!!");
        }
    }
    
    public static function resetControls():Void{
        controls.clear();
    }
    
    public static function getInputFunction(id:String, type:CtControlsInputType):Void->Bool{
        if(controls.exists(id)){
            return function():Bool{
                var result:Bool = false;
                
                var control = controls.get(id);
                
                if(control.inputKey != null){
                    switch(type){
                        case JUSTRELEASED:
                            if(FlxG.keys.anyJustReleased([control.inputKey])) result = true;
                        case PRESSED:
                            if(FlxG.keys.anyPressed([control.inputKey])) result = true;
                        case JUSTPRESSED:
                            if(FlxG.keys.anyJustPressed([control.inputKey])) result = true;
                    }
                } 
                
                if (control.inputPad != null){
                    switch(type){
                        case JUSTRELEASED:
                            if(isGamepadActive() && FlxG.gamepads.lastActive.anyJustReleased([control.inputPad])) result = true;
                        case PRESSED:
                            if(isGamepadActive() && FlxG.gamepads.lastActive.anyPressed([control.inputPad])) result = true;
                        case JUSTPRESSED:
                            if(isGamepadActive() && FlxG.gamepads.lastActive.anyJustPressed([control.inputPad])) result = true;
                    }
                }
                
                return result;
            };
        } else {
            FlxG.log.error("[CtControls] Input " + id + " doesn't exist, so it can't be checked!!");
            return function():Bool{
                return false;
            };
        }
    }
    
    public static function checkInput(id:String, type:CtControlsInputType):Bool{
        return getInputFunction(id, type)();
    }
    
    public static function isGamepadActive():Bool{
        return(FlxG.gamepads.lastActive != null);
    }
}