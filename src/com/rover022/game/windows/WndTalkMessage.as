package com.rover022.game.windows {
import com.rover022.game.actors.mobs.npcs.NPC;
import com.rover022.game.utils.DebugTool;

import starling.display.Button;
import starling.events.Event;
import starling.text.TextField;

public class WndTalkMessage extends WndTabbed {
    public var npc:NPC;
    private var text:TextField;
    public var count:int = 0;

    public function WndTalkMessage() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, init)
    }

    private function init(event:Event):void {
        count = 0;
    }

    override public function creatCloseBotton():void {
        super.creatCloseBotton();

        var btn:Button = DebugTool.makeButton("next");
        btn.x = 100;
        btn.addEventListener(Event.TRIGGERED, onNextClose);
        backGroundview.addChild(btn);

        text = new TextField(320, 300, "label");
        text.y = 20;
        backGroundview.addChild(text);
    }

    private function onNextClose(event:Event):void {
        text.text = npc.getTalk(count);
        count++;
        if (text.text == "") {
            onClose();
        }
    }
}
}
