package ctUtil.sound;

class CtSound
{
    public static function getMetaData(embeddedSound:FlxSoundAsset):CtSoundMetaData
    {
        if(embeddedSound is String){
            var extensions:Array<String> = [".mp3", ".ogg"];

            var fixedPath = embeddedSound;

            for(extension in extensions){
                fixedPath = FlxStringUtil.remove(fixedPath, extension);
            }

            fixedPath += "_metadata.json";

            if(Assets.exists(fixedPath)){
                return new CtSoundMetaData(fixedPath);
            }
        }

        return null;
    }

    public static function adjustVolumeWithMetaData(volume:Float, metaData:CtSoundMetaData):Float{
        if(metaData == null) return volume;
        return volume * metaData.volume;
    }

    // actually call these functions

    public static function play(?embeddedSound:Null<FlxSoundAsset>, volume:Float = 1.0, looped:Bool = false, ?group:FlxSoundGroup, autoDestroy:Bool = false, ?onComplete:Void->Void):FlxSound{
        var metaData = getMetaData(embeddedSound);
        return FlxG.sound.play(embeddedSound, adjustVolumeWithMetaData(volume, metaData), looped, group, autoDestroy, onComplete);
    }
    
    public static function load(?embeddedSound:FlxSoundAsset, volume = 1.0, looped = false, ?group:FlxSoundGroup, autoDestroy = false, autoPlay = false, ?url:String, ?onComplete:Void->Void, ?onLoad:Void->Void):FlxSound
    {
        var metaData = getMetaData(embeddedSound);
        return FlxG.sound.load(embeddedSound, adjustVolumeWithMetaData(volume, metaData), looped, group, autoDestroy, autoPlay, url, onComplete, onLoad);
    }

    public static function playMusic(?embeddedSound:FlxSoundAsset, volume = 1.0, looped = true, ?group:FlxSoundGroup):Void{
        var metaData = getMetaData(embeddedSound);
        FlxG.sound.playMusic(embeddedSound, adjustVolumeWithMetaData(volume, metaData), looped, group);
    }
}