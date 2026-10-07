package ctUtil.cache;

/**
 * This class contains functions to cache audio and graphics (not yet)
 */
class CtCache {
    public static function cacheAudio(ids:Array<String>):Void{
        if(ids.length <= 0){
            trace("[CtCache] Can't cache " + ids.length + " audios..");
        }

        trace("[CtCache] Caching audio list (" + ids.length + ")");

        for(id in ids){
            trace("[CtCache] Caching audio... " + id);
            FlxG.sound.cache(id);
            trace("[CtCache] Cached audio! " + id);
        }

        trace("[CtCache] Done Caching audio list (" + ids.length + ")");
    }
}