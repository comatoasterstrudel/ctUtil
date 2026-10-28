package ctUtil.json;

class CtJsonRegistrySingle
{
    public var cl:Class<CtJsonLoader>;
    var jsons:Map<String, Dynamic> = [];

    public function new(cl:Class<CtJsonLoader>, ids:Array<String>){
        this.cl = cl;

        for(id in ids){
            var json = Type.createInstance(cl, [id]);
            if(json != null) jsons.set(id, json);
        }
    }

    public function get(id:String):Dynamic{
        return Reflect.copy(jsons.get(id));
    }
}