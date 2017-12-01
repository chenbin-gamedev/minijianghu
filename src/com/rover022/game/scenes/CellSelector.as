package com.rover022.game.scenes {
import com.rover022.game.Dungeon;
import com.rover022.game.TouchArea;
import com.rover022.game.actors.Char;
import com.rover022.game.tiles.DungeonTilemap;

import flash.geom.Point;

import starling.events.Event;

public class CellSelector extends TouchArea {
    public function CellSelector() {
        super();

        addEventListener(Event.TRIGGERED, onClick);
    }

    public var dragging:Boolean = false;
    public var listener:Function = null;

    public var enabled:Boolean;

    private var mouseZoom:Number;

    private var dragThreshold:Number;

    protected function onClick(e:Event):void {

        if (dragging) {

            dragging = false;

        } else {

            for each (var mob:Char in Dungeon.level.mobs) {
                if (mob != null && mob.hitTest(new Point(x, y))) {
                    select(mob.pos);
                    return;
                }
            }
            select((this as DungeonTilemap).screenToTile(x, y, true))
        }
    }

    public function select(cell:int):void {
        if (enabled && listener != null && cell != -1) {
            listener.onSelect(cell);
            GameScene.ready();
        } else {
            GameScene.cancel();

        }

    }


    public function resetKeyHold():void {

    }

    public function cancel():void {

    }

    public function processKeyHold():void {

    }
}
}
