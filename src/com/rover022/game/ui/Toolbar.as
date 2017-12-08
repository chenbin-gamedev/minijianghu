package com.rover022.game.ui {
import com.rover022.game.items.Item;
import com.rover022.game.scenes.GameScene;
import com.rover022.game.windows.WndBag;

import flash.geom.Point;

import starling.display.Sprite;
import starling.events.Event;

import test.TestStartScene;

import utils.MenuButton;

public class Toolbar extends Sprite {
    public var examining:Boolean;
    private var wnd:WndBag;

    public function Toolbar() {
        super();
        create();
    }

    private function create():void {
        var btn:MenuButton = TestStartScene.initTestFunButton(0, 0, "包裹", onBaglick);
        addChild(btn);
    }

    private function onBaglick(e:Event):void {
        if (wnd == null) {
            wnd = new WndBag();
            wnd.creatCloseBotton();
        }
        GameScene.show(wnd);
    }

    public function pickup(item:Item, pos:Point):void {

    }

    //

}
}
