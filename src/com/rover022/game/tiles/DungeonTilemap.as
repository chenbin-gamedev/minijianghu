package com.rover022.game.tiles {
public class DungeonTilemap extends Tilemap {
    public static var SIZE:int = 16;


    public function DungeonTilemap() {
        super();
    }

    public function screenToTile(x:Number, y:Number, b:Boolean):int {
        return 1;
    }
}
}
