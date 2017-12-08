package com.rover022.game.ui {
import com.rover022.game.utils.DebugTool;

import starling.display.Button;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;

public class Window extends Sprite {
    public var view:Sprite;
    public var backGroundview:Sprite;

    public function Window() {
        super();
        backGroundview = new Sprite();
        addChild(backGroundview)
    }

    public function onClose(e:Event = null):void {
        removeFromParent();
    }

    /**
     * 建立测试用关闭按钮
     */
    public function creatCloseBotton():void {
        var bg:Image = DebugTool.makeImage(320, 0x909957);
        backGroundview.addChild(bg);

        var btn:Button = DebugTool.makeButton("close");
        btn.addEventListener(Event.TRIGGERED, onClose);
        backGroundview.addChild(btn);

    }
}
}
