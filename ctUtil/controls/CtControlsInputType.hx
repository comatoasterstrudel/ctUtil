package ctUtil.controls;

/**
 * The different types of inputs you can check a CtControlData for.
 */
enum CtControlsInputType
{
    /**
     * Was the input just released? (eg: you let go of the space key)
     */
    JUSTRELEASED;
    
    /**
     * Was the input just pressed? (eg: you just pressed down on the space key this frame)
     */
    JUSTPRESSED;
    
    /**
     * Is the input pressed? (eg: youre holding down the space key)
     */
    PRESSED;
}