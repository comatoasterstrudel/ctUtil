package ctUtil.json;

/**
 * this class can be used for loading json files!!
 */
class CtJsonLoader
{
    public var data:Dynamic = null;

    /**
     * @param path the path to the JSON file you want to load
     * @param backupPath the path that should be used in the event the file you request isnt found
     */
    public function new(path:String, ?backupPath:Null<String>, ?disableErrors:Bool = false):Void{        
        if(!Assets.exists(path)){
            if(backupPath != null){
                if(Assets.exists(backupPath)){
					if(!disableErrors) FlxG.log.error("Can't find JSON file at " + path + ", used backup JSON file at " + backupPath + ".");
					path = backupPath;
                } else {
					if(!disableErrors) FlxG.log.error("Can't find JSON file at " + path + ", or backup JSON file at " + backupPath + ".");
                    return;
                }
            } else {
                if(!disableErrors) FlxG.log.error("Can't find JSON file at " + path + ". Try adding a backup path?");
                return;
            } 
        }
        
        data = Json.parse(Assets.getText(path));
    }
}