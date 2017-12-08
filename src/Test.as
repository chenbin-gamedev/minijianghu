package {
import com.rover022.game.items.Generator;
import com.rover022.game.items.Item;
import com.rover022.game.utils.Pathfinder;

import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;

public class Test extends Sprite {
    public function Test() {
        super();


        testDropItem();
//        testMapMod();

//      testDraw()

    }

    private function testDraw():void {
        var f_size:Number = 44;
        var nBox:Sprite = new Sprite();
        nBox.graphics.beginFill(0x00ff00, 1);
        nBox.graphics.drawRect(0, 0, f_size, f_size);
        nBox.graphics.drawRect(2, 2, f_size - 4, f_size - 4);
        nBox.graphics.endFill();
        addChild(nBox)
    }

    private function testDropItem():void {
        Generator.reset();
        for (var i:int = 0; i < 100; i++) {
            var item:Item = Generator.randomItem();
            trace(item);
        }

    }

    private function testMapMod():void {
        var map:Array = [
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0, 0, 0]];

        var pt:Pathfinder = new Pathfinder();
        pt.loadMap(map, 10, 10);
        var path:Array = pt.getPath(new Point(1, 1), new Point(8, 8), false);
        trace(path.length, path);
        var myShape:Shape = new Shape();
        addChild(myShape);

        myShape.graphics.lineStyle(2, 0x990000, 5);

        for (var i:int = 0; i < path.length; i++) {
            trace(path[i].x, path[i].y)
            myShape.graphics.lineTo(path[i].x, path[i].y);
            ;
        }
    }
}
}
