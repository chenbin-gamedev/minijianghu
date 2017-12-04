package com.rover022.game.utils {
public class RandomeUtil {
    public function RandomeUtil() {
    }

    public static function normalIntRange(min:int, max:int):int {
        return int(Math.random() * (max - min)) + min;
    }
}
}
