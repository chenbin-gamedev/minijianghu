package com.rover022.game.tiles {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Actor;
import com.rover022.game.utils.DebugTool;

import starling.display.Sprite;

public class Tile extends Sprite {
    public function Tile() {
        super();
        if (Dungeon.isdebug) {
            addChild(DebugTool.makeImage(Actor.SIZE , 0x0000FF));
        }
    }
}

}
