package com.rover022.game {
import com.rover022.game.events.ItemEvent;
import com.rover022.game.tiles.DungeonTilemap;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class TouchArea extends Sprite {
    public var target:DungeonTilemap;

    public function TouchArea() {
        super();
        addEventListener(TouchEvent.TOUCH, isPressed);
    }

    protected function onTouchUp(event:TouchEvent):void {
        // trace("onTouchUp")
    }

    protected function onTouchDown(event:TouchEvent):void {
        // trace("onTouchDown")
    }

    private function isPressed(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this);
        if (touch == null) {
            return;
        }
        //trace(touch.phase);
        if (touch.phase == TouchPhase.BEGAN)//on finger down
        {
            onTouchDown(event);
            //do your stuff
            //addEventListener(Event.ENTER_FRAME, onButtonHold);
        }
        if (touch.phase == TouchPhase.ENDED) //on finger up
        {
            onTouchUp(event);
            //stop doing stuff
            //removeEventListener(Event.ENTER_FRAME, onButtonHold);
        }
    }

    private function onButtonHold(e:Event):void {
        trace("doing stuff while button pressed!");
    }

}
}
