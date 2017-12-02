package com.rover022.game.tiles {
import flash.geom.Point;

public class DungeonTilemap extends Tilemap {
    public static var SIZE:int = 58;

    public function DungeonTilemap() {
        super();
    }

    public function screenToTile(x:Number, y:Number, b:Boolean):Point {
        return new Point();
    }

    public static function setupVariance(length:uint, seedCurDepth:*):void {

    }
}
}
