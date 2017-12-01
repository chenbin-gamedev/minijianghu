package com.rover022.game.scenes {
import com.rover022.game.items.Item;
import com.rover022.game.ui.StatusPane;

import starling.text.TextField;

public class GameScene extends PixelScene {
    public static var scene:GameScene;
    public var pane:StatusPane;

    public function GameScene() {
        super();
        var text:TextField = new TextField(200, 20, "GameScene");
        text.y = 50;
        addChild(text);
    }

    override public function create():void {
        super.create();
        trace("GameScene is create");
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
