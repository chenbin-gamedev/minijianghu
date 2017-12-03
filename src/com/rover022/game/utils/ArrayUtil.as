package com.rover022.game.utils {
public class ArrayUtil {
    public function ArrayUtil() {
    }

    public static function getRandom(_array:Array):* {
        var _index:int = int(Math.random() * _array.length);
        return _array[_index];
    }
}
}
