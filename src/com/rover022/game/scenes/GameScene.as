package com.rover022.game.scenes {
import com.rover022.game.items.Item;
import com.rover022.game.ui.StatusPane;

public class GameScene extends PixelScene {
    public static var scene:GameScene;
    public var pane:StatusPane;

    public function GameScene() {
        super();
    }

    public static function selectCall(onListen:Function):void {

    }

    public static function pickUp(item:Item, pos:int):void {

    }

    public static function updataKeyDisplay():void {
        if (scene != null) {
            scene.pane.updateKeys();
        }
    }
}
}
