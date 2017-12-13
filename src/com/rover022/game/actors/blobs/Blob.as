package com.rover022.game.actors.blobs {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Actor;
import com.rover022.game.utils.DebugTool;

import flash.geom.Point;

public class Blob extends Actor {
    public var emitter:*;
    public var pos:Point;

    public function Blob() {
        super();

        initDrawDebug();
    }

    public function initDrawDebug():void {
        if (Dungeon.isdebug) {

            addChild(DebugTool.makeImage(SIZE, 0xaa7812));
        }
    }

    public function setPos(pos:Point):void {
        this.pos = pos;
        x = SIZE * pos.x;
        y = SIZE * pos.y;
    }
}
}
