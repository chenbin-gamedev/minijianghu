package com.rover022.game.windows.wnditems {
import com.rover022.game.items.Item;

import starling.display.DisplayObject;
import starling.display.Sprite;

public class GridLayoutSprite extends Sprite {

    public var w:int;

    public var c_width:Number;
    public var dataArray:Array;

    public function GridLayoutSprite(c_width:Number, _w:int = 5, length:int = 20) {
        w = _w;
        this.c_width = c_width;
        dataArray = new Array(length);
    }

    public function add(src:DisplayObject):void {
        src.x = (size % w) * c_width;
        src.y = int(size / w) * c_width;
        addChild(src);
    }

    public function get size():int {
        return numChildren;
    }

    public function getIndexByType(item:Item):int {
        return dataArray.indexOf(item);
    }
}
}
