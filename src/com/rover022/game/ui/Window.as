package com.rover022.game.ui {
import starling.display.Sprite;
import starling.events.Event;

public class Window extends Sprite {
    public var view:Sprite;

    public function Window() {
        super();
    }

    public function onClose(e:Event = null):void {
        removeFromParent();
    }
}
}
