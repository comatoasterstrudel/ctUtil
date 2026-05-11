package ctUtil.events;

/**
 * Class that holds a transaction to be used in a CtEventManager
 */
class CtEventTransaction{
    /**
     * Name of the transaction
     */
    public var name:String = '';
    
    public function new(name:String):Void{
        this.name = name;
    }
}