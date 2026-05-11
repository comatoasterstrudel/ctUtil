package ctUtil.events;

/**
 * A class to manage events, and trigger them after certain transaction are complete
 */
class CtEventManager
{
    /**
     * The list of events to trigger
     */
    public var eventQueue:Array<Void->Void> = [];
    
    /**
     * The current active transactions
     */
    public var currentTransactions:Array<CtEventTransaction> = [];
    
    public function new():Void{
        eventQueue = [];
        currentTransactions = [];
    }
    
    /**
     * Call this to update the event manager
     */
    public function update():Void{
        if(currentTransactions.length <= 0 && eventQueue.length > 0){
            eventQueue[0]();
            eventQueue.remove(eventQueue[0]);
        }
    }
    
    /**
     * Call this to add a new event to the event queue
     * @param event 
     */
    public function addEvent(event:Void->Void):Void{
        this.eventQueue.push(event);
    }
    
    /**
     * Call this to start a new transaction and add it to the list of current transactions
     * @param name the name of the transaction
     * @return the transaction that gets made
     */
    public function startTransaction(name:String):CtEventTransaction{
        var transaction = new CtEventTransaction(name);
        currentTransactions.push(transaction);
        return transaction;
    }
    
    /**
     * Call this to finish a transaction
     * @param name the name of the transaction you want to end
     */
    public function finishTransaction(name:String):Void{
        var transaction = getTransactionFromName(name);
        
        if(transaction != null){
            currentTransactions.remove(transaction);
        }
    }
    
    /**
     * Call this to get a transaction by its name
     * @param name The name of the event
     * @return The event
     */
    public function getTransactionFromName(name:String):CtEventTransaction
    {
        for(transaction in currentTransactions){
            if(transaction.name == name) return transaction;
        }
        
        return null;
    }
    
    /**
     * Call this to reset all events and transactions in this event manager
     */
    public function reset():Void{
        eventQueue = [];
        currentTransactions = [];
    }
}