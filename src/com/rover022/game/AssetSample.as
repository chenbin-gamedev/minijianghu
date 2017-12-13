package com.rover022.game {
import flash.media.SoundChannel;

public class AssetSample {
    public function AssetSample() {
    }

    /**
     * 声音播放
     * @param soundName
     */
    public static function play(soundName:String):void {
        var explosion:SoundChannel = MiniGame.assets.playSound(soundName);
    }



}
}
