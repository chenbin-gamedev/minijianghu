package com.rover022.game.scenes {
import com.rover022.game.Dungeon;
import com.rover022.game.TouchArea;
import com.rover022.game.actors.Char;
import com.rover022.game.tiles.DungeonTilemap;
import com.rover022.game.tiles.DungeonTilemap;

import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Point;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;

public class CellSelector extends TouchArea {
    public var dragging:Boolean = false;
    public var listener:Function = null;
    public var enabled:Boolean = true;
    private var mouseZoom:Number;
    private var dragThreshold:Number;

    public function CellSelector() {
        super();
        addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    }

    override protected function onMouseDown(event:MouseEvent):void {
        trace("onMouseDown")
    }

    override protected function onTouchDown(event:TouchEvent):void {
        super.onTouchDown(event);
        //
        var touch:Touch = event.getTouch(this);
        var p1:Point = touch.getLocation(this);

        if (dragging) {
            dragging = false;
        } else {
            var f_x:int = int(p1.x / DungeonTilemap.SIZE);
            var f_y:int = int(p1.y / DungeonTilemap.SIZE);

            select(new Point(f_x, f_y));

//            //有怪物选择怪物 没怪物选择地块
//            for each (var mob:Char in Dungeon.level.mobs) {
//                if (mob != null && mob.hitTest(p1)) {
//                    select(mob.pos);
//                    return;
//                }
//            }
//            var tiles:DungeonTilemap = GameScene.scene.tiles;
//            select(tiles.screenToTile(p1.x, p1.y, true));
        }
    }

    /**
     * 选中一点
     *
     * @param cell
     */
    public function select(cell:Point):void {
        trace("select ", cell.x, cell.y);
        if (enabled && cell != null) {
            //listener.onSelect(cell);
            //如果英雄能处理这一步,那么前进
            if (Dungeon.hero.handle(cell)) {
                Dungeon.hero.next()
            }
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
