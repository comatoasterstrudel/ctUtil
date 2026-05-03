package ctUtil.controls;

/**
 * A class that provides an easy to use control system. Supports both keyboard and gamepads out of the box!! Yay
 */
class CtControls
{
    /**
     * The list of all of the controls currently registered.
     */
    public static var controls:Map<String, CtControlData> = [];
    
    /**
     * Call this to register a control to the list!!
     * @param controlData The data for this control
     * @return returns the data also
     */
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
    
    /**
     * Call this to remove a control from the list
     * @param id the name of the control you want to remove
     */
    public static function removeControl(id:String):Void{
        if(controls.exists(id)){
            controls.remove(id);   
        } else {
            FlxG.log.error("[CtControls] Input " + id + " doesn't exist, so it can't be removed!!");
        }
    }
    
    /**
     * Call this to reset all controls in the list
     */
    public static function resetControls():Void{
        controls.clear();
    }
    
    /**
     * Call this to recieve a function that returns the status of a certain control
     * @param id the name of the control you want to check
     * @param type the input type (eg: RELEASED, JUSTPRESSED)
     * @return the function that can check a certain control
     */
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
    
    /**
     * Call this to check the status of a certain control
     * @param id the name of the control you want to check
     * @param type the input type (eg: RELEASED, JUSTPRESSED)
     * @return the status of the control
     */
    public static function checkInput(id:String, type:CtControlsInputType):Bool{
        return getInputFunction(id, type)();
    }
    
    /**
     * Call this to check if there are any active gamepads this frame
     * @return true if there is an active gamepad
     */
    public static function isGamepadActive():Bool{
        return(FlxG.gamepads.lastActive != null);
    }
}