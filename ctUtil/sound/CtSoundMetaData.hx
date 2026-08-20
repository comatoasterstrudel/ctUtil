package ctUtil.sound;

class CtSoundMetaData extends CtJsonLoader
{
    public var id:String;

    public var name:String;
    public var volume:Float;

    public function new(id:String):Void{
        super(id);

        this.id = id;

        this.name = data.name ?? "";
        this.volume = FlxMath.bound(data.volume ?? 1, 0, 1);
    }
}