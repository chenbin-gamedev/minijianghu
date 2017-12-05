package com.rover022.game.utils {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.hero.Hero;

import flash.filesystem.File;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

public class Bundle {
    public var gold:int;

    public var depth:int;
    public var data:Object = {};

    public function Bundle(src:Object = null) {
        if (src) {
            data = src;
        } else {
            data = {};
        }
    }

    public function put(key:String, value:Object):void {
        data[key] = value;
    }

    public function toString():String {
        return JSON.stringify(data);
    }

    public function getHero():Hero {
        return Dungeon.hero;
    }

    public function getDroppedItems():Array {
        return new Array()
    }

    public static function read(bety:ByteArray):Bundle {
        var file:FileStream = File.applicationDirectory.resolvePath("");
        file.open();
        return new Bundle();
    }

    public static function write(file:ByteArray):Boolean {
        var file:FileStream = File.applicationDirectory.resolvePath("");
        file.open();
        file.writeUTF();

        return new Bundle();
    }

    public function get(key:String):Bundlable {
        return getBundle(key).getClassObject();
    }

    public function getClassObject():Bundlable {

    }

    private function getBundle(key:String):Bundle {
        return new Bundle(data.key);
    }

}
}
