package com.rover022.game.utils {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.levels.Level;

public class Bundle {
    public var gold:int;

    public var depth:int;

    public function Bundle() {
    }

    public function getHero():Hero {
        return Dungeon.hero;
    }

    public function getDroppedItems():Array {
        return new Array()
    }

    public static function readFromFile():Bundle {
        return new Bundle();
    }

    public function getLevel():Level {
        return new Level();
    }
}
}
