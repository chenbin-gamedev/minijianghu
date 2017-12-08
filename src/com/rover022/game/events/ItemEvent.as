package com.rover022.game.events {
import starling.events.Event;

public class ItemEvent extends Event {
    public static const ITEM_CLICK:String = "ITEM_CLICK";
    public function ItemEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
    }
}
}
