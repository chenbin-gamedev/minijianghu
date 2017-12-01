package com.rover022.game.tiles {
import starling.display.Sprite;

public class Tilemap extends Sprite {
    public function Tilemap() {
        super();
    }


    protected var data:Array;
    protected var mapWidth:int;
    protected var mapHeight:int;
    protected var size:int;

    private var cellW:Number;
    private var cellH:Number;

    protected var vertices:Array;
    protected var quads:Array;
    protected var buffer:Array;

    public function map(data:Array, cols:int):void {

        this.data = data;

        mapWidth = cols;
        mapHeight = data.length / cols;
        size = mapWidth * mapHeight;

        width = cellW * mapWidth;
        height = cellH * mapHeight;

        // quads = Quad.createSet( size );

        updateMap();
    }

    //forces a full update, including new buffer
    public function updateMap():void {

    }

    public function updateMapCell(cell:int):void {

    }

    private function moveToUpdating():void {
        //updating = new Rect(updated);
        //updated.setEmpty();
    }

    protected function updateVertices():void {
        moveToUpdating();
    }


    public function draw():void {
//        super.draw();
    }


    public function destroy():void {

    }

    protected function needsRender(pos:int):Boolean {
        return true;
    }


}
}
