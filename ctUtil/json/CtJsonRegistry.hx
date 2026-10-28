package ctUtil.json;

class CtJsonRegistry
{
    var singles:Array<CtJsonRegistrySingle>;

    public function new (){
        singles = [];
    }

    public function addRegistry(cl:Class<CtJsonLoader>, ids:Array<String>):CtJsonRegistrySingle{
        var single = new CtJsonRegistrySingle(cl, ids);

        if(getRegistry(cl) != null){
            FlxG.log.error("Can't add registry of type " + Type.getClassName(cl) + ".. its already part of this registry!");
            return null;
        }

        singles.push(single);

        return single;
    }

    public function getRegistry(cl:Class<CtJsonLoader>):CtJsonRegistrySingle
    {
        for(single in singles){
            if(single.cl == cl) return single;
        }

        return null;
    }
}