package ctUtil.controls;

/**
 * A typedef for data for a certain control. While the inputs are OPTIONAL, you must have at least ONE.
 */
typedef CtControlData = {
    /**
     * The name of this control
     */
    var id:String;
    
    /**
     * OPTIONAL; The FlxKey tied to this control. 
     */
    var ?inputKey:FlxKey;
    
    /**
     * OPTIONAL; The FlxGamepadInputID tied to this control. 
     */
    var ?inputPad:FlxGamepadInputID;
}