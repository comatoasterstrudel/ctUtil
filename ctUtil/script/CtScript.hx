package ctUtil.script;

#if hscript_iris
/**
 * A class for creating HScript files really really easily !!!
 * this is built off of hscript-iris
 */
class CtScript
{
    public var name:String = "";
    
    /**
     * Has init() been called yet?
     */
    public static var initComplete:Bool = false;
    
    /**
     * The actual script object for this CtScript. You shouldnt need to interface with this directly ever
     */
    public var script:Iris;
    
    /**
     * The default values that will get applied to scripts
     */
    public static var defaultValues:Array<CtScriptValue> = [];
    
    public function new(scriptPath:String):Void{
        if(!initComplete) init();
        
        if(!Assets.exists(scriptPath)){
            FlxG.log.error("No H-Script file found!! (" + scriptPath + ")");
            return;
        }
        
        var splitPath = scriptPath.split("/");
        name = splitPath[splitPath.length - 1];
        for(ending in [".hxc", ".hx"]){
            name = StringTools.replace(name, ending, "");
        }
        
        script = new Iris(Assets.getText(scriptPath), {name: name});
        
        for(value in defaultValues){
            setValue(value);
        }
    }
    
    /**
     * Call this to execute a function on the script
     * @param name the name of the function you want to call
     * @param args any arguments the function might have
     * @return any return values the function might have
     */
    public function executeFunction(name:String, ?args:Array<Any>):Dynamic
    {
        var result = script.call(name, args);

        if(result == null){
            return null;
        } else {
            return result.returnValue;        
        }
    }
    
    /**
     * Call this to set a value on this script
     * @param value 
     */
    public function setValue(value:CtScriptValue){
        script.set(value.name, value.value);    
    }
    
    /**
     * Call this to set a default value that will be applied to any scripts
     * @param value 
     */
    public static function setDefaultValue(value:CtScriptValue):Void{
        defaultValues.push(value);
    }
    
    /**
     * Call this to initialize all of the base default values
     */
    public static function init():Void{
        if(initComplete) return;
        

        setDefaultValue({name: "add", value: function(obj){
            FlxG.state.add(obj);
        }});

        setDefaultValue({name: "remove", value: function(obj){
            FlxG.state.remove(obj);
        }});

        setDefaultValue({name: "insert", value: function(pos, obj){
            FlxG.state.insert(pos, obj);
        }});

        setDefaultValue({name: "CtUtil", value: CtUtil});
        setDefaultValue({name: "FlxG", value: FlxG});
        setDefaultValue({name: "FlxState", value: FlxState});
        setDefaultValue({name: "CtSprite", value: CtSprite});
        setDefaultValue({name: "CtText", value: CtText});
        setDefaultValue({name: "CtMenuManager", value: CtMenuManager});

        initComplete = true;
    }

    public function destroy():Void{
        script.destroy();
        script = null;
    }
}
#end